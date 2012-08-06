From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Aug 2012 13:32:03 +0100
Subject: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between DT and
 non-DT boots
Message-ID: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're booting with Device Tree enabled, we want the IRQ numbers to
be taken and translated from the Device Tree binary. If not, they
should be taken from the resource allocation defined in the AB8500 MFD
core driver.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/misc/ab8500-ponkey.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 1a1d974..afcd87f 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -47,6 +47,7 @@ static irqreturn_t ab8500_ponkey_handler(int irq, void *data)
 static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *np = pdev->dev.of_node;
 	struct ab8500_ponkey *ponkey;
 	struct input_dev *input;
 	int irq_dbf, irq_dbr;
@@ -73,8 +74,9 @@ static int __devinit ab8500_ponkey_probe(struct platform_device *pdev)
 
 	ponkey->idev = input;
 	ponkey->ab8500 = ab8500;
-	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
-	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
+
+	ponkey->irq_dbf = (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) : irq_dbf;
+	ponkey->irq_dbr = (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) : irq_dbr;
 
 	input->name = "AB8500 POn(PowerOn) Key";
 	input->dev.parent = &pdev->dev;
-- 
1.7.9.5
