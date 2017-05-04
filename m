From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu,  4 May 2017 20:49:30 +0200
Subject: [PATCH 2/4] pinctrl: meson: meson8: add support for the I2S and SPDIF
 pins
In-Reply-To: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
References: <20170504184932.5372-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170504184932.5372-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the I2S and SPDIF input and output pins, similar
to what we have on GXBB and GXL.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 9d9ddd9c0f83..d6fc7994cad5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -224,6 +224,18 @@ static const unsigned int i2c_sck_c0_pins[] = { PIN(GPIOY_1, 0) };
 
 static const unsigned int pwm_a_y_pins[] = { PIN(GPIOY_16, 0) };
 
+static const unsigned int i2s_out_ch45_pins[] = { PIN(GPIOY_0, 0) };
+static const unsigned int i2s_out_ch23_pins[] = { PIN(GPIOY_1, 0) };
+static const unsigned int i2s_out_ch01_pins[] = { PIN(GPIOY_4, 0) };
+static const unsigned int i2s_in_ch01_pins[] = { PIN(GPIOY_5, 0) };
+static const unsigned int i2s_lr_clk_in_pins[] = { PIN(GPIOY_6, 0) };
+static const unsigned int i2s_ao_clk_in_pins[] = { PIN(GPIOY_7, 0) };
+static const unsigned int i2s_am_clk_pins[] = { PIN(GPIOY_8, 0) };
+static const unsigned int i2s_out_ch78_pins[] = { PIN(GPIOY_9, 0) };
+
+static const unsigned int spdif_in_pins[] = { PIN(GPIOY_2, 0) };
+static const unsigned int spdif_out_pins[] = { PIN(GPIOY_3, 0) };
+
 /* bank DV */
 static const unsigned int dvin_rgb_pins[] = { PIN(GPIODV_0, 0), PIN(GPIODV_1, 0),
 					      PIN(GPIODV_2, 0), PIN(GPIODV_3, 0),
@@ -398,6 +410,11 @@ static const unsigned int i2c_mst_sda_ao_pins[] = { PIN(GPIOAO_5, AO_OFF) };
 
 static const unsigned int pwm_f_ao_pins[] = { PIN(GPIO_TEST_N, AO_OFF) };
 
+static const unsigned int i2s_am_clk_out_ao_pins[] = { PIN(GPIOAO_8, AO_OFF) };
+static const unsigned int i2s_ao_clk_out_ao_pins[] = { PIN(GPIOAO_9, AO_OFF) };
+static const unsigned int i2s_lr_clk_out_ao_pins[] = { PIN(GPIOAO_10, AO_OFF) };
+static const unsigned int i2s_out_ch01_ao_pins[] = { PIN(GPIOAO_11, AO_OFF) };
+
 static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOX_0, 0),
 	GPIO_GROUP(GPIOX_1, 0),
@@ -558,6 +575,18 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 
 	GROUP(pwm_a_y,		9,	14),
 
+	GROUP(i2s_out_ch45,	1,	10),
+	GROUP(i2s_out_ch23,	1,	19),
+	GROUP(i2s_out_ch01,	1,	6),
+	GROUP(i2s_in_ch01,	1,	5),
+	GROUP(i2s_lr_clk_in,	1,	4),
+	GROUP(i2s_ao_clk_in,	1,	2),
+	GROUP(i2s_am_clk,	1,	0),
+	GROUP(i2s_out_ch78,	1,	11),
+
+	GROUP(spdif_in,		1,	8),
+	GROUP(spdif_out,	1,	7),
+
 	/* bank DV */
 	GROUP(dvin_rgb,		0,	6),
 	GROUP(dvin_vs,		0,	9),
@@ -733,6 +762,11 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 	GROUP(i2c_mst_sda_ao,		0,	5),
 
 	GROUP(pwm_f_ao,			0,	19),
+
+	GROUP(i2s_am_clk_out_ao,	0,	30),
+	GROUP(i2s_ao_clk_out_ao,	0,	29),
+	GROUP(i2s_lr_clk_out_ao,	0,	28),
+	GROUP(i2s_out_ch01_ao,		0,	27),
 };
 
 static const char * const gpio_groups[] = {
@@ -860,6 +894,12 @@ static const char * const i2c_b_groups[] = {
 	"i2c_sda_b", "i2c_sck_b"
 };
 
+static const char * const i2s_groups[] = {
+	"i2s_out_ch45", "i2s_out_ch23_pins", "i2s_out_ch01_pins",
+	"i2s_in_ch01_pins", "i2s_lr_clk_in_pins", "i2s_ao_clk_in_pins",
+	"i2s_am_clk_pins", "i2s_out_ch78_pins"
+};
+
 static const char * const sd_c_groups[] = {
 	"sd_d0_c", "sd_d1_c", "sd_d2_c", "sd_d3_c",
 	"sd_cmd_c", "sd_clk_c"
@@ -910,6 +950,10 @@ static const char * const sdxc_b_groups[] = {
 	"sdxc_d13_b", "sdxc_d0_b", "sdxc_clk_b", "sdxc_cmd_b"
 };
 
+static const char * const spdif_groups[] = {
+	"spdif_in", "spdif_out"
+};
+
 static const char * const uart_ao_groups[] = {
 	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a"
 };
@@ -934,6 +978,11 @@ static const char * const pwm_f_ao_groups[] = {
 	"pwm_f"
 };
 
+static const char * const i2s_ao_groups[] = {
+	"i2s_am_clk_out_ao", "i2s_ao_clk_out_ao", "i2s_lr_clk_out_ao",
+	"i2s_out_ch01_ao"
+};
+
 static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(sd_a),
@@ -966,6 +1015,8 @@ static struct meson_pmx_func meson8_cbus_functions[] = {
 	FUNCTION(pwm_c),
 	FUNCTION(pwm_d),
 	FUNCTION(pwm_e),
+	FUNCTION(i2s),
+	FUNCTION(spdif),
 };
 
 static struct meson_pmx_func meson8_aobus_functions[] = {
@@ -975,6 +1026,7 @@ static struct meson_pmx_func meson8_aobus_functions[] = {
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_mst_ao),
 	FUNCTION(pwm_f_ao),
+	FUNCTION(i2s_ao),
 };
 
 static struct meson_bank meson8_cbus_banks[] = {
-- 
2.12.2
