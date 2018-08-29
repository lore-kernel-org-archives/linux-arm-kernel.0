From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 29 Aug 2018 11:31:04 +0200
Subject: [PATCH] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180829093104.GA22065@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Reichel <sre@kernel.org>
    
Add support for the audio-codec node by converting from
devm_of_platform_populate() to devm_mfd_add_devices().
   
Tested-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 5276911..20d9692 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -18,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 
+#include <linux/mfd/core.h>
 #include <linux/mfd/motorola-cpcap.h>
 #include <linux/spi/spi.h>
 
@@ -216,6 +217,53 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
+static const struct mfd_cell cpcap_mfd_devices[] = {
+	{
+		.name          = "cpcap_adc",
+		.of_compatible = "motorola,mapphone-cpcap-adc",
+	}, {
+		.name          = "cpcap_battery",
+		.of_compatible = "motorola,cpcap-battery",
+	}, {
+		.name          = "cpcap-charger",
+		.of_compatible = "motorola,mapphone-cpcap-charger",
+	}, {
+		.name          = "cpcap-regulator",
+		.of_compatible = "motorola,mapphone-cpcap-regulator",
+	}, {
+		.name          = "cpcap-rtc",
+		.of_compatible = "motorola,cpcap-rtc",
+	}, {
+		.name          = "cpcap-pwrbutton",
+		.of_compatible = "motorola,cpcap-pwrbutton",
+	}, {
+		.name          = "cpcap-usb-phy",
+		.of_compatible = "motorola,mapphone-cpcap-usb-phy",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 0,
+		.of_compatible = "motorola,cpcap-led-red",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 1,
+		.of_compatible = "motorola,cpcap-led-green",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 2,
+		.of_compatible = "motorola,cpcap-led-blue",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 3,
+		.of_compatible = "motorola,cpcap-led-adl",
+	}, {
+		.name          = "cpcap-led",
+		.id            = 4,
+		.of_compatible = "motorola,cpcap-led-cp",
+	}, {
+		.name          = "cpcap-codec",
+	}
+};
+
 static int cpcap_probe(struct spi_device *spi)
 {
 	const struct of_device_id *match;
@@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_of_platform_populate(&cpcap->spi->dev);
+	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
+				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
 }
 
 static struct spi_driver cpcap_driver = {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/3c3e43c7/attachment.sig>
