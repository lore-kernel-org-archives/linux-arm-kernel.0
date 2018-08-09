From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 9 Aug 2018 12:40:41 +0800
Subject: [PATCH v1 6/7] net: mvneta: Don't use GRO on Armada 3720
In-Reply-To: <20180808152706.21727-7-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-7-marek.behun@nic.cz>
Message-ID: <20180809124022.790f1784@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ more people

On Wed,  8 Aug 2018 17:27:05 +0200 Marek Beh?n wrote:

> For some reason on Armada 3720 boards (EspressoBin and Turris Mox) the
> networking driver behaves weirdly when using napi_gro_receive.
> 
> For example downloading a big file from a local network (low ping) is
> fast, but when downloading from a remote server (higher ping), the
> download speed is at first high but drops rapidly to almost nothing or
> absolutely nothing.

We also met this issue on some berlin platforms. I tried to fix the bug,
but no clue so far.

> 
> This is fixed when using netif_receive_skb instead of napi_gro_receive.

This is a workaround. The good news is this workaround also fixes the issue
we saw on berlin.

> 
> Signed-off-by: Marek Behun <marek.behun@nic.cz>
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
> Cc: netdev at vger.kernel.org
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0ad2f3f7da85..27f3017d94c5 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1959,7 +1959,10 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
>  
>  			skb->protocol = eth_type_trans(skb, dev);
>  			mvneta_rx_csum(pp, rx_status, skb);
> -			napi_gro_receive(&port->napi, skb);
> +			if (pp->neta_armada3700)
> +				netif_receive_skb(skb);
> +			else
> +				napi_gro_receive(&port->napi, skb);
>  
>  			rcvd_pkts++;
>  			rcvd_bytes += rx_bytes;
> @@ -2001,7 +2004,10 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
>  
>  		mvneta_rx_csum(pp, rx_status, skb);
>  
> -		napi_gro_receive(&port->napi, skb);
> +		if (pp->neta_armada3700)
> +			netif_receive_skb(skb);
> +		else
> +			napi_gro_receive(&port->napi, skb);
>  	}
>  
>  	if (rcvd_pkts) {
