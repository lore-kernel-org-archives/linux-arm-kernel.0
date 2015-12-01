From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Dec 2015 02:35:03 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <12844690.Yr8y3jA010@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <3754277.KmO9Nk3XLD@wuerfel> <20151201212904.GA14442@yury-N73SV>
 <12844690.Yr8y3jA010@wuerfel>
Message-ID: <20151201233503.GA23156@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 11:39:42PM +0100, Arnd Bergmann wrote:
> On Wednesday 02 December 2015 00:29:04 Yury Norov wrote:
> > > > +#define compat_sys_shmat               sys_shmat
> > > 
> > > What's special about compat_sys_shmat?
> > > 
> > 
> > It's about  	 definition.
> > For aarch32 glibc defines it as (__getpagesize () << 2).
> > For ILP32 there's no definition, and so generic one is used: (__getpagesize ()).
> 
> Ok, got it.
> 
> > In kernel, for ARM64, COMPAT_SHMLBA defined just as 0x4000. Both
> > compat and non-compat shmat syscalls pass identical arguments to
> > do_shmat, except shmlba. Effectively, library expects shmlba to
> > be 0x1000, as sys_shmat does. And compat_sys_shmat expects 0x4000.
> > 
> > I think, both kernel and library parts are to be fixed. In library
> > we'd use definition identical to ARM. For kernel we'd use compat
> > syscall.
> 
> I'm not sure I understand this part. What changes specifically do we need?
> 

For kernel:

        diff --git a/arch/arm64/include/asm/shmparam.h b/arch/arm64/include/asm/shmparam.h
        index 4df608a..e368a55 100644
        --- a/arch/arm64/include/asm/shmparam.h
        +++ b/arch/arm64/include/asm/shmparam.h
        @@ -21,7 +21,7 @@
          * alignment value. Since we don't have aliasing D-caches, the rest of
          * the time we can safely use PAGE_SIZE.
          */
        -#define COMPAT_SHMLBA	0x4000
        +#define COMPAT_SHMLBA	(4 * PAGE_SIZE)
         
         #include <asm-generic/shmparam.h>
         
        diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
        index c5bc712..877bedf 100644
        --- a/arch/arm64/kernel/sys_ilp32.c
        +++ b/arch/arm64/kernel/sys_ilp32.c
        @@ -42,15 +42,12 @@ asmlinkage long sys_rt_sigreturn_wrapper(void);
         #define compat_sys_pwrite64            sys_pwrite64
         #define compat_sys_readahead           sys_readahead
         #define compat_sys_rt_sigaction        sys_rt_sigaction
        -#define compat_sys_shmat               sys_shmat
         #define compat_sys_sync_file_range     sys_sync_file_range
         #define compat_sys_truncate64          sys_truncate
         #define compat_sys_sigaltstack         sys_sigaltstack
 
For library - just create a header in ilp32 directory that defines
SHMLBA exactly as arm: __getpagesize () << 2

> It sounds like shmat is one of the cases we an override makes sense
> and we should use sys_shmat with PAGE_SIZE for aarch64 ilp32 mode.
> 

[...]

> We normally assume that the page size on ARM is fixed to 4K, so
> there might be user space that just hardcodes 16K SHMLBA 

It means that we should use compat_sys_shmat because hardcoded
userspace may have a chance to work for 4K pages. If we'll use
sys_shmat (and so 4K SHMLBA), we'll definitely make hardcoded
userspace broken. Non-hardcoded userspace will work anyway.

We can describe in documentation that 4k pages are prefferable.

Yury
