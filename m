From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jan 2014 10:42:12 +0000
Subject: [PATCHv8] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1389088974-31465-1-git-send-email-denis@eukrea.com>
References: <1389088974-31465-1-git-send-email-denis@eukrea.com>
Message-ID: <20140107104212.GD2930@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 10:02:53AM +0000, Denis Carikli wrote:
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v7->v8:
> - The default-state was renamed to default-brightness-level.
> - default-brightness-level is now mandatory, like for backlight-pwm,
>   That way we avoid having to handle the case where it's not set,
>   which means that we would need not to set the gpio, but still
>   report a brightness value for sysfs, when not all gpio controllers are
>   able to read the gpio value.
> - switched the default-brightness-level to boolean values (0 or 1) instead
>   of using strings ("on", "off", "keep").
> - The documentation was updated accordingly.
> - The example in the documentation now uses the dts gpio defines.
> - The "backlight: gpio_backlight: Use a default state enum." patch was then
>   dropped, becuase it is not necessary anymore.
> 
> ChangeLog v6->v7:
> - removed a compilation warning with the removal of the useless ret declaration.
> 
> ChangeLog v5->v6:
> - The default state handling was reworked:
>   - it's now called default-state, and looks like the gpio-leds default-state.
>   - it now has a "keep" option, like for the gpio-leds.
>   - that "keep" option is the default when the default-state property is not set.
> - The documentation was updated accordingly.
> 
> ChangeLog v4->v5:
> - The default-brightness property now defaults to 0 in the driver.
> - def_value int becomes a bool.
> - The check for the gpio validity has been reworked.
> ---
>  .../bindings/video/backlight/gpio-backlight.txt    |   19 ++++++
>  drivers/video/backlight/gpio_backlight.c           |   64 +++++++++++++++++---
>  2 files changed, 76 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> new file mode 100644
> index 0000000..d022add
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> @@ -0,0 +1,19 @@
> +gpio-backlight bindings
> +
> +Required properties:
> +  - compatible: "gpio-backlight"
> +  - gpios: describes the gpio that is used for enabling/disabling the backlight
> +    (see GPIO binding[0] for more details).
> +  - default-brightness-level: the default brightness level. Valid values:
> +    - 0: off
> +    - 1: on

If this is a boolean, use a boolean/empty property (default-on would be
a good candidate, or you could have default-off if most people are gonig
to want the display on at boot).

[...]

> +	ret = of_property_read_u32(np, "default-brightness-level",
> +				   &gbl->def_value);

This could be:

gbl->def_value = of_property_read_bool(np, "default-on");

Then you don't have to worry about people doing crazy things like having
default-brightness-level = <6> when you only support a boolean value.

Thanks,
Mark.
