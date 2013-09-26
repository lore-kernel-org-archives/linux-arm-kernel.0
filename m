From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 20:26:46 +0100
Subject: [PATCH 2/3] dma: mxs-dma: Track number of irqs for callback
In-Reply-To: <1380207996-27257-3-git-send-email-mpa@pengutronix.de>
References: <1380207996-27257-1-git-send-email-mpa@pengutronix.de>
 <1380207996-27257-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20130926192646.GR12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 05:06:35PM +0200, Markus Pargmann wrote:
> Currently there is one tasklet scheduled for all interrupts between two
> mxs_dma_tasklet calls for one channel. With more than one interrupts,
> the tasklet is only called once.
> 
> Using low latency audio playback, can lead to problems. When using
> sound/soc/soc-dmaengine-pcm.c, the dmaengine_pcm_dma_complete relies on
> being called for each interrupt that occures. This function is the
> callback which is called from the mxs-dma driver in mxs_dma_tasklet.
> This can cause wrong position counters and can lead to a wrong DMA
> buffer offset. In this situation the DMA engine and pcm lib may write
> and read from the same buffer segment.

I've actually covered this before.  DMAengine drivers (or infact the
entire system) makes no guarantees how many callbacks will happen for
a cyclic DMA.  Think about what happens if you lose an interrupt because
of USB taking a very long time to service your mouse (yes, that really
happens.)

You will notice that the soc dmaengine layer has two pcm ops, one for
implementations with residue reporting, which can cope with missed
interrupts, and another for those which provide no residue.  I strongly
recommend that you ensure that your DMAengine driver correctly reports
the residue, and use the soc dmaengine driver in a mode which uses that
rather than implementing these fragile schemes.
