From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  7 Mar 2017 14:31:01 +0100
Subject: [PATCH 2/3] pinctrl: meson-gxl: Fix inverted registers and add
 missing pins
In-Reply-To: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
References: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488893462-7016-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix some inverted bit numbers in some pinctrl groups and add missing pins
and groups to be in pair with the GXBB pinctrl pins definition.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 86 ++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 91dfc49..b22e1eb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -136,6 +136,11 @@
 static const unsigned int emmc_cmd_pins[] = { PIN(BOOT_10, EE_OFF) };
 static const unsigned int emmc_ds_pins[] = { PIN(BOOT_15, EE_OFF) };
 
+static const unsigned int nor_d_pins[]		= { PIN(BOOT_11, EE_OFF) };
+static const unsigned int nor_q_pins[]		= { PIN(BOOT_12, EE_OFF) };
+static const unsigned int nor_c_pins[]		= { PIN(BOOT_13, EE_OFF) };
+static const unsigned int nor_cs_pins[]		= { PIN(BOOT_15, EE_OFF) };
+
 static const unsigned int sdcard_d0_pins[] = { PIN(CARD_1, EE_OFF) };
 static const unsigned int sdcard_d1_pins[] = { PIN(CARD_0, EE_OFF) };
 static const unsigned int sdcard_d2_pins[] = { PIN(CARD_5, EE_OFF) };
@@ -167,9 +172,13 @@
 
 static const unsigned int uart_tx_b_pins[]	= { PIN(GPIODV_24, EE_OFF) };
 static const unsigned int uart_rx_b_pins[]	= { PIN(GPIODV_25, EE_OFF) };
+static const unsigned int uart_cts_b_pins[]	= { PIN(GPIODV_26, EE_OFF) };
+static const unsigned int uart_rts_b_pins[]	= { PIN(GPIODV_27, EE_OFF) };
 
 static const unsigned int uart_tx_c_pins[]	= { PIN(GPIOX_8, EE_OFF) };
 static const unsigned int uart_rx_c_pins[]	= { PIN(GPIOX_9, EE_OFF) };
+static const unsigned int uart_cts_c_pins[]	= { PIN(GPIOX_10, EE_OFF) };
+static const unsigned int uart_rts_c_pins[]	= { PIN(GPIOX_11, EE_OFF) };
 
 static const unsigned int i2c_sck_a_pins[]	= { PIN(GPIODV_25, EE_OFF) };
 static const unsigned int i2c_sda_a_pins[]	= { PIN(GPIODV_24, EE_OFF) };
@@ -180,6 +189,9 @@
 static const unsigned int i2c_sck_c_pins[]	= { PIN(GPIODV_29, EE_OFF) };
 static const unsigned int i2c_sda_c_pins[]	= { PIN(GPIODV_28, EE_OFF) };
 
+static const unsigned int i2c_sck_c_dv19_pins[]	= { PIN(GPIODV_19, EE_OFF) };
+static const unsigned int i2c_sda_c_dv18_pins[]	= { PIN(GPIODV_18, EE_OFF) };
+
 static const unsigned int eth_mdio_pins[]	= { PIN(GPIOZ_0, EE_OFF) };
 static const unsigned int eth_mdc_pins[]	= { PIN(GPIOZ_1, EE_OFF) };
 static const unsigned int eth_clk_rx_clk_pins[]	= { PIN(GPIOZ_2, EE_OFF) };
@@ -227,6 +239,8 @@
 
 static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
 static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
+static const unsigned int uart_tx_ao_b_0_pins[]	= { PIN(GPIOAO_0, 0) };
+static const unsigned int uart_rx_ao_b_1_pins[]	= { PIN(GPIOAO_1, 0) };
 static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
 static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, 0) };
 static const unsigned int uart_tx_ao_b_pins[]	= { PIN(GPIOAO_4, 0) };
@@ -234,12 +248,18 @@
 static const unsigned int uart_cts_ao_b_pins[]	= { PIN(GPIOAO_2, 0) };
 static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
 
