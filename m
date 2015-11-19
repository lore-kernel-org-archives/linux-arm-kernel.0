From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Thu, 19 Nov 2015 05:20:31 +0200
Subject: [linux-sunxi] [PATCH] thermal: Add support for Sunxi THS on the
 Allwinner H3
In-Reply-To: <20151118205147.GA19779@maud.lan>
References: <20151118205147.GA19779@maud.lan>
Message-ID: <20151119052031.58d25778@i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 18 Nov 2015 21:51:48 +0100
Josef Gajdusek <atx@atx.name> wrote:

> This patch adds support for the Sunxi thermal sensor on the Allwinner H3.
> Also adds declaration of the H3 THS clock to clk-sunxi.c ignoring the
> dividers as they are not continuous (clk-divider.c cannot be used as it
> does not support setting an enable bit).
> Should be easily extendable for the A33/A83T/... as they have similar but
> not completely identical sensors.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>

Thanks for working on this. The thermal sensor is very useful on
H3 because this SoC tends to be running rather hot at high clock
frequencies.

Do you also have plans for making use of an irq handler?

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
>  .../devicetree/bindings/thermal/sunxi-ths.txt      |  24 ++
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  27 +++
>  drivers/clk/sunxi/clk-sunxi.c                      |  16 ++
>  drivers/thermal/Kconfig                            |   7 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/sunxi_ths.c                        | 263 +++++++++++++++++++++
>  7 files changed, 339 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/sunxi-ths.txt
>  create mode 100644 drivers/thermal/sunxi_ths.c

[...]

> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -604,6 +604,13 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
>  	*p = calcp;
>  }
>  
> +static void sun8i_h3_get_ths_factors(u32 *freq, u32 parent_rate,
> +				      u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	/* Ignore the dividers as they are not continuous */
> +	*freq = parent_rate;
> +}

Can you elaborate on this? What's wrong with the dividers? Which clock
frequency happens to be used for THS in the end?

> +static int sunxi_ths_h3_init(struct sunxi_ths_data *data)
> +{
> +	if (data->calreg)
> +		writel(readl(data->calreg) & 0xfff, data->regs + THS_H3_CDATA);
> +	/* Magical constants mostly taken from Allwinner 3.4 kernel.
> +	 * Seem to work fine, though this could be configurable in DT/sysft
> +	 */
> +	writel(0xff << THS_H3_CTRL0_SENSOR_ACQ0,
> +			data->regs + THS_H3_CTRL0);
> +	writel((0x3f << THS_H3_CTRL2_SENSOR_ACQ1) | BIT(THS_H3_CTRL2_SENSE_EN),
> +			data->regs + THS_H3_CTRL2);
> +	writel((0x390 << THS_H3_INT_CTRL_THERMAL_PER) | BIT(THS_H3_INT_CTRL_DATA_IRQ_EN),
> +			data->regs + THS_H3_INT_CTRL);
> +	writel(BIT(THS_H3_FILTER_EN) | (0x2 << THS_H3_FILTER_TYPE),
> +			data->regs + THS_H3_FILTER);
> +	return 0;
> +}

The H3 manual has some nice description of these registers and explains
how these parameters should be calculated (they depend on the THS clock
frequency). No magic involved.

Currently the H3 manual is available from Orange Pi people and OLIMEX.
There is also an open request about releasing it "officially":
    https://github.com/allwinner-zh/documents/issues/9

-- 
Best regards,
Siarhei Siamashka
