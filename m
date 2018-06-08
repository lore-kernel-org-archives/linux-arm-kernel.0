From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  8 Jun 2018 12:05:47 +0200
Subject: [PATCH] pinctrl: actions: Fix uninitialized error in
 owl_pin_config_set()
Message-ID: <1528452347-23986-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With gcc 4.1.2:

    drivers/pinctrl/actions/pinctrl-owl.c: In function ?owl_pin_config_set?:
    drivers/pinctrl/actions/pinctrl-owl.c:336: warning: ?ret? may be used uninitialized in this function

Indeed, if num_configs is zero, the uninitialized value will be returned
as an error code.

Fix this by preinitializing it to zero.

Fixes: 2242ddfbf4d699b5 ("pinctrl: actions: Add Actions S900 pinctrl driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/pinctrl/actions/pinctrl-owl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 76243caa08c630c0..b5c880b50bb371f5 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -333,7 +333,7 @@ static int owl_pin_config_set(struct pinctrl_dev *pctrldev,
 	unsigned long flags;
 	unsigned int param;
 	u32 reg, bit, width, arg;
-	int ret, i;
+	int ret = 0, i;
 
 	info = &pctrl->soc->padinfo[pin];
 
-- 
2.7.4
