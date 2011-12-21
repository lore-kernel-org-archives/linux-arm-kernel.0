From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 21 Dec 2011 22:38:23 +0800
Subject: [PATCH] ARM: imx6q: build pm code only when CONFIG_PM selected
Message-ID: <1324478303-3899-1-git-send-email-eric.miao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Eric Miao <eric.miao@linaro.org>
---
 arch/arm/mach-imx/Kconfig               |    1 +
 arch/arm/mach-imx/Makefile              |    6 +++++-
 arch/arm/mach-imx/head-v7.S             |    2 ++
 arch/arm/plat-mxc/include/mach/common.h |    8 +++++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c44aa97..6ee6803 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -602,6 +602,7 @@ config SOC_IMX6Q
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
+	select ARM_CPU_SUSPEND if PM
 	select USE_OF
 
 	help
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index aba7321..7a739bb 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,4 +70,8 @@ AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
+
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o
+endif
diff --git a/arch/arm/mach-imx/head-v7.S b/arch/arm/mach-imx/head-v7.S
index 6229efb..a59cae7 100644
--- a/arch/arm/mach-imx/head-v7.S
+++ b/arch/arm/mach-imx/head-v7.S
@@ -71,6 +71,7 @@ ENTRY(v7_secondary_startup)
 ENDPROC(v7_secondary_startup)
 #endif
 
+#ifdef CONFIG_PM
 /*
  * The following code is located into the .data section.  This is to
  * allow phys_l2x0_saved_regs to be accessed with a relative load
@@ -97,3 +98,4 @@ ENDPROC(v7_cpu_resume)
 	.globl	phys_l2x0_saved_regs
 phys_l2x0_saved_regs:
         .long   0
+#endif
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index c75f254..f4ebdb8 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -131,6 +131,12 @@ extern void imx53_evk_common_init(void);
 extern void imx53_qsb_common_init(void);
 extern void imx53_smd_common_init(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
-extern void imx6q_pm_init(void);
 extern void imx6q_clock_map_io(void);
+
+#ifdef CONFIG_PM
+extern void imx6q_pm_init(void);
+#else
+static inline void imx6q_pm_init(void) {}
+#endif
+
 #endif
-- 
1.7.5.4
