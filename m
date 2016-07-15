From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 14:34:00 +0530
Subject: [PATCH 5/8] uio: fix dmem_region_start computation
In-Reply-To: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1468573443-4670-6-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Viktorin <viktorin@rehivetech.com>

The variable i contains a total number of resources (including
IORESOURCE_IRQ). However, we want the dmem_region_start to point
after the last resource of type IORESOURCE_MEM. The original behaviour
leads (very likely) to skipping several UIO mapping regions and makes
them useless. Fix this by computing dmem_region_start from the uiomem
which points to the last used UIO mapping.

Fixes: 0a0c3b5a24bd ("Add new uio device for dynamic memory allocation")

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
---
 drivers/uio/uio_dmem_genirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 915facb..e1134a4 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -229,7 +229,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		++uiomem;
 	}
 
-	priv->dmem_region_start = i;
+	priv->dmem_region_start = uiomem - &uioinfo->mem[0];
 	priv->num_dmem_regions = pdata->num_dynamic_regions;
 
 	for (i = 0; i < pdata->num_dynamic_regions; ++i) {
-- 
1.9.1
