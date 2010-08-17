From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Aug 2010 16:58:02 +0100
Subject: [PATCH 1/3] ARM: realview: fix CPU hotplug support for SMP platforms
In-Reply-To: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
References: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
Message-ID: <1282060684-27761-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current CPU hotplug functions for RealView boards suffer from a number
of problems:

- The location of the SMP/AMP bit in the Auxiliary Control Register is
  correct only for 11MPCore.

- The I-cache is not flushed when a core leaves lowpower mode

- The assembly routines for entering/leaving the lowpower state can
  be made more readable by using macros for operations such as dsb().

This patch fixes these problems for the RealView boards and has been
tested successfully on the PB11MPCore board.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-realview/hotplug.c |   39 +++++++++++++++++++++++--------------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index f95521a..fdb79dd 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -8,11 +8,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
 
+#include <mach/board-eb.h>
+#include <mach/board-pbx.h>
+
 #include <asm/cacheflush.h>
 
 extern volatile int pen_release;
@@ -21,42 +25,50 @@ static DECLARE_COMPLETION(cpu_killed);
 
 static inline void cpu_enter_lowpower(void)
 {
-	unsigned int v;
+	unsigned int v, smp_ctrl;
+
+	smp_ctrl = (core_tile_pbxa9mp() || core_tile_a9mp()) ? 0x40 : 0x20;
 
 	flush_cache_all();
+	dsb();
 	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
 	/*
 	 * Turn off coherency
 	 */
 	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x20\n"
+	"	bic	%0, %0, %1\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
+	/* DSB */
+	"       mcr     p15, 0, %2, c7, c10, 4\n"
+	/* Disable D-cache */
 	"	mrc	p15, 0, %0, c1, c0, 0\n"
 	"	bic	%0, %0, #0x04\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	  : "=&r" (v)
-	  : "r" (0)
-	  : "cc");
+	  : "r" (smp_ctrl), "r" (0)
+	  : "memory");
 }
 
 static inline void cpu_leave_lowpower(void)
 {
-	unsigned int v;
+	unsigned int v, smp_ctrl;
 
+	smp_ctrl = (core_tile_pbxa9mp() || core_tile_a9mp()) ? 0x40 : 0x20;
+
+	flush_cache_all();
+	dsb();
 	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
 	"	orr	%0, %0, #0x04\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, #0x20\n"
+	"	orr	%0, %0, %1\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
 	  : "=&r" (v)
-	  :
-	  : "cc");
+	  : "r" (smp_ctrl)
+	  : "memory");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu)
+static void __ref platform_do_lowpower(unsigned int cpu)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
@@ -67,10 +79,7 @@ static inline void platform_do_lowpower(unsigned int cpu)
 		/*
 		 * here's the WFI
 		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		asm volatile("wfi" : : : "memory");
 
 		if (pen_release == cpu) {
 			/*
-- 
1.6.3.3
