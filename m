From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Nov 2010 11:26:32 +0100
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <20101123101210.GA18170@n2100.arm.linux.org.uk>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
Message-ID: <20101123102632.GM4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Nov 23, 2010 at 10:12:11AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 23, 2010 at 10:43:02AM +0100, Uwe Kleine-K?nig wrote:
> > There is no need to memzero the buffer because dma_alloc_coherent zeros
> > the memory for us.
> > 
> > This fixes:
> > 
> > 	BUG: Your driver calls ioremap() on system memory.  This leads
> > 	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
> > 	<4>will fail in the next kernel release.  Please fix your driver.
> > 
> > Tested-by: Michael Grzeschik <mgr@pengutronix.de>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > it seems to work this way, still I'd like to have some feedback if this
> > is done right.  Russell?
> 
> Yes and probably no.  Yes, it's architecturally correct because the memory
> will be mapped only once, thereby avoiding the aliasing issue.
> 
> Probably no, because the memory is mapped strongly as device memory by
> ioremap.  ISTR whether memory remains accessible when mapped as a device
> is not something covered by the architecture, but I guess is more to do
> with how the interconnect on the SoC is setup.
> 
> In other words, we probably have gremlins lurking in
> dma_declare_coherent_memory() which could bite us at a later date.
That is, the patch is OK as such, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
