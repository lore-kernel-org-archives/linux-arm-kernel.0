From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 15 Mar 2013 14:18:20 +0530
Subject: [PATCH] DMA: OF: Check properties value before running be32_to_cpup()
 on it
Message-ID: <0a0ef15d47393fe9d24a395c38068b871f913776.1363337257.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In of_dma_controller_register() routine we are calling of_get_property() as an
parameter to be32_to_cpup(). In case the property doesn't exist we will get a
crash.

This patch changes this code to check if we got a valid property first and then
runs be32_to_cpup() on it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---

My mails are broken, i have pushed this patch here:

http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/dma-of-fix

 drivers/dma/of-dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 69d04d2..09c7ad1 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -93,6 +93,7 @@ int of_dma_controller_register(struct device_node *np,
 {
 	struct of_dma	*ofdma;
 	int		nbcells;
+	const __be32	*prop;
 
 	if (!np || !of_dma_xlate) {
 		pr_err("%s: not enough information provided\n", __func__);
@@ -103,8 +104,11 @@ int of_dma_controller_register(struct device_node *np,
 	if (!ofdma)
 		return -ENOMEM;
 
-	nbcells = be32_to_cpup(of_get_property(np, "#dma-cells", NULL));
-	if (!nbcells) {
+	prop = of_get_property(np, "#dma-cells", NULL);
+	if (prop)
+		nbcells = be32_to_cpup(prop);
+
+	if (!prop || !nbcells) {
 		pr_err("%s: #dma-cells property is missing or invalid\n",
 		       __func__);
 		kfree(ofdma);
-- 
1.7.12.rc2.18.g61b472e
