From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 29 May 2011 00:53:29 +0400
Subject: [PATCH] pxa: don't ask for a buffer from DMA zone
Message-ID: <mailman.3.1306616227.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA don't have special DMA zone. And since
197b59ae6e8bee56fcef37ea2482dc08414e2ac (mm: fail GFP_DMA allocations
when ZONE_DMA is not configured) allocation with GFP_DMA set will fail
with a trace like this:

------------[ cut here ]------------
WARNING: at mm/page_alloc.c:2251
__alloc_pages_nodemask+0xa0/0x5ac()
Modules linked in:
[<c00385b0>] (unwind_backtrace+0x0/0xf0) from [<c0050b1c>] (warn_slowpath_common+0x4c/0x64)
[<c0050b1c>] (warn_slowpath_common+0x4c/0x64) from [<c0050b4c>] (warn_slowpath_null+0x18/0x1c)
[<c0050b4c>] (warn_slowpath_null+0x18/0x1c) from [<c00908ec>] (__alloc_pages_nodemask+0xa0/0x5ac)
[<c00908ec>] (__alloc_pages_nodemask+0xa0/0x5ac) from [<c0090e74>] (__get_free_pages+0x10/0x3c)
[<c0090e74>] (__get_free_pages+0x10/0x3c) from [<c01d608c>] (pxa_irda_init_iobuf+0x18/0x48)
[<c01d608c>] (pxa_irda_init_iobuf+0x18/0x48) from [<c01d61d8>] (pxa_irda_probe+0x11c/0x32c)
[<c01d61d8>] (pxa_irda_probe+0x11c/0x32c) from [<c019474c>] (platform_drv_probe+0x14/0x18)
[<c019474c>] (platform_drv_probe+0x14/0x18) from [<c0193508>] (really_probe+0xa0/0x158)
[<c0193508>] (really_probe+0xa0/0x158) from [<c019360c>] (driver_probe_device+0x4c/0x64)
[<c019360c>] (driver_probe_device+0x4c/0x64) from [<c0193684>] (__driver_attach+0x60/0x84)
[<c0193684>] (__driver_attach+0x60/0x84) from [<c0192d78>] (bus_for_each_dev+0x48/0x84)
[<c0192d78>] (bus_for_each_dev+0x48/0x84) from [<c01926b8>] (bus_add_driver+0xa8/0x220)
[<c01926b8>] (bus_add_driver+0xa8/0x220) from [<c0193c7c>] (driver_register+0xac/0x13c)
[<c0193c7c>] (driver_register+0xac/0x13c) from [<c0033440>] (do_one_initcall+0x94/0x16c)
[<c0033440>] (do_one_initcall+0x94/0x16c) from [<c00083f4>] (kernel_init+0x94/0x140)
[<c00083f4>] (kernel_init+0x94/0x140) from [<c00348d0>] (kernel_thread_exit+0x0/0x8)
---[ end trace 0b8bf08f70147098 ]---

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/net/irda/pxaficp_ir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/irda/pxaficp_ir.c b/drivers/net/irda/pxaficp_ir.c
index 001ed0a..a5ebaef 100644
--- a/drivers/net/irda/pxaficp_ir.c
+++ b/drivers/net/irda/pxaficp_ir.c
@@ -805,7 +805,7 @@ static int pxa_irda_resume(struct platform_device *_dev)
 
 static int pxa_irda_init_iobuf(iobuff_t *io, int size)
 {
-	io->head = kmalloc(size, GFP_KERNEL | GFP_DMA);
+	io->head = kmalloc(size, GFP_KERNEL);
 	if (io->head != NULL) {
 		io->truesize = size;
 		io->in_frame = FALSE;
-- 
1.7.4.4


--Qxx1br4bt0+wmkIi--
