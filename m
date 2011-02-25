From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 25 Feb 2011 14:55:45 +0300
Subject: [PATCH] davinci: da850/omap-l138: Add Carrier Link OK check in
	Davinci RX Handler
In-Reply-To: <1298627788-32339-1-git-send-email-vinay.hegde@ti.com>
References: <1298627788-32339-1-git-send-email-vinay.hegde@ti.com>
Message-ID: <4D6798C1.7090404@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-02-2011 12:56, Hegde, Vinay wrote:

    This is not a patch to arch/arm/mach-davinci/, so the summary prefix 
should not be "davinci: da850/omap-l138:" but rather "davinci_emac:" as you're 
patching this driver.

> This patch adds an additional check in the Davinci EMAC RX Handler,
> which tests the __LINK_STATE_NOCARRIER flag along with the
> __LINK_STATE_START flag as part EMAC shutting down procedure.

> This avoids
> WARNING: at drivers/net/davinci_emac.c:1040 emac_rx_handler+0xf8/0x120()
> during rtcwake used to suspend the target for a specified duration.

> Signed-off-by: Hegde, Vinay <vinay.hegde@ti.com>

> diff --git a/drivers/net/davinci_emac.c b/drivers/net/davinci_emac.c
> index 2a628d1..7018bfe 100644
> --- a/drivers/net/davinci_emac.c
> +++ b/drivers/net/davinci_emac.c
> @@ -1008,7 +1008,7 @@ static void emac_rx_handler(void *token, int len, int status)
>   	int			ret;
>
>   	/* free and bail if we are shutting down */
> -	if (unlikely(!netif_running(ndev))) {
> +	if (unlikely(!netif_running(ndev) || !netif_carrier_ok(ndev))) {
>   		dev_kfree_skb_any(skb);
>   		return;
>   	}

WBR, Sergei
