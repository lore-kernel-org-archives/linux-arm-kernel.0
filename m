From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 19 Jul 2018 08:22:00 +0200
Subject: [RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device
 during probe
In-Reply-To: <20180718235710.18242-3-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-3-jmkrzyszt@gmail.com>
Message-ID: <20180719082200.470ac8d1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Jul 2018 01:57:04 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Initialize NWP GPIO pin low to protect the device from hazard during
> probe.  Release write protection as soon as the device is under
> control.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 48233d638d2a..6ac38e9cfa1a 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -219,8 +219,8 @@ static int ams_delta_init(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	/* Set chip enabled, but  */
> -	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_HIGH);
> +	/* Set chip enabled but write protected */
> +	priv->gpiod_nwp = devm_gpiod_get(&pdev->dev, "nwp", GPIOD_OUT_LOW);
>  	if (IS_ERR(priv->gpiod_nwp)) {
>  		err = PTR_ERR(priv->gpiod_nwp);
>  		dev_err(&pdev->dev, "NWP GPIO request failed (%d)\n", err);
> @@ -267,6 +267,9 @@ static int ams_delta_init(struct platform_device *pdev)
>  	if (err)
>  		goto out_mtd;
>  
> +	/* As soon as the device is found, release write protection */
> +	gpiod_set_value(priv->gpiod_nwp, 1);

Please don't do that until we have a generic way to assert/deassert WP
from the core. I agree that we shouldn't write things in the
nand_scan() path, but I'd be more comfortable if the core had control
on this pin just in case we ever need to disable write-protection
during chip detection/initialization.

> +
>  	/* Register the partitions */
>  	mtd_device_register(mtd, partition_info, ARRAY_SIZE(partition_info));
>  
> @@ -288,6 +291,9 @@ static int ams_delta_cleanup(struct platform_device *pdev)
>  	struct mtd_info *mtd = nand_to_mtd(&priv->nand_chip);
>  	void __iomem *io_base = priv->io_base;
>  
> +	/* Apply write protection */
> +	gpiod_set_value(priv->gpiod_nwp, 0);
> +
>  	/* Release resources, unregister device */
>  	nand_release(mtd);
>  
