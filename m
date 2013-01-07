From: bhutchings@solarflare.com (Ben Hutchings)
Date: Mon, 7 Jan 2013 16:53:11 +0000
Subject: [PATCH 3.8-rc] net: mvneta: fix driver operation in SMP context
In-Reply-To: <1357576074-24245-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576074-24245-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1357577591.2658.16.camel@bwh-desktop.uk.solarflarecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-07 at 17:27 +0100, Thomas Petazzoni wrote:
> From: Dmitri Epshtein <dima@marvell.com>
> 
> In order for the driver to behave properly in a SMP context, the same
> transmit queue should be used by the kernel in dev_queue_xmit() and in
> the driver's mvneta_tx() function. To achieve that, the driver now
> implements the ->ndo_select_txq() operation.
>
> For now, it always returns the same transmit queue, txq_def, until the
> driver is expanded to properly take advantage of the multiqueue
> capabilities of the hardware.
[...]

Well it looks like the driver already sets up multiple TX queues, and
you just need to call skb_get_queue_mapping(skb) to look up the TX queue
in mvneta_tx().

Also since the numbers of queues are variable you should be calling
alloc_etherdev_mqs(sizeof(struct mvneta_port), txq_number, rxq_number)
instead of alloc_etherdev_mq(..., 8) in mvneta_probe().

If for some reason the current hardware initialisation doesn't actually
work for more than 1 TX queue then change the number you pass to
alloc_etherdev_mqs().

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
