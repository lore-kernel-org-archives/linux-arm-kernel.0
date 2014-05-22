From: leela.krishna@linaro.org (Leela Krishna Amudala)
Date: Thu, 22 May 2014 13:27:35 +0530
Subject: [PATCH] ARM: EXYNOS: Use wfi macro in platform_do_lowpower
Message-ID: <1400745455-27920-1-git-send-email-leela.krishna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is originally based on commit b3377d186572 ("ARM: 7064/1:
vexpress: Use wfi macro in platform_do_lowpower.")

Current Exynos CPU hotplug code includes a hardcoded WFI
instruction, in ARM encoding.  When the kernel is compiled in Thumb-2
mode, this is invalid and causes the machine to hang hard when a CPU
is offlined.

Use wfi macro instead of the hardcoded WFI instruction.

Signed-off-by: Leela Krishna Amudala <leela.krishna@linaro.org>
---
 arch/arm/mach-exynos/hotplug.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 69fa483..8a134d0 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -46,13 +46,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 		if (cpu == 1)
 			exynos_cpu_power_down(cpu);
 
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
+		wfi();
 
 		if (pen_release == cpu_logical_map(cpu)) {
 			/*
-- 
1.7.9.5
