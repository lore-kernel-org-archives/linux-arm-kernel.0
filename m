From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 22:27:59 +0800
Subject: [PATCH 3/3] pinctrl: sirf: add USB1/UART1 pinmux usb/uart share
In-Reply-To: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
References: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1380464879-19897-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rong Wang <Rong.Wang@csr.com>

dn and dp of USB1 can share with UART1(UART1 can route rx,tx to dn and dp pins of USB1).
here we add this pinmux capability.
USB1/UART1 mode selection has dedicated control register in RSC module, here we attach
the register offset of private data of related pin groups.

Signed-off-by: Rong Wang <Rong.Wang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi         | 12 ++++++++
 arch/arm/boot/dts/prima2.dtsi         | 12 ++++++++
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 56 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sirf/pinctrl-prima2.c | 52 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/sirf/pinctrl-sirf.c   |  8 ++---
 drivers/pinctrl/sirf/pinctrl-sirf.h   |  6 ++--
 6 files changed, 140 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index a49032c..978bab4 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -558,6 +558,18 @@
                                                 sirf,function = "usb1_utmi_drvbus";
                                         };
                                 };
+                                usb1_dp_dn_pins_a: usb1_dp_dn at 0 {
+                                        usb1_dp_dn {
+                                                sirf,pins = "usb1_dp_dngrp";
+                                                sirf,function = "usb1_dp_dn";
+                                        };
+                                };
+                                uart1_route_io_usb1_pins_a: uart1_route_io_usb1 at 0 {
+                                        uart1_route_io_usb1 {
+                                                sirf,pins = "uart1_route_io_usb1grp";
+                                                sirf,function = "uart1_route_io_usb1";
+                                        };
+                                };
                                 warm_rst_pins_a: warm_rst at 0 {
                                         warm_rst {
                                                 sirf,pins = "warm_rstgrp";
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 2769bf3..daee5894 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -580,6 +580,18 @@
                                                 sirf,function = "usb1_utmi_drvbus";
                                         };
                                 };
+                                usb1_dp_dn_pins_a: usb1_dp_dn at 0 {
+                                        usb1_dp_dn {
+                                                sirf,pins = "usb1_dp_dngrp";
+                                                sirf,function = "usb1_dp_dn";
+                                        };
+                                };
+                                uart1_route_io_usb1_pins_a: uart1_route_io_usb1 at 0 {
+                                        uart1_route_io_usb1 {
+                                                sirf,pins = "uart1_route_io_usb1grp";
+                                                sirf,function = "uart1_route_io_usb1";
+                                        };
+                                };
                                 warm_rst_pins_a: warm_rst at 0 {
                                         warm_rst {
                                                 sirf,pins = "warm_rstgrp";
diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index edf45a6..8ab7898 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -122,6 +122,9 @@ static const struct pinctrl_pin_desc sirfsoc_pads[] = {
 	PINCTRL_PIN(100, "ac97_dout"),
 	PINCTRL_PIN(101, "ac97_din"),
 	PINCTRL_PIN(102, "x_rtc_io"),
+
+	PINCTRL_PIN(103, "x_usb1_dp"),
+	PINCTRL_PIN(104, "x_usb1_dn"),
 };
 
 static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
@@ -139,6 +142,7 @@ static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
 static const struct sirfsoc_padmux lcd_16bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_16bits_sirfsoc_muxmask),
 	.muxmask = lcd_16bits_sirfsoc_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = 0,
 };
@@ -164,6 +168,7 @@ static const struct sirfsoc_muxmask lcd_18bits_muxmask[] = {
 static const struct sirfsoc_padmux lcd_18bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_18bits_muxmask),
 	.muxmask = lcd_18bits_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4) | BIT(15),
 	.funcval = 0,
 };
@@ -189,6 +194,7 @@ static const struct sirfsoc_muxmask lcd_24bits_muxmask[] = {
 static const struct sirfsoc_padmux lcd_24bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_24bits_muxmask),
 	.muxmask = lcd_24bits_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4) | BIT(15),
 	.funcval = 0,
 };
