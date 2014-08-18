From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:22 +0800
Subject: [PATCH 3/6] pinctrl: atlas6: take mclk pin out of i2s pingroup
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1408351765-18253-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

The I2S controller can output mclk to external audio codec. But by
hardware design, some codecs need mclk and some codecs do not need
mclk. So the mclk pin can be an independent pinctrl group, and the
card driver can get it or not based on boards.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 41 ++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index b0bd2c4..9cc8faf 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -377,11 +377,25 @@ static const struct sirfsoc_padmux cko1_padmux = {
 
 static const unsigned cko1_pins[] = { 42 };
 
-static const struct sirfsoc_muxmask i2s_muxmask[] = {
+static const struct sirfsoc_muxmask i2s_mclk_muxmask[] = {
 	{
 		.group = 1,
 		.mask = BIT(10),
-	}, {
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
+static const struct sirfsoc_muxmask i2s_muxmask[] = {
+	{
 		.group = 3,
 		.mask = BIT(2) | BIT(3) | BIT(4) | BIT(5),
 	},
@@ -391,17 +405,12 @@ static const struct sirfsoc_padmux i2s_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_muxmask),
 	.muxmask = i2s_muxmask,
 	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
-	.funcmask = BIT(3),
-	.funcval = BIT(3),
 };
 
-static const unsigned i2s_pins[] = { 42, 98, 99, 100, 101 };
+static const unsigned i2s_pins[] = { 98, 99, 100, 101 };
 
 static const struct sirfsoc_muxmask i2s_no_din_muxmask[] = {
 	{
-		.group = 1,
-		.mask = BIT(10),
-	}, {
 		.group = 3,
 		.mask = BIT(2) | BIT(3) | BIT(4),
 	},
@@ -411,17 +420,12 @@ static const struct sirfsoc_padmux i2s_no_din_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_no_din_muxmask),
 	.muxmask = i2s_no_din_muxmask,
 	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
-	.funcmask = BIT(3),
-	.funcval = BIT(3),
 };
 
-static const unsigned i2s_no_din_pins[] = { 42, 98, 99, 100 };
+static const unsigned i2s_no_din_pins[] = { 98, 99, 100 };
 
 static const struct sirfsoc_muxmask i2s_6chn_muxmask[] = {
 	{
-		.group = 1,
-		.mask = BIT(10) | BIT(20) | BIT(23),
-	}, {
 		.group = 3,
 		.mask = BIT(2) | BIT(3) | BIT(4) | BIT(5),
 	},
@@ -431,11 +435,11 @@ static const struct sirfsoc_padmux i2s_6chn_padmux = {
 	.muxmask_counts = ARRAY_SIZE(i2s_6chn_muxmask),
 	.muxmask = i2s_6chn_muxmask,
 	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
-	.funcmask = BIT(1) | BIT(3) | BIT(9),
-	.funcval = BIT(1) | BIT(3) | BIT(9),
+	.funcmask = BIT(1) | BIT(9),
+	.funcval = BIT(1) | BIT(9),
 };
 
-static const unsigned i2s_6chn_pins[] = { 42, 52, 55, 98, 99, 100, 101 };
+static const unsigned i2s_6chn_pins[] = { 52, 55, 98, 99, 100, 101 };
 
 static const struct sirfsoc_muxmask ac97_muxmask[] = {
 	{
@@ -977,6 +981,7 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("usb1_dp_dngrp", usb1_dp_dn_pins),
 	SIRFSOC_PIN_GROUP("uart1_route_io_usb1grp", uart1_route_io_usb1_pins),
 	SIRFSOC_PIN_GROUP("pulse_countgrp", pulse_count_pins),
+	SIRFSOC_PIN_GROUP("i2smclkgrp", i2s_mclk_pins),
 	SIRFSOC_PIN_GROUP("i2sgrp", i2s_pins),
 	SIRFSOC_PIN_GROUP("i2s_no_dingrp", i2s_no_din_pins),
 	SIRFSOC_PIN_GROUP("i2s_6chngrp", i2s_6chn_pins),
@@ -1029,6 +1034,7 @@ static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
 static const char * const
 	uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
+static const char * const i2smclkgrp[] = { "i2smclkgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const i2s_no_dingrp[] = { "i2s_no_dingrp" };
 static const char * const i2s_6chngrp[] = { "i2s_6chngrp" };
@@ -1089,6 +1095,7 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1",
 		uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
+	SIRFSOC_PMX_FUNCTION("i2s_mclk", i2smclkgrp, i2s_mclk_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_no_din", i2s_no_dingrp, i2s_no_din_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_6chn", i2s_6chngrp, i2s_6chn_padmux),
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
