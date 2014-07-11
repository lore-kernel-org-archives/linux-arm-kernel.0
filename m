From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Jul 2014 10:17:57 +0200
Subject: [PATCH] spi: efm32: correct namespacing of location property
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Message-ID: <1405066677-12858-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,location"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/spi/efm32-spi.txt | 13 +++++++------
 drivers/spi/spi-efm32.c                             |  8 +++++++-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/efm32-spi.txt b/Documentation/devicetree/bindings/spi/efm32-spi.txt
index 130cd17e3680..750e29aff9bc 100644
--- a/Documentation/devicetree/bindings/spi/efm32-spi.txt
+++ b/Documentation/devicetree/bindings/spi/efm32-spi.txt
@@ -10,11 +10,12 @@ Required properties:
 - cs-gpios: see spi-bus.txt
 
 Recommended properties :
-- efm32,location: Value to write to the ROUTE register's LOCATION bitfield to
-                  configure the pinmux for the device, see datasheet for values.
-                  If "efm32,location" property is not provided, keeping what is
-                  already configured in the hardware, so its either the reset
-                  default 0 or whatever the bootloader did.
+- energymicro,location: Value to write to the ROUTE register's LOCATION
+                        bitfield to configure the pinmux for the device, see
+                        datasheet for values.
+                        If this property is not provided, keeping what is
+                        already configured in the hardware, so its either the
+                        reset default 0 or whatever the bootloader did.
 
 Example:
 
@@ -26,7 +27,7 @@ spi1: spi at 0x4000c400 { /* USART1 */
 	interrupts = <15 16>;
 	clocks = <&cmu 20>;
 	cs-gpios = <&gpio 51 1>; // D3
-	efm32,location = <1>;
+	energymicro,location = <1>;
 	status = "ok";
 
 	ks8851 at 0 {
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index be44a3eeb5e8..6caeb1cac0f3 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -294,10 +294,16 @@ static void efm32_spi_probe_dt(struct platform_device *pdev,
 	u32 location;
 	int ret;
 
-	ret = of_property_read_u32(np, "efm32,location", &location);
+	ret = of_property_read_u32(np, "energymicro,location", &location);
+
+	if (ret)
+		/* fall back to wrongly namespaced property */
+		ret = of_property_read_u32(np, "efm32,location", &location);
+
 	if (ret)
 		/* fall back to old and (wrongly) generic property "location" */
 		ret = of_property_read_u32(np, "location", &location);
+
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
 	} else {
-- 
2.0.0