@@ -214,6 +220,7 @@ static const struct sirfsoc_muxmask lcdrom_muxmask[] = {
 static const struct sirfsoc_padmux lcdrom_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcdrom_muxmask),
 	.muxmask = lcdrom_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = BIT(4),
 };
@@ -237,6 +244,7 @@ static const struct sirfsoc_muxmask uart0_muxmask[] = {
 static const struct sirfsoc_padmux uart0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(uart0_muxmask),
 	.muxmask = uart0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(9),
 	.funcval = BIT(9),
 };
@@ -284,6 +292,7 @@ static const struct sirfsoc_muxmask uart2_muxmask[] = {
 static const struct sirfsoc_padmux uart2_padmux = {
 	.muxmask_counts = ARRAY_SIZE(uart2_muxmask),
 	.muxmask = uart2_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(10),
 	.funcval = BIT(10),
 };
@@ -317,6 +326,7 @@ static const struct sirfsoc_muxmask sdmmc3_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc3_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc3_muxmask),
 	.muxmask = sdmmc3_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(7),
 	.funcval = 0,
 };
@@ -336,6 +346,7 @@ static const struct sirfsoc_muxmask spi0_muxmask[] = {
 static const struct sirfsoc_padmux spi0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(spi0_muxmask),
 	.muxmask = spi0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(7),
 	.funcval = BIT(7),
 };
@@ -352,6 +363,7 @@ static const struct sirfsoc_muxmask cko1_muxmask[] = {
 static const struct sirfsoc_padmux cko1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(cko1_muxmask),
 	.muxmask = cko1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(3),
 	.funcval = 0,
 };
@@ -371,6 +383,7 @@ static const struct sirfsoc_muxmask i2s_muxmask[] = {
 static const struct sirfsoc_padmux i2s_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_muxmask),
 	.muxmask = i2s_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(3),
 	.funcval = BIT(3),
 };
@@ -390,6 +403,7 @@ static const struct sirfsoc_muxmask i2s_no_din_muxmask[] = {
 static const struct sirfsoc_padmux i2s_no_din_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_no_din_muxmask),
 	.muxmask = i2s_no_din_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(3),
 	.funcval = BIT(3),
 };
@@ -409,6 +423,7 @@ static const struct sirfsoc_muxmask i2s_6chn_muxmask[] = {
 static const struct sirfsoc_padmux i2s_6chn_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_6chn_muxmask),
 	.muxmask = i2s_6chn_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(1) | BIT(3) | BIT(9),
 	.funcval = BIT(1) | BIT(3) | BIT(9),
 };
@@ -439,6 +454,7 @@ static const struct sirfsoc_muxmask spi1_muxmask[] = {
 static const struct sirfsoc_padmux spi1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(spi1_muxmask),
 	.muxmask = spi1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(16),
 	.funcval = 0,
 };
@@ -455,6 +471,7 @@ static const struct sirfsoc_muxmask sdmmc1_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc1_muxmask),
 	.muxmask = sdmmc1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5),
 	.funcval = BIT(5),
 };
@@ -471,6 +488,7 @@ static const struct sirfsoc_muxmask gps_muxmask[] = {
 static const struct sirfsoc_padmux gps_padmux = {
 	.muxmask_counts = ARRAY_SIZE(gps_muxmask),
 	.muxmask = gps_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(13),
 	.funcval = 0,
 };
@@ -487,6 +505,7 @@ static const struct sirfsoc_muxmask sdmmc5_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc5_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc5_muxmask),
 	.muxmask = sdmmc5_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(13),
 	.funcval = BIT(13),
 };
@@ -503,6 +522,7 @@ static const struct sirfsoc_muxmask usp0_muxmask[] = {
 static const struct sirfsoc_padmux usp0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usp0_muxmask),
 	.muxmask = usp0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(1) | BIT(2) | BIT(9),
 	.funcval = 0,
 };
