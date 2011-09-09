From: nbowler@elliptictech.com (Nick Bowler)
Date: Fri,  9 Sep 2011 11:26:51 -0400
Subject: [PATCH 4/5] ARM: tegra: Use wfi macro in platform_do_lowpower.
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <1315582012-23507-5-git-send-email-nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current Tegra CPU hotplug code includes a hardcoded WFI instruction, in
ARM encoding.  The hardcoded instruction is both hard to understand and
doomed to failure when building the kernel in Thumb-2 mode.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
Compile tested in ARM mode only as I could not build for this platform
in Thumb-2 mode:

/scratch_space/linux-2.6/arch/arm/mach-tegra/headsmp.S: Assembler messages:
/scratch_space/linux-2.6/arch/arm/mach-tegra/headsmp.S:51: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'
---
 arch/arm/mach-tegra/hotplug.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-tegra/hotplug.c b/arch/arm/mach-tegra/hotplug.c
index f329404..4fc72d6 100644
--- a/arch/arm/mach-tegra/hotplug.c
+++ b/arch/arm/mach-tegra/hotplug.c
@@ -13,6 +13,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 
 static inline void cpu_enter_lowpower(void)
 {
@@ -60,13 +61,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
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
 
 		/*if (pen_release == cpu) {*/
 			/*
-- 
1.7.3.4
