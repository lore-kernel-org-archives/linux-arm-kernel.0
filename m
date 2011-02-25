From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 25 Feb 2011 08:16:18 -0500
Subject: [PATCH] davinci: da850/omap-l138: Add Carrier Link OK check in
	Davinci RX Handler
In-Reply-To: <1298627788-32339-1-git-send-email-vinay.hegde@ti.com>
References: <1298627788-32339-1-git-send-email-vinay.hegde@ti.com>
Message-ID: <4D67ABA2.6060808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2011 04:56 AM, Hegde, Vinay wrote:
> This patch adds an additional check in the Davinci EMAC RX Handler,
> which tests the __LINK_STATE_NOCARRIER flag along with the
> __LINK_STATE_START flag as part EMAC shutting down procedure.
> 
> This avoids
> WARNING: at drivers/net/davinci_emac.c:1040 emac_rx_handler+0xf8/0x120()
> during rtcwake used to suspend the target for a specified duration.
> 
> Signed-off-by: Hegde, Vinay <vinay.hegde@ti.com>
> ---
>  drivers/net/davinci_emac.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/davinci_emac.c b/drivers/net/davinci_emac.c
> index 2a628d1..7018bfe 100644
> --- a/drivers/net/davinci_emac.c
> +++ b/drivers/net/davinci_emac.c
> @@ -1008,7 +1008,7 @@ static void emac_rx_handler(void *token, int len, int status)
>  	int			ret;
>  
>  	/* free and bail if we are shutting down */
> -	if (unlikely(!netif_running(ndev))) {
> +	if (unlikely(!netif_running(ndev) || !netif_carrier_ok(ndev))) {
>  		dev_kfree_skb_any(skb);
>  		return;
>  	}

Looks ok.

Acked-by: Cyril Chemparathy <cyril@ti.com>
