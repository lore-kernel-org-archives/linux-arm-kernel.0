From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 20 Jan 2016 15:17:36 +0300
Subject: [PATCH v6 20/21] all: s390: make compat wrappers the generic
 solution
In-Reply-To: <20160120081643.GB3395@osiris>
References: <20160115124646.GD4130@osiris> <20160119175223.GA6603@yury-N73SV>
 <20160120081643.GB3395@osiris>
Message-ID: <20160120121736.GA22029@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 09:16:44AM +0100, Heiko Carstens wrote:
> > +#ifndef __ARCH_WANT_COMPAT_SYS_GETDENTS64
> > +SYSCALL_DEFINE_WRAP3(getdents64, unsigned int, fd,
> > +		struct linux_dirent64 __user *, dirent, unsigned int, count)
> > +#else
> >  SYSCALL_DEFINE3(getdents64, unsigned int, fd,
> >  		struct linux_dirent64 __user *, dirent, unsigned int, count)
> > +#endif
> >  {
> >  	struct fd f;
> >  	struct linux_dirent64 __user * lastdirent;
> 
> This is a non-obvious change at first glance. I think it would make sense
> to split this patch into at least three or four separate patches:
> - one which introduces the infrastructure
> - one which converts the non-obvious syscalls like this one
> - one which converts the rest
> - one which enables the architectures

Agree. This one became too big and non-trivial...
I'll prepare patchset this week. I also think, it's better
to send it separately, like we did with 32/64bit off_t:
https://lkml.org/lkml/2015/12/26/71

> 
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index a76c917..293864c 100644
> > --- a/include/linux/compat.h
> > +++ b/include/linux/compat.h
> > @@ -55,6 +55,52 @@
> >  	}								\
> >  	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
> > 
> > +#define SYSCALL_DEFINE_WRAP1(name, ...) SYSCALL_DEFINE_WRAPx(1, _##name, __VA_ARGS__)
> > +#define SYSCALL_DEFINE_WRAP2(name, ...) SYSCALL_DEFINE_WRAPx(2, _##name, __VA_ARGS__)
> > +#define SYSCALL_DEFINE_WRAP3(name, ...) SYSCALL_DEFINE_WRAPx(3, _##name, __VA_ARGS__)
> > +#define SYSCALL_DEFINE_WRAP4(name, ...) SYSCALL_DEFINE_WRAPx(4, _##name, __VA_ARGS__)
> > +#define SYSCALL_DEFINE_WRAP5(name, ...) SYSCALL_DEFINE_WRAPx(5, _##name, __VA_ARGS__)
> > +#define SYSCALL_DEFINE_WRAP6(name, ...) SYSCALL_DEFINE_WRAPx(6, _##name, __VA_ARGS__)
> > +
> > +#ifndef __SC_COMPAT_TYPE
> > +#define __SC_COMPAT_TYPE(t, a) \
> > +	__typeof(__builtin_choose_expr(sizeof(t) > 4, 0L, (t)0)) a
> > +#endif
> > +
> > +#ifndef __SC_COMPAT_CAST
> > +#define __SC_COMPAT_CAST(t, a)	((t) ((t)(-1) < 0 ? (s64)(s32)(a) : (u64)(u32)(a)))
> > +#endif
> 
> You might consider adding a BUILD_BUG_ON() here, like within the s390 variant.
> 
> Personally I don't like the SYSCALL_DEFINE_WRAPx names too much. But that
> can be changed easily if somebody comes up with a better name for it.

Neither me... Maybe SYSCALL_DEFINE_WRAPPEDx?

> 
> > +#define SYSCALL_DEFINE_WRAPx(x, name, ...)						\
> > +asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));				\
> > +asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))			\
> > +		__attribute__((alias(__stringify(compat_SyS##name))));			\
> > +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__));	\
> > +asmlinkage long notrace compat_SyS##name(__MAP(x,__SC_COMPAT_TYPE,__VA_ARGS__))		\
> > +{											\
> > +	return sys##name(__MAP(x,__SC_COMPAT_CAST,__VA_ARGS__));			\
> > +}											\
> > +SYSCALL_DEFINEx(x, name, __VA_ARGS__)
> 
> Given that the system call functions might be inlined, I think it would
> make sense to remove the "notrace" attribute. Otherwise we would end up
> with lots of untraceable (and unpatchable) functions. I didn't care back
> then for the small compat wrappers...

Ok

> 
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index 0623787..ab14c3f 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -17,27 +17,41 @@ asmlinkage long sys_ni_syscall(void)
> >  }
> > 
> >  cond_syscall(sys_quotactl);
> > +cond_syscall(compat_sys_quotactl);
> 
> It might make sense to add a define which adds both variants.
> 
> Btw. for future versions please add linux-arch to cc.

Ok.

Yury.
