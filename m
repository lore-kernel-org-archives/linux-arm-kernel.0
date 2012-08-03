From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  3 Aug 2012 16:30:39 +0200
Subject: [PATCH] SPI: MXS: Allow to pass the SPI master bus number from the
 device tree
In-Reply-To: <1343076052-27312-1-git-send-email-marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
Message-ID: <1344004239-22868-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you don't do it, the bus number will be a bogus value, possibly used
for device file names in drivers like spidev.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spi-mxs.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index d6a80a1..d6a73ef 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -527,6 +527,15 @@ static int __devinit mxs_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	if (pdev->id != -1)
+		master->bus_num = pdev->id;
+	if (np) {
+		unsigned long prop;
+
+		of_property_read_u32(np, "cell-index", &prop);
+		master->bus_num = prop;
+	}
+
 	master->transfer_one_message = mxs_spi_transfer_one;
 	master->setup = mxs_spi_setup;
 	master->cleanup = mxs_spi_cleanup;
-- 
1.7.9.5
