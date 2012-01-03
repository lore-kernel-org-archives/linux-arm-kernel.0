From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 17:25:04 +0000
Subject: DMA: PL330: support for multiple irqs?
In-Reply-To: <4F03372A.6050809@gmail.com>
References: <4F03372A.6050809@gmail.com>
Message-ID: <20120103172504.GC2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 06:13:14PM +0100, dirac3000 wrote:
> I have noticed the current PL330 driver does not provide any support for
> multiples interrupts, even if the controller allows such implementation
> (e.g.: one interrupt line for channel).
> 
> So far the driver takes the first element of the IRQ field in the
> amba_device structure and makes a request on that IRQ, but I am working
> on a PL330 with 7 different IRQ lines (6 for events + 1 for irq_abort).

So, you seem to have the first SoC which uses this silly 'lets not use
the common interrupt' sillyness.

> A possibility would be to change the driver to loop over the
> amba_device->irq array, but this is limited to max 2 IRQs, and I don't
> understand this limitation.

That's because no one before has used the separate IRQ lines.  To do
so just needlessly increases the complexity of the drivers.

It's probably just as easy to arrange your platform code to treat all
the physical interrupts for the device as one logical interrupt and be
done with it.
