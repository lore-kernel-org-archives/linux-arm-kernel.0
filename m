From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:34 +0000
Subject: [RFC 3/9] clk: bcm2835: add ability to control mash level via
 device-tree
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Control maximum mash levels that can get used via the device tree.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   39 +++++++++++++++++++++++++++--------
 include/dt-bindings/clock/bcm2835.h |    9 ++++++++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 8fccbd3..48c1ad0 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -303,10 +303,10 @@
 #define BCM2835_MASH_MAX_FREQ	25000000u
 
 enum bcm2835_clock_mash_type {
-	MASH_NONE = 0,
-	MASH_FRAC = 1,
-	MASH_2ND_ORDER = 2,
-	MASH_3RD_ORDER = 3
+	MASH_NONE = BCM2835_MASH_NONE,
+	MASH_FRAC = BCM2835_MASH_FRAC,
+	MASH_ORDER_2 = BCM2835_MASH_ORDER_2,
+	MASH_ORDER_3 = BCM2835_MASH_ORDER_3
 };
 
 /*
@@ -713,6 +713,7 @@ struct bcm2835_clock_data {
 	u32 frac_bits;
 	/* the mash value to use - see CM_MASH */
 	enum bcm2835_clock_mash_type mash;
+	bool mash_forced;
 
 	bool is_vpu_clock;
 };
@@ -1508,7 +1509,7 @@ static divmash bcm2835_clock_choose_div(struct clk_hw *hw,
 
 	/* select mash mode */
 	if (data->frac_bits && divf)
-		mash = data->mash ? data->mash : MASH_FRAC;
+		mash = data->mash_forced ? data->mash : MASH_FRAC;
 
 	/*
 	 * handle possible limits for different mash levels with fall-tru
@@ -1517,17 +1518,17 @@ static divmash bcm2835_clock_choose_div(struct clk_hw *hw,
 	 *   http://elinux.org/BCM2835_datasheet_errata#p105_table
 	 */
 	switch (mash) {
-	case MASH_3RD_ORDER:
+	case MASH_ORDER_3:
 		if ((divi >= divi_min + 3) &&
 		    (divi + 4 <= divi_max) &&
 		    (parent_rate / (divi - 3) <= BCM2835_MASH_MAX_FREQ))
-			return divmash_calc(MASH_3RD_ORDER, div);
+			return divmash_calc(MASH_ORDER_3, div);
 		/* fall tru if not in bounds */
-	case MASH_2ND_ORDER:
+	case MASH_ORDER_2:
 		if ((divi >= divi_min + 1) &&
 		    (divi + 2 <= divi_max) &&
 		    (parent_rate / (divi - 1) <= BCM2835_MASH_MAX_FREQ))
-			return divmash_calc(MASH_2ND_ORDER, div);
+			return divmash_calc(MASH_ORDER_2, div);
 		/* fall tru if not in bounds */
 	case MASH_FRAC:
 		if ((divi >= divi_min) &&
@@ -1993,6 +1994,8 @@ static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 	struct device *dev = cprman->dev;
 	struct device_node *nc;
 	struct bcm2835_clock_data *data;
+	int err;
+	u32 value;
 
 	/* find the corresponding dt-node */
 	nc = bcm2835_find_dt_node(cprman, id);
@@ -2008,6 +2011,24 @@ static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 	/* apply overrides */
 	bcm2835_register_clock_of_parents(cprman, data, nc);
 
+	/* check for mash */
+	err = of_property_read_u32(nc, "brcm,mash-max-order", &value);
+	if (!err) {
+		switch (value) {
+		case MASH_NONE:
+		case MASH_FRAC:
+		case MASH_ORDER_2:
+		case MASH_ORDER_3:
+			data->mash = value;
+			data->mash_forced = 1;
+			break;
+		default:
+			dev_err(dev, "clock %s: undefined mash type: %d\n",
+				data->name, value);
+			break;
+		}
+	}
+
 	/* and return the result */
 	return data;
 }
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index d29f181..eb73380 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -67,3 +67,12 @@
 #define BCM2835_CLOCK_TD0		51
 #define BCM2835_CLOCK_TD1		52
 #define BCM2835_CLOCK_TEC		53
+
+/* the mash divider options */
+#define BCM2835_MASH_NONE		0
+#define BCM2835_MASH_ORDER_1		1
+#define BCM2835_MASH_ORDER_2		2
+#define BCM2835_MASH_ORDER_3		3
+
+#define BCM2835_MASH_INTEGER		BCM2835_MASH_NONE
+#define BCM2835_MASH_FRAC		BCM2835_MASH_ORDER_1
-- 
1.7.10.4
