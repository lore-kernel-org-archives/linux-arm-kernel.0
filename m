From: peppe.cavallaro@st.com (Giuseppe CAVALLARO)
Date: Mon, 3 Apr 2017 14:32:33 +0200
Subject: [PATCH v3 02/20] net: stmmac: add optional setup function
In-Reply-To: <20170403091444.29876-3-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
 <20170403091444.29876-3-clabbe.montjoie@gmail.com>
Message-ID: <262f763b-d158-dd77-3dba-1d7b90a1eef9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Corentin

On 4/3/2017 11:14 AM, Corentin Labbe wrote:
> Instead of adding more ifthen logic for adding a new mac_device_info
> setup function, it is easier to add a function pointer to the function
> needed.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
>   include/linux/stmmac.h                            | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 43361f3..3beca41 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3508,7 +3508,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>   	struct mac_device_info *mac;
>   
>   	/* Identify the MAC HW device */
> -	if (priv->plat->has_gmac) {
> +	if (priv->plat->setup) {
> +		mac = priv->plat->setup(priv);
> +	} else if (priv->plat->has_gmac) {
>   		priv->dev->priv_flags |= IFF_UNICAST_FLT;
>   		mac = dwmac1000_setup(priv->ioaddr,
>   				      priv->plat->multicast_filter_bins,
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 3921cb9..dadd74b 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -144,6 +144,8 @@ struct stmmac_txq_cfg {
>   	u32 prio;
>   };
>   
> +struct stmmac_priv;
> +
>   struct plat_stmmacenet_data {
>   	int bus_id;
>   	int phy_addr;
> @@ -177,6 +179,7 @@ struct plat_stmmacenet_data {
>   	void (*fix_mac_speed)(void *priv, unsigned int speed);
>   	int (*init)(struct platform_device *pdev, void *priv);
>   	void (*exit)(struct platform_device *pdev, void *priv);
> +	struct mac_device_info *(*setup)(struct stmmac_priv *priv);

In that case  I prefer to have void *priv as done for the other callbacks.
I mean, keep the priv struct inside the driver part.

peppe

>   	void *bsp_priv;
>   	struct clk *stmmac_clk;
>   	struct clk *pclk;
