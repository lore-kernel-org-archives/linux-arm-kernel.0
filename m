From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  1 Aug 2017 17:57:19 +0200
Subject: [PATCH 1/2] pinctrl: armada-37xx: Fix the pin 23 on south bridge
In-Reply-To: <20170801155720.10229-1-gregory.clement@free-electrons.com>
References: <20170801155720.10229-1-gregory.clement@free-electrons.com>
Message-ID: <20170801155720.10229-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pin 23 on South bridge does not belong to the rgmii group. It belongs to
a separate group which can have 3 functions.

Due to this the fix also have to update the way the functions are
managed. Until now each groups used NB_FUNCS(which was 2) functions. For
the mpp23, 3 functions are available but it is the only group which needs
it, so on the loop involving NB_FUNCS an extra test was added to handle
only the functions added.

The bug was visible with the merge of the commit 07d065abf93d "arm64:
dts: marvell: armada-3720-db: Add vqmmc regulator for SD slot", the gpio
regulator used the gpio 23, due to this the whole rgmii group was setup
to gpio which broke the Ethernet support on the Armada 3720 DB
board. Thanks to this patch, the UHS SD cards (which need the vqmmc)
_and_ the Ethernet work again.

Cc: stable at vger.kernel.org
Fixes: 87466ccd9401 ("pinctrl: armada-37xx: Add pin controller support
for Armada 37xx")
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index f024e25787fc..c95c76ecc3f7 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -37,7 +37,7 @@
 #define IRQ_STATUS	0x10
 #define IRQ_WKUP	0x18
 
-#define NB_FUNCS 2
+#define NB_FUNCS 3
 #define GPIO_PER_REG	32
 
 /**
@@ -126,6 +126,16 @@ struct armada_37xx_pinctrl {
 		.funcs = {_func1, "gpio"}	\
 	}
 
+#define PIN_GRP_GPIO_3(_name, _start, _nr, _mask, _v1, _v2, _v3, _f1, _f2) \
+	{					\
+		.name = _name,			\
+		.start_pin = _start,		\
+		.npins = _nr,			\
+		.reg_mask = _mask,		\
+		.val = {_v1, _v2, _v3},	\
+		.funcs = {_f1, _f2, "gpio"}	\
+	}
+
 #define PIN_GRP_EXTRA(_name, _start, _nr, _mask, _v1, _v2, _start2, _nr2, \
 		      _f1, _f2)				\
 	{						\
@@ -171,12 +181,13 @@ static struct armada_37xx_pin_group armada_37xx_sb_groups[] = {
 	PIN_GRP_GPIO("usb32_drvvbus0", 0, 1, BIT(0), "drvbus"),
 	PIN_GRP_GPIO("usb2_drvvbus1", 1, 1, BIT(1), "drvbus"),
 	PIN_GRP_GPIO("sdio_sb", 24, 6, BIT(2), "sdio"),
-	PIN_GRP_EXTRA("rgmii", 6, 12, BIT(3), 0, BIT(3), 23, 1, "mii", "gpio"),
+	PIN_GRP_GPIO("rgmii", 6, 12, BIT(3), "mii"),
 	PIN_GRP_GPIO("pcie1", 3, 2, BIT(4), "pcie"),
 	PIN_GRP_GPIO("ptp", 20, 3, BIT(5), "ptp"),
 	PIN_GRP("ptp_clk", 21, 1, BIT(6), "ptp", "mii"),
 	PIN_GRP("ptp_trig", 22, 1, BIT(7), "ptp", "mii"),
-	PIN_GRP("mii_col", 23, 1, BIT(8), "mii", "mii_err"),
+	PIN_GRP_GPIO_3("mii_col", 23, 1, BIT(8) | BIT(14), 0, BIT(8), BIT(14),
+		       "mii", "mii_err"),
 };
 
 const struct armada_37xx_pin_data armada_37xx_pin_nb = {
@@ -208,7 +219,7 @@ static int armada_37xx_get_func_reg(struct armada_37xx_pin_group *grp,
 {
 	int f;
 
-	for (f = 0; f < NB_FUNCS; f++)
+	for (f = 0; (f < NB_FUNCS) && grp->funcs[f]; f++)
 		if (!strcmp(grp->funcs[f], func))
 			return f;
 
@@ -795,7 +806,7 @@ static int armada_37xx_fill_group(struct armada_37xx_pinctrl *info)
 		for (j = 0; j < grp->extra_npins; j++)
 			grp->pins[i+j] = grp->extra_pin + j;
 
-		for (f = 0; f < NB_FUNCS; f++) {
+		for (f = 0; (f < NB_FUNCS) && grp->funcs[f]; f++) {
 			int ret;
 			/* check for unique functions and count groups */
 			ret = armada_37xx_add_function(info->funcs, &funcsize,
@@ -847,7 +858,7 @@ static int armada_37xx_fill_func(struct armada_37xx_pinctrl *info)
 			struct armada_37xx_pin_group *gp = &info->groups[g];
 			int f;
 
-			for (f = 0; f < NB_FUNCS; f++) {
+			for (f = 0; (f < NB_FUNCS) && gp->funcs[f]; f++) {
 				if (strcmp(gp->funcs[f], name) == 0) {
 					*groups = gp->name;
 					groups++;
-- 
2.13.2