+static const unsigned int i2c_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
+static const unsigned int i2c_slave_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_slave_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
+
 static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
 
 static const unsigned int pwm_ao_a_3_pins[]	= { PIN(GPIOAO_3, 0) };
 static const unsigned int pwm_ao_a_8_pins[]	= { PIN(GPIOAO_8, 0) };
 
 static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
+static const unsigned int pwm_ao_b_6_pins[]	= { PIN(GPIOAO_6, 0) };
 
 static struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
@@ -355,8 +375,8 @@
 	GROUP(sdio_d1,		5,	30),
 	GROUP(sdio_d2,		5,	29),
 	GROUP(sdio_d3,		5,	28),
-	GROUP(sdio_cmd,		5,	27),
-	GROUP(sdio_clk,		5,	26),
+	GROUP(sdio_clk,		5,	27),
+	GROUP(sdio_cmd,		5,	26),
 	GROUP(sdio_irq,		5,	24),
 	GROUP(uart_tx_a,	5,	19),
 	GROUP(uart_rx_a,	5,	18),
@@ -364,13 +384,15 @@
 	GROUP(uart_rts_a,	5,	16),
 	GROUP(uart_tx_c,	5,	13),
 	GROUP(uart_rx_c,	5,	12),
+	GROUP(uart_cts_c,	5,	11),
+	GROUP(uart_rts_c,	5,	10),
 	GROUP(pwm_a,		5,	25),
 	GROUP(pwm_e,		5,	15),
 	GROUP(pwm_f_x,		5,	14),
 
 	/* Bank Z */
-	GROUP(eth_mdio,		4,	22),
-	GROUP(eth_mdc,		4,	23),
+	GROUP(eth_mdio,		4,	23),
+	GROUP(eth_mdc,		4,	22),
 	GROUP(eth_clk_rx_clk,	4,	21),
 	GROUP(eth_rx_dv,	4,	20),
 	GROUP(eth_rxd0,		4,	19),
@@ -393,12 +415,16 @@
 	/* Bank DV */
 	GROUP(uart_tx_b,	2,	16),
 	GROUP(uart_rx_b,	2,	15),
-	GROUP(i2c_sck_a,	1,	15),
-	GROUP(i2c_sda_a,	1,	14),
-	GROUP(i2c_sck_b,	1,	13),
-	GROUP(i2c_sda_b,	1,	12),
-	GROUP(i2c_sck_c,	1,	11),
-	GROUP(i2c_sda_c,	1,	10),
+	GROUP(uart_cts_b,	2,	14),
+	GROUP(uart_rts_b,	2,	13),
+	GROUP(i2c_sda_c_dv18,	1,	17),
+	GROUP(i2c_sck_c_dv19,	1,	16),
+	GROUP(i2c_sda_a,	1,	15),
+	GROUP(i2c_sck_a,	1,	14),
+	GROUP(i2c_sda_b,	1,	13),
+	GROUP(i2c_sck_b,	1,	12),
+	GROUP(i2c_sda_c,	1,	11),
+	GROUP(i2c_sck_c,	1,	10),
 	GROUP(pwm_b,		2,	11),
 	GROUP(pwm_d,		2,	12),
 
@@ -407,6 +433,10 @@
 	GROUP(emmc_clk,		7,	30),
 	GROUP(emmc_cmd,		7,	29),
 	GROUP(emmc_ds,		7,	28),
+	GROUP(nor_d,		7,	13),
+	GROUP(nor_q,		7,	12),
+	GROUP(nor_c,		7,	11),
+	GROUP(nor_cs,		7,	10),
 	GROUP(nand_ce0,		7,	7),
 	GROUP(nand_ce1,		7,	6),
 	GROUP(nand_rb0,		7,	5),
@@ -441,16 +471,23 @@
 	GPIO_GROUP(GPIOAO_9, 0),
 
 	/* bank AO */
