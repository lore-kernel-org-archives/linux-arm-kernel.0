From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 30 Jan 2014 13:54:24 +0800
Subject: [PATCH 1/2] pinctrl: sirf: add pin group for USP0 with only RX or TX
 frame sync for atlas6
Message-ID: <1391061264-2162-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rongjun Ying <rongjun.ying@csr.com>

USP0 has multiple functions, and has RX and TX frame sync signals, for some scenarios
like audio PCM, we don't need both of them. so here we add two possibilities for USP0
only holding one of TX and RX frame sync.

commit 8385af02bad only added this group for prima2, and missed atlas6. her this patch
fixes it.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c |   43 +++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index 2b9f320..09211fb 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -529,6 +529,40 @@ static const struct sirfsoc_padmux usp0_padmux = {
 
 static const unsigned usp0_pins[] = { 51, 52, 53, 54, 55 };
 
+static const struct sirfsoc_muxmask usp0_only_utfs_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(19) | BIT(20) | BIT(21) | BIT(22),
+	},
+};
+
+static const struct sirfsoc_padmux usp0_only_utfs_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp0_only_utfs_muxmask),
+	.muxmask = usp0_only_utfs_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(1) | BIT(2) | BIT(6),
+	.funcval = 0,
+};
+
+static const unsigned usp0_only_utfs_pins[] = { 51, 52, 53, 54 };
+
+static const struct sirfsoc_muxmask usp0_only_urfs_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(19) | BIT(20) | BIT(21) | BIT(23),
+	},
+};
+
+static const struct sirfsoc_padmux usp0_only_urfs_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp0_only_urfs_muxmask),
+	.muxmask = usp0_only_urfs_muxmask,
+	.ctrlreg = SIRFSOC_RSC_PIN_MUX,
+	.funcmask = BIT(1) | BIT(2) | BIT(9),
+	.funcval = 0,
+};
+
+static const unsigned usp0_only_urfs_pins[] = { 51, 52, 53, 55 };
+
 static const struct sirfsoc_muxmask usp0_uart_nostreamctrl_muxmask[] = {
 	{
 		.group = 1,
@@ -905,6 +939,8 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("usp0grp", usp0_pins),
 	SIRFSOC_PIN_GROUP("usp0_uart_nostreamctrl_grp",
 					usp0_uart_nostreamctrl_pins),
+	SIRFSOC_PIN_GROUP("usp0_only_utfs_grp", usp0_only_utfs_pins),
+	SIRFSOC_PIN_GROUP("usp0_only_urfs_grp", usp0_only_urfs_pins),
 	SIRFSOC_PIN_GROUP("usp1grp", usp1_pins),
 	SIRFSOC_PIN_GROUP("usp1_uart_nostreamctrl_grp",
 					usp1_uart_nostreamctrl_pins),
@@ -953,6 +989,9 @@ static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
 static const char * const usp0_uart_nostreamctrl_grp[] = {
 					"usp0_uart_nostreamctrl_grp" };
 static const char * const usp0grp[] = { "usp0grp" };
+static const char * const usp0_only_utfs_grp[] = { "usp0_only_utfs_grp" };
+static const char * const usp0_only_urfs_grp[] = { "usp0_only_urfs_grp" };
+
 static const char * const usp1grp[] = { "usp1grp" };
 static const char * const usp1_uart_nostreamctrl_grp[] = {
 					"usp1_uart_nostreamctrl_grp" };
@@ -1003,6 +1042,10 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("usp0_uart_nostreamctrl",
 						usp0_uart_nostreamctrl_grp,
 						usp0_uart_nostreamctrl_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_only_utfs", usp0_only_utfs_grp,
+						usp0_only_utfs_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_only_urfs", usp0_only_urfs_grp,
+						usp0_only_urfs_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1", usp1grp, usp1_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1_uart_nostreamctrl",
 						usp1_uart_nostreamctrl_grp,
-- 
1.7.5.4
