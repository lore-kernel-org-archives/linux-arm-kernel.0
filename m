From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:20 -0700
Subject: [PATCH 1/7] pinctrl: amlogic: gxbb: add UART_AO_B, I2C
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-2-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pins for some more AO domain devices: UART_AO_B and I2C master &
slave.

Also, rename UART_AO to UART_AO_A since UART_AO_B has also been added.

Cc: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 39 ++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 6dd27685e31e..35397fcc5380 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -177,7 +177,7 @@
 				uart_ao_a_pins: uart_ao_a {
 					mux {
 						groups = "uart_tx_ao_a", "uart_rx_ao_a";
-						function = "uart_ao";
+						function = "uart_ao_a";
 					};
 				};
 			};
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index eeabafbbf598..50551677b0ee 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -168,6 +168,16 @@ static const unsigned int uart_tx_ao_a_pins[]	= { PIN(GPIOAO_0, 0) };
 static const unsigned int uart_rx_ao_a_pins[]	= { PIN(GPIOAO_1, 0) };
 static const unsigned int uart_cts_ao_a_pins[]	= { PIN(GPIOAO_2, 0) };
 static const unsigned int uart_rts_ao_a_pins[]	= { PIN(GPIOAO_3, 0) };
+static const unsigned int uart_tx_ao_b_pins[]	= { PIN(GPIOAO_0, 0) };
+static const unsigned int uart_rx_ao_b_pins[]	= { PIN(GPIOAO_1, 0),
+						    PIN(GPIOAO_5, 0) };
+static const unsigned int uart_cts_ao_b_pins[]	= { PIN(GPIOAO_2, 0) };
+static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
+
+static const unsigned int i2c_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
+static const unsigned int i2c_slave_sck_ao_pins[] = {PIN(GPIOAO_4, 0) };
+static const unsigned int i2c_slave_sda_ao_pins[] = {PIN(GPIOAO_5, 0) };
 
 static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
 	GPIO_GROUP(GPIOZ_0, EE_OFF),
@@ -316,10 +326,18 @@ static struct meson_pmx_group meson_gxbb_aobus_groups[] = {
 	GPIO_GROUP(GPIOAO_13, 0),
 
 	/* bank AO */
+	GROUP(uart_tx_ao_b,	0,	26),
+	GROUP(uart_rx_ao_b,	0,	25),
 	GROUP(uart_tx_ao_a,	0,	12),
 	GROUP(uart_rx_ao_a,	0,	11),
 	GROUP(uart_cts_ao_a,	0,	10),
 	GROUP(uart_rts_ao_a,	0,	9),
+	GROUP(uart_cts_ao_b,	0,	8),
+	GROUP(uart_rts_ao_b,	0,	7),
+	GROUP(i2c_sck_ao,	0,	6),
+	GROUP(i2c_sda_ao,	0,	5),
+	GROUP(i2c_slave_sck_ao, 0,	2),
+	GROUP(i2c_slave_sda_ao, 0,	1),
 };
 
 static const char * const gpio_periphs_groups[] = {
@@ -365,8 +383,20 @@ static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_10", "GPIOAO_11", "GPIOAO_12", "GPIOAO_13",
 };
 
-static const char * const uart_ao_groups[] = {
-	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a"
+static const char * const uart_ao_a_groups[] = {
+	"uart_tx_ao_a", "uart_rx_ao_a", "uart_cts_ao_a", "uart_rts_ao_a",
+};
+
+static const char * const uart_ao_b_groups[] = {
+	"uart_tx_ao_b", "uart_rx_ao_b", "uart_cts_ao_b", "uart_rts_ao_b",
+};
+
+static const char * const i2c_ao_groups[] = {
+	"i2c_sdk_ao", "i2c_sda_ao",
+};
+
+static const char * const i2c_slave_ao_groups[] = {
+	"i2c_slave_sdk_ao", "i2c_slave_sda_ao",
 };
 
 static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
@@ -375,7 +405,10 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
 
 static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
 	FUNCTION(gpio_aobus),
-	FUNCTION(uart_ao),
+	FUNCTION(uart_ao_a),
+	FUNCTION(uart_ao_b),
+	FUNCTION(i2c_ao),
+	FUNCTION(i2c_slave_ao),
 };
 
 static struct meson_bank meson_gxbb_periphs_banks[] = {
-- 
2.7.4
