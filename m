From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 May 2012 09:02:16 +0100
Subject: [RFC 03/34] dmaengine: virt-dma: add support for cyclic DMA
 periodic callbacks
In-Reply-To: <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIqg-0006yu-5Z@rmk-PC.arm.linux.org.uk>
 <CACRpkdba_aFbyBt9hkYqBR=oY6fq0KHchjGcuS_NhbOMbE0Owg@mail.gmail.com>
Message-ID: <20120530080216.GH12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 03:52:53PM +0800, Linus Walleij wrote:
> On Tue, May 29, 2012 at 5:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Add support for cyclic DMA's periodic callbacks. ?Drivers are expected
> > to call vchan_cyclic_callback() when a period has completed, which will
> > schedule the tasklet to make the callback into the driver.
> >
> > As callbacks are made from tasklet context, it is important to realise
> > that we don't guarantee a callback for each completed period, but for
> > N completed periods where N may be greater than one.
> 
> This last thing was something we have to fix right?
> Like for each driver to keep a counter of completed periods
> and call the handler repeatedly if N > 1.

No, I don't think we should do that - ALSA doesn't require it, and ALSA
is about the only user of this.  As I've said, DMA engine drivers should
implement a correct tx_status function, which returns the remaining bytes
to be transferred to the end of the buffer so it's possible to find out
how many periods have completed when the callback is called.
