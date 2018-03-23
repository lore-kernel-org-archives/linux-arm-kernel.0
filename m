From: davem@davemloft.net (David Miller)
Date: Fri, 23 Mar 2018 13:04:18 -0400 (EDT)
Subject: [PATCH v5 3/5] bnx2x: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
References: <cb6a0522-2c53-b252-49db-5779d24963c6@codeaurora.org>
 <20180323.124326.2170503491903886041.davem@davemloft.net>
 <4bd9ccd2-df8f-acad-2513-eefe065dc852@codeaurora.org>
Message-ID: <20180323.130418.2223623186761161723.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 23 Mar 2018 12:51:47 -0400

> It could if txdata->tx_db was not a union. There is a data dependency
> between txdata->tx_db.data.prod and txdata->tx_db.raw. 
> 
> So, no reordering.

I don't see it that way, the code requires that:

 	txdata->tx_db.data.prod += nbd;

is visible before the doorbell update.

barrier() doesn't provide that.

Neither does writel_relaxed().  However plain writel() does.

Therefore the code is only correct as-is, and your change potentially
adds a reordering problem.
