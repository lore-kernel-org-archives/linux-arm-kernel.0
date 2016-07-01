From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  2 Jul 2016 01:56:05 +0200
Subject: [PATCH v2] pinctrl: qcom: add support for EBI2
Message-ID: <1467417365-31681-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to mux in the second external bus interface as
follows:

- CS1 and CS2 on GPIO39 and GPIO40 as func 2
- ADDR_7 thru ADDR_0 on GPIO123 thru GPIO130 as func 1
- CS4, CS3 and CS0 on GPIO132, GPIO133, GPIO134 as func 1
- DATA_15 thru DATA_0 on GPIO135 thru GPIO150 as func 1
- OE on GPIO151 as func 1
- ADV on GPIO153 as func 1
- WE on GPIO157 as func 1

This external bus is used on the APQ8060 Dragonboard to connect
an external SMSC9211 ethernet adapter, but there are many other
usecases for the EBI2.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Pick out the exact right pin assignments from the old codebase.
---
 drivers/pinctrl/qcom/pinctrl-msm8660.c | 72 +++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8660.c b/drivers/pinctrl/qcom/pinctrl-msm8660.c
index 3e8f7ac2ac8a..debc90101553 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8660.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8660.c
@@ -506,6 +506,7 @@ enum msm8660_functions {
 	MSM_MUX_usb_fs2_oe_n,
 	MSM_MUX_vfe,
 	MSM_MUX_vsens_alarm,
+	MSM_MUX_ebi2,
 	MSM_MUX__,
 };
 
