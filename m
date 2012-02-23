From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Thu, 23 Feb 2012 12:39:10 +0000
Subject: [PATCH v2] davinci_emac: Do not free all rx dma descriptors
 during	init
In-Reply-To: <1329995657-7051-1-git-send-email-christian.riesch@omicron.at>
References: <1329995657-7051-1-git-send-email-christian.riesch@omicron.at>
Message-ID: <B6A220404B6BFC4BBD2AB91C54D39DF431775769@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 23, 2012 at 16:44:17, Christian Riesch wrote:
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
> Cc: <stable@vger.kernel.org>
> Cc: Hegde, Vinay <vinay.hegde@ti.com>
> Cc: Cyril Chemparathy <cyril@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Hi,
> Since my first submission of this patch yesterday I did additional tests
> with suspend/rtcwake. My tests confirmed that the solution in this
> patch solves the problem that was addressed by commit
> 0a5f38467765ee15478db90d81e40c269c8dda20 while not destroying the
> rx communication channel. 
> 

Tested on DA850 and confirmed that there is no regression.

Tested-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

Regards,
Sudhakar
