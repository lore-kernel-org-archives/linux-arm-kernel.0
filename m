From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:38:12 +0100
Subject: [PATCH] mtd: sh_flctl: pass FIFO as physical address
Message-ID: <3152458.D3kElfhRW2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By convention, the FIFO address we pass using dmaengine_slave_config
is a physical address in the form that is understood by the DMA
engine, as a dma_addr_t, phys_addr_t or resource_size_t.

The sh_flctl driver however passes a virtual __iomem address that
gets cast to dma_addr_t in the slave driver. This happens to work
on shmobile because that platform sets up an identity mapping for
its MMIO regions, but such code is not portable to other platforms,
and prevents us from ever changing the platform mapping or reusing
the driver on other architectures like ARM64 that might not have the
mapping.

We also get a warning about a type mismatch for the case that
dma_addr_t is wider than a pointer, i.e. when CONFIG_LPAE is set:

drivers/mtd/nand/sh_flctl.c: In function 'flctl_setup_dma':
drivers/mtd/nand/sh_flctl.c:163:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);

This changes the driver to instead pass the physical address of
the FIFO that is extracted from the MMIO resource, making the
code more portable and avoiding the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/sh_flctl.c  | 5 +++--
 include/linux/mtd/sh_flctl.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 57dc52578e07..0830a2d601e9 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -160,7 +160,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.direction = DMA_MEM_TO_DEV;
-	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
+	cfg.dst_addr = flctl->fifo;
 	cfg.src_addr = 0;
 	ret = dmaengine_slave_config(flctl->chan_fifo0_tx, &cfg);
 	if (ret < 0)
@@ -176,7 +176,7 @@ static void flctl_setup_dma(struct sh_flctl *flctl)
 
 	cfg.direction = DMA_DEV_TO_MEM;
 	cfg.dst_addr = 0;
-	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
+	cfg.src_addr = flctl->fifo;
 	ret = dmaengine_slave_config(flctl->chan_fifo0_rx, &cfg);
 	if (ret < 0)
 		goto err;
@@ -1095,6 +1095,7 @@ static int flctl_probe(struct platform_device *pdev)
 	flctl->reg = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(flctl->reg))
 		return PTR_ERR(flctl->reg);
+	flctl->fifo = res->start + 0x24; /* FLDTFIFO */
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 1c28f8879b1c..067b37aff4a1 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -148,6 +148,7 @@ struct sh_flctl {
 	struct platform_device	*pdev;
 	struct dev_pm_qos_request pm_qos;
 	void __iomem		*reg;
+	resource_size_t		fifo;
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
 	int	read_bytes;
-- 
2.1.0.rc2
