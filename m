From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Jul 2014 14:35:12 +0800
Subject: [PATCH] SPI: spi-imx: enable realtime master workqueue
In-Reply-To: <1405683059-23316-1-git-send-email-list-09_linux_arm@tqsc.de>
References: <1405683059-23316-1-git-send-email-list-09_linux_arm@tqsc.de>
Message-ID: <20140722063510.GB21229@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 01:30:59PM +0200, Markus Niebel wrote:
> From: Markus Niebel <Markus.Niebel@tq-group.de>
> 
> SPI master provides an option to run the SPI workqueue
> with realtime prio. This feature is currently used only
> by spi-pl022.
> 
> Support this feature for spi-imx by parsing an optional
> bool value from device tree.

This sounds like a Linux specific feature/implementation, so shouldn't
be a decision of device tree.

Shawn

> 
> Note: maybe useful for all SPI controllers.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.de>
> ---
>  .../devicetree/bindings/spi/fsl-imx-cspi.txt       |    4 ++++
>  drivers/spi/spi-imx.c                              |    1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 4256a6d..6b908c7 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -8,6 +8,10 @@ Required properties:
>  - fsl,spi-num-chipselects : Contains the number of the chipselect
>  - cs-gpios : Specifies the gpio pins to be used for chipselects.
>  
> +Optional properties:
> +- fsl,rt : indicates the controller should run the message pump with realtime
> +	   priority to minimise the transfer latency on the bus (boolean)
> +
>  Example:
>  
>  ecspi at 70010000 {
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 5daff20..3a9c373 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -835,6 +835,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>  	master->bus_num = pdev->id;
>  	master->num_chipselect = num_cs;
> +	master->rt = of_property_read_bool(np, "fsl,rt");
>  
>  	spi_imx = spi_master_get_devdata(master);
>  	spi_imx->bitbang.master = master;
> -- 
> 1.7.9.5
> 
