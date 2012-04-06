From: samgandhi9@gmail.com (Sam Gandhi)
Date: Fri, 6 Apr 2012 07:53:06 -0700
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <4F7EC6AF.6000603@freescale.com>
References: <20120404070157.GB24930@pengutronix.de>
 <CAOdLEaqXyvHzTRSq2=RquZLqEO6kMEp11rjKJ+UtSqtF4nr-EA@mail.gmail.com>
 <20120404183314.GF17187@pengutronix.de>
 <CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>
 <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
 <4F7EC6AF.6000603@freescale.com>
Message-ID: <CAOdLEapBs-5RqUN_tjO+pOp9OvGh0YnusOpLz9MoxBLBgSPY2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I tested the following code :
> ==============================================================
>
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 5978113..0f5b09a 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -202,10 +202,12 @@ static struct mxs_dma_chan *to_mxs_dma_chan(struct
> dma_cha
> static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> {
> struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
> + dma_cookie_t c;
>
> + c = dma_cookie_assign(tx);
> mxs_dma_enable_chan(mxs_chan);
>
> - return dma_cookie_assign(tx);
> + return c;
> }
>
> static void mxs_dma_tasklet(unsigned long data)
>
>
Ack on testing.

I reverted the change that Vinod had suggested earlier, and applied
Huang's suggested change and it fixed the issue. Successfully erased
NAND, made UBI partitions and ran integck tests for several hours.

-Sam
