From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 6 Dec 2010 09:33:06 +0100
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <20101124080214.GU4693@pengutronix.de>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
Message-ID: <20101206083306.GI10693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alberto,

On Wed, Nov 24, 2010 at 09:02:14AM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Nov 23, 2010 at 03:17:13PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 23, 2010 at 03:08:49PM +0100, Alberto Panizzo wrote:
> > > Hi Uwe,
> > > On mar, 2010-11-23 at 11:26 +0100, Uwe Kleine-K?nig wrote:
> > > > Hello Russell,
> > > > 
> > > > On Tue, Nov 23, 2010 at 10:12:11AM +0000, Russell King - ARM Linux wrote:
> > > > > On Tue, Nov 23, 2010 at 10:43:02AM +0100, Uwe Kleine-K?nig wrote:
> > > > > > There is no need to memzero the buffer because dma_alloc_coherent zeros
> > > > > > the memory for us.
> > > > > > 
> > > > > > This fixes:
> > > > > > 
> > > > > > 	BUG: Your driver calls ioremap() on system memory.  This leads
> > > > > > 	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
> > > > > > 	<4>will fail in the next kernel release.  Please fix your driver.
> > > > > > 
> > > > > > Tested-by: Michael Grzeschik <mgr@pengutronix.de>
> > > > > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > > > ---
> > > > > > Hello,
> > > > > > 
> > > > > > it seems to work this way, still I'd like to have some feedback if this
> > > > > > is done right.  Russell?
> > > > > 
> > > > > Yes and probably no.  Yes, it's architecturally correct because the memory
> > > > > will be mapped only once, thereby avoiding the aliasing issue.
> > > > > 
> > > > > Probably no, because the memory is mapped strongly as device memory by
> > > > > ioremap.  ISTR whether memory remains accessible when mapped as a device
> > > > > is not something covered by the architecture, but I guess is more to do
> > > > > with how the interconnect on the SoC is setup.
> > > > > 
> > > > > In other words, we probably have gremlins lurking in
> > > > > dma_declare_coherent_memory() which could bite us at a later date.
> > > > That is, the patch is OK as such, right?
> > > > 
> > > > Best regards
> > > > Uwe
> > > > 
> > > 
> > > I'm trying to achieve the camera support for the i.MX31 3-Stack board.
> > > The camera driver is in an early stage and results are not as expected
> > > (I have to solve some timing issues). 
> > > Adding the dma reservation code as you do in this patch results in 
> > > system freeze when the capture chain is activated..
> > Hmm, system freeze as is Sysrq doesn't work anymore?
> > 
> > Sysrq-L comes to mind, or CONFIG_DETECT_HUNG_TASK=y together with the
> > various lock debug options!?
> Anything new from your side?  I wonder if this is only a problem in your
> driver.  Can I take a look at your driver?
ping

I'd like to have this patch in Sascha's for-.38 patch.  Sascha, what do
you think?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
