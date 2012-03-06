From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 05 Mar 2012 16:49:18 -0800
Subject: [PATCH v4] lpc32xx: Added ethernet driver
In-Reply-To: <1330987524.2538.61.camel@bwh-desktop>
References: <1330983641-32622-1-git-send-email-stigge@antcom.de>
 <1330987524.2538.61.camel@bwh-desktop>
Message-ID: <1330994958.9504.2.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-05 at 22:45 +0000, Ben Hutchings wrote:
> On Mon, 2012-03-05 at 22:40 +0100, Roland Stigge wrote:
> [...]

...

> > +				/* Copy packet from buffer */
> > +				memcpy(prdbuf,
> > +					pldat->rx_buff_v[rxconsidx], len);
> > +
> > +				/* Pass to upper layer */
> > +				skb->protocol = eth_type_trans(skb, ndev);
> > +				netif_rx(skb);
> > +				ndev->last_rx = jiffies;
> 
> Drivers don't need to set last_rx any more.

Also, a NAPI driver should call netif_receive_skb() instead of
netif_rx()

netif_rx() is more expensive because of additional queue, while
netif_receive_skb() directly calls the upper stacks.
