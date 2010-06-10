From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 10 Jun 2010 08:43:30 +0200
Subject: [PATCH 1/2 v2] mv643xx_eth: use sw csum for big packets
In-Reply-To: <1276073483-17208-1-git-send-email-saeed@marvell.com>
References: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
	<1276073483-17208-1-git-send-email-saeed@marvell.com>
Message-ID: <20100610064330.GK1743@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 09, 2010 at 11:51:23AM +0300, Saeed Bishara wrote:

> diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
> index e345ec8..2d0e06b 100644
> --- a/drivers/net/mv643xx_eth.c
> +++ b/drivers/net/mv643xx_eth.c
> @@ -289,6 +289,7 @@ struct mv643xx_eth_shared_private {
>  	unsigned int t_clk;
>  	int extended_rx_coal_limit;
>  	int tx_bw_control;
> +	int tx_csum_limit;
>  };
>  
>  #define TX_BW_CONTROL_ABSENT		0
> @@ -782,7 +783,8 @@ static int txq_submit_skb(struct tx_queue *txq, struct sk_buff *skb)
>  		       skb->protocol != htons(ETH_P_8021Q));
>  
>  		tag_bytes = (void *)ip_hdr(skb) - (void *)skb->data - ETH_HLEN;
> -		if (unlikely(tag_bytes & ~12)) {
> +		if (unlikely(tag_bytes & ~12) ||
> +			skb->len > mp->shared->tx_csum_limit) {

Please line up skb->len with unlikely() on the line above it.


> @@ -2666,6 +2668,9 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
>  	 * Detect hardware parameters.
>  	 */
>  	msp->t_clk = (pd != NULL && pd->t_clk != 0) ? pd->t_clk : 133000000;
> +	msp->tx_csum_limit = pd->tx_csum_limit ? pd->tx_csum_limit : 9 * 1024;
> +	/* add header count so we can compare against skb->len */
> +	msp->tx_csum_limit += ETH_HLEN;
>  	infer_hw_params(msp);

Is the limit 9 * 1024 + 14 for the whole packet, or 9 * 1024 for the IP
part?

I.e. what happens if skb->len is 9 * 1024 + 15, but there is one VLAN
tag present -- will the hardware be able to do the checksum offload or
not?
