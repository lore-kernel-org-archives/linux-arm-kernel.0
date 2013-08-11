From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:57 +0200
Subject: [PATCH 16/16] arch/arm/mach-pxa/stargate2.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-17-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
arity of the called function.

The semantic match that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e,f;
@@

f(...,
- ARRAY_AND_SIZE(e)
+ e,ARRAY_SIZE(e)
  ,...)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.

 arch/arm/mach-pxa/stargate2.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 62aea3e..adacedd 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -406,7 +406,8 @@ static struct i2c_pxa_platform_data i2c_pdata = {
 static void __init imote2_stargate2_init(void)
 {
 
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(sg2_im2_unified_pin_config));
+	pxa2xx_mfp_config(sg2_im2_unified_pin_config,
+			  ARRAY_SIZE(sg2_im2_unified_pin_config));
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
@@ -604,7 +605,7 @@ static struct platform_device *imote2_devices[] = {
 
 static void __init imote2_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(imote2_pin_config));
+	pxa2xx_mfp_config(imote2_pin_config, ARRAY_SIZE(imote2_pin_config));
 
 	imote2_stargate2_init();
 
@@ -983,13 +984,15 @@ static void __init stargate2_init(void)
 	   prior to connecting the MFP stuff up. */
 	__raw_writel(__raw_readl(MECR) & ~MECR_NOS, MECR);
 
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(stargate2_pin_config));
+	pxa2xx_mfp_config(stargate2_pin_config,
+			  ARRAY_SIZE(stargate2_pin_config));
 
 	imote2_stargate2_init();
 
-	platform_add_devices(ARRAY_AND_SIZE(stargate2_devices));
+	platform_add_devices(stargate2_devices, ARRAY_SIZE(stargate2_devices));
 
-	i2c_register_board_info(0, ARRAY_AND_SIZE(stargate2_i2c_board_info));
+	i2c_register_board_info(0, stargate2_i2c_board_info,
+				ARRAY_SIZE(stargate2_i2c_board_info));
 	i2c_register_board_info(1, stargate2_pwr_i2c_board_info,
 				ARRAY_SIZE(stargate2_pwr_i2c_board_info));
 
