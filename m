From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Jul 2014 10:22:20 +0200
Subject: [PATCH] i2c: efm32: correct namespacing of location property
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Message-ID: <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,location"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/i2c-efm32.txt | 4 ++--
 drivers/i2c/busses/i2c-efm32.c                      | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
index fc15ac519437..50b25c3da186 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
@@ -10,7 +10,7 @@ Required properties :
 Recommended properties :
 
  - clock-frequency : maximal I2C bus clock frequency in Hz.
- - efm32,location : Decides the location of the USART I/O pins.
+ - energymicro,location : Decides the location of the USART I/O pins.
    Allowed range : [0 .. 6]
 
 Example:
@@ -23,7 +23,7 @@ Example:
 		clocks = <&cmu clk_HFPERCLKI2C0>;
 		clock-frequency = <100000>;
 		status = "ok";
-		efm32,location = <3>;
+		energymicro,location = <3>;
 
 		eeprom at 50 {
 			compatible = "microchip,24c02";
diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index f7eccd682de9..5c4cf94527e3 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -370,7 +370,13 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(np, "efm32,location", &location);
+
+	ret = of_property_read_u32(np, "energymicro,location", &location);
+
+	if (!ret)
+		/* fall back to wrongly namespaced property */
+		ret = of_property_read_u32(np, "efm32,location", &location);
+
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
 	} else {
-- 
2.0.0
