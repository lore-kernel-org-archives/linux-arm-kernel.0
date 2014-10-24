From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 11:34:39 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <13842628.d0ipOeqpYt@wuerfel>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <CAOesGMh3ivsvrXpKj7J8tbSXnXutXJdkfm=sbo0j_eJVAQgFsg@mail.gmail.com>
 <13842628.d0ipOeqpYt@wuerfel>
Message-ID: <2166932.WW1ogsp4vG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 11:13:27 Arnd Bergmann wrote:
> On Thursday 23 October 2014 13:33:13 Olof Johansson wrote:
> > On Thu, Oct 23, 2014 at 1:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 23 October 2014 17:12:20 Russell King - ARM Linux wrote:
> > >>
> > >> > I haven't found the code in gcc that performs the type check for
> > >> > printf, but I've found a comment about that code intentionally
> > >> > resolving the type (printing 'unsigned int') when the typedef
> > >> > does not match the expected type.
> > >>
> > >> If I had a copy of the GCC 4.9 source locally, I'd dig into it too and
> > >> try to work out what's going on.  My gut feeling is that it's a bug in
> > >> GCC rather than something which the kernel is doing wrong.
> > >>
> > >
> > > I suspect it has something to do with the way that Olof's gcc is built,
> > > since it doesn't happen for me using the same kernel source and gcc-4.9.1
> > > or 4.10-prerelease.
> > 
> > Mine is a 4.9.1 built with segher's buildall scripts.
> > 
> 
> Ok, that also explains the problems with the missing __linux__ macro, given
> Ard's reply about bare-metal gcc.
> 
> I think we have two choices here:
> 
> a) change the buildall script so it actually builds a compiler that behaves
>    in the way we expect for the kernel (__SIZE_TYPE__ and __linux__ at least,
>    possibly others)
> 
> b) change the kernel to work with the way the bare-metal compiler is built,
>    adding -D__linux__ in the ARM Makefile and applying Ard's workaround for
>    __SIZE_TYPE__/__INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__.
> 
> Both options are a little hacky and I don't really like them, but I think
> it makes sense to do one of them.

I now realized that Ard's fix for __INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__
was actually merged into the kernel but we are just missing the respective
__SIZE_TYPE__ change. I guess we should probably continue down that path then.

I've pushed the patch below to the to-build branch of arm-soc, so we should
see the output of Olof's build bot soon. If that works and everybody thinks
this is the right approach, I can add it to Russell's patch tracker.

I'm still undecided about the __linux__ macro, the alternative would be to
change the aic7xxx.h/coda.h/radeon_cp.c files to test for __KERNEL__ as well,
like we do in some other drivers.

	Arnd

commit 06c07738af3c409d89df5f9d370a52850faf260a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Oct 24 11:28:10 2014 +0200

    [EXPERIMENTAL] try to get Linux to build with bare-metal toolchain
    
    Toolchains built for bare-metal ARM targets rather than libc based
    targets do not set the __linux__ macro, and some types are slightly
    different, which causes annoying build errors.
    
    We already have workarounds in the kernel for some of the types,
    and this adds another one for size_t, which was recently discovered
    to be missing.
    
    We also set __linux__ unconditionally in the top-level Makefile,
    which gets a few drivers to build.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 034a94904d69..6646c1170d44 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -40,6 +40,9 @@ ifeq ($(CONFIG_FRAME_POINTER),y)
 KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
 endif
 
+# freestanding toolchains don't define __linux__
+KBUILD_CFLAGS	+= -D__linux__
+
 ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 AS		+= -EB
diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
index a53cdb8f068c..baaa8739b0bf 100644
--- a/arch/arm/include/asm/types.h
+++ b/arch/arm/include/asm/types.h
@@ -16,7 +16,7 @@
  * types, so 'linux/types.h' and 'stdint.h' can be safely included from the same
  * source file (provided that -ffreestanding is used).
  *
- *                    int32_t         uint32_t               uintptr_t
+ *                    int32_t         uint32_t/size_t        uintptr_t
  * bare metal GCC     long            unsigned long          unsigned int
  * glibc GCC          int             unsigned int           unsigned int
  * kernel             int             unsigned int           unsigned long
@@ -29,7 +29,12 @@
 
 #ifdef __UINT32_TYPE__
 #undef __UINT32_TYPE__
-#define __UINT32_TYPE__	unsigned int
+#define __UINT32_TYPE__		unsigned int
+#endif
+
+#ifdef __SIZE_TYPE__
+#undef __SIZE_TYPE__
+#define __SIZE_TYPE__		unsigned int
 #endif
 
 #ifdef __UINTPTR_TYPE__
