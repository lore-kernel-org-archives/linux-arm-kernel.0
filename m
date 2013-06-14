From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 14 Jun 2013 14:41:46 +0530
Subject: [PATCH] ARM: OMAP5: Fix omap5 standalone build break
Message-ID: <1371201107-20929-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building omap5 standalone results in the below errors..

arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'
arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_core_count'

Fix this by adding the missing select for HAVE_ARM_SCU for SOC_OMAP5

Reported-by: Pekon Gupta <pekon@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..81690a2 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -109,6 +109,7 @@ config SOC_OMAP5
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
 	select CPU_V7
+	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
-- 
1.7.9.5
