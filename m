From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Aug 2017 16:48:32 +0200
Subject: [PATCH] net: stmmac: dwmac-sun8i: Use reset exclusive
In-Reply-To: <20170825143805.21733-1-clabbe.montjoie@gmail.com>
References: <20170825143805.21733-1-clabbe.montjoie@gmail.com>
Message-ID: <20170825144832.3w6izhri5vstbndp@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 04:38:05PM +0200, Corentin Labbe wrote:
> The current dwmac_sun8i module cannot be rmmod/modprobe due to that
> the reset controller was not released when removed.
> 
> This patch remove ambiguity, by using of_reset_control_get_exclusive and
> add the missing reset_control_put().
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index fffd6d5fc907..675a09629d85 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -782,6 +782,7 @@ static int sun8i_dwmac_unpower_internal_phy(struct sunxi_priv_data *gmac)
>  
>  	clk_disable_unprepare(gmac->ephy_clk);
>  	reset_control_assert(gmac->rst_ephy);
> +	reset_control_put(gmac->rst_ephy);
>  	return 0;
>  }
>  
> @@ -942,7 +943,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		}
>  
> -		gmac->rst_ephy = of_reset_control_get(plat_dat->phy_node, NULL);
> +		gmac->rst_ephy = of_reset_control_get_exclusive(plat_dat->phy_node, NULL);

Why not just use devm_reset_control_get?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170825/25f931d1/attachment.sig>
