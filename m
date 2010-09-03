From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 3 Sep 2010 10:42:01 +0100
Subject: [PATCH] regulators: add support max8952 regulator
In-Reply-To: <1283476524-12820-1-git-send-email-kgene.kim@samsung.com>
References: <1283476524-12820-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100903094200.GC8381@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 10:15:24AM +0900, Kukjin Kim wrote:

> +	ret2 = max8649_reg_read(info->i2c, MAX8649_CHIP_ID2);
> +	if (ret2 < 0) {
> +		dev_err(info->dev, "Failed to detect ID of %s:%d\n",
> +			id->name, ret2);
>  		goto out;
>  	}

If the read fails you'll not set an error code when you jump to out so
the probe will report success.  It might be clearer to have separate id
variables which you store the read values into if they're OK, just from
a legibility point of view.

> -	dev_info(info->dev, "Detected MAX8649 (ID:%x)\n", ret);
> +	dev_info(info->dev, "Detected %s (ID:%x %x)\n", id->name, ret, ret2);
> +
> +	info->type = id->driver_data;

It'd be nice to check that the type that was supplied matches the ID
read from the chip in case the user got things wrong, just for
defensiveness.