@@ -696,6 +697,14 @@ static const char * const vfe_groups[] = {
 static const char * const vsens_alarm_groups[] = {
 	"gpio127"
 };
+static const char * const ebi2_groups[] = {
+	"gpio39", "gpio40", "gpio123", "gpio124", "gpio125", "gpio126",
+	"gpio127", "gpio128", "gpio129", "gpio130", "gpio132", "gpio133",
+	"gpio134", "gpio135", "gpio136", "gpio137", "gpio138", "gpio139"
+	"gpio140", "gpio141", "gpio142", "gpio143", "gpio144", "gpio145",
+	"gpio146", "gpio147", "gpio148", "gpio149", "gpio150", "gpio151",
+	"gpio153", "gpio157"
+};
 
 static const struct msm_function msm8660_functions[] = {
 	FUNCTION(gpio),
@@ -749,6 +758,7 @@ static const struct msm_function msm8660_functions[] = {
 	FUNCTION(usb_fs2_oe_n),
 	FUNCTION(vfe),
 	FUNCTION(vsens_alarm),
+	FUNCTION(ebi2),
 };
 
 static const struct msm_pingroup msm8660_groups[] = {
@@ -791,8 +801,8 @@ static const struct msm_pingroup msm8660_groups[] = {
 	PINGROUP(36, gsbi1, _, _, _, _, _, _),
 	PINGROUP(37, gsbi2, _, _, _, _, _, _),
 	PINGROUP(38, gsbi2, _, _, _, _, _, _),
-	PINGROUP(39, gsbi2, _, mdp_vsync, _, _, _, _),
-	PINGROUP(40, gsbi2, _, _, _, _, _, _),
+	PINGROUP(39, gsbi2, ebi2, mdp_vsync, _, _, _, _),
+	PINGROUP(40, gsbi2, ebi2, _, _, _, _, _),
 	PINGROUP(41, gsbi3, mdp_vsync, _, _, _, _, _),
 	PINGROUP(42, gsbi3, vfe, _, _, _, _, _),
 	PINGROUP(43, gsbi3, _, _, _, _, _, _),
@@ -875,41 +885,41 @@ static const struct msm_pingroup msm8660_groups[] = {
 	PINGROUP(120, i2s, _, _, _, _, _, _),
 	PINGROUP(121, i2s, _, _, _, _, _, _),
 	PINGROUP(122, i2s, gp_clk_1b, _, _, _, _, _),
-	PINGROUP(123, _, gsbi2_spi_cs1_n, _, _, _, _, _),
-	PINGROUP(124, _, gsbi2_spi_cs2_n, _, _, _, _, _),
-	PINGROUP(125, _, gsbi2_spi_cs3_n, _, _, _, _, _),
-	PINGROUP(126, _, _, _, _, _, _, _),
-	PINGROUP(127, _, vsens_alarm, _, _, _, _, _),
-	PINGROUP(128, _, _, _, _, _, _, _),
-	PINGROUP(129, _, _, _, _, _, _, _),
-	PINGROUP(130, _, _, _, _, _, _, _),
+	PINGROUP(123, ebi2, gsbi2_spi_cs1_n, _, _, _, _, _),
+	PINGROUP(124, ebi2, gsbi2_spi_cs2_n, _, _, _, _, _),
+	PINGROUP(125, ebi2, gsbi2_spi_cs3_n, _, _, _, _, _),
+	PINGROUP(126, ebi2, _, _, _, _, _, _),
+	PINGROUP(127, ebi2, vsens_alarm, _, _, _, _, _),
+	PINGROUP(128, ebi2, _, _, _, _, _, _),
+	PINGROUP(129, ebi2, _, _, _, _, _, _),
+	PINGROUP(130, ebi2, _, _, _, _, _, _),
 	PINGROUP(131, _, _, _, _, _, _, _),
-	PINGROUP(132, _, _, _, _, _, _, _),
-	PINGROUP(133, _, _, _, _, _, _, _),
+	PINGROUP(132, ebi2, _, _, _, _, _, _),
+	PINGROUP(133, ebi2, _, _, _, _, _, _),
 	PINGROUP(134, _, _, _, _, _, _, _),
-	PINGROUP(135, _, _, _, _, _, _, _),
-	PINGROUP(136, _, _, _, _, _, _, _),
-	PINGROUP(137, _, _, _, _, _, _, _),
-	PINGROUP(138, _, _, _, _, _, _, _),
-	PINGROUP(139, _, _, _, _, _, _, _),
-	PINGROUP(140, _, _, _, _, _, _, _),
-	PINGROUP(141, _, _, _, _, _, _, _),
-	PINGROUP(142, _, _, _, _, _, _, _),
-	PINGROUP(143, _, sdc2, _, _, _, _, _),
-	PINGROUP(144, _, sdc2, _, _, _, _, _),
-	PINGROUP(145, _, sdc2, _, _, _, _, _),
-	PINGROUP(146, _, sdc2, _, _, _, _, _),
-	PINGROUP(147, _, sdc2, _, _, _, _, _),
-	PINGROUP(148, _, sdc2, _, _, _, _, _),
-	PINGROUP(149, _, sdc2, _, _, _, _, _),
-	PINGROUP(150, _, sdc2, _, _, _, _, _),
-	PINGROUP(151, _, sdc2, _, _, _, _, _),
+	PINGROUP(135, ebi2, _, _, _, _, _, _),
+	PINGROUP(136, ebi2, _, _, _, _, _, _),
+	PINGROUP(137, ebi2, _, _, _, _, _, _),
+	PINGROUP(138, ebi2, _, _, _, _, _, _),
+	PINGROUP(139, ebi2, _, _, _, _, _, _),
+	PINGROUP(140, ebi2, _, _, _, _, _, _),
+	PINGROUP(141, ebi2, _, _, _, _, _, _),
+	PINGROUP(142, ebi2, _, _, _, _, _, _),
+	PINGROUP(143, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(144, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(145, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(146, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(147, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(148, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(149, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(150, ebi2, sdc2, _, _, _, _, _),
+	PINGROUP(151, ebi2, sdc2, _, _, _, _, _),
 	PINGROUP(152, _, sdc2, _, _, _, _, _),
-	PINGROUP(153, _, _, _, _, _, _, _),
+	PINGROUP(153, ebi2, _, _, _, _, _, _),
 	PINGROUP(154, _, _, _, _, _, _, _),
 	PINGROUP(155, _, _, _, _, _, _, _),
 	PINGROUP(156, _, _, _, _, _, _, _),
-	PINGROUP(157, _, _, _, _, _, _, _),
+	PINGROUP(157, ebi2, _, _, _, _, _, _),
 	PINGROUP(158, _, _, _, _, _, _, _),
 	PINGROUP(159, sdc1, _, _, _, _, _, _),
 	PINGROUP(160, sdc1, _, _, _, _, _, _),
-- 
2.4.11
