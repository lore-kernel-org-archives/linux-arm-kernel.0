From: davem@davemloft.net (David Miller)
Date: Fri, 23 Mar 2018 12:20:35 -0400 (EDT)
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
References: <1521738603-23596-1-git-send-email-okaya@codeaurora.org>
 <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20180323.122035.1380806748695640531.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 22 Mar 2018 13:10:00 -0400

> Code includes wmb() followed by writel(). writel() already has a
> barrier on some architectures like arm64.
 ...
> @@ -4155,7 +4155,7 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	txdata->tx_db.data.prod += nbd;
>  	barrier();
>  
> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);
>  
>  	mmiowb();
 ...
> @@ -2592,7 +2592,7 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
>  
>  	txdata->tx_db.data.prod += 2;
>  	barrier();
> -	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> +	DOORBELL_RELAXED(bp, txdata->cid, txdata->tx_db.raw);

These are compiler barriers being used here, not wmb().

Look, if I can't see a clear:

	wmb()
	writel()

sequence in the patch hunks, I am going to keep pushing back on
these changes.

Thank you.
