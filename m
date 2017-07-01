From: shawnguo@kernel.org (Shawn Guo)
Date: Sat,  1 Jul 2017 11:45:36 +0800
Subject: [PATCH] pinctrl: zte: fix dereference of 'data' in zx_set_mux()
Message-ID: <1498880736-18143-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It fixes the following Smatch complaint:

drivers/pinctrl/zte/pinctrl-zx.c:76 zx_set_mux()
warn: variable dereferenced before check 'data' (see line 67)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: cbff0c4d27f4 ("pinctrl: add ZTE ZX pinctrl driver support")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pinctrl/zte/pinctrl-zx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/zte/pinctrl-zx.c b/drivers/pinctrl/zte/pinctrl-zx.c
index 787e3967bd5c..f828ee340a98 100644
--- a/drivers/pinctrl/zte/pinctrl-zx.c
+++ b/drivers/pinctrl/zte/pinctrl-zx.c
@@ -64,10 +64,8 @@ static int zx_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
 	struct zx_pinctrl_soc_info *info = zpctl->info;
 	const struct pinctrl_pin_desc *pindesc = info->pins + group_selector;
 	struct zx_pin_data *data = pindesc->drv_data;
-	struct zx_mux_desc *mux = data->muxes;
-	u32 mask = (1 << data->width) - 1;
-	u32 offset = data->offset;
-	u32 bitpos = data->bitpos;
+	struct zx_mux_desc *mux;
+	u32 mask, offset, bitpos;
 	struct function_desc *func;
 	unsigned long flags;
 	u32 val, mval;
@@ -76,6 +74,11 @@ static int zx_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
 	if (!data)
 		return -EINVAL;
 
+	mux = data->muxes;
+	mask = (1 << data->width) - 1;
+	offset = data->offset;
+	bitpos = data->bitpos;
+
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
 		return -EINVAL;
-- 
1.9.1
