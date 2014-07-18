From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 13:30:53 +0200
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource subsystem
Message-ID: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aua. This really hurts. I wonder how this could ever be admitted to
the Linux kernel...
Further comments suppressed because the would most likely violate the
CDA.

If someone should not grasp what this patch does, they should consider
what happens upon unloading/reloading the kernel module.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/spi/spi-omap2-mcspi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 68441fa..cb23f5d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1379,15 +1379,13 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	r->start += regs_offset;
-	r->end += regs_offset;
-	mcspi->phys = r->start;
-
 	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(mcspi->base)) {
 		status = PTR_ERR(mcspi->base);
 		goto free_master;
 	}
+	mcspi->phys = r->start + regs_offset;
+	mcspi->base += regs_offset;
 
 	mcspi->dev = &pdev->dev;
 
-- 
1.7.10.4
