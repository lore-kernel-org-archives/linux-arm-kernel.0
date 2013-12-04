From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 05 Dec 2013 00:05:44 +0300
Subject: [PATCH RFCv2 5/6] net: phy: suspend unused PHYs on mdio_bus in
 late_initcall
In-Reply-To: <1386171888-28190-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384978913-8052-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1386171888-28190-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <529F9928.9090407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/04/2013 06:44 PM, Sebastian Hesselbarth wrote:

> Since phy_attach ensures PHYs are resumed, we can now suspend all
> PHYs that have no attached netdev after initcalls.

> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> RFCv1->RFCv2:
> - only check for phydev->attached_dev and let phy_suspend decide on
>    performing suspend or not (Suggested by Florian)

> @Florian: You suggested to 'make sure that the MDIO bus suspend policy
> was set to "auto"'. I wasn't able to find any clue how to check that,
> so I ignored that for now.

> Cc: David Miller <davem@davemloft.net>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   drivers/net/phy/mdio_bus.c |   25 +++++++++++++++++++++++++
>   1 files changed, 25 insertions(+), 0 deletions(-)

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 5617876..f533d17 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -320,6 +320,31 @@ static int mdio_bus_match(struct device *dev, struct device_driver *drv)
>   		(phydev->phy_id & phydrv->phy_id_mask));
>   }
>
> +static int mdio_bus_suspend_unused(struct device *busdev, void *data)
> +{
> +	struct mii_bus *bus = to_mii_bus(busdev);
> +	struct phy_device *phydev;
> +	int i;
> +
> +	for (i = 0; i < PHY_MAX_ADDR; i++) {
> +		if (!bus->phy_map[i])
> +			continue;
> +
> +		phydev = to_phy_device(&bus->phy_map[i]->dev);

    Why so complex? 'bus->phy_map[i]' already gives you 'phydev'.

> +		if (!phydev->attached_dev)
> +			phy_suspend(phydev);
> +	}
> +
> +	return 0;
> +}

WBR, Sergei
