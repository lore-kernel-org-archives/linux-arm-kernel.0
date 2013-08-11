From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:46 +0200
Subject: [PATCH 5/16] arch/arm/mach-pxa/vpac270.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-6-git-send-email-Julia.Lawall@lip6.fr>
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

 arch/arm/mach-pxa/vpac270.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index aa89488..bb5ceef 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -465,7 +465,8 @@ static struct i2c_board_info __initdata vpac270_i2c_devs[] = {
 
 static void __init vpac270_rtc_init(void)
 {
-	i2c_register_board_info(0, ARRAY_AND_SIZE(vpac270_i2c_devs));
+	i2c_register_board_info(0, vpac270_i2c_devs,
+				ARRAY_SIZE(vpac270_i2c_devs));
 }
 #else
 static inline void vpac270_rtc_init(void) {}
@@ -678,7 +679,8 @@ static struct i2c_board_info __initdata vpac270_pi2c_board_info[] = {
 
 static void __init vpac270_pmic_init(void)
 {
-	i2c_register_board_info(1, ARRAY_AND_SIZE(vpac270_pi2c_board_info));
+	i2c_register_board_info(1, vpac270_pi2c_board_info,
+				ARRAY_SIZE(vpac270_pi2c_board_info));
 }
 #else
 static inline void vpac270_pmic_init(void) {}
@@ -690,7 +692,7 @@ static inline void vpac270_pmic_init(void) {}
  ******************************************************************************/
 static void __init vpac270_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(vpac270_pin_config));
+	pxa2xx_mfp_config(vpac270_pin_config, ARRAY_SIZE(vpac270_pin_config));
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
