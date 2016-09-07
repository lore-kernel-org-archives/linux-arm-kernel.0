From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:38 +0200
Subject: [PATCH 2/7] pinctrl: amlogic: gxbb: add nand pins
In-Reply-To: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473261223-15412-3-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EE domains pins for the NAND flash controller.
Even tough we have no driver for the NAND flash controller yet, we need
to have these pins in pinctrl as the actual pin are shared with the spifc
controller. The bootloader on the S905-P200 setup pinmux for the NAND
controller so we need the kernel to properly deactivate this if necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 802ad83..08e6cdd 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -168,6 +168,15 @@ static const unsigned int sdcard_d3_pins[] = { PIN(CARD_4, EE_OFF) };
 static const unsigned int sdcard_cmd_pins[] = { PIN(CARD_3, EE_OFF) };
 static const unsigned int sdcard_clk_pins[] = { PIN(CARD_2, EE_OFF) };
 
+static const unsigned int nand_ce0_pins[]	= { PIN(BOOT_8, EE_OFF) };
+static const unsigned int nand_ce1_pins[]	= { PIN(BOOT_9, EE_OFF) };
+static const unsigned int nand_rb0_pins[]	= { PIN(BOOT_10, EE_OFF) };
+static const unsigned int nand_ale_pins[]	= { PIN(BOOT_11, EE_OFF) };
+static const unsigned int nand_cle_pins[]	= { PIN(BOOT_12, EE_OFF) };
+static const unsigned int nand_wen_clk_pins[]	= { PIN(BOOT_13, EE_OFF) };
+static const unsigned int nand_ren_wr_pins[]	= { PIN(BOOT_14, EE_OFF) };
+static const unsigned int nand_dqs_pins[]	= { PIN(BOOT_15, EE_OFF) };
+
 static const unsigned int uart_tx_a_pins[]	= { PIN(GPIOX_12, EE_OFF) };
 static const unsigned int uart_rx_a_pins[]	= { PIN(GPIOX_13, EE_OFF) };
 static const unsigned int uart_cts_a_pins[]	= { PIN(GPIOX_14, EE_OFF) };
@@ -402,6 +411,14 @@ static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GROUP(spifc_q,		5,	3),
 	GROUP(spifc_c,		5,	2),
 	GROUP(spifc_cs,		5,	0),
+	GROUP(nand_ce0,		4,	26),
+	GROUP(nand_ce1,		4,	27),
+	GROUP(nand_rb0,		4,	25),
+	GROUP(nand_ale,		4,	24),
+	GROUP(nand_cle,		4,	23),
+	GROUP(nand_wen_clk,	4,	22),
+	GROUP(nand_ren_wr,	4,	21),
+	GROUP(nand_dqs,		4,	20),
 
 	/* Bank CARD */
 	GROUP(sdcard_d1,	2,	14),
@@ -493,6 +510,11 @@ static const char * const sdcard_groups[] = {
 	"sdcard_cmd", "sdcard_clk",
 };
 
+static const char * const nand_groups[] = {
+	"nand_ce0", "nand_ce1", "nand_rb0", "nand_ale", "nand_cle",
+	"nand_wen_clk", "nand_ren_wr", "nand_dqs",
+};
+
 static const char * const uart_a_groups[] = {
 	"uart_tx_a", "uart_rx_a", "uart_cts_a", "uart_rts_a",
 };
@@ -539,6 +561,7 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 	FUNCTION(emmc),
 	FUNCTION(spifc),
 	FUNCTION(sdcard),
+	FUNCTION(nand),
 	FUNCTION(uart_a),
 	FUNCTION(uart_b),
 	FUNCTION(uart_c),
-- 
2.7.4
