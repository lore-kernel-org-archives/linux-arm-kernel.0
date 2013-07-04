From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:55:26 +0800
Subject: [PATCH 2/5] pinctrl: sirf: add usp0_uart_nostreamctrl pin group for
 usp-uart without flowctrl
In-Reply-To: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
References: <1372924529-5519-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1372924529-5519-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

this patch adds the lost pin group which supports to let USP0 to simulate
a UART without hardware flow control.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi         |  6 ++++++
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 7d1a279..6e24ecf 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -485,6 +485,12 @@
                                                 sirf,function = "usp0";
                                         };
                                 };
+				usp0_uart_nostreamctrl_pins_a: usp0 at 1 {
+                                        usp0 {
+                                                sirf,pins = "usp0_uart_nostreamctrl_grp";
+                                                sirf,function = "usp0_uart_nostreamctrl";
+                                        };
+                                };
                                 usp1_pins_a: usp1 at 0 {
                                         usp1 {
                                                 sirf,pins = "usp1grp";
diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index c641be9..867c968 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -509,6 +509,19 @@ static const struct sirfsoc_padmux usp0_padmux = {
 
 static const unsigned usp0_pins[] = { 51, 52, 53, 54, 55 };
 
+static const struct sirfsoc_muxmask usp0_uart_nostreamctrl_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(20) | BIT(21),
+	},
+};
+
+static const struct sirfsoc_padmux usp0_uart_nostreamctrl_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp0_uart_nostreamctrl_muxmask),
+	.muxmask = usp0_uart_nostreamctrl_muxmask,
+};
+
+static const unsigned usp0_uart_nostreamctrl_pins[] = { 52, 53 };
 static const struct sirfsoc_muxmask usp1_muxmask[] = {
 	{
 		.group = 0,
@@ -822,6 +835,8 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("uart2grp", uart2_pins),
 	SIRFSOC_PIN_GROUP("uart2_nostreamctrlgrp", uart2_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp0grp", usp0_pins),
+	SIRFSOC_PIN_GROUP("usp0_uart_nostreamctrl_grp",
+					usp0_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp1grp", usp1_pins),
 	SIRFSOC_PIN_GROUP("i2c0grp", i2c0_pins),
 	SIRFSOC_PIN_GROUP("i2c1grp", i2c1_pins),
@@ -862,6 +877,8 @@ static const char * const uart0grp[] = { "uart0grp" };
 static const char * const uart1grp[] = { "uart1grp" };
 static const char * const uart2grp[] = { "uart2grp" };
 static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
+static const char * const usp0_uart_nostreamctrl_grp[] = {
+					"usp0_uart_nostreamctrl_grp" };
 static const char * const usp0grp[] = { "usp0grp" };
 static const char * const usp1grp[] = { "usp1grp" };
 static const char * const i2c0grp[] = { "i2c0grp" };
@@ -904,6 +921,9 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0", usp0grp, usp0_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_uart_nostreamctrl",
+						usp0_uart_nostreamctrl_grp,
+						usp0_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1", usp1grp, usp1_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c0", i2c0grp, i2c0_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c1", i2c1grp, i2c1_padmux),
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
