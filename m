From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 12 Jul 2018 13:50:00 +0800
Subject: [PATCH] pinctrl: mt7622: fix probe fail by misuse the selector
Message-ID: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

After the commit acf137951367 ("pinctrl: core: Return selector to the
pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
selector to the pinctrl driver"), it's necessary to add the fixes
needed for the pin controller drivers to use the appropriate returned
selector for a negative error number returned in case of the fail at
these functions. Otherwise, the driver would have a failed probe and
that causes boot message cannot correctly output and devices fail
to acquire their own pins.

Cc: Kevin Hilman <khilman@baylibre.com>
Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 2411c384..6f931b8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1538,7 +1538,7 @@ static int mtk_build_groups(struct mtk_pinctrl *hw)
 		err = pinctrl_generic_add_group(hw->pctrl, group->name,
 						group->pins, group->num_pins,
 						group->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register group %s\n",
 				group->name);
 			return err;
@@ -1559,7 +1559,7 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 						  func->group_names,
 						  func->num_group_names,
 						  func->data);
-		if (err) {
+		if (err < 0) {
 			dev_err(hw->dev, "Failed to register function %s\n",
 				func->name);
 			return err;
-- 
2.7.4
