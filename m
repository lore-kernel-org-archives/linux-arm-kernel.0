From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 21 May 2017 01:02:17 +0900
Subject: [PATCH] pinctrl: single: use of_device_get_match_data() to get soc
 data
Message-ID: <1495296137-6461-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of_device_get_match_data() instead of of_match_device().
It allows us to remove the forward declaration of pcs_of_match.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/pinctrl-single.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9c267dc..b8b3d93 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1270,8 +1270,6 @@ static void pcs_free_resources(struct pcs_device *pcs)
 #endif
 }
 
-static const struct of_device_id pcs_of_match[];
-
 static int pcs_add_gpio_func(struct device_node *node, struct pcs_device *pcs)
 {
 	const char *propname = "pinctrl-single,gpio-range";
@@ -1637,15 +1635,14 @@ static int pcs_quirk_missing_pinctrl_cells(struct pcs_device *pcs,
 static int pcs_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct pcs_pdata *pdata;
 	struct resource *res;
 	struct pcs_device *pcs;
 	const struct pcs_soc_data *soc;
 	int ret;
 
-	match = of_match_device(pcs_of_match, &pdev->dev);
-	if (!match)
+	soc = of_device_get_match_data(&pdev->dev);
+	if (WARN_ON(!soc))
 		return -EINVAL;
 
 	pcs = devm_kzalloc(&pdev->dev, sizeof(*pcs), GFP_KERNEL);
@@ -1658,7 +1655,6 @@ static int pcs_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&pcs->lock);
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->gpiofuncs);
-	soc = match->data;
 	pcs->flags = soc->flags;
 	memcpy(&pcs->socdata, soc, sizeof(*soc));
 
-- 
2.7.4
