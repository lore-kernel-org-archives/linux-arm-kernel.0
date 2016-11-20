From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 20 Nov 2016 20:37:20 +0100
Subject: [RFC PATCH v2 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <1479478912-14067-1-git-send-email-andrei.pistirica@microchip.com>
References: <1479478912-14067-1-git-send-email-andrei.pistirica@microchip.com>
Message-ID: <20161120193720.GA7874@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 03:21:51PM +0100, Andrei Pistirica wrote:
> +#ifdef CONFIG_MACB_USE_HWSTAMP
> +void macb_ptp_init(struct net_device *ndev);
> +#else
> +void macb_ptp_init(struct net_device *ndev) { }

static inline ^^^

> +#endif


> +void macb_ptp_init(struct net_device *ndev)
> +{
> +	struct macb *bp = netdev_priv(ndev);
> +	struct timespec64 now;
> +	u32 rem = 0;
> +
> +	if (!(bp->caps | MACB_CAPS_GEM_HAS_PTP)){
> +		netdev_vdbg(bp->dev, "Platform does not support PTP!\n");
> +		return;
> +	}

You would have needed '&' and not '|' here.

Also, using a flag limits the code to your platform.  This works for
you, but it is short sighted.  The other MACB PTP blocks have
different register layouts, and this patch does not lay the ground
work for the others.

The driver needs to be designed to support the other platforms.

Thanks,
Richard
