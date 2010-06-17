From: davem@davemloft.net (David Miller)
Date: Wed, 16 Jun 2010 18:03:41 -0700 (PDT)
Subject: [PATCH 04/12] phylib: add a way to make PHY time stamps possible.
In-Reply-To: <27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
Message-ID: <20100616.180341.242128217.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 15 Jun 2010 18:08:20 +0200

> +static inline void skb_tx_timetamp(struct phy_device *phy, struct sk_buff *skb)
> +{
> +	union skb_shared_tx *shtx = skb_tx(skb);
> +
> +	if (shtx->hardware && phy && phy->drv->txtstamp)
> +		phy->drv->txtstamp(phy, skb);
> +
> +	if (shtx->software && !shtx->in_progress)
> +		skb_tstamp_tx(skb, NULL);
> +}
> +
> +static inline void skb_rx_timetamp(struct phy_device *phy, struct sk_buff *skb)
> +{
> +	if (phy && phy->drv->rxtstamp)
> +		phy->drv->rxtstamp(phy, skb);
> +}

Since, as you say, this can provide a way to deal with the sw TX
timestamping sequencing problem we have right now, I'd rather
you implement this from the inside out instead of from the
outside in.

By this I mean you should provide these inline helpers by default
then we can begin to put them into the drivers.

You could also split the SW tstamp handling into a seperate inline
function, which drivers call immediately once they know they will
actually give the packet to the hardware for sending.
