From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 23 Sep 2015 21:31:12 +0300
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
 <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <5602EFF0.8040207@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 23.09.2015 16:37, Sascha Hauer wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/thermal/Kconfig       |   8 +
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/mtk_thermal.c | 537 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100644 drivers/thermal/mtk_thermal.c
> 

[snip]

> +
> +	auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
> +	if (!auxadc) {
> +		dev_err(&pdev->dev, "missing auxadc node\n");
> +		return -ENODEV;
> +	}
> +
> +	auxadc_phys_base = of_get_phys_base(auxadc);

in case of OF_DYNAMIC enabled of_parse_phandle() requires of_node_put(),
which is fine to place right here.

> +	if (auxadc_phys_base == OF_BAD_ADDR) {
> +		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> +		return -EINVAL;
> +	}
> +

[snip]

> +
> +	/*
> +	 * These calibration values should finally be provided by the
> +	 * firmware or fuses. For now use default values.
> +	 */
> +	mt->calib_slope = -123;
> +	mt->calib_offset = 465124;
> +
> +	for (i = 0; i < MT8173_NUM_ZONES; i++)
> +		mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> +
> +	platform_set_drvdata(pdev, mt);
> +
> +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +		struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +		bank->tzd = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> +				&mtk_thermal_ops);

I would propose to add return value checks here, otherwise there might
be an oops in mtk_thermal_remove(), if something goes wrong.

--
With best wishes,
Vladimir
