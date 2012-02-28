From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Feb 2012 00:15:01 -0300
Subject: [PATCH] ARM: mx3: Setup AIPS registers
Message-ID: <1330398901-20211-1-git-send-email-festevam@gmail.com>
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
 arch/arm/mach-imx/cpu-imx31.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/cpu-imx31.c b/arch/arm/mach-imx/cpu-imx31.c
index 3f2345f..c309d51 100644
--- a/arch/arm/mach-imx/cpu-imx31.c
+++ b/arch/arm/mach-imx/cpu-imx31.c
@@ -60,3 +60,35 @@ int mx31_revision(void)
 	return mx31_cpu_rev;
 }
 EXPORT_SYMBOL(mx31_revision);
+
+static void __init imx_set_aips(void __iomem *base)
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
+ * Clear the on and off peripheral modules Supervisor Protect bit
+ * for SDMA to access them. Did not change the AIPS control registers
+ * (offset 0x20) access type
+ */
+	__raw_writel(0x0, base + 0x40);
+	__raw_writel(0x0, base + 0x44);
+	__raw_writel(0x0, base + 0x48);
+	__raw_writel(0x0, base + 0x4C);
+	reg = __raw_readl(base + 0x50) & 0x00FFFFFF;
+	__raw_writel(reg, base + 0x50);
+}
+
+static int __init post_cpu_init(void)
+{
+	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
+	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
+
+	return 0;
+}
+postcore_initcall(post_cpu_init);
-- 
1.7.1
