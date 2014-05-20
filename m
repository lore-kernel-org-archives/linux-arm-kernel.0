From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 May 2014 21:10:19 +0800
Subject: [PATCH v9 06/14] ARM: hisi: enable HiP04
In-Reply-To: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1400591427-21922-7-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC what supports 16 cores. And it relies on MCPM
framework.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 10 +++++++++-
 arch/arm/mach-hisi/hisilicon.c |  9 +++++++++
 arch/arm/mach-hisi/platmcpm.c  |  1 -
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index da16efd..3f1ece7 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -17,7 +17,15 @@ config ARCH_HI3xxx
 	select PINCTRL
 	select PINCTRL_SINGLE
 	help
-	  Support for Hisilicon Hi36xx/Hi37xx processor family
+	  Support for Hisilicon Hi36xx/Hi37xx SoC family
+
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select HAVE_ARM_ARCH_TIMER
+	select MCPM if SMP
+	select MCPM_QUAD_CLUSTER if SMP
+	help
+	  Support for Hisilicon HiP04 SoC family
 
 endmenu
 
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..a9f648f 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -88,3 +88,12 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
 MACHINE_END
+
+static const char *hip04_compat[] __initconst = {
+	"hisilicon,hip04-d01",
+	NULL,
+};
+
+DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
+	.dt_compat	= hip04_compat,
+MACHINE_END
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index b991e82..2bda12b 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -134,7 +134,6 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
 	       CORE_DEBUG_RESET_BIT(cpu);
 	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
 	spin_unlock_irq(&boot_lock);
-	msleep(POLL_MSEC);
 
 	return 0;
 }
-- 
1.9.1
