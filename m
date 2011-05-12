From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 May 2011 21:34:26 -0700
Subject: [RFC 2/3] ARM: Tegra: Device Tree Support: Add i2c devices
In-Reply-To: <20110511232659.10362.45811.stgit@riker>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232659.10362.45811.stgit@riker>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA2C5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Bonesio wrote at Wednesday, May 11, 2011 5:27 PM:
> This patch initializes i2c controller devices in board-dt.c. The i2c controller
> is added to tegra250.dtsi so later on-board i2c devices can be found and
> initialized based on the device tree information.
>...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
>...
> +#include <linux/i2c.h>
> +#include <linux/i2c-tegra.h>

I don't think those headers are needed now the platform data isn't set up here.

> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
>...
> @@ -598,6 +609,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  	i2c_dev->adapter.algo = &tegra_i2c_algo;
>  	i2c_dev->adapter.dev.parent = &pdev->dev;
>  	i2c_dev->adapter.nr = pdev->id;
> +	i2c_dev->adapter.dev.of_node = of_node_get(pdev->dev.of_node);

It seems like users of this of_node (i.e. the probe function) could just
access pdev->dev.of_node directly (since pdev is already passed in)
rather than storing a copy here. At least, sdhci-tegra.c works that way.
Still, this isn't a big deal, I think.

> @@ -605,6 +617,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  	}
> 
> +	of_i2c_register_devices(&i2c_dev->adapter);
> +

I would have expected that to be performed inside the core I2C code,
probably inside i2c_add_numbered_adapter? Still, it looks like the
other I2C controllers don't already work that way, so this is probably
more a suggestion for future cleanup than something to be addressed in
this patch.

-- 
nvpublic
