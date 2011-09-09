From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri,  9 Sep 2011 11:26:48 -0400
Subject: [PATCH 1/5] ARM: realview: Use wfi macro in platform_do_lowpower.
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <1315582012-23507-2-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current Realview CPU hotplug code includes a hardcoded WFI instruction,
in ARM encoding.  The hardcoded instruction is both hard to understand
and doomed to failure when building the kernel in Thumb-2 mode.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
Compile tested in both ARM and Thumb-2 mode.
---
 arch/arm/mach-realview/hotplug.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
index a87523d..6d19377 100644
--- a/arch/arm/mach-realview/hotplug.c
+++ b/arch/arm/mach-realview/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 
 extern volatile int pen_release;
 
@@ -61,13 +62,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 	 * code will have already disabled interrupts
 	 */
 	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		wfi();
 
 		if (pen_release == cpu) {
 			/*
-- 
1.7.3.4
