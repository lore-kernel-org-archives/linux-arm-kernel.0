From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 13 Apr 2013 00:22:48 +0200
Subject: [PATCH v5 00/14] ARM: samsung-time: Prepare for multiplatform
 support
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <201304130022.49987.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Am Freitag, 12. April 2013, 21:17:16 schrieb Tomasz Figa:
> This series is an attempt to make the samsung-time clocksource driver ready
> for multiplatform kernels. It moves the driver to drivers/clocksource,
> cleans it up from uses of static platform-specific definitions, simplifies
> timer interrupt handling and adds Device Tree support.
> 
> The samsung_pwm clocksource driver is made the master driver, which
> exposes a single function to the PWM driver to get required data. Only
> samsung-time driver is reworked to use the master driver at this time,
> since the PWM driver can be already considered broken at the moment and
> needs separate series of several patches to fix and clean it up, which
> I am already working on.
> 
> Tested on Universal C210 board with Device Tree. Not tested without
> Device Tree, since it has been already broken before this series.
> Compile tested for other related SoCs.

On a s3c2416 based board with both non-dt and preliminary-dt support
Tested-by: Heiko Stuebner <heiko@sntech.de>

One nitpick:

Without dt support, you get this:

  CC      drivers/clocksource/samsung_pwm.o
drivers/clocksource/samsung_pwm.c:620: warning: ?samsung_pwm_clocksource_init_of? defined but not used

So, something like the following might be necessary

-------------- 8< -------------------
diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index a12ee08..2bf8303 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -617,6 +617,7 @@ static void __init __samsung_pwm_clocksource_init(
        samsung_clocksource_init();
 }
 
+#ifdef CONFIG_CLKSRC_OF
 static void __init samsung_pwm_clocksource_init_of(struct device_node *np)
 {
        __samsung_pwm_clocksource_init(NULL, np);
@@ -629,6 +630,7 @@ CLOCKSOURCE_OF_DECLARE(s5p6440_pwm, "samsung,s5p6440-pwm",
                                        samsung_pwm_clocksource_init_of);
 CLOCKSOURCE_OF_DECLARE(s5pc100_pwm, "samsung,s5pc100-pwm",
                                        samsung_pwm_clocksource_init_of);
+#endif
 
 void __init samsung_pwm_clocksource_init(struct platform_device *pdev)
 {
-------------- 8< -------------------


Heiko
