From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 11 May 2014 16:06:03 +0800
Subject: [PATCH v6 07/15] ARM: hisi: enable HiP04
In-Reply-To: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399795571-17231-8-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support HiP04 SoC what supports 16 cores. And it relies on MCPM
framework.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-hisi/Kconfig     | 10 +++++++++-
 arch/arm/mach-hisi/core.h      |  2 ++
 arch/arm/mach-hisi/hisilicon.c | 12 ++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

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
 
diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index af23ec2..1e60795 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -12,4 +12,6 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
+extern bool __init hip04_smp_init_ops(void);
+
 #endif
diff --git a/arch/arm/mach-hisi/hisilicon.c b/arch/arm/mach-hisi/hisilicon.c
index 741faf3..6489e57 100644
--- a/arch/arm/mach-hisi/hisilicon.c
+++ b/arch/arm/mach-hisi/hisilicon.c
@@ -88,3 +88,15 @@ DT_MACHINE_START(HI3620, "Hisilicon Hi3620 (Flattened Device Tree)")
 	.smp		= smp_ops(hi3xxx_smp_ops),
 	.restart	= hi3xxx_restart,
 MACHINE_END
+
+#ifdef CONFIG_ARCH_HIP04
+static const char *hip04_compat[] __initconst = {
+	"hisilicon,hip04-d01",
+	NULL,
+};
+
+DT_MACHINE_START(HIP04, "Hisilicon HiP04 (Flattened Device Tree)")
+	.dt_compat	= hip04_compat,
+	.smp_init	= smp_init_ops(hip04_smp_init_ops),
+MACHINE_END
+#endif
-- 
1.9.1
