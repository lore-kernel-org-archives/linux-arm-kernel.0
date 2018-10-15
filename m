From: Tudor.Ambarus@microchip.com (Tudor.Ambarus at microchip.com)
Date: Mon, 15 Oct 2018 09:00:54 +0000
Subject: [PATCH v2] usb: host: ohci-at91: fix request of irq for optional gpio
Message-ID: <20181015090001.5195-1-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

atmel,oc-gpio is optional. Request its irq only when atmel,oc is set
in device tree.

devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
return value for NULL before error, because it is more probable that
atmel,oc is not set.

This fixes the following errors on boards where atmel,oc is not set in
device tree:
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
[    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v2: fix typos in commit message s/it's/its, s/probably/probable

Based on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git,
usb-next branch.

 drivers/usb/host/ohci-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e98673954020..ec6739ef3129 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		pdata->overcurrent_pin[i] =
 			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
 						      i, GPIOD_IN);
+		if (!pdata->overcurrent_pin[i])
+			continue;
 		if (IS_ERR(pdata->overcurrent_pin[i])) {
 			err = PTR_ERR(pdata->overcurrent_pin[i]);
 			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
-- 
2.9.4
