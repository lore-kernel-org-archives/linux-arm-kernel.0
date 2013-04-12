From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Fri, 12 Apr 2013 14:56:21 +0200
Subject: [PATCH] SPI: spidev: Add DT compatible string for spidev driver.
Message-ID: <20130412125621.9645.78102.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spidev driver is useful to allow userspace access
to SPI devices that have no kernel SPI driver.

However DT requires a compatible tree to allow the driver
to be probed.

To avoid having to modify the driver for every extra device
add a generic "linux,spidev" compatible string that may be
used in the DT to match such devices.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt |    3 +++
 drivers/spi/spidev.c                              |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 296015e..3176587 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -59,6 +59,9 @@ contain the following properties.
 If a gpio chipselect is used for the SPI slave the gpio number will be passed
 via the cs_gpio
 
+For slave devices having no kernel driver the compatible string "linux,spidev"
+may be used to enable access from userspace via the spidev driver.
+
 SPI example for an MPC5200 SPI bus:
 	spi at f00 {
 		#address-cells = <1>;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 2e0655d..c2447a8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -646,6 +646,7 @@ static int spidev_remove(struct spi_device *spi)
 
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
+	{ .compatible = "linux,spidev" },
 	{},
 };
 
