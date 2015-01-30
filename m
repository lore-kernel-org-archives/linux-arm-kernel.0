From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 30 Jan 2015 11:28:47 +0300
Subject: [patch] irqchip: mtk-sysirq: fix an error code
Message-ID: <20150130082847.GB21357@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"chip_data->intpol_base" used to be an ERR_PTR() but we recently changed
it to be NULL.  We need to update the error code as well because
"PTR_ERR(NULL)" means success where really we want to return -ENOMEM.

Fixes: cdb647a772e9 ('irqchip: mtk-sysirq: Get irq number from register resource size')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index eaf0a71..22eb34c 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -144,7 +144,7 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	chip_data->intpol_base = ioremap(res.start, size);
 	if (!chip_data->intpol_base) {
 		pr_err("mtk_sysirq: unable to map sysirq register\n");
-		ret = PTR_ERR(chip_data->intpol_base);
+		ret = -ENOMEM;
 		goto out_free;
 	}
 
