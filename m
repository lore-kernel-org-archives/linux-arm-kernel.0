From: wang.yi59@zte.com.cn (Yi Wang)
Date: Thu, 22 Nov 2018 14:49:45 +0800
Subject: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Message-ID: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wen Yang <wen.yang99@zte.com.cn>

Currently there are 2 problems with the ucc_of_parse_tdm function:
1,a possible null pointer dereference in ucc_of_parse_tdm,
detected by the semantic patch deref_null.cocci,
with the following warning:
drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
2,dev gets modified, so in any case that devm_iounmap() will fail even when
the new pdev is valid, because the iomap was done with a different pdev.
This patch fixes them.

Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/soc/fsl/qe/qe_tdm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..9a29f0b 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -47,7 +47,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	struct resource *res;
 	struct device_node *np2;
 	static int siram_init_flag;
-	struct platform_device *pdev;
+	struct platform_device *pdev_si, *pdev_siram;
 
 	sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
 	if (sprop) {
@@ -129,16 +129,16 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	if (!np2)
 		return -EINVAL;
 
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
+	pdev_si = of_find_device_by_node(np2);
+	if (!pdev_si) {
 		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		return -EINVAL;
 	}
 
 	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
+	res = platform_get_resource(pdev_si, IORESOURCE_MEM, 0);
+	utdm->si_regs = devm_ioremap_resource(&pdev_si->dev, res);
 	if (IS_ERR(utdm->si_regs)) {
 		ret = PTR_ERR(utdm->si_regs);
 		goto err_miss_siram_property;
@@ -150,8 +150,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		goto err_miss_siram_property;
 	}
 
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
+	pdev_siram = of_find_device_by_node(np2);
+	if (!pdev_siram) {
 		ret = -EINVAL;
 		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
@@ -159,8 +159,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	}
 
 	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
+	res = platform_get_resource(pdev_siram, IORESOURCE_MEM, 0);
+	utdm->siram = devm_ioremap_resource(&pdev_siram->dev, res);
 	if (IS_ERR(utdm->siram)) {
 		ret = PTR_ERR(utdm->siram);
 		goto err_miss_siram_property;
@@ -174,7 +174,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	return ret;
 
 err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
+	devm_iounmap(&pdev_si->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5
