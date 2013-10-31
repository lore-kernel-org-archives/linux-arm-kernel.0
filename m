From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 09:08:26 +0000
Subject: [PATCH] dmaengine: imx-dma: fix format warnings
In-Reply-To: <20131031082531.GK23549@S2101-09.ap.freescale.net>
References: <E1VbgJK-0006iu-9m@rmk-PC.arm.linux.org.uk>
 <20131031082531.GK23549@S2101-09.ap.freescale.net>
Message-ID: <20131031090826.GV16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 04:25:35PM +0800, Shawn Guo wrote:
> On Thu, Oct 31, 2013 at 12:40:30AM +0000, Russell King wrote:
> > drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:575:3: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:589:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:599:4: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:929:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t'
> > drivers/dma/imx-dma.c:959:2: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t'
> > 
> 
> We should probably mention the compiler version that we're seeing these
> warnings with.  It seems that my gcc 4.6.3 does not complain about them.

This will be compiler independent.  You can't pass 64-bit quantities to
printf with "%x".  The reason you're not seeing them is because your
normal builds will have dma_addr_t as 32-bit, but if LPAE is enabled
(which can happen with randconfig), dma_addr_t can also be 64-bit.

This is why Olof's build results regularly pop this up.

As I will be expanding my builds to include things like LPAE and KVM,
I will start seeing these warnings as well.
