From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 27 Jun 2014 22:48:42 +0400
Subject: [PATCH CFT 12/30] net: fec: ensure fec_enet_free_buffers()
 properly cleans the rings
In-Reply-To: <E1X0XwQ-0001Na-Kg@rmk-PC.arm.linux.org.uk>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
 <E1X0XwQ-0001Na-Kg@rmk-PC.arm.linux.org.uk>
Message-ID: <53ADBC8A.8070103@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/27/2014 07:19 PM, Russell King wrote:

> Ensure that we do not double-free any allocations, and that any transmit
> skbuffs are properly freed when we clean up the rings.

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>   drivers/net/ethernet/freescale/fec_main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 9c5570a3e32e..8024b7a8e7f4 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -2079,8 +2079,14 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>   	}
>
>   	bdp = fep->tx_bd_base;
> -	for (i = 0; i < fep->tx_ring_size; i++)
> +	for (i = 0; i < fep->tx_ring_size; i++) {
>   		kfree(fep->tx_bounce[i]);
> +		fep->tx_bounce[i] = NULL;
> +		skb = fep->tx_skbuff[i];
> +		fep->tx_skbuff[i] = NULL;
> +		if (skb)
> +			dev_kfree_skb(skb);

    dev_kfree_skb() (actually, consume_skb() that it calls) already checks 
'skb' for NULL.

WBR, Sergei
