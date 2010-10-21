From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Oct 2010 14:44:08 +0200
Subject: [PATCH 1/6] Realview PCIX support - add main support module code
In-Reply-To: <000001cb7107$43712770$ca537650$@tuckley@arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<201010202316.33540.arnd@arndb.de>
	<000001cb7107$43712770$ca537650$@tuckley@arm.com>
Message-ID: <201010211444.08555.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 October 2010, Colin Tuckley wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: 20 October 2010 22:17
> 
> First, I need to point out that this code and the patches are quite old.
> They have been used internally since before 2.6.33 and I then forward ported
> them for submission. 

Yes, I could see that from the code ;-)

> > How about merging this patch with into the last one? No point
> > adding code that doesn't even get seen by the compiler.
> 
> The idea was to keep the series in logical chunks and since this was already
> quite large I kept it separate.

Logical chunks are good, but the last one was not really logical.
If you really want smaller patches, you can split the initialization
from the run-time (config space, interrupts, ...) handling. I don't think
it's too big though, new drivers just tend be be much bigger than incremental
patches on existing code.

> > How about a temporary
> > 	void __iomem *base = PCIX_UNIT_BASE;
> > as a shortcut so you don't have to write PCIX_UNIT_BASE every time.
> 
> I believe it's clearer the way it is.

Ok.
 
> > > +#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> > > +	/* 512MB of DMA capable RAM is available - mapped at 0x70000000
> > > +	 * Note :- 0x70000000 is *not* on a 512MB boundary so it
> > > +	 * must be mapped in two parts */
> > > +	/* Window#0 256MB and enable */
> > > +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK0);
> > > +	/* Window#1 256MB and enable */
> > > +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK1);
> > > +
> > > +	/* Window base address setting */
> > > +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> > > +	writel(0x70000004, PCIX_UNIT_BASE + PCI_PTBADDR0L);
> > > +	/* Memory Base Address[63:32] */
> > > +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR0M);
> > > +
> > > +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> > > +	writel(0x80000004, PCIX_UNIT_BASE + PCI_PTBADDR1L);
> > > +	/* Memory Base Address[63:32] */
> > > +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR1M);
> > 
> > If you write PHYS_OFFSET into PCI_PTBADDR1L, you don't need
> > the #ifdef, and the code gets reusable on platforms that have
> > yet another phys offset.
> 
> That wouldn't allow for the differences in size of DMA capable RAM. I know
> it could be computed but I think this makes it clearer.

It certainly didn't make it clear from my perspective -- I didn't
notice that the sizes are different here ;-).

I'm hoping we can eliminate the CONFIG_REALVIEW_HIGH_PHYS_OFFSET
option at some point, and turn PHYS_OFFSET into a run-time option.
If you calculate the values, there's one less place to fix then.

> > > +	realview_pb_pcix_sync();
> > > +	udelay(1500); /* Allow hardware to settle */
> > 
> > You should not need to delay for that long. What is the problem
> > here? If the sync operation actually does a sync, you should not
> > need to wait again, right?
> 
> This is copied from the NEC docs and example code. It isn't really a sync
> (as in waiting for something) it's more a device to get the hardware into a
> known state. It works and I don't have time to do the testing required if I
> start changing things like that which could be critical.

Then just add this explanation to the comment and turn it into an msleep().

> > > +{
> > > +	u32 mode;
> > > +	u32 config_addr;
> > > +
> > > +	writel(0x000307F7, PCIX_UNIT_BASE + PCI_PERRSTAT); /* clear error
> > bit */
> > > +	writew(0xfb30, PCIX_UNIT_BASE + PCI_STATUS);	   /* error bit
> > clear */
> > 
> > I would guess that you need locking here, two drivers might
> > simultaneously be
> > accessing config space on different CPUs, or you might have kernel
> > preemption
> > enabled and get preempted between the register accesses.
> 
> Hmm... you could be correct, however we have done a lot of testing on SMP
> systems with no problems. I'll have a chat with Catalin about this.

PCI config spaces are extremely rare once the system is booted up.
I'm not surprised that it works in practice, but that doesn't make it
correct ;-)

> > > +static int __init pci_realview_pb_setup(int nr, struct pci_sys_data
> > *sys)
> > > +{
> > > +	if (machine_is_realview_pb11mp())
> > > +		irq_gic_start = IRQ_PB11MP_GIC_START;
> > > +	else
> > > +		irq_gic_start = IRQ_PBA8_GIC_START;
> > 
> > Can you remove the board specific tests from the common file? Just pass
> > the
> > interrupt number through an init function that can get called by the
> > board file, which will make reuse much easier if other platforms use
> > the same hardware.
> 
> There will not be any more mach-realview board designs, certainly none that
> use this root complex.

Yes, but:

1. There might be other companies that have licensed the same macro for
their SoCs.

2. I was discussing with Peter Maydell to implement this in qemu as well,
so it could be used on all ARM platforms. Ideally you should be able
to specify the settings using a device tree once that gets supported, so
you can have a PCI bus in an emulated platform that normally doesn't have
one. Don't worry about the device tree stuff now, but it would really be
helpful to allow configuring this from outside (same as the phys offset.

3. I hope we can eventually merge the realview and versatile express
platforms so it becomes possible to build a generic kernel for them
all.

> > > +	sys->io_offset = REALVIEW_PB_PCI_IO_BASE;
> > 
> > Why do you need to set io_offset?
> 
> I haven't investigated this. Is it something that is really wrong? Or just a
> different way of doing things?

It looks wrong to me, but I haven't figured out what it does exactly.
For the xilinx PCI, I had to disable it, IIRC.

> > Really no swizzling? That is very unusual, almost everyone needs to set
> > pci_common_swizzle here to make bridges work.
> 
> No generic swizzling, it's done during the bus scan because it's very
> non-standard due to the hardware design.

Well, the swizzling is for the devices behind a bridge. I think your code
will break if you have another PCI-X bridge in a PCI-X slot or a PCIe
switch in a PCIe slot.

I think if you use the correct swizzling function, you not only fix
cards with integrated bridges but also greatly simplify the
pci_realview_pb_map_irq function, which can then become something like:

static int __devinit pci_realview_pb_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
/*	   ^^^^^^ note: it needs to be devinit to support hotplug PCIe. */
{
	switch (slot) {
	case REALVIEW_PCIX_TO_PCI_SLOT: /* logical slot that the PCI bridge connects to */
		return REALVIEW_PCIX_INTA + (((pin - 1) + 3 - (slot & 3)) & 3);
	case REALVIEW_PCIX_TO_PCIE_SLOT:/* logical slot that the PCIe bridge connects to */
		return REALVIEW_PCIE_INTA + (((pin - 1) + 3 - (slot & 3)) & 3);
	}
}

	Arnd
