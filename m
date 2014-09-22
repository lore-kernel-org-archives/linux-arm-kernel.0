From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 22 Sep 2014 21:37:55 +0200
Subject: [PATCH] mfd: inherit coherent_dma_mask from parent device
Message-ID: <1411414675-19010-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_mask and dma_parms are already inherited from the parent device but
dma_coherent_mask was left uninitialized (set to zero thanks to kzalloc).
Set sub-device coherent_dma_mask to its parent value to simplify
sub-drivers making use of dma coherent helper functions (those drivers
currently have to explicitly set the dma coherent mask using
dma_set_coherent_mask function).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---

Hi,

This patch is follow-up of a discussion we had on a KMS driver thread [1].
This patch is only copying the parent device coherent_dma_mask to avoid
calling specific dma_set_coherent_mask in case the coherent mask is the
default one.

I'm a bit surprised this hasn't been done earlier while other dma fields
(mask and parms) are already inherited from the parent device, so please
tell me if there already was an attempt to do the same, and if so, what
was the reson for rejecting it :-).

Best Regards,

Boris

[1]https://lkml.org/lkml/2014/9/22/392

 drivers/mfd/mfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 892d343..5d0fbe1 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -101,6 +101,7 @@ static int mfd_add_device(struct device *parent, int id,
 	pdev->dev.type = &mfd_dev_type;
 	pdev->dev.dma_mask = parent->dma_mask;
 	pdev->dev.dma_parms = parent->dma_parms;
+	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
 	ret = regulator_bulk_register_supply_alias(
 			&pdev->dev, cell->parent_supplies,
-- 
1.9.1
