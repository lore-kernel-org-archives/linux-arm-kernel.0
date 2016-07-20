From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jul 2016 11:56:12 +0200
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <4697175.RMdFEWr9V5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 20, 2016 10:03:16 AM CEST LABBE Corentin wrote:
> +
> +       /* Benched on OPIPC with 100M, setting more than 256 does not give any
> +        * perf boost
> +        */
> +       priv->nbdesc_rx = 128;
> +       priv->nbdesc_tx = 256;
> +
> 

256 tx descriptors can introduce a significant latency. Can you add
support for BQL (netdev_sent_queue/netdev_completed_queue) to limit
the queue size to the minimum?

I also noticed that your tx_lock() prevents you from concurrently
running sun8i_emac_complete_xmit() and sun8i_emac_xmit(). Is that
necessary? I'd think that you can find a way to make them work
concurrently.

	Arnd
