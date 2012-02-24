From: davem@davemloft.net (David Miller)
Date: Fri, 24 Feb 2012 03:25:31 -0500 (EST)
Subject: [PATCH v2] davinci_emac: Do not free all rx dma descriptors
 during init
In-Reply-To: <1329995657-7051-1-git-send-email-christian.riesch@omicron.at>
References: <1329995657-7051-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <20120224.032531.607179170339382701.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Riesch <christian.riesch@omicron.at>
Date: Thu, 23 Feb 2012 12:14:17 +0100

> This patch fixes a regression that was introduced by
> 
> commit 0a5f38467765ee15478db90d81e40c269c8dda20
> davinci_emac: Add Carrier Link OK check in Davinci RX Handler
> 
> Said commit adds a check whether the carrier link is ok. If the link is
> not ok, the skb is freed and no new dma descriptor added to the rx dma
> channel. This causes trouble during initialization when the carrier
> status has not yet been updated. If a lot of packets are received while
> netif_carrier_ok returns false, all dma descriptors are freed and the
> rx dma transfer is stopped.
> 
> The bug occurs when the board is connected to a network with lots of
> traffic and the ifconfig down/up is done, e.g., when reconfiguring
> the interface with DHCP.
> 
> The bug can be reproduced by flood pinging the davinci board while doing
> ifconfig eth0 down
> ifconfig eth0 up
> on the board.
> 
> After that, the rx path stops working and the overrun value reported
> by ifconfig is counting up.
> 
> This patch reverts commit 0a5f38467765ee15478db90d81e40c269c8dda20
> and instead issues warnings only if cpdma_chan_submit returns -ENOMEM.
> 
> Signed-off-by: Christian Riesch <christian.riesch@omicron.at>

Applied to 'net', thanks.
