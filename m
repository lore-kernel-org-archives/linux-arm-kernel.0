From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 19:05:45 -0500
Subject: [PATCH 1/7] mtd: spi-nor: cadence-quadspi: add a delay in write
 sequence
In-Reply-To: <20170801045434.8733-2-vigneshr@ti.com>
References: <20170801045434.8733-1-vigneshr@ti.com>
 <20170801045434.8733-2-vigneshr@ti.com>
Message-ID: <20170810000545.hphnihd5ghugfbof@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 10:24:28AM +0530, Vignesh R wrote:
> As per 66AK2G02 TRM[1] SPRUHY8F section 11.15.5.3 Indirect Access
> Controller programming sequence, a delay equal to couple QSPI master
> clock(~5ns) is required after setting CQSPI_REG_INDIRECTWR_START bit and
> writing data to the flash. Add a new compatible to handle the couple of
> cycles of delay required in the indirect write sequence, since this
> delay is specific to TI 66AK2G SoC.
> 
> [1]http://www.ti.com/lit/ug/spruhy8f/spruhy8f.pdf
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt |  1 +
>  drivers/mtd/spi-nor/cadence-quadspi.c                     | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> index f248056da24c..fdd511a83511 100644
> --- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
> @@ -2,6 +2,7 @@
>  
>  Required properties:
>  - compatible : Should be "cdns,qspi-nor".
> +	       Should be "ti,k2g-qspi" for TI 66AK2G platform.
>  - reg : Contains two entries, each of which is a tuple consisting of a
>  	physical address and length. The first entry is the address and
>  	length of the controller register set. The second entry is the
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 53c7d8e0327a..94571590371d 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -76,6 +76,7 @@ struct cqspi_st {
>  	u32			fifo_depth;
>  	u32			fifo_width;
>  	u32			trigger_address;
> +	u32			wr_delay;
>  	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>  };
>  
> @@ -608,6 +609,14 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor,
>  	reinit_completion(&cqspi->transfer_complete);
>  	writel(CQSPI_REG_INDIRECTWR_START_MASK,
>  	       reg_base + CQSPI_REG_INDIRECTWR);
> +	/*
> +	 * As per 66AK2G02 TRM SPRUHY8F section 11.15.5.3 Indirect Access
> +	 * Controller programming sequence, couple of cycles of
> +	 * QSPI_REF_CLK delay is required for the above bit to
> +	 * be internally synchronized by the QSPI module. Provide 5
> +	 * cycles of delay.
> +	 */
> +	ndelay(cqspi->wr_delay);
>  
>  	while (remaining > 0) {
>  		write_bytes = remaining > page_size ? page_size : remaining;
> @@ -1213,6 +1222,9 @@ static int cqspi_probe(struct platform_device *pdev)
>  	}
>  
>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
> +	if (of_device_is_compatible(dev->of_node, "ti,k2g-qspi"))
> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
> +						   cqspi->master_ref_clk_hz);

Use the data pointer in the of_device_id table and put the delay value 
there.

>  
>  	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
>  			       pdev->name, cqspi);
> @@ -1285,6 +1297,7 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>  
>  static const struct of_device_id cqspi_dt_ids[] = {
>  	{.compatible = "cdns,qspi-nor",},
> +	{.compatible = "ti,k2g-qspi",},
>  	{ /* end of table */ }
>  };
>  
> -- 
> 2.13.3
> 
