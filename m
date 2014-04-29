From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 29 Apr 2014 16:49:59 -0300
Subject: [PATCH for v3.15] net: mvmdio: Check for a valid interrupt instead of
 an error
Message-ID: <1398800999-9814-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following commit:

commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef
Author: Rob Herring <robh@kernel.org>
Date:   Wed Apr 23 17:57:41 2014 -0500

    of/irq: do irq resolution in platform_get_irq

changed platform_get_irq() which now returns ENODEV and EPROBE_DEFER,
in addition to ENXIO. If there's no interrupt for mvmdio, platform_get_irq()
returns ENODEV, but we currently check only for ENXIO.

Fix this by looking for a positive integer, which is the proper way of
validating a virtual interrupt number.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index b161a52..eb2cabf 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -232,7 +232,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		clk_prepare_enable(dev->clk);
 
 	dev->err_interrupt = platform_get_irq(pdev, 0);
-	if (dev->err_interrupt != -ENXIO) {
+	if (dev->err_interrupt > 0) {
 		ret = devm_request_irq(&pdev->dev, dev->err_interrupt,
 					orion_mdio_err_irq,
 					IRQF_SHARED, pdev->name, dev);
-- 
1.9.1
