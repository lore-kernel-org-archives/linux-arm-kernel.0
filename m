From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 11:00:23 +0100
Subject: [PATCH 2/8] ARM i.MX51: setup mipi
In-Reply-To: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
References: <1298887229-7987-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1298887229-7987-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mipi unit has to be brought to a sane default state. This
unit is not present on i.MX53, so we add the setup here instead
of the ipu driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx5/cpu.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
index d40671d..1de2ca2 100644
--- a/arch/arm/mach-mx5/cpu.c
+++ b/arch/arm/mach-mx5/cpu.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <mach/hardware.h>
 #include <asm/io.h>
 
@@ -102,11 +104,45 @@ int mx53_revision(void)
 }
 EXPORT_SYMBOL(mx53_revision);
 
+/*
+ * The MIPI HSC unit has been removed from the i.MX51 Reference Manual by
+ * the Freescale marketing division. However this did not remove the
+ * hardware from the chip which still needs to be configured for proper
+ * IPU support.
+ */
+static void __init ipu_mipi_setup(void)
+{
+	struct clk *hsc_clk;
+	void __iomem *hsc_addr;
+
+	hsc_addr = MX51_IO_ADDRESS(MX51_MIPI_HSC_BASE_ADDR);
+
+	hsc_clk = clk_get_sys(NULL, "mipi_hsp");
+	if (IS_ERR(hsc_clk)) {
+		pr_err("failed to get mipi clock\n");
+		return;
+	}
+	clk_enable(hsc_clk);
+
+	/* setup MIPI module to legacy mode */
+	__raw_writel(0xf00, hsc_addr);
+
+	/* CSI mode: reserved; DI control mode: legacy (from Freescale BSP) */
+	__raw_writel(__raw_readl(hsc_addr + 0x800) | 0x30ff,
+		hsc_addr + 0x800);
+
+	clk_disable(hsc_clk);
+	clk_put(hsc_clk);
+}
+
 static int __init post_cpu_init(void)
 {
 	unsigned int reg;
 	void __iomem *base;
 
+	if (cpu_is_mx51())
+		ipu_mipi_setup();
+
 	if (cpu_is_mx51() || cpu_is_mx53()) {
 		if (cpu_is_mx51())
 			base = MX51_IO_ADDRESS(MX51_AIPS1_BASE_ADDR);
-- 
1.7.2.3
