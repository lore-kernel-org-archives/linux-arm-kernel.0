From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 3 Feb 2017 11:01:38 -0800
Subject: [PATCH net-next 7/8] net: ethernet: annapurna: add eee helpers to
 the Alpine driver
In-Reply-To: <20170203181216.30214-8-antoine.tenart@free-electrons.com>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-8-antoine.tenart@free-electrons.com>
Message-ID: <1ca99587-64cb-c918-888b-b77144562cb4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2017 10:12 AM, Antoine Tenart wrote:
> Add the get_eee() and set_eee() helpers to support the Energy-Efficient
> (EEE) feature in the Annapurna Labs Alpine driver.

Missing SoB.

> ---
>  drivers/net/ethernet/annapurna/al_eth.c            | 44 +++++++++++
>  drivers/net/ethernet/annapurna/al_hw_eth.h         | 28 +++++++
>  drivers/net/ethernet/annapurna/al_hw_eth_ec_regs.h | 11 +++
>  .../net/ethernet/annapurna/al_hw_eth_mac_regs.h    | 11 +++
>  drivers/net/ethernet/annapurna/al_hw_eth_main.c    | 92 ++++++++++++++++++++++
>  5 files changed, 186 insertions(+)
> 
> diff --git a/drivers/net/ethernet/annapurna/al_eth.c b/drivers/net/ethernet/annapurna/al_eth.c
> index d06a75a49ce5..674dafdb638a 100644
> --- a/drivers/net/ethernet/annapurna/al_eth.c
> +++ b/drivers/net/ethernet/annapurna/al_eth.c
> @@ -2519,6 +2519,47 @@ static u32 al_eth_get_rxfh_indir_size(struct net_device *netdev)
>  	return AL_ETH_RX_RSS_TABLE_SIZE;
>  }
>  
> +static int al_eth_get_eee(struct net_device *netdev,
> +			  struct ethtool_eee *edata)
> +{
> +	struct al_eth_adapter *adapter = netdev_priv(netdev);
> +	struct al_eth_eee_params params;
> +
> +	if (!adapter->phy_exist)
> +		return -EOPNOTSUPP;

Just check for adapter->phydev instead of doing that, please audit your
entire submission for similar uses.

> +
> +	al_eth_eee_get(&adapter->hw_adapter, &params);
> +
> +	edata->eee_enabled = params.enable;
> +	edata->tx_lpi_timer = params.tx_eee_timer;
> +
> +	return phy_ethtool_get_eee(adapter->phydev, edata);
> +}
> +
> +static int al_eth_set_eee(struct net_device *netdev,
> +			  struct ethtool_eee *edata)
> +{
> +	struct al_eth_adapter *adapter = netdev_priv(netdev);
> +	struct al_eth_eee_params params;
> +
> +	struct phy_device *phydev;
> +
> +	if (!adapter->phy_exist)
> +		return -EOPNOTSUPP;
> +
> +	phydev = mdiobus_get_phy(adapter->mdio_bus, adapter->phy_addr);

That's a very bizarre way of getting a reference to a PHY device, you
should have gotten one from a prior call to phy_{connect,attach} and
remembered it in your drivers' private structure, of use the one
attached to the net_device. Why are you doing this?

> +
> +	phy_init_eee(phydev, 1);

You are supposed to check the return value of phy_init_eee().

> +
> +	params.enable = edata->eee_enabled;
> +	params.tx_eee_timer = edata->tx_lpi_timer;
> +	params.min_interval = 10;
> +
> +	al_eth_eee_config(&adapter->hw_adapter, &params);
> +
> +	return phy_ethtool_set_eee(phydev, edata);
> +}


-- 
Florian
