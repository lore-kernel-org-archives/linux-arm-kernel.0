From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 4 Feb 2012 12:45:34 +0000
Subject: [BUG] Spitz charger broken (and other sharpsl warnings)?
Message-ID: <20120204124534.GT889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building my test PXA configuration, it spat out these warnings.
There's three of them, the first probably does need fixing ASAP.

This one is particularly nasty:
arch/arm/mach-pxa/spitz_pm.c: In function 'spitz_charger_wakeup':
arch/arm/mach-pxa/spitz_pm.c:178: warning: left shift count >= width of type

static unsigned long spitz_charger_wakeup(void)
{
        unsigned long ret;
        ret = (!gpio_get_value(SPITZ_GPIO_KEY_INT)
                << GPIO_bit(SPITZ_GPIO_KEY_INT))
                | (!gpio_get_value(SPITZ_GPIO_SYNC)
                << GPIO_bit(SPITZ_GPIO_SYNC)); <========
        return ret;
}

If this impacts the way the charger works, it's definitely something that
needs fixing.  We don't want more exploding batteries.

----------------------------------------------------------------------------
arch/arm/mach-pxa/sharpsl_pm.c: In function 'sharpsl_pm_pxa_read_max1111':
arch/arm/mach-pxa/sharpsl_pm.c:180: warning: ISO C90 forbids mixed declarations and code

int sharpsl_pm_pxa_read_max1111(int channel)
{
        /* Ugly, better move this function into another module */
        if (machine_is_tosa())
            return 0;

        extern int max1111_read_channel(int); <=====

        /* max1111 accepts channels from 0-3, however,
         * it is encoded from 0-7 here in the code.
         */
        return max1111_read_channel(channel >> 1);

This seems to have been introduced by:

commit f16177c20c42e1bd780b35259a995f7718986dd4
Author: Eric Miao <eric.miao@marvell.com>
Date:   Fri Aug 29 06:19:32 2008 +0800

    hwmon: add max1111_read_channel() for use by sharpsl_pm

    This is not generic, and is added here for backward compatibility.
    It is made an individual commit here to make it easier for revert
    once the sharpsl_pm gets generic enough.

    Signed-off-by: Eric Miao <eric.miao@marvell.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index e804ae0..9427d80 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -132,8 +132,17 @@ int sharpsl_pm_pxa_read_max1111(int channel)
        if (machine_is_tosa()) // Ugly, better move this function into another module
            return 0;

+#ifdef CONFIG_SENSORS_MAX1111
+       extern int max1111_read_channel(int);
+
+       /* max1111 accepts channels from 0-3, however,
+        * it is encoded from 0-7 here in the code.
+        */
+       return max1111_read_channel(channel >> 1);
+#else
        return corgi_ssp_max1111_get((channel << MAXCTRL_SEL_SH) | MAXCTRL_PD0 | MAXCTRL_PD1
                        | MAXCTRL_SGL | MAXCTRL_UNI | MAXCTRL_STR);
+#endif
 }

 void sharpsl_pm_pxa_init(void)

----------------------------------------------------------------------------
arch/arm/mach-pxa/sharpsl_pm.c: At top level:
arch/arm/mach-pxa/sharpsl_pm.c:694: warning: 'sharpsl_fatal_check' defined but not used

This warning has been around for a long time, since:

commit 99f329a2ba3c2d07cc90ca9309babf27ddf98bff
Author: Pavel Machek <pavel@ucw.cz>
Date:   Sun Sep 6 07:28:40 2009 +0200

    [ARM] pxa/sharpsl_pm: zaurus c3000 aka spitz: fix resume

    sharpsl_pm.c code tries to read battery state very early during
    resume, but those battery meters are connected on SPI and that's only
    resumed way later.

    Replace the check with simple checking of battery fatal signal, that
    actually works at this stage.

    Signed-off-by: Pavel Machek <pavel@ucw.cz>
    Tested-by: Stanislav Brabec <utx@penguin.cz>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 2546c06..629e05d 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -678,8 +678,8 @@ static int corgi_enter_suspend(unsigned long alarm_time, unsigned int alarm_enab
                dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
        }

-       if ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || (sharpsl_fatal_check() < 0) )
-       {
+       if ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) ||
+           (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_FATAL))) {
                dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
                corgi_goto_sleep(alarm_time, alarm_enable, state);
                return 1;
