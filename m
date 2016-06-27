From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Mon, 27 Jun 2016 17:34:22 +0300
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160626072838.28082-3-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-3-stephen.boyd@linaro.org>
Message-ID: <20160627143422.GB21398@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm fine with most of the patch, except..

On Sun, Jun 26, 2016 at 12:28:19AM -0700, Stephen Boyd wrote:
> @@ -39,7 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
>  	struct ulpi *ulpi = to_ulpi_dev(dev);
>  	const struct ulpi_device_id *id;
>  
> -	for (id = drv->id_table; id->vendor; id++)
> +	if (of_driver_match_device(dev, driver))
> +		return 1;

I don't like this part. We should match separately like that only
if the bus does not support native enumeration, and of course ULPI
with its vendor and product IDs does. There really should always be
IDs to match with here. So exceptions have to be solved before we
attempt matching.

Since we also have to support platforms where the PHY is initially
powered off and reading the IDs from the registers is not possible
because of that, I think we should consider getting the product and
vendor IDs optionally from device properties. Something like this:


diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 01c0c04..6228a85 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -152,7 +152,7 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_driver);
 
 /* -------------------------------------------------------------------------- */
 
-static int ulpi_register(struct device *dev, struct ulpi *ulpi)
+static int ulpi_read_id(struct ulpi *ulpi)
 {
        int ret;
 
@@ -174,6 +174,21 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
        ulpi->id.product = ulpi_read(ulpi, ULPI_PRODUCT_ID_LOW);
        ulpi->id.product |= ulpi_read(ulpi, ULPI_PRODUCT_ID_HIGH) << 8;
 
+       return 0;
+}
+
+static int ulpi_register(struct device *dev, struct ulpi *ulpi)
+{
+       int ret;
+
+       ret = device_property_read_u16(dev, "ulpi-vendor", &ulpi->id.vendor);
+       ret |= device_property_read_u16(dev, "ulpi-product", &ulpi->id.product);
+       if (ret) {
+               ret = ulpi_read_id(ulpi);
+               if (ret)
+                       return ret;
+       }
+
        ulpi->dev.parent = dev;
        ulpi->dev.bus = &ulpi_bus;
        ulpi->dev.type = &ulpi_dev_type;


That should cover both cases. You would just have to create the IDs
yourself in this case.


Thanks,

-- 
heikki
