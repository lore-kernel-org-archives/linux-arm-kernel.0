From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Oct 2010 13:05:37 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009114444.GL29673@pengutronix.de>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
	<201010091311.26335.arnd@arndb.de>
	<20101009114444.GL29673@pengutronix.de>
Message-ID: <20101009120537.GD20975@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 01:44:44PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sat, Oct 09, 2010 at 01:11:26PM +0200, Arnd Bergmann wrote:
> > When you say that "many drivers broken", can you list the ones you know
> > about? It would probably help resolve this the right way.
> I know about the camera stuff on mx3/pcm037.  See
> pcm037_camera_alloc_dma in arch/arm/mach-mx3/mach-pcm037.c.

dma_alloc_coherent, stuffing that into dma_declare_coherent_memory,
which then ioremaps the memory obtained from dma_alloc_coherent, and
is then handed out via a subsequent dma_alloc_coherent call.

So what we end up with is the kernel mapping (normal memory, cacheable),
the DMA coherent mapping (normal memory, non-cacheable) but with the
same shared-ness as the kernel mapping, and finally the ioremap mapping
(device, shared).  So three aliasing mappings all with different
attributes.
