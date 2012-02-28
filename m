From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 28 Feb 2012 09:23:46 -0300
Subject: [PATCH v2] ARM: mx3: Setup AIPS registers
Message-ID: <1330431826-29217-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was observed on a mx31pdk board that audio playback only worked when the bootloader was Redboot, and 
did not work when U-boot was used. 

Comparing the sources of these bootloaders showed that the AIPS registers were not setup in U-boot.

Instead of relying on the bootloader to setup the AIPS registers, do it in the kernel so that audio
playback can work independantly of the bootloader being used.

Copied the AIPS settings from Redboot to the kernel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Make sure post_cpu_init() only runs on mx31
- Place imx_set_aips() in a common location so that other SoCs can use it.
- Improve comments about OPACRx

 arch/arm/mach-imx/cpu-imx31.c           |   11 +++++++++++
 arch/arm/plat-mxc/cpu.c                 |   24 ++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 3 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index 3f2345f..8841039 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -60,3 +60,14 @@ int mx31_revision(void)
 	return mx31_cpu_rev;
 }
 EXPORT_SYMBOL(mx31_revision);
+
+static int __init post_cpu_init(void)
+{
+	if (cpu_is_mx31()) {
+		imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
+		imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
+	}
+
+	return 0;
+}
+postcore_initcall(post_cpu_init);
diff --git a/arch/arm/plat-mxc/cpu.c b/arch/arm/plat-mxc/cpu.c
index f5b7e0f..a20a131 100644
--- a/arch/arm/plat-mxc/cpu.c
+++ b/arch/arm/plat-mxc/cpu.c
@@ -1,5 +1,6 @@
 
 #include <linux/module.h>
+#include <linux/io.h>
 #include <mach/hardware.h>
 
 unsigned int __mxc_cpu_type;
@@ -18,3 +19,26 @@ void imx_print_silicon_rev(const char *cpu, int srev)
 		pr_info("CPU identified as %s, silicon rev %d.%d\n",
 				cpu, (srev >> 4) & 0xf, srev & 0xf);
 }
+
+void __init imx_set_aips(void __iomem *base)
+{
+	unsigned int reg;
+/*
+ * Set all MPROTx to be non-bufferable, trusted for R/W,
+ * not forced to user-mode.
+ */
+	__raw_writel(0x77777777, base + 0x0);
+	__raw_writel(0x77777777, base + 0x4);
+
+/*
+ * Set all OPACRx to be non-bufferable, to not require
+ * supervisor privilege level for access, allow for
+ * write access and untrusted master access.
+ */
+	__raw_writel(0x0, base + 0x40);
+	__raw_writel(0x0, base + 0x44);
+	__raw_writel(0x0, base + 0x48);
+	__raw_writel(0x0, base + 0x4C);
+	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
+	__raw_writel(reg, base + 0x50);
+}
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 1bf0df8..16c3864 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -75,6 +75,7 @@ extern void mxc_restart(char, const char *);
 extern void mxc_arch_reset_init(void __iomem *);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern void imx_set_aips(void __iomem *);
 
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
-- 
1.7.1
