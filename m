From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:03 +0800
Subject: [PATCH v10 04/11] ARM: hisi: enable HiP04
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC what supports 16 cores. And it relies on MCPM
framework.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 8 ++++++++
 arch/arm/mach-hisi/hisilicon.c | 9 +++++++++
 arch/arm/mach-hisi/platmcpm.c  | 1 -
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 90fdbb4..a458f28 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -19,6 +19,14 @@ config ARCH_HI3xxx
 	help
 	  Support for Hisilicon Hi36xx SoC family
 
+config ARCH_HIP04
+	bool "Hisilicon HiP04 Cortex A15 family" if ARCH_MULTI_V7
+	select HAVE_ARM_ARCH_TIMER
+	select MCPM if SMP
+	select MCPM_QUAD_CLUSTER if SMP
+	help
+	  Support for Hisilicon HiP04 SoC family
+
 config ARCH_HIX5HD2
 	bool "Hisilicon X5HD2 family" if ARCH_MULTI_V7
 	select CACHE_L2X0
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index e842ca9..938cdba 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -114,3 +114,12 @@ DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
 	.smp		= smp_ops(hix5hd2_smp_ops),
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
index 3befcb3..d903d75 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -116,7 +116,6 @@ static int hip04_mcpm_power_up(unsigned int cpu, unsigned int cluster)
 	       CORE_DEBUG_RESET_BIT(cpu);
 	writel_relaxed(data, sysctrl + SC_CPU_RESET_DREQ(cluster));
 	spin_unlock_irq(&boot_lock);
-	msleep(POLL_MSEC);
 
 	return 0;
 }
-- 
1.9.1
