From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2011 13:25:16 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <alpine.LFD.2.00.1106201814490.2142@xanadu.home>
References: <alpine.LFD.2.00.1106201306210.2142@xanadu.home>
	<201106202323.49513.arnd@arndb.de>
	<alpine.LFD.2.00.1106201814490.2142@xanadu.home>
Message-ID: <201106211325.16777.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 June 2011, Nicolas Pitre wrote:
> On Mon, 20 Jun 2011, Arnd Bergmann wrote:

> This example is flawed. The DMA API documentation already forbids DMA to 
> the stack because of cache line sharing issues.  If you declare your 
> buffer outside of the function body, the compiler can't optimize away 
> the buffer store anymore, and this example works as expected without any 
> memory clobber.

Ok, another example, even simpler:

int f(int *dma_buf, volatile int *mmio_reg)
{
        (void) *mmio_reg; /* wait for DMA to complete */
        return *dma_buf;
}


gcc-4.4, 4.5 and 4.6 all turn this into:

        ldr     r0, [r0, #0]
        ldr     r3, [r1, #0]
        bx      lr

which means that the dma_buf variable is dereferenced before the
volatile mmio_reg variable, which opens up a race: An interrupt may have
signalled us that a DMA is in progress, so we read a MMIO register from
the device (this is guaranteed to flush the DMA on PCI and similar buses).
If we read the dma_buf before we read the mmio register, the data we get
back may be stale.

Adding a barrier() between the two turns the assembly into the expected

        ldr     r3, [r1, #0]
        ldr     r0, [r0, #0]
        bx      lr


	Arnd