@@ -535,6 +555,7 @@ static const struct sirfsoc_muxmask usp1_muxmask[] = {
 static const struct sirfsoc_padmux usp1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usp1_muxmask),
 	.muxmask = usp1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(16),
 	.funcval = BIT(16),
 };
@@ -554,6 +575,7 @@ static const struct sirfsoc_muxmask nand_muxmask[] = {
 static const struct sirfsoc_padmux nand_padmux = {
 	.muxmask_counts = ARRAY_SIZE(nand_muxmask),
 	.muxmask = nand_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5) | BIT(19),
 	.funcval = 0,
 };
@@ -570,6 +592,7 @@ static const struct sirfsoc_muxmask sdmmc0_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc0_muxmask),
 	.muxmask = sdmmc0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5) | BIT(19),
 	.funcval = BIT(19),
 };
@@ -586,6 +609,7 @@ static const struct sirfsoc_muxmask sdmmc2_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc2_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc2_muxmask),
 	.muxmask = sdmmc2_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(11),
 	.funcval = 0,
 };
@@ -602,6 +626,7 @@ static const struct sirfsoc_muxmask sdmmc2_nowp_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc2_nowp_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc2_nowp_muxmask),
 	.muxmask = sdmmc2_nowp_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(11),
 	.funcval = 0,
 };
@@ -634,6 +659,7 @@ static const struct sirfsoc_muxmask vip_muxmask[] = {
 static const struct sirfsoc_padmux vip_padmux = {
 	.muxmask_counts = ARRAY_SIZE(vip_muxmask),
 	.muxmask = vip_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(18),
 	.funcval = BIT(18),
 };
@@ -654,6 +680,7 @@ static const struct sirfsoc_muxmask vip_noupli_muxmask[] = {
 static const struct sirfsoc_padmux vip_noupli_padmux = {
 	.muxmask_counts = ARRAY_SIZE(vip_noupli_muxmask),
 	.muxmask = vip_noupli_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(15),
 	.funcval = BIT(15),
 };
@@ -684,6 +711,7 @@ static const struct sirfsoc_muxmask i2c1_muxmask[] = {
 static const struct sirfsoc_padmux i2c1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2c1_muxmask),
 	.muxmask = i2c1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(16),
 	.funcval = 0,
 };
@@ -700,6 +728,7 @@ static const struct sirfsoc_muxmask pwm0_muxmask[] = {
 static const struct sirfsoc_padmux pwm0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(pwm0_muxmask),
 	.muxmask = pwm0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(12),
 	.funcval = 0,
 };
@@ -772,6 +801,7 @@ static const struct sirfsoc_muxmask warm_rst_muxmask[] = {
 static const struct sirfsoc_padmux warm_rst_padmux = {
 	.muxmask_counts = ARRAY_SIZE(warm_rst_muxmask),
 	.muxmask = warm_rst_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = 0,
 };
@@ -789,6 +819,7 @@ static const struct sirfsoc_muxmask usb0_upli_drvbus_muxmask[] = {
 static const struct sirfsoc_padmux usb0_upli_drvbus_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usb0_upli_drvbus_muxmask),
 	.muxmask = usb0_upli_drvbus_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(18),
 	.funcval = 0,
 };
@@ -805,12 +836,31 @@ static const struct sirfsoc_muxmask usb1_utmi_drvbus_muxmask[] = {
 static const struct sirfsoc_padmux usb1_utmi_drvbus_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usb1_utmi_drvbus_muxmask),
 	.muxmask = usb1_utmi_drvbus_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(11),
 	.funcval = BIT(11), /* refer to PAD_UTMI_DRVVBUS1_ENABLE */
 };
 
 static const unsigned usb1_utmi_drvbus_pins[] = { 28 };
 
