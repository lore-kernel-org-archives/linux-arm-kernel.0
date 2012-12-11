From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue, 11 Dec 2012 11:58:45 +0100
Subject: [PATCH] drivers/pinctrl/pinctrl-at91.c: convert kfree to devm_kfree
Message-ID: <1355223525-19165-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The function at91_dt_node_to_map is ultimately called by the function
pinctrl_get, which is an exported function.  Since it is possible that this
function is not called from within a probe function, for safety, the kfree
is converted to a devm_kfree, to both free the data and remove it from the
device in a failure situation.

A newline is added in the call to devm_kfree to avoid exceeding the 80
character limit.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pinctrl/pinctrl-at91.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index c5e7571..0da8a5f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -255,7 +255,8 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	}
 
 	map_num += grp->npins;
-	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num, GFP_KERNEL);
+	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * map_num,
+			       GFP_KERNEL);
 	if (!new_map)
 		return -ENOMEM;
 
@@ -265,7 +266,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* create mux map */
 	parent = of_get_parent(np);
 	if (!parent) {
-		kfree(new_map);
+		devm_kfree(pctldev->dev, new_map);
 		return -EINVAL;
 	}
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
