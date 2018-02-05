From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Mon, 5 Feb 2018 21:48:53 +0100
Subject: [PATCH v2 1/2] mtd: fsl-quadspi: Update slave device hwcap based
 on mode provided in dtsi file
In-Reply-To: <1517549484-6024-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1517549484-6024-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1517549484-6024-2-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <b868bd0c-2d5e-f4cf-a32c-012e021d3a89@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yogesh,

Le 02/02/2018 ? 06:31, Yogesh Gaur a ?crit?:
> FSL QuadSPI controller supports Single, dual, quad modes of operation.
> Mode information is available via "spi-tx-bus-width" and
> "spi-rx-bus-width" nodes of device tree for the connected slave device.
> 
> Update read and write hwcap capability for slave device by reading
> "spi-rx-bus-width" and "spi-tx-bus-width" respectively.
> Assign hwcaps mask to minimal caps for the slave node i.e.
> 	SNOR_HWCAPS_READ | SNOR_HWCAPS_PP
> 
> If value not provided in device tree file, then fallback to default
> mode i.e. SNOR_HWCAPS_READ_1_1_4 and SNOR_HWCAPS_PP.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v2:
> - None
> 
>  drivers/mtd/spi-nor/fsl-quadspi.c | 56 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index b9c5918..1503e0c 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -994,17 +994,14 @@ static void fsl_qspi_unprep(struct spi_nor *nor, enum spi_nor_ops ops)
>  
>  static int fsl_qspi_probe(struct platform_device *pdev)
>  {
> -	const struct spi_nor_hwcaps hwcaps = {
> -		.mask = SNOR_HWCAPS_READ_1_1_4 |
> -			SNOR_HWCAPS_PP,
> -	};
> +	struct spi_nor_hwcaps hwcaps;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
>  	struct fsl_qspi *q;
>  	struct resource *res;
>  	struct spi_nor *nor;
>  	struct mtd_info *mtd;
> -	int ret, i = 0;
> +	int ret, i = 0, value;
>  
>  	q = devm_kzalloc(dev, sizeof(*q), GFP_KERNEL);
>  	if (!q)
> @@ -1077,6 +1074,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  
>  	/* iterate the subnodes. */
>  	for_each_available_child_of_node(dev->of_node, np) {
> +		/* Reset hwcaps mask to minimal caps for the slave node. */
> +		hwcaps.mask = SNOR_HWCAPS_READ | SNOR_HWCAPS_PP;
> +		value = 0;
> +
>  		/* skip the holes */
>  		if (!q->has_second_chip)
>  			i *= 2;
> @@ -1106,6 +1107,51 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>  		/* set the chip address for READID */
>  		fsl_qspi_set_base_addr(q, nor);
>  
> +		/*
> +		 * If spi-rx-bus-width and spi-tx-bus-width not defined assign
> +		 * default hardware capabilities SNOR_HWCAPS_READ_1_1_4 and
> +		 * SNOR_HWCAPS_PP supported by the Quad-SPI controller.
> +		 */
> +		if (!of_property_read_u32(np, "spi-rx-bus-width", &value)) {
> +			switch (value) {
> +			case 1:
> +				hwcaps.mask |= SNOR_HWCAPS_READ |
> +					       SNOR_HWCAPS_READ_FAST;
> +				break;
> +			case 2:
> +				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2 |
> +					       SNOR_HWCAPS_READ_1_2_2;

I guess there is a misunderstanding in the meaning of spi-rx-bus-width and
spi-tx-bus_width.

spi-rx-bus-width = <N>, resp. spi-tx-bus-width = <N>, means the SPI controller
can receive, resp. send, data on N I/O Lines.

Then let's take the example of some Fast Read X-Y-Z command:

the op code is *sent* on X I/O lines: you need to check spi-tx-bus-width
the address/mode/dummy bits are *sent* on Y I/O lines: check spi-tx-bus-width too
the data bits are *received* on Z I/O lines: check spi-rx-bus_width.

> +				break;
> +			case 4:
> +				hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4 |
> +					       SNOR_HWCAPS_READ_1_4_4;

The same here: to allow SPI 1-4-4, you have to check that spi-tx-bus-width == 4.

So your usage of spi-{tx|rx}-bus-width is not consistent with the usage done in
the SPI subsystem. Please have a look at drivers/mtd/devices/m25p80.c, especially
how the SPI_RX_QUAD and SPI_TX_QUAD flags are used in the m25p_probe() function
to have a better idea of how it should work.

Also have a look at of_spi_parse_dt() in drivers/spi/spi.c, to figure out how the
SPI_{TX|RX}_{DUAL|QUAD} flags are set according to the spi-{tx|rx}-bus-width DT
properties.

> +				break;
> +			default:
> +				dev_err(dev,
> +					"spi-rx-bus-width %d not supported\n",
> +					value);
> +				break;
> +			}
> +		} else
> +			hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;

Not sure whether it passes checkpatch, you may have to add { } for the else
statement even if there is a single line as the if statement use { }.

Personally I don't mind that much. Please just check that your patch passes
checkpatch verification and it will be okay for me :)

Best regards,

Cyrille

> +
> +		if (!of_property_read_u32(np, "spi-tx-bus-width", &value)) {
> +			switch (value) {
> +			case 1:
> +				hwcaps.mask |= SNOR_HWCAPS_PP;
> +				break;
> +			case 4:
> +				hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4 |
> +					       SNOR_HWCAPS_PP_1_4_4;
> +				break;
> +			default:
> +				dev_err(dev,
> +					"spi-tx-bus-width %d not supported\n",
> +					value);
> +				break;
> +			}
> +		}
> +
>  		ret = spi_nor_scan(nor, NULL, &hwcaps);
>  		if (ret)
>  			goto mutex_failed;
> 
