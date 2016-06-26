From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sun, 26 Jun 2016 00:28:20 -0700
Subject: [PATCH 03/21] usb: ulpi: Avoid reading/writing in device creation
 with OF devices
In-Reply-To: <20160626072838.28082-1-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
Message-ID: <20160626072838.28082-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ULPI devices are matched up against ULPI drivers by reading the
vendor id and product id registers in the ULPI address space.
Before we try to read those registers we'll do a scratch write to
test the interface. Unfortunately, this doesn't work well if the
ULPI device is not powered at the time of device creation. In
that case, the scratch register writes fail and product and
vendor ids can't be read.

If the ULPI spec had some way to describe generic power
requirements for the scratch, product, and vendor registers we
could but power sequencing into the ULPI bus layer and power up
the device before touching the hardware. Unfortunately this
doesn't exist. Furthermore, the power information is device
specific, so it varies from device to device and is not standard.

Let's punt on doing the reads/writes here when we're using DT
backed ULPI devices. This avoids any problems where we need to
power on the device but haven't figured out which device it is
yet to know what sort of regulators, clks, etc. that need to be
turned on for it to work.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 drivers/usb/common/ulpi.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 980af672bfe3..a6b2a150b176 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -197,25 +197,7 @@ static int ulpi_of_register(struct ulpi *ulpi)
 
 static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 {
-	int ret;
-
-	/* Test the interface */
-	ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
-	if (ret < 0)
-		return ret;
-
-	ret = ulpi_read(ulpi, ULPI_SCRATCH);
-	if (ret < 0)
-		return ret;
-
-	if (ret != 0xaa)
-		return -ENODEV;
-
-	ulpi->id.vendor = ulpi_read(ulpi, ULPI_VENDOR_ID_LOW);
-	ulpi->id.vendor |= ulpi_read(ulpi, ULPI_VENDOR_ID_HIGH) << 8;
-
-	ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
-	ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
+	int ret = -ENODEV;
 
 	ulpi->dev.parent = dev;
 	ulpi->dev.bus = &ulpi_bus;
@@ -230,6 +212,26 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
 			return ret;
 	}
 
+	if (ret) {
+		/* Test the interface */
+		ret = ulpi_write(ulpi, ULPI_SCRATCH, 0xaa);
+		if (ret < 0)
+			return ret;
+
+		ret = ulpi_read(ulpi, ULPI_SCRATCH);
+		if (ret < 0)
+			return ret;
+
+		if (ret != 0xaa)
+			return -ENODEV;
+
+		ulpi->id.vendor = ulpi_read(ulpi, ULPI_VENDOR_ID_LOW);
+		ulpi->id.vendor |= ulpi_read(ulpi, ULPI_VENDOR_ID_HIGH) << 8;
+
+		ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
+		ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
+	}
+
 	if (of_device_request_module(&ulpi->dev))
 		request_module("ulpi:v%04xp%04x", ulpi->id.vendor,
 			       ulpi->id.product);
-- 
2.9.0.rc2.8.ga28705d
