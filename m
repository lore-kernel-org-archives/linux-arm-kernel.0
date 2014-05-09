From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri,  9 May 2014 13:59:01 +0400
Subject: [PATCH 2/3] ARM: i.MX1 clk: Add devicetree support
In-Reply-To: <1399629542-32387-1-git-send-email-shc_work@mail.ru>
References: <1399629542-32387-1-git-send-email-shc_work@mail.ru>
Message-ID: <1399629542-32387-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds devicetree support CCM module for i.MX1 (MC9328MX1) CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/clock/imx1-clock.txt       | 46 ++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx1.c                       | 10 ++++-
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/imx1-clock.txt b/Documentation/devicetree/bindings/clock/imx1-clock.txt
new file mode 100644
index 0000000..f66fe37
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx1-clock.txt
@@ -0,0 +1,46 @@
+* Clock bindings for Freescale i.MX1
+
+Required properties:
+- compatible: Should be "fsl,imx1-ccm".
+- reg: Address and length of the register set.
+- interrupts: Should contain CCM interrupt.
+- #clock-cells: Should be <1>.
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. The following is a full list of i.MX1
+clocks and IDs.
+
+	Clock			ID
+	---------------------------
+	dummy			0
+	clk32			1
+	clk16m_ext		2
+	clk16m			3
+	clk32_premult		4
+	prem			5
+	mpll			6
+	mpll_gate		7
+	spll			8
+	spll_gate		9
+	mcu			10
+	fclk			11
+	hclk			12
+	clk48m			13
+	per1			14
+	per2			15
+	per3			16
+	clko			17
+	uart3_gate		18
+	ssi2_gate		19
+	brom_gate		20
+	dma_gate		21
+	csi_gate		22
+	mma_gate		23
+	usbd_gate		24
+
+Examples:
+	clks: ccm at 0021b000 {
+		compatible = "fsl,imx1-ccm";
+		reg = <0x0021b000 0x1000>;
+		interrupts = <59>;
+	};
diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 602b30a..d13dce4 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -20,7 +20,9 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include "clk.h"
 #include "common.h"
@@ -57,7 +59,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	int i;
 
 	clk[dummy] = imx_clk_fixed("dummy", 0);
-	clk[clk32] = imx_clk_fixed("clk32", fref);
+	clk[clk32] = imx_obtain_fixed_clock("clk32", fref);
 	clk[clk16m_ext] = imx_clk_fixed("clk16m_ext", 16000000);
 	clk[clk16m] = imx_clk_gate("clk16m", "clk16m_ext", CCM_CSCR, 17);
 	clk[clk32_premult] = imx_clk_fixed_factor("clk32_premult", "clk32", 512, 1);
@@ -120,3 +122,9 @@ int __init mx1_clocks_init(unsigned long fref)
 
 	return 0;
 }
+
+static void __init mx1_clocks_init_dt(struct device_node *np)
+{
+	mx1_clocks_init(32768);
+}
+CLK_OF_DECLARE(imx1_ccm, "fsl,imx1-ccm", mx1_clocks_init_dt);
-- 
1.8.3.2
