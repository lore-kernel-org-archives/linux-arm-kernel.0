From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 21:01:33 +0200
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <3697657.tZFV7pR81Q@flatron>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
Message-ID: <201306192101.34102.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 18:40:47 Mark Brown wrote:
> > On Sun, Jun 16, 2013 at 10:54:07PM +0200, Tomasz Figa wrote:
> > > One of the biggest roadblocks on the way of S3C64xx to DeviceTree
> > > support is its DMA driver, which is completely platform-specific and
> > > provides private API (s3c-dma), not even saying that its design is
> > > completely against multiplatform-awareness.
> > 
> > I tried to test this on my s3c64xx based system but it gave me a kernel
> > that didn't boot far enough to give console output (there's some early
> > init stuff that uses SPI...).  That said, I needed:
> > 
> > diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> > index 210a893..0f49707 100644
> > --- a/drivers/dma/amba-pl08x.c
> > +++ b/drivers/dma/amba-pl08x.c
> > @@ -313,7 +313,7 @@ static int pl08x_request_mux(struct pl08x_dma_chan
> > *plchan) int ret;
> > 
> >       if (plchan->mux_use++ == 0 && pd->get_signal) {
> > -             ret = pd->get_signal(plchan->cd);
> > +             ret = (pd->get_signal)(plchan->cd);
> 
> Hmm, that's strange. The former is a completely valid piece of code...

get_signal is a macro defined in include/linux/signal.h. If that header
gets included, neither of the two is valid.

	Arnd
