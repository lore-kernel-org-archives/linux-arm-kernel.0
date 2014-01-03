From: 21cnbao@gmail.com (Barry Song)
Date: Fri,  3 Jan 2014 10:59:22 +0800
Subject: [PATCH 1/5] pinctrl: sirf: add lost usp1_uart_nostreamctrl group for
 atlas6
In-Reply-To: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
References: <1388717966-11703-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1388717966-11703-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

commit af614b2301f0e304 adds lost USP-based UART pin groups for prima2,
but missed usp1_uart_nostreamctrl group for atlas6, this patch fixes it.

this makes USP(Universal Serial Ports) port1 can work as uart without
stream ctrl.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index 8ab7898..2b9f320 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -562,6 +562,23 @@ static const struct sirfsoc_padmux usp1_padmux = {
 
 static const unsigned usp1_pins[] = { 15, 43, 44, 45, 46 };
 
+static const struct sirfsoc_muxmask usp1_uart_nostreamctrl_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(12) | BIT(13),
+	},
+};
+
+static const struct sirfsoc_padmux usp1_uart_nostreamctrl_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp1_uart_nostreamctrl_muxmask),
+	.muxmask = usp1_uart_nostreamctrl_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(16),
+	.funcval = BIT(16),
+};
+
+static const unsigned usp1_uart_nostreamctrl_pins[] = { 44, 45 };
+
 static const struct sirfsoc_muxmask nand_muxmask[] = {
 	{
 		.group = 2,
@@ -889,6 +906,8 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("usp0_uart_nostreamctrl_grp",
 					usp0_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp1grp", usp1_pins),
+	SIRFSOC_PIN_GROUP("usp1_uart_nostreamctrl_grp",
+					usp1_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("i2c0grp", i2c0_pins),
 	SIRFSOC_PIN_GROUP("i2c1grp", i2c1_pins),
 	SIRFSOC_PIN_GROUP("pwm0grp", pwm0_pins),
@@ -935,6 +954,8 @@ static const char * const usp0_uart_nostreamctrl_grp[] = {
 					"usp0_uart_nostreamctrl_grp" };
 static const char * const usp0grp[] = { "usp0grp" };
 static const char * const usp1grp[] = { "usp1grp" };
+static const char * const usp1_uart_nostreamctrl_grp[] = {
+					"usp1_uart_nostreamctrl_grp" };
 static const char * const i2c0grp[] = { "i2c0grp" };
 static const char * const i2c1grp[] = { "i2c1grp" };
 static const char * const pwm0grp[] = { "pwm0grp" };
@@ -983,6 +1004,9 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 						usp0_uart_nostreamctrl_grp,
 						usp0_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1", usp1grp, usp1_padmux),
+	SIRFSOC_PMX_FUNCTION("usp1_uart_nostreamctrl",
+						usp1_uart_nostreamctrl_grp,
+						usp1_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c0", i2c0grp, i2c0_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c1", i2c1grp, i2c1_padmux),
 	SIRFSOC_PMX_FUNCTION("pwm0", pwm0grp, pwm0_padmux),
-- 
1.7.5.4
