From: colin.king@canonical.com (Colin King)
Date: Tue, 12 Sep 2017 12:21:24 +0100
Subject: [PATCH] pinctrl: uniphier: make arrays static,
 reduces object code size
Message-ID: <20170912112124.1143-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate const arrays on the stack, instead make them
static.  Makes the object code smaller nearly 1000 bytes. Also
line break wide lines to avoid checkpatch warnings.

Before:
   text	   data	    bss	    dec	    hex	filename
  13112	   1996	      0	  15108	   3b04	pinctrl-uniphier-core.o

After:
   text	   data	    bss	    dec	    hex	filename
  11642	   2476	      0	  14118	   3726	pinctrl-uniphier-core.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index f9267fabe6b0..26fda5c53e65 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -204,9 +204,10 @@ static int uniphier_conf_pin_drive_get(struct pinctrl_dev *pctldev,
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	enum uniphier_pin_drv_type type =
 				uniphier_pin_get_drv_type(desc->drv_data);
-	const unsigned int strength_1bit[] = {4, 8};
-	const unsigned int strength_2bit[] = {8, 12, 16, 20};
-	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16};
+	static const unsigned int strength_1bit[] = {4, 8};
+	static const unsigned int strength_2bit[] = {8, 12, 16, 20};
+	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12,
+						     14, 16};
 	const unsigned int *supported_strength;
 	unsigned int drvctrl, reg, shift, mask, width, val;
 	int ret;
@@ -399,9 +400,10 @@ static int uniphier_conf_pin_drive_set(struct pinctrl_dev *pctldev,
 	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	enum uniphier_pin_drv_type type =
 				uniphier_pin_get_drv_type(desc->drv_data);
-	const unsigned int strength_1bit[] = {4, 8, -1};
-	const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
-	const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14, 16, -1};
+	static const unsigned int strength_1bit[] = {4, 8, -1};
+	static const unsigned int strength_2bit[] = {8, 12, 16, 20, -1};
+	static const unsigned int strength_3bit[] = {4, 5, 7, 9, 11, 12, 14,
+						     16, -1};
 	const unsigned int *supported_strength;
 	unsigned int drvctrl, reg, shift, mask, width, val;
 
-- 
2.14.1
