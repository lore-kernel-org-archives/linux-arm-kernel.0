From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 06:12:30 -0300
Subject: [PATCH v2 04/15] watchdog: orion: Handle IRQ
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390295561-3466-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-enabled where an irqchip driver for the brigde interrupt controller is
available can handle the watchdog IRQ properly. Therefore, we request
the interruption and add a dummy handler that merely calls panic().

This is done in order to have an initial 'ack' of the interruption,
which clears the watchdog state.

Furthermore, since some platforms don't have such IRQ, this commit
makes the interruption specification optional.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
 drivers/watchdog/orion_wdt.c                       | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 5dc8d30..0731fbd 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 Optional properties:
 
+- interrupts	: Contains the IRQ for watchdog expiration
 - timeout-sec	: Contains the watchdog timeout in seconds
 
 Example:
@@ -14,6 +15,7 @@ Example:
 	wdt at 20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		interrupts = <3>;
 		timeout-sec = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index cf64510..06e766f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
@@ -131,10 +132,16 @@ static struct watchdog_device orion_wdt = {
 	.min_timeout = 1,
 };
 
+static irqreturn_t orion_wdt_irq(int irq, void *devid)
+{
+	panic("Watchdog Timeout");
+	return IRQ_HANDLED;
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
+	int ret, irq;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -151,6 +158,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0) {
+		/*
+		 * Not all supported platforms specify an interruption for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = request_irq(irq, orion_wdt_irq, 0, pdev->name, NULL);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+			return ret;
+		}
+	}
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5
