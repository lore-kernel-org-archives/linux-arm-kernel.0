From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 1 Jul 2018 09:58:54 +0200
Subject: [PATCH net-next 5/5] net: gemini: Indicate that we can handle
 jumboframes
In-Reply-To: <20180630161806.24312-5-linus.walleij@linaro.org>
References: <20180630161806.24312-1-linus.walleij@linaro.org>
 <20180630161806.24312-5-linus.walleij@linaro.org>
Message-ID: <20180701075854.GB15006@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 30, 2018 at 06:18:06PM +0200, Linus Walleij wrote:
> The hardware supposedly handles frames up to 10236 bytes and
> implements .ndo_change_mtu() so accept 10236 minus the ethernet
> header for a VLAN tagged frame on the netdevices.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 79324bbfd768..ae475393e4ac 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2473,6 +2473,11 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  
>  	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
>  	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
> +	/* We can handle jumbo frames up to 10236 bytes so, let's accept
> +	 * payloads of 10236 bytes minus VLAN and ethernet header
> +	 */
> +	netdev->min_mtu = 256;
> +	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;

Hi Linus

The commit message does not mention the min mtu you set here. Where
does 256 come from?

Thanks
     Andrew
