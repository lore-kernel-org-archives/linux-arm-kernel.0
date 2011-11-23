From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 23 Nov 2011 17:10:42 +0530
Subject: [PATCH] IMX/SDMA : save the real count for one DMA transaction.
In-Reply-To: <4ECCD910.1010004@freescale.com>
References: <1322039585-7901-1-git-send-email-b32955@freescale.com>
 <20111123105821.GC4063@pengutronix.de> <4ECCD34C.1090400@freescale.com>
 <20111123110626.GD4063@pengutronix.de> <4ECCD553.5020804@freescale.com>
 <20111123111816.GF4063@pengutronix.de>  <4ECCD910.1010004@freescale.com>
Message-ID: <1322048442.1516.274.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-23 at 19:29 +0800, Huang Shijie wrote:
> > On Wed, Nov 23, 2011 at 07:13:23PM +0800, Huang Shijie wrote:
> >>>>>> +	/* save the real count we received or transmitted. */
> >>>>>> +	chan->private = (void *)count;
> >>>>> And if someone later needs another variable which is private?
> >>>>>
> >>>> I ever wanted to add an new parameter `void *` to dma_aync_tx_callback,
> >>>> but it seemed i have
> >>>> to change a lot of files.
> >>>>
> >>>> Do you have any better suggestion?
> >>> Use a private struct and put count in there.
> >>>
> >> Where to put the private struct? in the imx-sdma.c ?
> >> If i put it there, how can i get it in the UART driver with the current
> >> DMA API?
> > So, in the UART driver you assume that void* is an int? Or how do you
> > currently use count?
> >
> In the UART driver, I use the following lines:
> -------------------------------------------------------
> + struct dma_chan *chan = sport->dma_chan_rx;
> + unsigned int count = (unsigned int)chan->private;
> -------------------------------------------------------
Chan->private is a depreciated field, and will be removed soon...
possibly 3.3, so obviosly any usage of it is incorrect

Why dont you use .device_tx_status callback and return the number of
bytes remaining to be transmitted in residue value of the struct
dma_tx_state. That should be size - count.

-- 
~Vinod
