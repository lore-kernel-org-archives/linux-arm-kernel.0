From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Jul 2014 10:16:45 +0200
Subject: [PATCH] serial: efm32: correct namespacing of location property
In-Reply-To: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
Message-ID: <1405066605-12801-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson pointed out that usually the company name is picked as
namespace prefix to specific properties. So expect "energymicro,location"
but fall back to the previously introduced name "efm32,location".

Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/serial/efm32-uart.txt | 4 ++--
 drivers/tty/serial/efm32-uart.c                         | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/efm32-uart.txt b/Documentation/devicetree/bindings/serial/efm32-uart.txt
index 3ca01336b837..8adbab268ca3 100644
--- a/Documentation/devicetree/bindings/serial/efm32-uart.txt
+++ b/Documentation/devicetree/bindings/serial/efm32-uart.txt
@@ -6,7 +6,7 @@ Required properties:
 - interrupts : Should contain uart interrupt
 
 Optional properties:
-- efm32,location : Decides the location of the USART I/O pins.
+- energymicro,location : Decides the location of the USART I/O pins.
   Allowed range : [0 .. 5]
   Default: 0
 
@@ -16,5 +16,5 @@ uart at 0x4000c400 {
 	compatible = "energymicro,efm32-uart";
 	reg = <0x4000c400 0x400>;
 	interrupts = <15>;
-	efm32,location = <0>;
+	energymicro,location = <0>;
 };
diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 3b0ee9afd76f..cb007a4f4d15 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -671,10 +671,16 @@ static int efm32_uart_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return 1;
 
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
 		if (location > 5) {
 			dev_err(&pdev->dev, "invalid location\n");
-- 
2.0.0
