From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 19 Jul 2018 14:35:54 +0100
Subject: [PATCH v2] mmc: sunxi: remove output of virtual base address
Message-ID: <20180719133554.30737-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent Linux versions refuse to print actual virtual kernel addresses,
to not give a hint about the location of the kernel in a randomized virtual
address space. This affects the output of the sunxi MMC controller
driver, which now produces the rather uninformative line:

[    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8

Since the virtual base address is not really interesting in the first
place, let's just drop this value. The same applies to Linux' notion of
the interrupt number, which is independent from the GIC SPI number.
We have the physical address as part of the DT node name, which is way
more useful for debugging purposes.
To keep a success message in the driver, we print some information that
is not too obvious and that we learned while probing the device:
the maximum request size and whether it uses the new timing mode.
So the output turns into:
sunxi-mmc 1c0f000.mmc: max request size: 16384 KB, uses new timings mode
sunxi-mmc 1c11000.mmc: max request size: 2048 KB

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Changelog v1 ... v2:
- dropped output of Linux interrupt number
- added max request size and timings mode output

 drivers/mmc/host/sunxi-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8e7f3e35ee3d..fbbc09d82338 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1407,7 +1407,10 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_dma;
 
-	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
+	dev_info(&pdev->dev, "max request size: %u KB%s\n",
+		 mmc->max_req_size >> 10,
+		 host->use_new_timings ? ", uses new timings mode" : "");
+
 	return 0;
 
 error_free_dma:
-- 
2.14.4
