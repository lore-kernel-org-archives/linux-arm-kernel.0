From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 17 Jul 2018 11:09:58 +0100
Subject: [PATCH] mmc: sunxi: remove output of virtual base address
Message-ID: <20180717100958.12042-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Linux versions refuse to print actual virtual kernel addresses,
to not give a hint about the location of the kernel in a randomized virtual
address space. This affects the output of the sunxi MMC controller
driver, which now produces the rather uninformative line:

[    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8

Since the virtual base address is not really interesting in the first
place, let's just drop this value. We have the physical address as part
of the DT node name, which is way more useful for debugging purposes.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8e7f3e35ee3d..811b08d2d0f2 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1407,7 +1407,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
-	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
+	dev_info(&pdev->dev, "irq:%u\n", host->irq);
 	return 0;
 
 error_free_dma:
-- 
2.14.4
