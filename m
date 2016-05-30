From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 30 May 2016 11:55:13 +0300
Subject: [PATCH v1 05/14] mfd: twl6040: Register child device for
 twl6040-pdmclk
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Message-ID: <20160530085522.30398-6-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The McPDM in OMAP4/5 is using the pdmclk from twl6040 as functional clock.
The twl6040-pdmclk driver provides a clock which can be used to make sure
that the pdmclk is active when the McPDM is in use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/twl6040.txt | 1 +
 drivers/mfd/twl6040.c                             | 5 +++++
 include/linux/mfd/twl6040.h                       | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Documentation/devicetree/bindings/mfd/twl6040.txt
index e6afdfa3543d..9a98ee7c323d 100644
--- a/Documentation/devicetree/bindings/mfd/twl6040.txt
+++ b/Documentation/devicetree/bindings/mfd/twl6040.txt
@@ -12,6 +12,7 @@ Required properties:
 - interrupt-parent: The parent interrupt controller
 - gpio-controller:
 - #gpio-cells = <1>: twl6040 provides GPO lines.
+- #clock-cells = <0>; twl6040 is a provider of pdmclk which is used by McPDM
 - twl6040,audpwron-gpio: Power on GPIO line for the twl6040
 
 - vio-supply: Regulator for the twl6040 VIO supply
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 2596546553aa..873628a1bd79 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -782,6 +782,11 @@ static int twl6040_probe(struct i2c_client *client,
 	cell->name = "twl6040-gpo";
 	children++;
 
+	/* PDM clock support  */
+	cell = &twl6040->cells[children];
+	cell->name = "twl6040-pdmclk";
+	children++;
+
 	/* The chip is powered down so mark regmap to cache only and dirty */
 	regcache_cache_only(twl6040->regmap, true);
 	regcache_mark_dirty(twl6040->regmap);
diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 8015db974157..ef0bb07c3f3d 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -168,7 +168,7 @@
 #define TWL6040_VIBROCDET		0x20
 #define TWL6040_TSHUTDET                0x40
 
-#define TWL6040_CELLS			3
+#define TWL6040_CELLS			4
 
 #define TWL6040_REV_ES1_0		0x00
 #define TWL6040_REV_ES1_1		0x01 /* Rev ES1.1 and ES1.2 */
-- 
2.8.3
