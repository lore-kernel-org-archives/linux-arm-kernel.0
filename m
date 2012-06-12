From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Tue, 12 Jun 2012 23:07:47 +0200 (CEST)
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
Message-ID: <1795608889.2533817.1339535267600.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Alan Carvalho de Assis <acassis@gmail.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../drivers/char/hw_random/mxc-rnga.c              |   22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git linux-next-HEAD-c90e5d2.orig/drivers/char/hw_random/mxc-rnga.c linux-next-HEAD-c90e5d2/drivers/char/hw_random/mxc-rnga.c
index 187c6be..2924253 100644
--- linux-next-HEAD-c90e5d2.orig/drivers/char/hw_random/mxc-rnga.c
+++ linux-next-HEAD-c90e5d2/drivers/char/hw_random/mxc-rnga.c
@@ -24,6 +24,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/hw_random.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 /* RNGA Registers */
@@ -60,16 +61,21 @@
 
 static struct platform_device *rng_dev;
 
-static int mxc_rnga_data_present(struct hwrng *rng)
+static int mxc_rnga_data_present(struct hwrng *rng, int wait)
 {
-	int level;
 	void __iomem *rng_base = (void __iomem *)rng->priv;
-
-	/* how many random numbers is in FIFO? [0-16] */
-	level = ((__raw_readl(rng_base + RNGA_STATUS) &
-			RNGA_STATUS_LEVEL_MASK) >> 8);
-
-	return level > 0 ? 1 : 0;
+	int level, data, i;
+
+	for (i = 0; i < 20; i++) {
+		/* how many random numbers is in FIFO? [0-16] */
+		level = ((__raw_readl(rng_base + RNGA_STATUS) &
+				RNGA_STATUS_LEVEL_MASK) >> 8);
+		data = level > 0 ? 1 : 0;
+		if (data || !wait)
+			break;
+		udelay(10);
+	}
+	return data;
 }
 
 static int mxc_rnga_data_read(struct hwrng *rng, u32 * data)
