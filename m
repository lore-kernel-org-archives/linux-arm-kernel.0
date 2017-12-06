From: lollivier@baylibre.com (Loys Ollivier)
Date: Wed,  6 Dec 2017 11:21:32 +0100
Subject: [PATCH v2] firmware: qcom: scm: Fix incorrect of_node_put call in
 scm_init
Message-ID: <1512555692-14439-1-git-send-email-lollivier@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using other platform architectures, in the init of the qcom_scm
driver, of_node_put is called on /firmware if no qcom dt is found.
This results in a kernel error: Bad of_node_put() on /firmware.

The call to of_node_put from the qcom_scm init is unnecessary as
of_find_matching_node is calling it automatically.

Remove this of_node_put().

Fixes: d0f6fa7ba2d6 ("firmware: qcom: scm: Convert SCM to platform driver")
Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
---
Change since v1, remove the curly brackets as if statement becomes a
one liner.

 drivers/firmware/qcom_scm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index af4c75217ea6..5beb6a6adcf6 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -632,10 +632,8 @@ static int __init qcom_scm_init(void)
 
 	np = of_find_matching_node(fw_np, qcom_scm_dt_match);
 
-	if (!np) {
-		of_node_put(fw_np);
+	if (!np)
 		return -ENODEV;
-	}
 
 	of_node_put(np);
 
-- 
2.7.4