+static const struct sirfsoc_padmux usb1_dp_dn_padmux = {
+	.muxmask_counts = 0,
+	.ctrlreg = SIRFSOC_RSC_USB_UART_SHARE,
+	.funcmask = BIT(2),
+	.funcval = BIT(2),
+};
+
+static const unsigned usb1_dp_dn_pins[] = { 103, 104 };
+
+static const struct sirfsoc_padmux uart1_route_io_usb1_padmux = {
+	.muxmask_counts = 0,
+	.ctrlreg = SIRFSOC_RSC_USB_UART_SHARE,
+	.funcmask = BIT(2),
+	.funcval = 0,
+};
+
+static const unsigned uart1_route_io_usb1_pins[] = { 103, 104 };
+
 static const struct sirfsoc_muxmask pulse_count_muxmask[] = {
 	{
 		.group = 0,
@@ -859,6 +909,8 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("sdmmc5grp", sdmmc5_pins),
 	SIRFSOC_PIN_GROUP("usb0_upli_drvbusgrp", usb0_upli_drvbus_pins),
 	SIRFSOC_PIN_GROUP("usb1_utmi_drvbusgrp", usb1_utmi_drvbus_pins),
+	SIRFSOC_PIN_GROUP("usb1_dp_dngrp", usb1_dp_dn_pins),
+	SIRFSOC_PIN_GROUP("uart1_route_io_usb1grp", uart1_route_io_usb1_pins),
 	SIRFSOC_PIN_GROUP("pulse_countgrp", pulse_count_pins),
 	SIRFSOC_PIN_GROUP("i2sgrp", i2s_pins),
 	SIRFSOC_PIN_GROUP("i2s_no_dingrp", i2s_no_din_pins),
@@ -903,6 +955,8 @@ static const char * const sdmmc5grp[] = { "sdmmc5grp" };
 static const char * const sdmmc2_nowpgrp[] = { "sdmmc2_nowpgrp" };
 static const char * const usb0_upli_drvbusgrp[] = { "usb0_upli_drvbusgrp" };
 static const char * const usb1_utmi_drvbusgrp[] = { "usb1_utmi_drvbusgrp" };
+static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
+static const char * const uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const i2s_no_dingrp[] = { "i2s_no_dingrp" };
@@ -949,6 +1003,8 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("sdmmc2_nowp", sdmmc2_nowpgrp, sdmmc2_nowp_padmux),
 	SIRFSOC_PMX_FUNCTION("usb0_upli_drvbus", usb0_upli_drvbusgrp, usb0_upli_drvbus_padmux),
 	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus", usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("usb1_dp_dn", usb1_dp_dngrp, usb1_dp_dn_padmux),
+	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1", uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_no_din", i2s_no_dingrp, i2s_no_din_padmux),
diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 241d839..050777b 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -126,6 +126,9 @@ static const struct pinctrl_pin_desc sirfsoc_pads[] = {
 	PINCTRL_PIN(112, "x_ldd[13]"),
 	PINCTRL_PIN(113, "x_ldd[14]"),
 	PINCTRL_PIN(114, "x_ldd[15]"),
+
+	PINCTRL_PIN(115, "x_usb1_dp"),
+	PINCTRL_PIN(116, "x_usb1_dn"),
 };
 
 static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
@@ -143,6 +146,7 @@ static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
 static const struct sirfsoc_padmux lcd_16bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_16bits_sirfsoc_muxmask),
 	.muxmask = lcd_16bits_sirfsoc_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = 0,
 };
@@ -168,6 +172,7 @@ static const struct sirfsoc_muxmask lcd_18bits_muxmask[] = {
 static const struct sirfsoc_padmux lcd_18bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_18bits_muxmask),
 	.muxmask = lcd_18bits_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = 0,
 };
@@ -193,6 +198,7 @@ static const struct sirfsoc_muxmask lcd_24bits_muxmask[] = {
 static const struct sirfsoc_padmux lcd_24bits_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcd_24bits_muxmask),
 	.muxmask = lcd_24bits_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = 0,
 };
