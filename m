From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 15 Jun 2017 10:25:10 -0700
Subject: [PATCH] watchdog: meson-wdt: add support for the watchdog on
 Meson8 and Meson8m2
In-Reply-To: <20170611095219.22095-1-martin.blumenstingl@googlemail.com>
References: <20170611095219.22095-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170615172510.GA7549@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 11, 2017 at 11:52:19AM +0200, Martin Blumenstingl wrote:
> The watchdog IP block on Meson8 and Meson8m2 is already supported by the
> existing meson-wdt driver. Meson8 uses the same register bits as Meson6,
> while the newer Meson8m2 SoC uses the same register bits as Meson8b.
> 
> Currently watchdog support on Meson8 SoC already works because
> meson8.dtsi simply uses the "amlogic,meson6-wdt" compatible. Adding a
> separate compatible for Meson8 makes this more explicit though.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

In general, changes like this are not necessary, though. The dts file
is supposed to reference both generic and specific compatible strings.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 6 +++++-
>  drivers/watchdog/meson_wdt.c                             | 2 ++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> index ae70185d96e6..f2fbe1a39d31 100644
> --- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> @@ -2,7 +2,11 @@ Meson SoCs Watchdog timer
>  
>  Required properties:
>  
> -- compatible : should be "amlogic,meson6-wdt" or "amlogic,meson8b-wdt"
> +- compatible : depending on the SoC this should be one of:
> +	"amlogic,meson6-wdt"
> +	"amlogic,meson8-wdt"
> +	"amlogic,meson8b-wdt"
> +	"amlogic,meson8m2-wdt"
>  - reg : Specifies base physical address and size of the registers.
>  
>  Example:
> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
> index 491b9bf13d84..304274c67735 100644
> --- a/drivers/watchdog/meson_wdt.c
> +++ b/drivers/watchdog/meson_wdt.c
> @@ -155,7 +155,9 @@ static const struct watchdog_ops meson_wdt_ops = {
>  
>  static const struct of_device_id meson_wdt_dt_ids[] = {
>  	{ .compatible = "amlogic,meson6-wdt", .data = &meson6_wdt_data },
> +	{ .compatible = "amlogic,meson8-wdt", .data = &meson6_wdt_data },
>  	{ .compatible = "amlogic,meson8b-wdt", .data = &meson8b_wdt_data },
> +	{ .compatible = "amlogic,meson8m2-wdt", .data = &meson8b_wdt_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, meson_wdt_dt_ids);
> -- 
> 2.13.1
> 
