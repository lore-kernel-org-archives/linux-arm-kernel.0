From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:24 +0800
Subject: [PATCH 5/6] pinctrl: atlas6: Add I2S external clock input pingroup
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1408351765-18253-5-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

The I2S controller can use the external clock as reference clock with
master mode. But based on different hardware or software design, this
external clock might be needed or not needed.
So the external input pin can be an independent pinctrl group, and the
card driver can decice to get it or not.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index 9cc8faf..45f8391 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -394,6 +394,23 @@ static const struct sirfsoc_padmux i2s_mclk_padmux = {
 
 static const unsigned i2s_mclk_pins[] = { 42 };
 
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
 		.group = 3,
@@ -982,6 +999,7 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("uart1_route_io_usb1grp", uart1_route_io_usb1_pins),
 	SIRFSOC_PIN_GROUP("pulse_countgrp", pulse_count_pins),
 	SIRFSOC_PIN_GROUP("i2smclkgrp", i2s_mclk_pins),
+	SIRFSOC_PIN_GROUP("i2s_ext_clk_inputgrp", i2s_ext_clk_input_pins),
 	SIRFSOC_PIN_GROUP("i2sgrp", i2s_pins),
 	SIRFSOC_PIN_GROUP("i2s_no_dingrp", i2s_no_din_pins),
 	SIRFSOC_PIN_GROUP("i2s_6chngrp", i2s_6chn_pins),
@@ -1035,6 +1053,7 @@ static const char * const
 	uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
 static const char * const i2smclkgrp[] = { "i2smclkgrp" };
+static const char * const i2s_ext_clk_inputgrp[] = { "i2s_ext_clk_inputgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const i2s_no_dingrp[] = { "i2s_no_dingrp" };
 static const char * const i2s_6chngrp[] = { "i2s_6chngrp" };
@@ -1096,6 +1115,8 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 		uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_mclk", i2smclkgrp, i2s_mclk_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_ext_clk_input", i2s_ext_clk_inputgrp,
+						i2s_ext_clk_input_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_no_din", i2s_no_dingrp, i2s_no_din_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_6chn", i2s_6chngrp, i2s_6chn_padmux),
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
