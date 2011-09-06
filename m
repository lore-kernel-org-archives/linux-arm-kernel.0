From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 13:27:18 +0100
Subject: [PATCH v8 04/16] DMA: PL330: Remove the start operation for
	handling DMA_TERMINATE_ALL command
In-Reply-To: <CABb+yY1QN9CzT=CGJ1n-pk8_QyeEK1Sx=HT2n8SMB9O-XrsXDg@mail.gmail.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1314924284-25554-5-git-send-email-boojin.kim@samsung.com>
	<CABb+yY1QN9CzT=CGJ1n-pk8_QyeEK1Sx=HT2n8SMB9O-XrsXDg@mail.gmail.com>
Message-ID: <20110906122718.GP6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 05:52:19PM +0530, Jassi Brar wrote:
> On Fri, Sep 2, 2011 at 6:14 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> > Origianl code carries out the start operation after flush operation.
> > But start operation is not required for DMA_TERMINATE_ALL command.
> > So, This patch removes the unnecessary start operation and only carries out
> > the flush oeration for handling DMA_TERMINATE_ALL command.
> 
> Not exactly. The 'start' is impotent when called from this path because there
> is nothing left queued after the call to 'flush'.
> pl330_tasklet() is called because that is a common function that does the
> house-keeping acc to what's presently in 'work' and 'done' lists.
> 
> Though as a side-effect, your patch does avoid doing callbacks on submitted
> xfers during DMA_TERMINATE_ALL - which may or may not be the right thing
> to do.

It is defined that DMA_TERMINATE_ALL does not call the callbacks:

1. int dmaengine_terminate_all(struct dma_chan *chan)

   This causes all activity for the DMA channel to be stopped, and may
   discard data in the DMA FIFO which hasn't been fully transferred.
   No callback functions will be called for any incomplete transfers.
