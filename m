From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Sep 2017 10:45:25 +0200
Subject: [PATCH v2] net: stmmac: dwmac-sun8i: Use reset exclusive
In-Reply-To: <20170918183043.8028-1-clabbe.montjoie@gmail.com>
References: <20170918183043.8028-1-clabbe.montjoie@gmail.com>
Message-ID: <20170919084525.vdbjrqx5qvhhxmor@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 08:30:43PM +0200, Corentin Labbe wrote:
> The current dwmac_sun8i module cannot be rmmod/modprobe due to that
> the reset controller was not released when removed.
> 
> This patch remove ambiguity, by using of_reset_control_get_exclusive and
> add the missing reset_control_put().
> 
> Note that we cannot use devm_reset_control_get, since the reset is not
> in the device node.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
> Changes since v1:
> - added a note about devm_reset_control_get in commit message

That comment would be better if it was in the code.

> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 57bb6dd7b401..1736d7cb0d96 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -854,6 +854,7 @@ static int sun8i_dwmac_unpower_internal_phy(struct sunxi_priv_data *gmac)
>  
>  	clk_disable_unprepare(gmac->ephy_clk);
>  	reset_control_assert(gmac->rst_ephy);
> +	reset_control_put(gmac->rst_ephy);

Putting it here is weird.

What would happen if power_phy / unpower_phy is called several times?

Can't we just make it symetric and undo in remove what we do in probe?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/3933a590/attachment.sig>
