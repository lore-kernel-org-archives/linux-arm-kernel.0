From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Wed, 20 Jan 2016 09:16:44 +0100
Subject: [PATCH v6 20/21] all: s390: make compat wrappers the generic
 solution
In-Reply-To: <20160119175223.GA6603@yury-N73SV>
References: <20160115124646.GD4130@osiris> <20160119175223.GA6603@yury-N73SV>
Message-ID: <20160120081643.GB3395@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 08:52:23PM +0300, Yury Norov wrote:
> > > +asmlinkage long compat_sys_creat(const char __user *pathname,
> > > umode_t mode);
> > > +asmlinkage long compat_sys_link(const char __user *oldname,
> > > +                             const char __user *newname);
> > > +asmlinkage long compat_sys_chdir(const char __user *filename);
> > > +asmlinkage long compat_sys_mknod(const char __user *filename,
> > > umode_t mode,
> > > +                             unsigned dev);
> >
> > Are these really needed?
> 
> 91 of ~160 wrapped syscalls produce compile time error without it on
> arm64:
> arch/arm64/kernel/sys_ilp32.c:59:35: error: ?compat_sys_io_destroy? undeclared here (not in a function)
>  #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
>                                    ^
> include/uapi/asm-generic/unistd.h:39:1: note: in expansion of macro ?__SC_WRAP?
> __SC_WRAP(__NR_io_destroy, sys_io_destroy)
> ^
> 
> I think, it's better to leave it as is...

I see. The syscall tables on arm seem to be generated in C code. So you
need the declarations.

> diff --git a/fs/readdir.c b/fs/readdir.c
> index ced6791..d34cc49 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -17,6 +17,7 @@
>  #include <linux/dirent.h>
>  #include <linux/security.h>
>  #include <linux/syscalls.h>
> +#include <linux/compat.h>
>  #include <linux/unistd.h>
> 
>  #include <asm/uaccess.h>
> @@ -274,8 +275,13 @@ efault:
>  	return -EFAULT;
>  }
> 
> +#ifndef __ARCH_WANT_COMPAT_SYS_GETDENTS64
> +SYSCALL_DEFINE_WRAP3(getdents64, unsigned int, fd,
> +		struct linux_dirent64 __user *, dirent, unsigned int, count)
> +#else
>  SYSCALL_DEFINE3(getdents64, unsigned int, fd,
>  		struct linux_dirent64 __user *, dirent, unsigned int, count)
> +#endif
>  {
>  	struct fd f;
>  	struct linux_dirent64 __user * lastdirent;

This is a non-obvious change at first glance. I think it would make sense
to split this patch into at least three or four separate patches:
- one which introduces the infrastructure
- one which converts the non-obvious syscalls like this one
- one which converts the rest
- one which enables the architectures

> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index a76c917..293864c 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -55,6 +55,52 @@
>  	}								\
>  	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> 
> +#define SYSCALL_DEFINE_WRAP1(name, ...) SYSCALL_DEFINE_WRAPx(1, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP2(name, ...) SYSCALL_DEFINE_WRAPx(2, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP3(name, ...) SYSCALL_DEFINE_WRAPx(3, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP4(name, ...) SYSCALL_DEFINE_WRAPx(4, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP5(name, ...) SYSCALL_DEFINE_WRAPx(5, _##name, __VA_ARGS__)
> +#define SYSCALL_DEFINE_WRAP6(name, ...) SYSCALL_DEFINE_WRAPx(6, _##name, __VA_ARGS__)
> +
> +#ifndef __SC_COMPAT_TYPE
> +#define __SC_COMPAT_TYPE(t, a) \
> +	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
> +#endif
> +
> +#ifndef __SC_COMPAT_CAST
> +#define __SC_COMPAT_CAST(t, a)	((t) ((t)(-1) < 0 ? (s64)(s32)(a) : (u64)(u32)(a)))
> +#endif

You might consider adding a BUILD_BUG_ON() here, like within the s390 variant.

Personally I don't like the SYSCALL_DEFINE_WRAPx names too much. But that
can be changed easily if somebody comes up with a better name for it.

> +#define SYSCALL_DEFINE_WRAPx(x, name, ...)						\
> +asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));				\
> +asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))			\
> +		__attribute__((alias(__stringify(compat_SyS##name))));			\
> +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));	\
> +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))		\
> +{											\
> +	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));			\
> +}											\
> +SYSCALL_DEFINEx(x, name, __VA_ARGS__)

Given that the system call functions might be inlined, I think it would
make sense to remove the "notrace" attribute. Otherwise we would end up
with lots of untraceable (and unpatchable) functions. I didn't care back
then for the small compat wrappers...

> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 0623787..ab14c3f 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -17,27 +17,41 @@ asmlinkage long sys_ni_syscall(void)
>  }
> 
>  cond_syscall(sys_quotactl);
> +cond_syscall(compat_sys_quotactl);

It might make sense to add a define which adds both variants.

Btw. for future versions please add linux-arch to cc.
