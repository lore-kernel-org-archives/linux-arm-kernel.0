From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:47 +0200
Subject: [PATCH 6/16] arch/arm/mach-pxa: Avoid using ARRAY_AND_SIZE(e) as a
 function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-7-git-send-email-Julia.Lawall@lip6.fr>
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

 arch/arm/mach-pxa/palmld.c  |    2 +-
 arch/arm/mach-pxa/palmt5.c  |    2 +-
 arch/arm/mach-pxa/palmtc.c  |    2 +-
 arch/arm/mach-pxa/palmte2.c |    7 ++++---
 arch/arm/mach-pxa/palmtx.c  |    2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index cf210b1..4e3016a 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -322,7 +322,7 @@ static void __init palmld_map_io(void)
 
 static void __init palmld_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
+	pxa2xx_mfp_config(palmld_pin_config, ARRAY_SIZE(palmld_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 3ed9b02..c054003 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -184,7 +184,7 @@ static void __init palmt5_reserve(void)
 
 static void __init palmt5_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmt5_pin_config));
+	pxa2xx_mfp_config(palmt5_pin_config, ARRAY_SIZE(palmt5_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 100b176..aea2e19 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -517,7 +517,7 @@ static inline void palmtc_lcd_init(void) {}
  ******************************************************************************/
 static void __init palmtc_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtc_pin_config));
+	pxa2xx_mfp_config(palmtc_pin_config, ARRAY_SIZE(palmtc_pin_config));
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 0742721..6cfd6b0 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -145,7 +145,8 @@ static struct gpio palmte_bl_gpios[] = {
 
 static int palmte2_backlight_init(struct device *dev)
 {
-	return gpio_request_array(ARRAY_AND_SIZE(palmte_bl_gpios));
+	return gpio_request_array(palmte_bl_gpios,
+				  ARRAY_SIZE(palmte_bl_gpios));
 }
 
 static int palmte2_backlight_notify(struct device *dev, int brightness)
@@ -157,7 +158,7 @@ static int palmte2_backlight_notify(struct device *dev, int brightness)
 
 static void palmte2_backlight_exit(struct device *dev)
 {
-	gpio_free_array(ARRAY_AND_SIZE(palmte_bl_gpios));
+	gpio_free_array(palmte_bl_gpios, ARRAY_SIZE(palmte_bl_gpios));
 }
 
 static struct platform_pwm_backlight_data palmte2_backlight_data = {
@@ -342,7 +343,7 @@ static void __init palmte2_udc_init(void)
 
 static void __init palmte2_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmte2_pin_config));
+	pxa2xx_mfp_config(palmte2_pin_config, ARRAY_SIZE(palmte2_pin_config));
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 83f830d..750ff97 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -341,7 +341,7 @@ static void __init palmtx_map_io(void)
 
 static void __init palmtx_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(palmtx_pin_config));
+	pxa2xx_mfp_config(palmtx_pin_config, ARRAY_SIZE(palmtx_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
