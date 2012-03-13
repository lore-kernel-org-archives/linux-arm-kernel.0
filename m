From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 13 Mar 2012 15:33:35 +0100
Subject: [PATCH 1/1] net: phylib: add error checking if no phy found
In-Reply-To: <1331636302-18256-1-git-send-email-b29396@freescale.com>
References: <1331636302-18256-1-git-send-email-b29396@freescale.com>
Message-ID: <4F5F5ABF.5030103@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 03/13/12 11:58, Dong Aisheng a ?crit :
> From: Dong Aisheng<dong.aisheng@linaro.org>
>
> Signed-off-by: Dong Aisheng<dong.aisheng@linaro.org>
> ---
>   drivers/net/phy/mdio_bus.c |   11 ++++++++++-
>   1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 88cc5db..d8e044d 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -101,6 +101,7 @@ static struct class mdio_bus_class = {
>   int mdiobus_register(struct mii_bus *bus)
>   {
>   	int i, err;
> +	u32 phynum = 0;
>
>   	if (NULL == bus || NULL == bus->name ||
>   			NULL == bus->read ||
> @@ -134,12 +135,20 @@ int mdiobus_register(struct mii_bus *bus)
>   			if (IS_ERR(phydev)) {
>   				err = PTR_ERR(phydev);
>   				goto error;
> +			} else if (phydev != NULL) {
> +				phynum++;
>   			}
>   		}
>   	}
>
> +	if (!phynum) {
> +		err = -ENODEV;
> +		printk(KERN_ERR "%s: no phys found\n", bus->name);
> +		goto error;
> +	}

I am not sure if this is a good idea to change it, especially if:
- the MII bus probing is also done later (quite some drivers do this)
- if we want to attach a fixed PHY because we could not probe one at 
registration time

> +
>   	bus->state = MDIOBUS_REGISTERED;
> -	pr_info("%s: probed\n", bus->name);
> +	pr_info("%s: %d phys probed\n", bus->name, phynum);
>   	return 0;
>
>   error:
