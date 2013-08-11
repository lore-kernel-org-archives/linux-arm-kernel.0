From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:45 +0200
Subject: [PATCH 4/16] arch/arm/mach-pxa/z2.c: Avoid using ARRAY_AND_SIZE(e) as
 a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-5-git-send-email-Julia.Lawall@lip6.fr>
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

 arch/arm/mach-pxa/z2.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 2513d8f..d8fb360 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -500,7 +500,8 @@ static struct i2c_board_info __initdata z2_i2c_board_info[] = {
 static void __init z2_i2c_init(void)
 {
 	pxa_set_i2c_info(NULL);
-	i2c_register_board_info(0, ARRAY_AND_SIZE(z2_i2c_board_info));
+	i2c_register_board_info(0, z2_i2c_board_info,
+				ARRAY_SIZE(z2_i2c_board_info));
 }
 #else
 static inline void z2_i2c_init(void) {}
@@ -674,7 +675,8 @@ static struct i2c_board_info __initdata z2_pi2c_board_info[] = {
 static void __init z2_pmic_init(void)
 {
 	pxa27x_set_i2c_power_info(NULL);
-	i2c_register_board_info(1, ARRAY_AND_SIZE(z2_pi2c_board_info));
+	i2c_register_board_info(1, z2_pi2c_board_info,
+				ARRAY_SIZE(z2_pi2c_board_info));
 }
 #else
 static inline void z2_pmic_init(void) {}
@@ -700,7 +702,7 @@ static void z2_power_off(void)
  ******************************************************************************/
 static void __init z2_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(z2_pin_config));
+	pxa2xx_mfp_config(z2_pin_config, ARRAY_SIZE(z2_pin_config));
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
