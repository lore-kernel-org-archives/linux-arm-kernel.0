From: Barry.Song@csr.com (Barry Song)
Date: Tue, 2 Sep 2014 17:46:47 +0800
Subject: [PATCH 1/2] pinctrl: prima2: add I2S 2ch, 6ch, nodin, mclk groups
Message-ID: <1409651208-5820-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

we have done that for atlas6 in commit ed36c1a, 086b8904 etc. here we
do same things for prima2.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-prima2.c | 88 ++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index fda2547f..357678e 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -386,12 +386,44 @@ static const struct sirfsoc_padmux cko1_padmux = {
 
 static const unsigned cko1_pins[] = { 42 };
 
+static const struct sirfsoc_muxmask i2s_mclk_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(10),
+	},
+};
+
+static const struct sirfsoc_padmux i2s_mclk_padmux = {
+	.muxmask_counts = ARRAY_SIZE(i2s_mclk_muxmask),
+	.muxmask = i2s_mclk_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(3),
+	.funcval = BIT(3),
+};
+
+static const unsigned i2s_mclk_pins[] = { 42 };
+
+static const struct sirfsoc_muxmask i2s_ext_clk_input_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(19),
+	},
+};
+
+static const struct sirfsoc_padmux i2s_ext_clk_input_padmux = {
+	.muxmask_counts = ARRAY_SIZE(i2s_ext_clk_input_muxmask),
+	.muxmask = i2s_ext_clk_input_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(2),
+	.funcval = BIT(2),
+};
+
+static const unsigned i2s_ext_clk_input_pins[] = { 51 };
+
 static const struct sirfsoc_muxmask i2s_muxmask[] = {
 	{
 		.group = 1,
-		.mask =
-			BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(19)
-				| BIT(23) | BIT(28),
+		.mask = BIT(11) | BIT(12) | BIT(13) | BIT(14),
 	},
 };
 
@@ -399,11 +431,42 @@ static const struct sirfsoc_padmux i2s_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_muxmask),
 	.muxmask = i2s_muxmask,
 	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
-	.funcmask = BIT(3) | BIT(9),
-	.funcval = BIT(3),
 };
 
-static const unsigned i2s_pins[] = { 42, 43, 44, 45, 46, 51, 55, 60 };
+static const unsigned i2s_pins[] = { 43, 44, 45, 46 };
+
+static const struct sirfsoc_muxmask i2s_no_din_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(11) | BIT(12) | BIT(14),
+	},
+};
+
+static const struct sirfsoc_padmux i2s_no_din_padmux = {
+	.muxmask_counts = ARRAY_SIZE(i2s_no_din_muxmask),
+	.muxmask = i2s_no_din_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+};
+
+static const unsigned i2s_no_din_pins[] = { 43, 44, 46 };
+
+static const struct sirfsoc_muxmask i2s_6chn_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(11) | BIT(12) | BIT(13) | BIT(14)
+			| BIT(23) | BIT(28),
+	},
+};
+
+static const struct sirfsoc_padmux i2s_6chn_padmux = {
+	.muxmask_counts = ARRAY_SIZE(i2s_6chn_muxmask),
+	.muxmask = i2s_6chn_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(1) | BIT(9),
+	.funcval = BIT(1) | BIT(9),
+};
+
+static const unsigned i2s_6chn_pins[] = { 43, 44, 45, 46, 55, 60  };
 
 static const struct sirfsoc_muxmask ac97_muxmask[] = {
 	{
@@ -926,7 +989,11 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("usb1_dp_dngrp", usb1_dp_dn_pins),
 	SIRFSOC_PIN_GROUP("uart1_route_io_usb1grp", uart1_route_io_usb1_pins),
 	SIRFSOC_PIN_GROUP("pulse_countgrp", pulse_count_pins),
+	SIRFSOC_PIN_GROUP("i2smclkgrp", i2s_mclk_pins),
+	SIRFSOC_PIN_GROUP("i2s_ext_clk_inputgrp", i2s_ext_clk_input_pins),
 	SIRFSOC_PIN_GROUP("i2sgrp", i2s_pins),
+	SIRFSOC_PIN_GROUP("i2s_no_dingrp", i2s_no_din_pins),
+	SIRFSOC_PIN_GROUP("i2s_6chngrp", i2s_6chn_pins),
 	SIRFSOC_PIN_GROUP("ac97grp", ac97_pins),
 	SIRFSOC_PIN_GROUP("nandgrp", nand_pins),
 	SIRFSOC_PIN_GROUP("spi0grp", spi0_pins),
@@ -980,7 +1047,11 @@ static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
 static const char * const
 	uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
+static const char * const i2smclkgrp[] = { "i2smclkgrp" };
+static const char * const i2s_ext_clk_inputgrp[] = { "i2s_ext_clk_inputgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
+static const char * const i2s_no_dingrp[] = { "i2s_no_dingrp" };
+static const char * const i2s_6chngrp[] = { "i2s_6chngrp" };
 static const char * const ac97grp[] = { "ac97grp" };
 static const char * const nandgrp[] = { "nandgrp" };
 static const char * const spi0grp[] = { "spi0grp" };
@@ -1037,7 +1108,12 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1",
 		uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_mclk", i2smclkgrp, i2s_mclk_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_ext_clk_input", i2s_ext_clk_inputgrp,
+						i2s_ext_clk_input_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_no_din", i2s_no_dingrp, i2s_no_din_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_6chn", i2s_6chngrp, i2s_6chn_padmux),
 	SIRFSOC_PMX_FUNCTION("ac97", ac97grp, ac97_padmux),
 	SIRFSOC_PMX_FUNCTION("nand", nandgrp, nand_padmux),
 	SIRFSOC_PMX_FUNCTION("spi0", spi0grp, spi0_padmux),
-- 
2.1.0



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
