From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 6 Jul 2015 10:34:48 +0200
Subject: [PATCH] thermal: consistently use int for temperatures
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CAMuHMdV0rHrNMt1kUg0CwoJ0etQ7sK0jF_My1qLRJLz0z958rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 6, 2015 at 9:19 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0?C. This will probably
> immediately shut the machine down due to overtemperature if started below
> 0?C.
>
> 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> is above the melting point of all known materials.
>
> Consistently use a plain 'int' for temperatures throughout the thermal code and
> the drivers. This only changes the places in the drivers where the temperature
> is passed around as pointer, when drivers internally use another type this is
> not changed.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Feuerer <peter@piie.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-acpi at vger.kernel.org
> Cc: platform-driver-x86 at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: lm-sensors at lm-sensors.org

For rcar-thermal:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index fe4e767..5d4ae7d 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -200,8 +200,7 @@ err_out_unlock:
>         return ret;
>  }
>
> -static int rcar_thermal_get_temp(struct thermal_zone_device *zone,
> -                                unsigned long *temp)
> +static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  {
>         struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>
> @@ -235,7 +234,7 @@ static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
>  }
>
>  static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
> -                                     int trip, unsigned long *temp)
> +                                     int trip, int *temp)
>  {
>         struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
>         struct device *dev = rcar_priv_to_dev(priv);
> @@ -299,7 +298,7 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
>  static void rcar_thermal_work(struct work_struct *work)
>  {
>         struct rcar_thermal_priv *priv;
> -       unsigned long cctemp, nctemp;
> +       int cctemp, nctemp;
>
>         priv = container_of(work, struct rcar_thermal_priv, work.work);
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
