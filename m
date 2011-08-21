From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 09:51:08 +0100
Subject: [PATCH 07/15] ARM: EXYNOS4: Use generic DMA PL330 driver
In-Reply-To: <CAJuYYwT0R+VXWvWuV6KK=m_knoxBnBf=GLVimPoe002mcvqqeA@mail.gmail.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<1311744697-10264-8-git-send-email-boojin.kim@samsung.com>
	<CAJuYYwT0R+VXWvWuV6KK=m_knoxBnBf=GLVimPoe002mcvqqeA@mail.gmail.com>
Message-ID: <20110821085108.GE12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 07:45:48PM +0530, Thomas Abraham wrote:
> > +struct dma_pl330_peri pdma0_peri[28] = {
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .peri_id = (u8)DMACH_PCM0_RX,
> > + ? ? ? ? ? ? ? .rqtype = DEVTOMEM,
> > + ? ? ? }, {
> 
> The client driver specifies the direction of the transfer
> (DMA_TO_DEVICE or DMA_FROM_DEVICE) when requesting for a dma channel.
> So, is the rqtype parameter required in the platform data for the dma
> driver?

That was done initially too with PL080, which has 8 uncommitted DMA
channels.  Peripheral drivers still had to pass the DMA direction.  So
it turned out to be entirely redundant information, so it got killed off,
along with other channel specific configuration which drivers should've
been doing via the slave configuration callback.

Passing lots of information via platform data which should come via
other routes makes dmaengine users fragile - you can't tell whether
they are passing the correct and full information necessary to work with
other dmaengine drivers.  So, the DMA engine platform data should only
contain the absolute _minimum_ of information.