@@ -218,6 +224,7 @@ static const struct sirfsoc_muxmask lcdrom_muxmask[] = {
 static const struct sirfsoc_padmux lcdrom_padmux = {
 	.muxmask_counts = ARRAY_SIZE(lcdrom_muxmask),
 	.muxmask = lcdrom_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(4),
 	.funcval = BIT(4),
 };
@@ -238,6 +245,7 @@ static const struct sirfsoc_muxmask uart0_muxmask[] = {
 static const struct sirfsoc_padmux uart0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(uart0_muxmask),
 	.muxmask = uart0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(9),
 	.funcval = BIT(9),
 };
@@ -282,6 +290,7 @@ static const struct sirfsoc_muxmask uart2_muxmask[] = {
 static const struct sirfsoc_padmux uart2_padmux = {
 	.muxmask_counts = ARRAY_SIZE(uart2_muxmask),
 	.muxmask = uart2_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(10),
 	.funcval = BIT(10),
 };
@@ -315,6 +324,7 @@ static const struct sirfsoc_muxmask sdmmc3_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc3_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc3_muxmask),
 	.muxmask = sdmmc3_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(7),
 	.funcval = 0,
 };
@@ -331,6 +341,7 @@ static const struct sirfsoc_muxmask spi0_muxmask[] = {
 static const struct sirfsoc_padmux spi0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(spi0_muxmask),
 	.muxmask = spi0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(7),
 	.funcval = BIT(7),
 };
@@ -361,6 +372,7 @@ static const struct sirfsoc_muxmask cko1_muxmask[] = {
 static const struct sirfsoc_padmux cko1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(cko1_muxmask),
 	.muxmask = cko1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(3),
 	.funcval = 0,
 };
@@ -379,6 +391,7 @@ static const struct sirfsoc_muxmask i2s_muxmask[] = {
 static const struct sirfsoc_padmux i2s_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_muxmask),
 	.muxmask = i2s_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(3) | BIT(9),
 	.funcval = BIT(3),
 };
@@ -395,6 +408,7 @@ static const struct sirfsoc_muxmask ac97_muxmask[] = {
 static const struct sirfsoc_padmux ac97_padmux = {
 	.muxmask_counts = ARRAY_SIZE(ac97_muxmask),
 	.muxmask = ac97_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(8),
 	.funcval = 0,
 };
@@ -411,6 +425,7 @@ static const struct sirfsoc_muxmask spi1_muxmask[] = {
 static const struct sirfsoc_padmux spi1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(spi1_muxmask),
 	.muxmask = spi1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(8),
 	.funcval = BIT(8),
 };
@@ -441,6 +456,7 @@ static const struct sirfsoc_muxmask gps_muxmask[] = {
 static const struct sirfsoc_padmux gps_padmux = {
 	.muxmask_counts = ARRAY_SIZE(gps_muxmask),
 	.muxmask = gps_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(12) | BIT(13) | BIT(14),
 	.funcval = BIT(12),
 };
@@ -463,6 +479,7 @@ static const struct sirfsoc_muxmask sdmmc5_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc5_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc5_muxmask),
 	.muxmask = sdmmc5_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(13) | BIT(14),
 	.funcval = BIT(13) | BIT(14),
 };
@@ -479,6 +496,7 @@ static const struct sirfsoc_muxmask usp0_muxmask[] = {
 static const struct sirfsoc_padmux usp0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usp0_muxmask),
 	.muxmask = usp0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(1) | BIT(2) | BIT(6) | BIT(9),
 	.funcval = 0,
 };
@@ -509,6 +527,7 @@ static const struct sirfsoc_muxmask usp1_muxmask[] = {
 static const struct sirfsoc_padmux usp1_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usp1_muxmask),
 	.muxmask = usp1_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(1) | BIT(9) | BIT(10) | BIT(11),
 	.funcval = 0,
 };
