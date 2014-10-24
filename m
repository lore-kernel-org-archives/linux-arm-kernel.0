From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 12:49:50 +0200
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
Message-ID: <3042812.F54XYg3Q4M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 03:30:06 Olof's autobuilder wrote:
> Here are the build results from automated periodic testing.
> 
> The tree being built was arm-soc, found at:
> 
> http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git (for-next or to-build branch)
> 
> Topmost commit:
> 
> 06c0773 [EXPERIMENTAL] try to get Linux to build with bare-metal toolchain

This appears to have fixed one problem but not the other:

> Build logs (stderr only) can be found at the following link (experimental):
> 
> http://arm-soc.lixom.net/buildlogs/arm-soc/v3.18-rc1-20-g06c0773/
> 
> 
> 	Runtime:		57m 11s
> 
> 	Passed:			129
> 	Failed:			0
> 
> 	Warnings:		2917
> 
> 	Section mismatches:	0
> 
> -------------------------------------------------------------------------------
> 
> Failed defconfigs:
> 
> -------------------------------------------------------------------------------
> 
> Errors:

All build errors are gone now, after passing -D__linux__. That is good.

>       1 drivers/video/fbdev/sm501fb.c:245:2: warning: format '%zd' expects argument of type 'signed size_t', but argument 8 has type 'size_t' [-Wformat=]
>       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat=]
>       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]

The warnings are completely unchanged, still 249 unique warnings involving size_t,
using this patch:

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
-#define __UINT32_TYPE__        unsigned int
+#define __UINT32_TYPE__                unsigned int
+#endif
+
+#ifdef __SIZE_TYPE__
+#undef __SIZE_TYPE__
+#define __SIZE_TYPE__          unsigned int
 #endif
 
 #ifdef __UINTPTR_TYPE__

	Arnd
