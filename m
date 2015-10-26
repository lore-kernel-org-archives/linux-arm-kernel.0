From: jiada_wang@mentor.com (Jiada Wang)
Date: Mon, 26 Oct 2015 12:21:55 +0900
Subject: No subject
In-Reply-To: <E1ZqY3A-0004Mt-KH@feisty.vs19.net>
References: <E1ZqY3A-0004Mt-KH@feisty.vs19.net>
Message-ID: <562D9C53.3050603@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

 > Subject: [PATCH v2 4/8] spi: imx: add selection for iMX53 and iMX6 
controller type
>
> ECSPI contorller for iMX53 and iMX6 has few hardware issues in slave
> mode and (32*n+1) SPI word size handling comparing to iMX51.
> The change add possibility to detect the SPI controller is use and apply
> workarounds/limitations.
> Documentation for device tree bindings updated
>
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
> ---
>   .../devicetree/bindings/spi/fsl-imx-cspi.txt       |  2 ++
>   drivers/spi/spi-imx.c                              | 36 ++++++++++++++++++++--
>   2 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 523341a..425485f 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -9,6 +9,8 @@ Required properties:
>     - "fsl,imx31-cspi" for SPI compatible with the one integrated on i.MX31
>     - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>     - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
> +  - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53
> +  - "fsl,imx6q-ecspi" for SPI compatible with the one integrated on i.MX6 family
>   - reg : Offset and length of the register set for the device
>   - interrupts : Should contain CSPI/eCSPI interrupt
>   - fsl,spi-num-chipselects : Contains the number of the chipselect
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index d9b730d..41c9cef 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -72,7 +72,8 @@ enum spi_imx_devtype {
>   	IMX27_CSPI,
>   	IMX31_CSPI,
>   	IMX35_CSPI,	/* CSPI on all i.mx except above */
> -	IMX51_ECSPI,	/* ECSPI on i.mx51 and later */
> +	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> +	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
>   };
>
>   struct spi_imx_data;
> @@ -129,9 +130,20 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
>   	return d->devtype_data->devtype == IMX35_CSPI;
>   }
>
> +static inline int is_imx53_ecspi(struct spi_imx_data *d)
> +{
> +	return d->devtype_data->devtype == IMX53_ECSPI;
> +}
> +
> +static inline int is_imx5x_ecspi(struct spi_imx_data *d)
> +{
> +	return d->devtype_data->devtype == IMX51_ECSPI ||
> +	       d->devtype_data->devtype == IMX53_ECSPI;
> +}
> +
>   static inline unsigned spi_imx_get_fifosize(struct spi_imx_data *d)
>   {
> -	return (d->devtype_data->devtype == IMX51_ECSPI) ? 64 : 8;
> +	return is_imx5x_ecspi(d) ? 64 : 8;
>   }
>
>   #define MXC_SPI_BUF_RX(type)						\
> @@ -680,6 +692,16 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_data = {
>   	.devtype = IMX51_ECSPI,
>   };
>
> +static struct spi_imx_devtype_data imx53_ecspi_devtype_data = {
> +	/* i.mx53 and later ecspi shares the functions with i.mx51 one */
> +	.intctrl = mx51_ecspi_intctrl,
> +	.config = mx51_ecspi_config,
> +	.trigger = mx51_ecspi_trigger,
> +	.rx_available = mx51_ecspi_rx_available,
> +	.reset = mx51_ecspi_reset,
> +	.devtype = IMX53_ECSPI,
> +};
> +
>   static const struct platform_device_id spi_imx_devtype[] = {
>   	{
>   		.name = "imx1-cspi",
> @@ -697,6 +719,12 @@ static const struct platform_device_id spi_imx_devtype[] = {
>   		.name = "imx35-cspi",
>   		.driver_data = (kernel_ulong_t) &imx35_cspi_devtype_data,
>   	}, {
> +		.name = "imx53-ecspi",
> +		.driver_data = (kernel_ulong_t)&imx53_ecspi_devtype_data,
> +	}, {
> +		.name = "imx6q-ecspi",
> +		.driver_data = (kernel_ulong_t)&imx53_ecspi_devtype_data,
> +	}, {
>   		.name = "imx51-ecspi",
>   		.driver_data = (kernel_ulong_t) &imx51_ecspi_devtype_data,
>   	}, {
> @@ -710,6 +738,8 @@ static const struct of_device_id spi_imx_dt_ids[] = {
>   	{ .compatible = "fsl,imx27-cspi", .data = &imx27_cspi_devtype_data, },
>   	{ .compatible = "fsl,imx31-cspi", .data = &imx31_cspi_devtype_data, },
>   	{ .compatible = "fsl,imx35-cspi", .data = &imx35_cspi_devtype_data, },
> +	{ .compatible = "fsl,imx53-ecspi", .data = &imx53_ecspi_devtype_data, },
> +	{ .compatible = "fsl,imx6q-ecspi", .data = &imx53_ecspi_devtype_data, },
>   	{ .compatible = "fsl,imx51-ecspi", .data = &imx51_ecspi_devtype_data, },
>   	{ /* sentinel */ }
>   };
> @@ -1299,7 +1329,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>   	 * Only validated on i.mx6 now, can remove the constrain if validated on
>   	 * other chips.
>   	 */
> -	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data &&
> +	if (is_imx5x_ecspi(spi_imx) &&
>   	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
>   		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
>
>

With this patch, there will still be issues with SPI controller on imx6 
soc other than imx6q,
for example SPI controller on imx6sl has compatibility
"compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi";"

So I would suggest to update device-tree file,
for example
imx53.dtsi
"fsl,imx53-ecspi", "fsl,imx51-ecspi"; -> "fsl,imx53-ecspi";
imx6qdl.dtsi
compatible = "fsl,imx6q-ecspi", "fsl,imx51-ecspi"; -> compatible = 
"fsl,imx6q-ecspi", "fsl,imx53-ecspi";
imx6sl.dtsi
compatible = "fsl,imx6sl-ecspi", "fsl,imx51-ecspi"; -> compatible = 
"fsl,imx6sl-ecspi", "fsl,imx53-ecspi";
etc...
by doing this, then only compatible string "fsl,imx53-ecspi" need to be
added in driver code.

Thanks,
Jiada
