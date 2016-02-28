From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:06 +0000
Subject: [PATCH v5 15/20] clk: bcm2835: add additional clocks
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-16-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add definitions for the following clocks:
* AVE0
* DFT
* GP0
* GP1
* GP2
* PULSE
* SLIM
* SMI
* TEC

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   71 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/bcm2835.h |   10 +++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index ff02871..5c62672 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -118,6 +118,8 @@
 #define CM_SDCCTL		0x1a8
 #define CM_SDCDIV		0x1ac
 #define CM_ARMCTL		0x1b0
+#define CM_AVEOCTL		0x1b8
+#define CM_AVEODIV		0x1bc
 #define CM_EMMCCTL		0x1c0
 #define CM_EMMCDIV		0x1c4
 
@@ -1711,6 +1713,18 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_TSENSDIV,
 		.int_bits = 5,
 		.frac_bits = 0),
+	[BCM2835_CLOCK_PULSE]	= REGISTER_OSC_CLK(
+		.name = "pulse",
+		.ctl_reg = CM_PULSECTL,
+		.div_reg = CM_PULSEDIV,
+		.int_bits = 12,
+		.frac_bits = 0),
+	[BCM2835_CLOCK_TEC]	= REGISTER_OSC_CLK(
+		.name = "tec",
+		.ctl_reg = CM_TECCTL,
+		.div_reg = CM_TECDIV,
+		.int_bits = 6,
+		.frac_bits = 0),
 
 	/* clocks with vpu parent mux */
 	[BCM2835_CLOCK_H264]	= REGISTER_VPU_CLK(
@@ -1725,6 +1739,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_ISPDIV,
 		.int_bits = 4,
 		.frac_bits = 8),
+
 	/*
 	 * Secondary SDRAM clock.  Used for low-voltage modes when the PLL
 	 * in the SDRAM controller can't be used.
@@ -1756,6 +1771,24 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.is_vpu_clock = true),
 
 	/* clocks with per parent mux */
+	[BCM2835_CLOCK_AVEO]	= REGISTER_PER_CLK(
+		.name = "aveo",
+		.ctl_reg = CM_AVEOCTL,
+		.div_reg = CM_AVEODIV,
+		.int_bits = 4,
+		.frac_bits = 0),
+	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
+		.name = "dft",
+		.ctl_reg = CM_DFTCTL,
+		.div_reg = CM_DFTDIV,
+		.int_bits = 5,
+		.frac_bits = 0),
+	[BCM2835_CLOCK_DFT]	= REGISTER_PER_CLK(
+		.name = "dpi",
+		.ctl_reg = CM_DPICTL,
+		.div_reg = CM_DPIDIV,
+		.int_bits = 4,
+		.frac_bits = 8),
 
 	/* Arasan EMMC clock */
 	[BCM2835_CLOCK_EMMC]	= REGISTER_PER_CLK(
@@ -1764,6 +1797,30 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.div_reg = CM_EMMCDIV,
 		.int_bits = 4,
 		.frac_bits = 8),
+
+	/* General purpose (GPIO) clocks */
+	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
+		.name = "gp0",
+		.ctl_reg = CM_GP0CTL,
+		.div_reg = CM_GP0DIV,
+		.int_bits = 12,
+		.frac_bits = 12,
+		.is_mash_clock = true),
+	[BCM2835_CLOCK_GP1]	= REGISTER_PER_CLK(
+		.name = "gp1",
+		.ctl_reg = CM_GP1CTL,
+		.div_reg = CM_GP1DIV,
+		.int_bits = 12,
+		.frac_bits = 12,
+		.is_mash_clock = true),
+	[BCM2835_CLOCK_GP2]	= REGISTER_PER_CLK(
+		.name = "gp2",
+		.ctl_reg = CM_GP2CTL,
+		.div_reg = CM_GP2DIV,
+		.int_bits = 12,
+		.frac_bits = 12,
+		.is_mash_clock = true),
+
 	/* HDMI state machine */
 	[BCM2835_CLOCK_HSM]	= REGISTER_PER_CLK(
 		.name = "hsm",
@@ -1785,12 +1842,26 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.int_bits = 12,
 		.frac_bits = 12,
 		.is_mash_clock = true),
+	[BCM2835_CLOCK_SLIM]	= REGISTER_PER_CLK(
+		.name = "slim",
+		.ctl_reg = CM_SLIMCTL,
+		.div_reg = CM_SLIMDIV,
+		.int_bits = 12,
+		.frac_bits = 12,
+		.is_mash_clock = true),
+	[BCM2835_CLOCK_SMI]	= REGISTER_PER_CLK(
+		.name = "smi",
+		.ctl_reg = CM_SMICTL,
+		.div_reg = CM_SMIDIV,
+		.int_bits = 4,
+		.frac_bits = 8),
 	[BCM2835_CLOCK_UART]	= REGISTER_PER_CLK(
 		.name = "uart",
 		.ctl_reg = CM_UARTCTL,
 		.div_reg = CM_UARTDIV,
 		.int_bits = 10,
 		.frac_bits = 12),
+
 	/* TV encoder clock.  Only operating frequency is 108Mhz.  */
 	[BCM2835_CLOCK_VEC]	= REGISTER_PER_CLK(
 		.name = "vec",
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index 9689812..f2e72e7 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -53,3 +53,13 @@
 #define BCM2835_PLLB_SP2		36
 #define BCM2835_PLLD_DSI0		37
 #define BCM2835_PLLD_DSI1		38
+
+#define BCM2835_CLOCK_AVEO		39
+#define BCM2835_CLOCK_DFT		40
+#define BCM2835_CLOCK_GP0		41
+#define BCM2835_CLOCK_GP1		42
+#define BCM2835_CLOCK_GP2		43
+#define BCM2835_CLOCK_PULSE		44
+#define BCM2835_CLOCK_SLIM		45
+#define BCM2835_CLOCK_SMI		46
+#define BCM2835_CLOCK_TEC		47
-- 
1.7.10.4
