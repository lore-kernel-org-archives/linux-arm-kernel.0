From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 16 Jun 2010 08:29:40 +0200
Subject: [PATCH 04/12] phylib: add a way to make PHY time stamps possible.
In-Reply-To: <27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<27c0ad283f025c2bb71e7ceb71be07f969939429.1276615626.git.richard.cochran@omicron.at>
Message-ID: <20100616062940.GC2887@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 06:08:20PM +0200, Richard Cochran wrote:

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

I forgot to mention this patch also provides a way to fix the broken
software timestamp fallback mode of the SO_TIMESTAMPING API.

We would have to add this inline call to every MAC driver in an
appropriate spot within the hard_xmit function. It is not too pretty,
but providing this as a compile time option will promote
standardization of the SO_TIMESTAMPING API for applications.

Richard
