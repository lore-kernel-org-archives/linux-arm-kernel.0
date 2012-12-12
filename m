From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Dec 2012 15:22:44 +0100 (CET)
Subject: [PATCH] drivers/pinctrl/pinctrl-at91.c: convert kfree to
 devm_kfree
In-Reply-To: <20121212115624.GI4398@game.jcrosoft.org>
References: <1355223525-19165-1-git-send-email-Julia.Lawall@lip6.fr>
 <20121212115624.GI4398@game.jcrosoft.org>
Message-ID: <alpine.DEB.2.02.1212121521590.1995@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The function at91_dt_node_to_map is ultimately called by the function
pinctrl_get, which is an exported function.  Since it is possible that this
function is not called from within a probe function, for safety, the kfree
is converted to a devm_kfree, to both free the data and remove it from the
device in a failure situation.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: Drop cleanup of the call to devm_kzalloc at the same time.

 drivers/pinctrl/pinctrl-at91.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index c5e7571..bff54bf 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -265,7 +265,7 @@ static int at91_dt_node_to_map(struct pinctrl_dev *pctldev,
 	/* create mux map */
 	parent = of_get_parent(np);
 	if (!parent) {
-		kfree(new_map);
+		devm_kfree(pctldev->dev, new_map);
 		return -EINVAL;
 	}
 	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
