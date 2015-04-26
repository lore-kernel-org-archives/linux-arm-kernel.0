From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:04 +0800
Subject: [PATCH 03/11] ARM: imx: move revision definitions and declarations
 into a header
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The revision definitions and declarations are widely used by clock
drivers.  As a step of moving clock drivers out of arch/arm/mach-imx,
let's create header include/soc/imx/revision.h to accommodate them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/common.h   |  4 ----
 arch/arm/mach-imx/hardware.h |  1 +
 arch/arm/mach-imx/mx27.h     |  4 ----
 arch/arm/mach-imx/mx3x.h     |  7 -------
 arch/arm/mach-imx/mxc.h      | 16 ----------------
 include/soc/imx/revision.h   | 37 +++++++++++++++++++++++++++++++++++++
 6 files changed, 38 insertions(+), 31 deletions(-)
 create mode 100644 include/soc/imx/revision.h

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5cddd1534265..3682d094a259 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -56,13 +56,10 @@ struct platform_device *mxc_register_gpio(char *name, int id,
 void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
-int mx51_revision(void);
-int mx53_revision(void);
 void imx_set_aips(void __iomem *);
 void imx_aips_allow_unprivileged_access(const char *compat);
 int mxc_device_init(void);
 void imx_set_soc_revision(unsigned int rev);
-unsigned int imx_get_soc_revision(void);
 void imx_init_revision_from_anatop(void);
 struct device *imx_soc_device_init(void);
 void imx6_enable_rbc(bool enable);
@@ -87,7 +84,6 @@ enum mx3_cpu_pwr_mode {
 };
 
 void mx3_cpu_lp_set(enum mx3_cpu_pwr_mode mode);
-void imx_print_silicon_rev(const char *cpu, int srev);
 
 void imx_enable_cpu(int cpu, bool enable);
 void imx_set_cpu_jump(int cpu, void *jump_addr);
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 76af2c03c241..d737f95ebb07 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -22,6 +22,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/io.h>
+#include <soc/imx/revision.h>
 #endif
 #include <asm/sizes.h>
 
diff --git a/arch/arm/mach-imx/mx27.h b/arch/arm/mach-imx/mx27.h
index 8a65f192e7f3..f96bb2642677 100644
--- a/arch/arm/mach-imx/mx27.h
+++ b/arch/arm/mach-imx/mx27.h
@@ -231,8 +231,4 @@
 #define MX27_DMA_REQ_SDHC3	36
 #define MX27_DMA_REQ_NFC	37
 
-#ifndef __ASSEMBLY__
-extern int mx27_revision(void);
-#endif
-
 #endif /* ifndef __MACH_MX27_H__ */
diff --git a/arch/arm/mach-imx/mx3x.h b/arch/arm/mach-imx/mx3x.h
index 96fb4fbc8ad7..6fec6114c2f1 100644
--- a/arch/arm/mach-imx/mx3x.h
+++ b/arch/arm/mach-imx/mx3x.h
@@ -185,11 +185,4 @@
 
 #define MX3x_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* Mandatory defines used globally */
-
-#if !defined(__ASSEMBLY__) && !defined(__MXC_BOOT_UNCOMPRESS)
-extern int mx35_revision(void);
-extern int mx31_revision(void);
-#endif
-
 #endif /* ifndef __MACH_MX3x_H__ */
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index 4c1343df2ba4..8726051fcfca 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,22 +39,6 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 
-#define IMX_CHIP_REVISION_1_0		0x10
-#define IMX_CHIP_REVISION_1_1		0x11
-#define IMX_CHIP_REVISION_1_2		0x12
-#define IMX_CHIP_REVISION_1_3		0x13
-#define IMX_CHIP_REVISION_1_4		0x14
-#define IMX_CHIP_REVISION_1_5		0x15
-#define IMX_CHIP_REVISION_2_0		0x20
-#define IMX_CHIP_REVISION_2_1		0x21
-#define IMX_CHIP_REVISION_2_2		0x22
-#define IMX_CHIP_REVISION_2_3		0x23
-#define IMX_CHIP_REVISION_3_0		0x30
-#define IMX_CHIP_REVISION_3_1		0x31
-#define IMX_CHIP_REVISION_3_2		0x32
-#define IMX_CHIP_REVISION_3_3		0x33
-#define IMX_CHIP_REVISION_UNKNOWN	0xff
-
 #define IMX_DDR_TYPE_LPDDR2		1
 
 #ifndef __ASSEMBLY__
diff --git a/include/soc/imx/revision.h b/include/soc/imx/revision.h
new file mode 100644
index 000000000000..9ea346924c35
--- /dev/null
+++ b/include/soc/imx/revision.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __SOC_IMX_REVISION_H__
+#define __SOC_IMX_REVISION_H__
+
+#define IMX_CHIP_REVISION_1_0		0x10
+#define IMX_CHIP_REVISION_1_1		0x11
+#define IMX_CHIP_REVISION_1_2		0x12
+#define IMX_CHIP_REVISION_1_3		0x13
+#define IMX_CHIP_REVISION_1_4		0x14
+#define IMX_CHIP_REVISION_1_5		0x15
+#define IMX_CHIP_REVISION_2_0		0x20
+#define IMX_CHIP_REVISION_2_1		0x21
+#define IMX_CHIP_REVISION_2_2		0x22
+#define IMX_CHIP_REVISION_2_3		0x23
+#define IMX_CHIP_REVISION_3_0		0x30
+#define IMX_CHIP_REVISION_3_1		0x31
+#define IMX_CHIP_REVISION_3_2		0x32
+#define IMX_CHIP_REVISION_3_3		0x33
+#define IMX_CHIP_REVISION_UNKNOWN	0xff
+
+int mx27_revision(void);
+int mx31_revision(void);
+int mx35_revision(void);
+int mx51_revision(void);
+int mx53_revision(void);
+
+unsigned int imx_get_soc_revision(void);
+void imx_print_silicon_rev(const char *cpu, int srev);
+
+#endif /* __SOC_IMX_REVISION_H__ */
-- 
1.9.1
