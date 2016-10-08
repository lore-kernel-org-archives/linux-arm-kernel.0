From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  8 Oct 2016 21:38:12 +0800
Subject: [PATCH] clk: hi6220: use CLK_OF_DECLARE_DRIVER for sysctrl and
 mediactrl clock init
Message-ID: <1475933892-16021-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The hi6220-sysctrl and hi6220-mediactrl are not only clock provider but
also reset controller.  It worked fine that single sysctrl/mediactrl
device node in DT can be used to initialize clock driver and populate
platform device for reset controller.  But it stops working after
commit 989eafd0b609 ("clk: core: Avoid double initialization of clocks")
gets merged.  The commit sets flag OF_POPULATED during clock
initialization to skip the platform device populating for the same
device node.  On hi6220, it effectively makes hi6220-sysctrl reset
driver not probe any more.

The patch changes hi6220 sysctrl and mediactrl clock init macro from
CLK_OF_DECLARE to CLK_OF_DECLARE_DRIVER, so that the reset driver using
the same hardware block can continue working.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
It fixes an issue that is seen on linux-next, i.e. the new added
hi6220-sysctrl reset driver doesn't probe at all, and consequently the
mmc driver fails to register.

Shawn

 drivers/clk/hisilicon/clk-hi6220.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index fe364e63f8de..c0e8e1f196aa 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -195,7 +195,7 @@ static void __init hi6220_clk_sys_init(struct device_node *np)
 	hi6220_clk_register_divider(hi6220_div_clks_sys,
 			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
 }
-CLK_OF_DECLARE(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
+CLK_OF_DECLARE_DRIVER(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
 
 
 /* clocks in media controller */
@@ -252,7 +252,7 @@ static void __init hi6220_clk_media_init(struct device_node *np)
 	hi6220_clk_register_divider(hi6220_div_clks_media,
 				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
 }
-CLK_OF_DECLARE(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
+CLK_OF_DECLARE_DRIVER(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
 
 
 /* clocks in pmctrl */
-- 
1.9.1
