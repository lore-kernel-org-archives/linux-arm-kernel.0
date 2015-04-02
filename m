From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  2 Apr 2015 18:39:31 +0300
Subject: [PATCH] dmaengine: sa11x0: report slave capabilities to upper layers
Message-ID: <1427989171-1702-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning by initializing necessary fields in the dma_device
structure.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/dma/dmaengine.c:863 dma_async_device_register+0x2b4/0x4f0()
this driver doesn't support generic slave capabilities reporting
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 4.0.0-rc5+ #10
Hardware name: Sharp-Collie
[<c0105cd8>] (unwind_backtrace) from [<c0103ef8>] (show_stack+0x10/0x14)
[<c0103ef8>] (show_stack) from [<c010e9b8>] (warn_slowpath_common+0x74/0xac)
[<c010e9b8>] (warn_slowpath_common) from [<c010ea20>] (warn_slowpath_fmt+0x30/0x40)
[<c010ea20>] (warn_slowpath_fmt) from [<c02956fc>] (dma_async_device_register+0x2b4/0x4f0)
[<c02956fc>] (dma_async_device_register) from [<c0296a9c>] (sa11x0_dma_probe+0x21c/0x358)
[<c0296a9c>] (sa11x0_dma_probe) from [<c02c52c0>] (platform_drv_probe+0x30/0x94)
[<c02c52c0>] (platform_drv_probe) from [<c02c39bc>] (driver_probe_device+0x84/0x234)
[<c02c39bc>] (driver_probe_device) from [<c02c3c4c>] (__driver_attach+0x98/0x9c)
[<c02c3c4c>] (__driver_attach) from [<c02c1f9c>] (bus_for_each_dev+0x74/0xa4)
[<c02c1f9c>] (bus_for_each_dev) from [<c02c3230>] (bus_add_driver+0x13c/0x1e8)
[<c02c3230>] (bus_add_driver) from [<c02c4260>] (driver_register+0x78/0xf8)
[<c02c4260>] (driver_register) from [<c0100624>] (do_one_initcall+0x84/0x1f4)
[<c0100624>] (do_one_initcall) from [<c0700e1c>] (kernel_init_freeable+0xf8/0x1b4)
[<c0700e1c>] (kernel_init_freeable) from [<c040a920>] (kernel_init+0x8/0xf0)
[<c040a920>] (kernel_init) from [<c01013a8>] (ret_from_fork+0x14/0x2c)
---[ end trace e188b8fe0e782e75 ]---

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/dma/sa11x0-dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 5adf540..5ff43c0 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -948,6 +948,12 @@ static int sa11x0_dma_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, d->slave.cap_mask);
 	d->slave.device_prep_slave_sg = sa11x0_dma_prep_slave_sg;
 	d->slave.device_prep_dma_cyclic = sa11x0_dma_prep_dma_cyclic;
+	d->slave.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	d->slave.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	d->slave.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES);
+	d->slave.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES);
 	ret = sa11x0_dma_init_dmadev(&d->slave, &pdev->dev);
 	if (ret) {
 		dev_warn(d->slave.dev, "failed to register slave async device: %d\n",
-- 
2.1.4
