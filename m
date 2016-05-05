From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu,  5 May 2016 15:53:28 +0000
Subject: [PATCH 5/5] clk: bcm2835: add support for
 BCM2835_CLOCK_FLAG_USE_MASH/INTEGER
In-Reply-To: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1462463608-22940-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow the use of higher order mash fractional divider modes
and also allow to force the use of integer dividers.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       | 57 +++++++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/bcm2835.h |  7 +++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index c80487e..08140ad 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -130,6 +130,7 @@
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
 # define CM_FRAC			BIT(9)
+# define CM_MASH			BIT(10)
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -888,6 +889,24 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 				 CM_DIV_FRAC_BITS - data->frac_bits);
 	}
 
+	/* based on flags modify settings */
+	switch (clock->flags & BCM2835_CLOCK_FLAG_USE_MASK) {
+	case BCM2835_CLOCK_FLAG_USE_FRAC:
+			break;
+	case BCM2835_CLOCK_FLAG_USE_INTEGER:
+		div &= GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
+			       CM_DIV_FRAC_BITS);
+		break;
+	case BCM2835_CLOCK_FLAG_USE_MASH2:
+		mindiv += 2 << CM_DIV_FRAC_BITS;
+		maxdiv -= 1 << CM_DIV_FRAC_BITS;
+		break;
+	case BCM2835_CLOCK_FLAG_USE_MASH3:
+		mindiv += 4 << CM_DIV_FRAC_BITS;
+		maxdiv -= 3 << CM_DIV_FRAC_BITS;
+		break;
+	}
+
 	/* apply the clamping  limits */
 	div = max_t(u32, div, mindiv);
 	div = min_t(u32, div, maxdiv);
@@ -996,8 +1015,26 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	 * clock this requirement should be take care of by the
 	 * clk-framework.
 	 */
-	ctl = cprman_read(cprman, data->ctl_reg) & ~CM_FRAC;
-	ctl |= (div & CM_DIV_FRAC_MASK) ? CM_FRAC : 0;
+	ctl = cprman_read(cprman, data->ctl_reg) & ~(CM_FRAC | CM_MASH);
+	if (div & CM_DIV_FRAC_MASK) {
+		/*
+		 * we never get to *MASH* for non-mash clock,
+		 * as it is filtered in bcm2835_register_clock
+		 * USE_INTEGER forces already choose_clock_div
+		 * to apply the mask so that we do not get here
+		 */
+		switch (clock->flags & BCM2835_CLOCK_FLAG_USE_MASK) {
+		case BCM2835_CLOCK_FLAG_USE_FRAC:
+			ctl |= CM_FRAC;
+			break;
+		case BCM2835_CLOCK_FLAG_USE_MASH2:
+			ctl |= CM_MASH;
+			break;
+		case BCM2835_CLOCK_FLAG_USE_MASH3:
+			ctl |= CM_MASH | CM_FRAC;
+			break;
+		}
+	}
 	cprman_write(cprman, data->ctl_reg, ctl);
 
 	cprman_write(cprman, data->div_reg, div);
@@ -1280,6 +1317,22 @@ bcm2835_register_clock(struct bcm2835_cprman *cprman,
 		clock->flags |= bcm2835_register_clock_default_parents(
 			cprman->dev, data);
 
+	/* check for MASH flags when the clock is not a mash clock */
+	if (!data->is_mash_clock) {
+		switch (clock->flags & BCM2835_CLOCK_FLAG_USE_MASK) {
+		case BCM2835_CLOCK_FLAG_USE_MASH2:
+		case BCM2835_CLOCK_FLAG_USE_MASH3:
+			dev_warn(cprman->dev,
+				 "found mash2/mash3 flag for clock %s, which does not support mash\n",
+				 data->name);
+			clock->flags &= BCM2835_CLOCK_FLAG_USE_MASK;
+			clock->flags |= BCM2835_CLOCK_FLAG_USE_FRAC;
+			break;
+		default:
+			break;
+		}
+	}
+
 	return devm_clk_register(cprman->dev, &clock->hw);
 }
 
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index e5396fe..5591bd1 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -90,3 +90,10 @@
 #define BCM2835_VPU_PARENT_PLLH_AUX	7
 #define BCM2835_VPU_PARENT_PLLC_CORE1	8
 #define BCM2835_VPU_PARENT_PLLC_CORE2	9
+
+/* additional clock flags */
+#define BCM2835_CLOCK_FLAG_USE_FRAC	((0 << 31) | (0 << 30))
+#define BCM2835_CLOCK_FLAG_USE_INTEGER	((0 << 31) | (1 << 30))
+#define BCM2835_CLOCK_FLAG_USE_MASH2	((1 << 31) | (0 << 30))
+#define BCM2835_CLOCK_FLAG_USE_MASH3	((1 << 31) | (1 << 30))
+#define BCM2835_CLOCK_FLAG_USE_MASK	((1 << 31) | (1 << 30))
-- 
2.1.4
