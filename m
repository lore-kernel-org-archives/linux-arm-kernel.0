From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 12:51:02 -0400
Subject: [PATCH 4/9] spi-orion: add device tree binding
In-Reply-To: <1339324322-29388-5-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-5-git-send-email-andrew@lunn.ch>
Message-ID: <20120610165102.GV14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31:56PM +0200, Andrew Lunn wrote:
> From: Michael Walle <michael@walle.cc>
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Looks good.

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  Documentation/devicetree/bindings/spi/spi-orion.txt |    5 +++++
>  drivers/spi/spi-orion.c                             |    9 +++++++++
>  2 files changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
> new file mode 100644
> index 0000000..e68597a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -0,0 +1,5 @@
> +Marvell Orion SPI device
> +
> +Required properties:
> +- compatible : should be "marvell,orion-spi".
> +- reg : offset and length of the register set for the device
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index 8c3d625..b16db3d 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/clk.h>
>  #include <asm/unaligned.h>
>  
> @@ -429,6 +430,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
>  	if (orion_spi_reset(spi) < 0)
>  		goto out_rel_mem;
>  
> +	master->dev.of_node = pdev->dev.of_node;
>  	status = spi_register_master(master);
>  	if (status < 0)
>  		goto out_rel_mem;
> @@ -468,10 +470,17 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
>  
>  MODULE_ALIAS("platform:" DRIVER_NAME);
>  
> +static const struct of_device_id orion_spi_of_match_table[] __devinitdata = {
> +	{ .compatible = "marvell,orion-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
> +
>  static struct platform_driver orion_spi_driver = {
>  	.driver = {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(orion_spi_of_match_table),
>  	},
>  	.remove		= __exit_p(orion_spi_remove),
>  };
> -- 
> 1.7.10
> 
