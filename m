From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:50 -0000
Subject: [PATCH v3 05/13] spi: sun6i: update CS handling from spi-sun4i
In-Reply-To: <cover.1465490774.git.hramrach@gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
Message-ID: <3bf00d7311a7ed5f5d71125b7b652175551061b6.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While trying to merge sun4i and sun6i spi drivers I noticed
the sun4i driver seems to have more reasonable CS handling.

Update sun6i to same.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun6i.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index bc29a98..06759d0 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -145,11 +145,30 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	reg &= ~SUN6I_TFR_CTL_CS_MASK;
 	reg |= SUN6I_TFR_CTL_CS(spi->chip_select);
 
+	/* We want to control the chip select manually */
+	reg |= SUN6I_TFR_CTL_CS_MANUAL;
+
 	if (enable)
 		reg |= SUN6I_TFR_CTL_CS_LEVEL;
 	else
 		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
 
+	/*
+	 * Even though this looks irrelevant since we are supposed to
+	 * be controlling the chip select manually, this bit also
+	 * controls the levels of the chip select for inactive
+	 * devices.
+	 *
+	 * If we don't set it, the chip select level will go low by
+	 * default when the device is idle, which is not really
+	 * expected in the common case where the chip select is active
+	 * low.
+	 */
+	if (spi->mode & SPI_CS_HIGH)
+		reg &= ~SUN6I_TFR_CTL_SPOL;
+	else
+		reg |= SUN6I_TFR_CTL_SPOL;
+
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 }
 
@@ -215,9 +234,6 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN6I_TFR_CTL_DHB;
 
-	/* We want to control the chip select manually */
-	reg |= SUN6I_TFR_CTL_CS_MANUAL;
-
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
-- 
2.8.1
