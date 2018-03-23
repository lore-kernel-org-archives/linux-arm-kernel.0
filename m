From: davem@davemloft.net (David Miller)
Date: Fri, 23 Mar 2018 12:43:26 -0400 (EDT)
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
References: <1521738603-23596-4-git-send-email-okaya@codeaurora.org>
 <20180323.122035.1380806748695640531.davem@davemloft.net>
 <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
Message-ID: <20180323.124326.2170503491903886041.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 12:31:12 -0400

> Sorry, you got me confused now.
> 
> If you look at the code closer, you'll see this.
> 
> 	wmb();
> 
> 	txdata->tx_db.data.prod += nbd;
> 	barrier();
> 
> 	DOORBELL(bp, txdata->cid, txdata->tx_db.raw);
> 
> and you also asked me to rename DOORBELL to DOORBELL_RELAXED() to make
> it obvious that we have a relaxed operator inside the macro.

This still doesn't match the stated pattern.

	wmb();
	/* no other memory or I/O or IOMEM operation */
	writel();

There is a write to a producer index there and then no non-compiler
barrier or any kind before the writel().

So, in fact, it might really need that implicit writel() barrier here!
