From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 04 May 2011 09:51:24 +0900
Subject: [PATCH] ARM: EXYNOS4: Bugfix Hotplug
Message-ID: <1304470284-25770-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When tested with "NURI" board, Exynos4 has not been working
properly and showed error messages when the secondary core is being
enabled with hotplug. The NURI board has Exynos4 of revision 1.

This patch enables Exynos4's hotplug to work properly.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos4/hotplug.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
index 2b5909e..b81a24a 100644
--- a/arch/arm/mach-exynos4/hotplug.c
+++ b/arch/arm/mach-exynos4/hotplug.c
@@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
 	 * Turn off coherency
 	 */
 	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, %3\n"
+	"	bic	%0, %0, #0x41\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
 	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
+	"	bic	%0, %0, #0x04\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
+	  : "r" (0)
 	  : "cc");
 }
 
@@ -45,14 +45,14 @@ static inline void cpu_leave_lowpower(void)
 	unsigned int v;
 
 	asm volatile(
-	"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
+	"	mrc	p15, 0, %0, c1, c0, 0\n"
+	"	orr	%0, %0, #0x04\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, %2\n"
+	"	orr	%0, %0, #0x41\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
 	  : "=&r" (v)
-	  : "Ir" (CR_C), "Ir" (0x40)
+	  :
 	  : "cc");
 }
 
-- 
1.7.4.1
