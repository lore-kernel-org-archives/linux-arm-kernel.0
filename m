From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Apr 2013 09:26:56 +0200
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
Message-ID: <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 2:58 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 22 April 2013 06:23, Mike Dunn <mikedunn@newsguy.com> wrote:
>> Will the big guy see this?  Only posted to linux-arm-kernel ML.
>>
>> Thanks Haojian,
>> Mike

I guess Haojian is referring to me, not Torvalds ...

> Sorry, I forgot to loop him in.
>
> Linus,
> Should I send the revert commit to you? Or will you revert it directly?

How hard is it to fix the real problem?

I'm looking at arch/arm/mach-pxa/palmtreo.c, would
something like this solve the problem:

>From 5acf99a576f563d48ca5d25b9e5a1bcdd09331eb Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2013 09:24:43 +0200
Subject: [PATCH] ARM: pxa: set up Treo GPIOs using device initcall

This augments the Treo setup to grab LCD GPIOs at device_initcall()
level instead of at init_machine() time, and propagates any
returned errors so that deferred probe will work.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-pxa/palmtreo.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index d82a50b..669b609 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -455,16 +455,20 @@ static void __init palmphone_common_init(void)
 }

 #ifdef CONFIG_MACH_TREO680
-void __init treo680_gpio_init(void)
+static int __init treo680_gpio_init(void)
 {
     unsigned int gpio;
+    int ret;

     /* drive all three lcd gpios high initially */
     const unsigned long lcd_flags = GPIOF_INIT_HIGH | GPIOF_DIR_OUT;

     /*
      * LCD GPIO initialization...
+     * only run this on the Treo680
      */
+    if (!machine_is_treo680())
+        return 0;

     /*
      * This is likely the power to the lcd.  Toggling it low/high appears to
@@ -474,8 +478,9 @@ void __init treo680_gpio_init(void)
      * treo680 configures it as gpio.
      */
     gpio = GPIO_NR_TREO680_LCD_POWER;
-    if (gpio_request_one(gpio, lcd_flags, "LCD power") < 0)
-        goto fail;
+    ret = gpio_request_one(gpio, lcd_flags, "LCD power");
+    if (ret < 0)
+        goto fail_lcd_power;

     /*
      * These two are called "enables", for lack of a better understanding.
@@ -486,28 +491,33 @@ void __init treo680_gpio_init(void)
      * revisited.
      */
     gpio = GPIO_NR_TREO680_LCD_EN;
-    if (gpio_request_one(gpio, lcd_flags, "LCD enable") < 0)
-        goto fail;
+    ret = gpio_request_one(gpio, lcd_flags, "LCD enable");
+    if (ret < 0)
+        goto fail_lcd_en;
     gpio = GPIO_NR_TREO680_LCD_EN_N;
-    if (gpio_request_one(gpio, lcd_flags, "LCD enable_n") < 0)
-        goto fail;
+    ret = gpio_request_one(gpio, lcd_flags, "LCD enable_n");
+    if (ret < 0)
+        goto fail_lcd_en_n;

     /* driving this low turns LCD on */
     gpio_set_value(GPIO_NR_TREO680_LCD_EN_N, 0);

-    return;
- fail:
-    pr_err("gpio %d initialization failed\n", gpio);
-    gpio_free(GPIO_NR_TREO680_LCD_POWER);
+    return 0;
+
+fail_lcd_en_n:
     gpio_free(GPIO_NR_TREO680_LCD_EN);
-    gpio_free(GPIO_NR_TREO680_LCD_EN_N);
+fail_lcd_en:
+    gpio_free(GPIO_NR_TREO680_LCD_POWER);
+fail_lcd_power:
+    pr_err("gpio %d initialization failed\n", gpio);
+    return ret;
 }
+device_initcall(treo680_gpio_init);

 static void __init treo680_init(void)
 {
     pxa2xx_mfp_config(ARRAY_AND_SIZE(treo680_pin_config));
     palmphone_common_init();
-    treo680_gpio_init();
     palm27x_mmc_init(GPIO_NR_TREO_SD_DETECT_N, GPIO_NR_TREO680_SD_READONLY,
             GPIO_NR_TREO680_SD_POWER, 0);
     treo680_docg4_flash_init();
--
1.7.11.3

(Tell me if gmail screws up the whitespace and I'll send it with
git-send-email ...)

Yours,
Linus Walleij
