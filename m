From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 21 Apr 2014 21:58:00 +0400
Subject: [PATCH v8 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <1397869980-21187-3-git-send-email-zhangfei.gao@linaro.org>
References: <1397869980-21187-1-git-send-email-zhangfei.gao@linaro.org>
 <1397869980-21187-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <53555C28.4050303@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/19/2014 05:12 AM, Zhangfei Gao wrote:

> Hisilicon hip04 platform mdio driver
> Reuse Marvell phy drivers/net/phy/marvell.c

> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
[...]

> diff --git a/drivers/net/ethernet/hisilicon/hip04_mdio.c b/drivers/net/ethernet/hisilicon/hip04_mdio.c
> new file mode 100644
> index 0000000..19826a3
> --- /dev/null
> +++ b/drivers/net/ethernet/hisilicon/hip04_mdio.c
> @@ -0,0 +1,185 @@
> +

    Empty line not needed here.

> +/* Copyright (c) 2014 Linaro Ltd.
> + * Copyright (c) 2014 Hisilicon Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

[...]

> +static int hip04_mdio_reset(struct mii_bus *bus)
> +{
> +	int temp, err, i;
> +
> +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> +		hip04_mdio_write(bus, i, 22, 0);

    Why? What kind of a register this is? <uapi/linux/mii.h> tells me it's 
MII_SREVISION...

> +		temp = hip04_mdio_read(bus, i, MII_BMCR);

    You're not checking for error...

> +		temp |= BMCR_RESET;
> +		err = hip04_mdio_write(bus, i, MII_BMCR, temp);

    Hmm, why you're open coding BMCR reset? There's phy_init_hw() doing this 
correctly...

> +		if (err < 0)
> +			return err;
> +	}
> +
> +	mdelay(500);
> +	return 0;
> +}
> +
> +static int hip04_mdio_probe(struct platform_device *pdev)
> +{
> +	struct resource *r;
> +	struct mii_bus *bus;
> +	struct hip04_mdio_priv *priv;
> +	int ret;
> +
> +	bus = mdiobus_alloc_size(sizeof(struct hip04_mdio_priv));
> +	if (!bus) {
> +		dev_err(&pdev->dev, "Cannot allocate MDIO bus\n");
> +		return -ENOMEM;
> +	}
> +
> +	bus->name = "hip04_mdio_bus";
> +	bus->read = hip04_mdio_read;
> +	bus->write = hip04_mdio_write;
> +	bus->reset = hip04_mdio_reset;

    Ah... However I don't think it a good implementation of that bus method...

[...]

WBR, Sergei
