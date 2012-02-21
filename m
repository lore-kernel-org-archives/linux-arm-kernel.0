From: michael.thalmeier@hale.at (Michael Thalmeier)
Date: Tue, 21 Feb 2012 13:13:30 +0100
Subject: [PATCH] i.MX31: mxc-rnga: implement waiting for data in driver
Message-ID: <1329826410-21739-1-git-send-email-michael.thalmeier@hale.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_rnga_data_present dit not use the wait parameter which caused a build
warning about initialization from incompatible pointer type.

Apart from this warning it is cleaner to implement the interface as intendet
and wait in the driver until data is available or a timeout has occured.

Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
 drivers/char/hw_random/mxc-rnga.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
index 187c6be..39fb446 100644
--- a/drivers/char/hw_random/mxc-rnga.c
+++ b/drivers/char/hw_random/mxc-rnga.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 /* RNGA Registers */
 #define RNGA_CONTROL			0x00
@@ -60,14 +61,19 @@
 
 static struct platform_device *rng_dev;
 
-static int mxc_rnga_data_present(struct hwrng *rng)
+static int mxc_rnga_data_present(struct hwrng *rng, int wait)
 {
-	int level;
+	int level, i;
 	void __iomem *rng_base = (void __iomem *)rng->priv;
 
-	/* how many random numbers is in FIFO? [0-16] */
-	level = ((__raw_readl(rng_base + RNGA_STATUS) &
-			RNGA_STATUS_LEVEL_MASK) >> 8);
+	for (i = 0; i < 20; i++) {
+		/* how many random numbers is in FIFO? [0-16] */
+		level = ((__raw_readl(rng_base + RNGA_STATUS) &
+				RNGA_STATUS_LEVEL_MASK) >> 8);
+		if (level || !wait)
+			break;
+		udelay(10);
+	}
 
 	return level > 0 ? 1 : 0;
 }
-- 
1.7.7.6



--
Scanned by MailScanner.