+	GROUP(uart_tx_ao_b_0,	0,	26),
+	GROUP(uart_rx_ao_b_1,	0,	25),
 	GROUP(uart_tx_ao_b,	0,	24),
-	GROUP(uart_rx_ao_b,	0,	25),
+	GROUP(uart_rx_ao_b,	0,	23),
 	GROUP(uart_tx_ao_a,	0,	12),
 	GROUP(uart_rx_ao_a,	0,	11),
 	GROUP(uart_cts_ao_a,	0,	10),
 	GROUP(uart_rts_ao_a,	0,	9),
 	GROUP(uart_cts_ao_b,	0,	8),
 	GROUP(uart_rts_ao_b,	0,	7),
+	GROUP(i2c_sck_ao,	0,	6),
+	GROUP(i2c_sda_ao,	0,	5),
+	GROUP(i2c_slave_sck_ao, 0,	2),
+	GROUP(i2c_slave_sda_ao, 0,	1),
 	GROUP(remote_input_ao,	0,	0),
 	GROUP(pwm_ao_a_3,	0,	22),
+	GROUP(pwm_ao_b_6,	0,	18),
 	GROUP(pwm_ao_a_8,	0,	17),
 	GROUP(pwm_ao_b,		0,	3),
 };
@@ -491,6 +528,10 @@
 	"emmc_nand_d07", "emmc_clk", "emmc_cmd", "emmc_ds",
 };
 
+static const char * const nor_groups[] = {
+	"nor_d", "nor_q", "nor_c", "nor_cs",
+};
+
 static const char * const sdcard_groups[] = {
 	"sdcard_d0", "sdcard_d1", "sdcard_d2", "sdcard_d3",
 	"sdcard_cmd", "sdcard_clk",
@@ -511,11 +552,11 @@
 };
 
 static const char * const uart_b_groups[] = {
-	"uart_tx_b", "uart_rx_b",
+	"uart_tx_b", "uart_rx_b", "uart_cts_b", "uart_rts_b",
 };
 
 static const char * const uart_c_groups[] = {
-	"uart_tx_c", "uart_rx_c",
+	"uart_tx_c", "uart_rx_c", "uart_cts_c", "uart_rts_c",
 };
 
 static const char * const i2c_a_groups[] = {
@@ -527,7 +568,7 @@
 };
 
 static const char * const i2c_c_groups[] = {
-	"i2c_sck_c", "i2c_sda_c",
+	"i2c_sck_c", "i2c_sda_c", "i2c_sda_c_dv18", "i2c_sck_c_dv19",
 };
 
 static const char * const eth_groups[] = {
@@ -584,6 +625,15 @@
 
 static const char * const uart_ao_b_groups[] = {
 	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
+	"uart_tx_ao_b_0", "uart_rx_ao_b_1",
+};
+
+static const char * const i2c_ao_groups[] = {
+	"i2c_sck_ao", "i2c_sda_ao",
+};
+
+static const char * const i2c_slave_ao_groups[] = {
+	"i2c_slave_sck_ao", "i2c_slave_sda_ao",
 };
 
 static const char * const remote_input_ao_groups[] = {
@@ -602,9 +652,14 @@
 	"pwm_ao_b",
 };
 
+static const char * const pwm_ao_b_6_groups[] = {
+	"pwm_ao_b_6",
+};
+
 static struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(gpio_periphs),
 	FUNCTION(emmc),
+	FUNCTION(nor),
 	FUNCTION(sdcard),
 	FUNCTION(sdio),
 	FUNCTION(nand),
@@ -630,10 +685,13 @@
 	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(uart_ao_b),
+	FUNCTION(i2c_ao),
+	FUNCTION(i2c_slave_ao),
 	FUNCTION(remote_input_ao),
 	FUNCTION(pwm_ao_a_3),
 	FUNCTION(pwm_ao_a_8),
 	FUNCTION(pwm_ao_b),
+	FUNCTION(pwm_ao_b_6),
 };
 
 static struct meson_bank meson_gxl_periphs_banks[] = {
-- 
1.9.1
