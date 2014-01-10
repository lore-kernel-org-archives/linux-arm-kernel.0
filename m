From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 10 Jan 2014 16:30:00 +0100
Subject: [PATCHv9 1/2] video: backlight: gpio-backlight: Add DT support.
In-Reply-To: <1389366444-29449-1-git-send-email-denis@eukrea.com>
References: <1389366444-29449-1-git-send-email-denis@eukrea.com>
Message-ID: <20140110163000.64dbeba9@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
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
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Added Shawn Guo in the Cc list.
> - The default-brightness-level is now a boolean default-on property,
>   the gpio is only touched if the gpio-backlight driver instance probes.
> - The code and documentation was updated accordingly.
> 
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
>  .../bindings/video/backlight/gpio-backlight.txt    |   19 +++++++
>  drivers/video/backlight/gpio_backlight.c           |   60 +++++++++++++++++---
>  2 files changed, 72 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
> 
[...]
> +static struct of_device_id gpio_backlight_of_match[] = {
> +	{ .compatible = "gpio-backlight" },
> +	{ /* sentinel */ }
> +};
> +
>  static struct platform_driver gpio_backlight_driver = {
>  	.driver		= {
>  		.name		= "gpio-backlight",
>  		.owner		= THIS_MODULE,
> +		.of_match_table = of_match_ptr(gpio_backlight_of_match),
>
useless use of of_match_ptr().
This would make sense, if the gpio_backlight_of_match struct was
conditionally compiled in depending on CONFIG_OF.
Since you unconditionally provide it you can use
&gpio_backlight_of_match directly.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