@@ -542,6 +561,7 @@ static const struct sirfsoc_muxmask usp2_muxmask[] = {
 static const struct sirfsoc_padmux usp2_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usp2_muxmask),
 	.muxmask = usp2_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(13) | BIT(14),
 	.funcval = 0,
 };
@@ -572,6 +592,7 @@ static const struct sirfsoc_muxmask nand_muxmask[] = {
 static const struct sirfsoc_padmux nand_padmux = {
 	.muxmask_counts = ARRAY_SIZE(nand_muxmask),
 	.muxmask = nand_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5),
 	.funcval = 0,
 };
@@ -580,6 +601,7 @@ static const unsigned nand_pins[] = { 64, 65, 92, 93, 94 };
 
 static const struct sirfsoc_padmux sdmmc0_padmux = {
 	.muxmask_counts = 0,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5),
 	.funcval = 0,
 };
@@ -596,6 +618,7 @@ static const struct sirfsoc_muxmask sdmmc2_muxmask[] = {
 static const struct sirfsoc_padmux sdmmc2_padmux = {
 	.muxmask_counts = ARRAY_SIZE(sdmmc2_muxmask),
 	.muxmask = sdmmc2_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(5),
 	.funcval = BIT(5),
 };
@@ -628,6 +651,7 @@ static const struct sirfsoc_muxmask vip_muxmask[] = {
 static const struct sirfsoc_padmux vip_padmux = {
 	.muxmask_counts = ARRAY_SIZE(vip_muxmask),
 	.muxmask = vip_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(0),
 	.funcval = 0,
 };
@@ -677,6 +701,7 @@ static const struct sirfsoc_muxmask viprom_muxmask[] = {
 static const struct sirfsoc_padmux viprom_padmux = {
 	.muxmask_counts = ARRAY_SIZE(viprom_muxmask),
 	.muxmask = viprom_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(0),
 	.funcval = BIT(0),
 };
@@ -693,6 +718,7 @@ static const struct sirfsoc_muxmask pwm0_muxmask[] = {
 static const struct sirfsoc_padmux pwm0_padmux = {
 	.muxmask_counts = ARRAY_SIZE(pwm0_muxmask),
 	.muxmask = pwm0_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(12),
 	.funcval = 0,
 };
@@ -764,6 +790,7 @@ static const struct sirfsoc_muxmask usb0_utmi_drvbus_muxmask[] = {
 static const struct sirfsoc_padmux usb0_utmi_drvbus_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usb0_utmi_drvbus_muxmask),
 	.muxmask = usb0_utmi_drvbus_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(6),
 	.funcval = BIT(6), /* refer to PAD_UTMI_DRVVBUS0_ENABLE */
 };
@@ -780,12 +807,31 @@ static const struct sirfsoc_muxmask usb1_utmi_drvbus_muxmask[] = {
 static const struct sirfsoc_padmux usb1_utmi_drvbus_padmux = {
 	.muxmask_counts = ARRAY_SIZE(usb1_utmi_drvbus_muxmask),
 	.muxmask = usb1_utmi_drvbus_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
 	.funcmask = BIT(11),
 	.funcval = BIT(11), /* refer to PAD_UTMI_DRVVBUS1_ENABLE */
 };
 
 static const unsigned usb1_utmi_drvbus_pins[] = { 59 };
 
+static const struct sirfsoc_padmux usb1_dp_dn_padmux = {
+	.muxmask_counts = 0,
+	.ctrlreg = SIRFSOC_RSC_USB_UART_SHARE,
+	.funcmask = BIT(2),
+	.funcval = BIT(2),
+};
+
+static const unsigned usb1_dp_dn_pins[] = { 115, 116 };
+
+static const struct sirfsoc_padmux uart1_route_io_usb1_padmux = {
+	.muxmask_counts = 0,
+	.ctrlreg = SIRFSOC_RSC_USB_UART_SHARE,
+	.funcmask = BIT(2),
+	.funcval = 0,
+};
+
+static const unsigned uart1_route_io_usb1_pins[] = { 115, 116 };
+
 static const struct sirfsoc_muxmask pulse_count_muxmask[] = {
 	{
 		.group = 0,
@@ -838,6 +884,8 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("sdmmc5grp", sdmmc5_pins),
 	SIRFSOC_PIN_GROUP("usb0_utmi_drvbusgrp", usb0_utmi_drvbus_pins),
 	SIRFSOC_PIN_GROUP("usb1_utmi_drvbusgrp", usb1_utmi_drvbus_pins),
+	SIRFSOC_PIN_GROUP("usb1_dp_dngrp", usb1_dp_dn_pins),
+	SIRFSOC_PIN_GROUP("uart1_route_io_usb1grp", uart1_route_io_usb1_pins),
 	SIRFSOC_PIN_GROUP("pulse_countgrp", pulse_count_pins),
 	SIRFSOC_PIN_GROUP("i2sgrp", i2s_pins),
 	SIRFSOC_PIN_GROUP("ac97grp", ac97_pins),
@@ -884,6 +932,8 @@ static const char * const sdmmc4grp[] = { "sdmmc4grp" };
 static const char * const sdmmc5grp[] = { "sdmmc5grp" };
 static const char * const usb0_utmi_drvbusgrp[] = { "usb0_utmi_drvbusgrp" };
 static const char * const usb1_utmi_drvbusgrp[] = { "usb1_utmi_drvbusgrp" };
+static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
+static const char * const uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const ac97grp[] = { "ac97grp" };
@@ -930,6 +980,8 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("sdmmc5", sdmmc5grp, sdmmc5_padmux),
 	SIRFSOC_PMX_FUNCTION("usb0_utmi_drvbus", usb0_utmi_drvbusgrp, usb0_utmi_drvbus_padmux),
 	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus", usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("usb1_dp_dn", usb1_dp_dngrp, usb1_dp_dn_padmux),
+	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1", uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("ac97", ac97grp, ac97_padmux),
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 26f946a..b81e388 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -166,12 +166,12 @@ static void sirfsoc_pinmux_endisable(struct sirfsoc_pmx *spmx, unsigned selector
 
 	if (mux->funcmask && enable) {
 		u32 func_en_val;
+
 		func_en_val =
-			readl(spmx->rsc_virtbase + SIRFSOC_RSC_PIN_MUX);
+			readl(spmx->rsc_virtbase + mux->ctrlreg);
 		func_en_val =
-			(func_en_val & ~mux->funcmask) | (mux->
-				funcval);
-		writel(func_en_val, spmx->rsc_virtbase + SIRFSOC_RSC_PIN_MUX);
+			(func_en_val & ~mux->funcmask) | (mux->funcval);
+		writel(func_en_val, spmx->rsc_virtbase + mux->ctrlreg);
 	}
 }
 
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.h b/drivers/pinctrl/sirf/pinctrl-sirf.h
index 17cc108..d7f16b4 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.h
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.h
@@ -9,8 +9,9 @@
 #ifndef __PINMUX_SIRF_H__
 #define __PINMUX_SIRF_H__
 
-#define SIRFSOC_NUM_PADS    622
-#define SIRFSOC_RSC_PIN_MUX 0x4
+#define SIRFSOC_NUM_PADS		622
+#define SIRFSOC_RSC_USB_UART_SHARE	0
+#define SIRFSOC_RSC_PIN_MUX		0x4
 
 #define SIRFSOC_GPIO_PAD_EN(g)		((g)*0x100 + 0x84)
 #define SIRFSOC_GPIO_PAD_EN_CLR(g)	((g)*0x100 + 0x90)
@@ -61,6 +62,7 @@ struct sirfsoc_padmux {
 	unsigned long muxmask_counts;
 	const struct sirfsoc_muxmask *muxmask;
 	/* RSC_PIN_MUX set */
+	unsigned long ctrlreg;
 	unsigned long funcmask;
 	unsigned long funcval;
 };
-- 
1.8.2.3
