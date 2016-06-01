From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 1 Jun 2016 11:56:02 +0300
Subject: [PATCH 01/28] crypto: omap-aes: Fix registration of algorithms
In-Reply-To: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
Message-ID: <1464771389-10640-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Algorithms can be registered only once. So skip registration of
algorithms if already registered (i.e. in case we have two AES cores
in the system.)

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/crypto/omap-aes.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index ce174d3..4a0e6a5 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1185,17 +1185,19 @@ static int omap_aes_probe(struct platform_device *pdev)
 	spin_unlock(&list_lock);
 
 	for (i = 0; i < dd->pdata->algs_info_size; i++) {
-		for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
-			algp = &dd->pdata->algs_info[i].algs_list[j];
+		if (!dd->pdata->algs_info[i].registered) {
+			for (j = 0; j < dd->pdata->algs_info[i].size; j++) {
+				algp = &dd->pdata->algs_info[i].algs_list[j];
 
-			pr_debug("reg alg: %s\n", algp->cra_name);
-			INIT_LIST_HEAD(&algp->cra_list);
+				pr_debug("reg alg: %s\n", algp->cra_name);
+				INIT_LIST_HEAD(&algp->cra_list);
 
-			err = crypto_register_alg(algp);
-			if (err)
-				goto err_algs;
+				err = crypto_register_alg(algp);
+				if (err)
+					goto err_algs;
 
-			dd->pdata->algs_info[i].registered++;
+				dd->pdata->algs_info[i].registered++;
+			}
 		}
 	}
 
-- 
1.9.1
