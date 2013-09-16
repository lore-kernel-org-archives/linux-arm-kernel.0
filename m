From: marex@denx.de (Marek Vasut)
Date: Mon, 16 Sep 2013 16:15:40 +0200
Subject: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register
 access
In-Reply-To: <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <1378887511-24530-4-git-send-email-jbe@pengutronix.de>
Message-ID: <201309161615.40751.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Replace the individual register access by a few shared access function to
> make the code easier to read and in order to add the i.MX23 SoC in the
> next step.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> CC: linux-arm-kernel at lists.infradead.org
> CC: devel at driverdev.osuosl.org
> CC: Marek Vasut <marex@denx.de>
> CC: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 204
> +++++++++++++++++++++--------------- 1 file changed, 120 insertions(+), 84
> deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 5535fed..4317fee 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -235,6 +235,56 @@ struct mxs_lradc {
>  #define LRADC_RESOLUTION			12
>  #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
> 
> +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> +}
> +
> +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> +}
> +
> +static void mxs_lradc_reg(struct mxs_lradc *lradc, u32 val, u32 reg)
> +{
> +	writel(val, lradc->base + reg);
> +}

Idea for later patch: Should we not move these functions to a MXS-specific 
header _later_ on so other drivers can leverage them too ?

[...]

Best regards,
Marek Vasut
