From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 11 Aug 2013 18:51:52 +0200
Subject: [PATCH 11/16] arch/arm/mach-pxa/palmtreo.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1376239917-15594-12-git-send-email-Julia.Lawall@lip6.fr>
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

 arch/arm/mach-pxa/palmtreo.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index d8b937c..bfe17c8 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -444,7 +444,7 @@ static void __init treo_reserve(void)
 
 static void __init palmphone_common_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo_pin_config));
+	pxa2xx_mfp_config(treo_pin_config, ARRAY_SIZE(treo_pin_config));
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
@@ -512,7 +512,7 @@ void __init treo680_gpio_init(void)
 
 static void __init treo680_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
+	pxa2xx_mfp_config(treo680_pin_config, ARRAY_SIZE(treo680_pin_config));
 	palmphone_common_init();
 	treo680_gpio_init();
 	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
@@ -524,7 +524,8 @@ static void __init treo680_init(void)
 #ifdef CONFIG_MACH_CENTRO
 static void __init centro_init(void)
 {
-	pxa2xx_mfp_config(ARRAY_AND_SIZE(centro685_pin_config));
+	pxa2xx_mfp_config(centro685_pin_config,
+			  ARRAY_SIZE(centro685_pin_config));
 	palmphone_common_init();
 	palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, -1,
 			GPIO_NR_CENTRO_SD_POWER, 1);
