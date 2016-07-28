From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Thu, 28 Jul 2016 15:18:26 +0200
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <4697175.RMdFEWr9V5@wuerfel>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
 <4697175.RMdFEWr9V5@wuerfel>
Message-ID: <20160728131826.GA7582@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 11:56:12AM +0200, Arnd Bergmann wrote:
> On Wednesday, July 20, 2016 10:03:16 AM CEST LABBE Corentin wrote:
> > +
> > +       /* Benched on OPIPC with 100M, setting more than 256 does not give any
> > +        * perf boost
> > +        */
> > +       priv->nbdesc_rx = 128;
> > +       priv->nbdesc_tx = 256;
> > +
> > 
> 
> 256 tx descriptors can introduce a significant latency. Can you add
> support for BQL (netdev_sent_queue/netdev_completed_queue) to limit
> the queue size to the minimum?

Done, since setting below 256 give lower performance with iperf.

> 
> I also noticed that your tx_lock() prevents you from concurrently
> running sun8i_emac_complete_xmit() and sun8i_emac_xmit(). Is that
> necessary? I'd think that you can find a way to make them work
> concurrently.
> 
> 	Arnd

I will reworked locking and it seems that no locking is necessary.
I have added the following comment about the locking strategy:

/* Locking strategy:
 * RX queue does not need any lock since only sun8i_emac_poll() access it.
 * (All other RX modifiers (ringparam/ndo_stop) disable NAPI and so sun8i_emac_poll())
 * TX queue is handled by sun8i_emac_xmit(), sun8i_emac_complete_xmit() and sun8i_emac_tx_timeout()
 * (All other RX modifiers (ringparam/ndo_stop) disable NAPI and stop queue)
 *
 * sun8i_emac_xmit() could fire only once (netif_tx_lock)
 * sun8i_emac_complete_xmit() could fire only once (called from NAPI)
 * sun8i_emac_tx_timeout() could fire only once (netif_tx_lock) and couldnt
 * race with sun8i_emac_xmit (due to netif_tx_lock) and with sun8i_emac_complete_xmit which disable NAPI.
 *
 * So only sun8i_emac_xmit and sun8i_emac_complete_xmit could fire at the same time.
 * But they never could modify the same descriptors:
 * - sun8i_emac_complete_xmit() will modify only descriptors with empty status
 * - sun8i_emac_xmit() will modify only descriptors set to DCLEAN
 * Proper memory barriers ensure that descriptor set to DCLEAN could not be
 * modified latter by sun8i_emac_complete_xmit().
 * */

Does I am right ?

Thanks for your review.

Regards

LABBE Corentin
