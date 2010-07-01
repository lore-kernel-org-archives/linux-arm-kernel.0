From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 1 Jul 2010 11:50:36 +0800
Subject: [PATCH 23/33] Removing dead BACKLIGHT_CORGI
In-Reply-To: <daefd019d1a302665a0cc5817ed50cfb4b7b1c44.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<daefd019d1a302665a0cc5817ed50cfb4b7b1c44.1277911346.git.siccegge@cs.fau.de>
Message-ID: <AANLkTikeR3hzF8KGBxPoRTiAmXXK62UB4CZ4t8tctC5_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 1, 2010 at 12:01 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> BACKLIGHT_CORGI doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

BACKLIGHT_CORGI was renamed to BACKLIGHT_GENERIC in commit
d00ba726725c6f41e43df00f83e484ba8f9fac5c.

Since it's now safe to completely transition to LCD_CORGI, which not only
includes the backlight functionality but also the LCD, so

Acked-by: Eric Miao <eric.y.miao@gmail.com>

> ---
> ?arch/arm/mach-pxa/corgi_pm.c ? | ? ?2 --
> ?arch/arm/mach-pxa/sharpsl_pm.c | ? 15 ---------------
> ?arch/arm/mach-pxa/spitz_pm.c ? | ? ?2 --
> ?3 files changed, 0 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
> index 3f1dc74..a735205 100644
> --- a/arch/arm/mach-pxa/corgi_pm.c
> +++ b/arch/arm/mach-pxa/corgi_pm.c
> @@ -165,8 +165,6 @@ static struct sharpsl_charger_machinfo corgi_pm_machinfo = {
> ? ? ? ?.should_wakeup ? = corgi_should_wakeup,
> ?#if defined(CONFIG_LCD_CORGI)
> ? ? ? ?.backlight_limit = corgi_lcd_limit_intensity,
> -#elif defined(CONFIG_BACKLIGHT_CORGI)
> - ? ? ? .backlight_limit = corgibl_limit_intensity,
> ?#endif
> ? ? ? ?.charge_on_volt ? = SHARPSL_CHARGE_ON_VOLT,
> ? ? ? ?.charge_on_temp ? = SHARPSL_CHARGE_ON_TEMP,
> diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
> index cb47672..582701e 100644
> --- a/arch/arm/mach-pxa/sharpsl_pm.c
> +++ b/arch/arm/mach-pxa/sharpsl_pm.c
> @@ -277,21 +277,6 @@ static void sharpsl_battery_thread(struct work_struct *private_)
> ? ? ? ?dev_dbg(sharpsl_pm.dev, "Battery: voltage: %d, status: %d, percentage: %d, time: %ld\n", voltage,
> ? ? ? ? ? ? ? ? ? ? ? ?sharpsl_pm.battstat.mainbat_status, sharpsl_pm.battstat.mainbat_percent, jiffies);
>
> -#ifdef CONFIG_BACKLIGHT_CORGI
> - ? ? ? /* If battery is low. limit backlight intensity to save power. */
> - ? ? ? if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
> - ? ? ? ? ? && ((sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_LOW)
> - ? ? ? ? ? || (sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL))) {
> - ? ? ? ? ? ? ? if (!(sharpsl_pm.flags & SHARPSL_BL_LIMIT)) {
> - ? ? ? ? ? ? ? ? ? ? ? sharpsl_pm.machinfo->backlight_limit(1);
> - ? ? ? ? ? ? ? ? ? ? ? sharpsl_pm.flags |= SHARPSL_BL_LIMIT;
> - ? ? ? ? ? ? ? }
> - ? ? ? } else if (sharpsl_pm.flags & SHARPSL_BL_LIMIT) {
> - ? ? ? ? ? ? ? sharpsl_pm.machinfo->backlight_limit(0);
> - ? ? ? ? ? ? ? sharpsl_pm.flags &= ~SHARPSL_BL_LIMIT;
> - ? ? ? }
> -#endif
> -
> ? ? ? ?/* Suspend if critical battery level */
> ? ? ? ?if ((sharpsl_pm.battstat.ac_status != APM_AC_ONLINE)
> ? ? ? ? ? ? && (sharpsl_pm.battstat.mainbat_status == APM_BATTERY_STATUS_CRITICAL)
> diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
> index 4209ddf..b36f0ae 100644
> --- a/arch/arm/mach-pxa/spitz_pm.c
> +++ b/arch/arm/mach-pxa/spitz_pm.c
> @@ -212,8 +212,6 @@ struct sharpsl_charger_machinfo spitz_pm_machinfo = {
> ? ? ? ?.should_wakeup ? ?= spitz_should_wakeup,
> ?#if defined(CONFIG_LCD_CORGI)
> ? ? ? ?.backlight_limit = corgi_lcd_limit_intensity,
> -#elif defined(CONFIG_BACKLIGHT_CORGI)
> - ? ? ? .backlight_limit ?= corgibl_limit_intensity,
> ?#endif
> ? ? ? ?.charge_on_volt ? = SHARPSL_CHARGE_ON_VOLT,
> ? ? ? ?.charge_on_temp ? = SHARPSL_CHARGE_ON_TEMP,
> --
> 1.7.0.4
>
>
