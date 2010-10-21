From: colin.tuckley@arm.com (Colin Tuckley)
Date: Thu, 21 Oct 2010 11:03:51 +0100
Subject: [PATCH 1/6] Realview PCIX support - add main support module code
In-Reply-To: <201010202316.33540.arnd@arndb.de>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<20101020130253.22199.48589.stgit@e102602-lin.cambridge.arm.com>
	<201010202316.33540.arnd@arndb.de>
Message-ID: <000001cb7107$43712770$ca537650$@tuckley@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 20 October 2010 22:17

First, I need to point out that this code and the patches are quite old.
They have been used internally since before 2.6.33 and I then forward ported
them for submission. I don't have a lot of time to do a proper
re-validation.

> How about merging this patch with into the last one? No point
> adding code that doesn't even get seen by the compiler.

The idea was to keep the series in logical chunks and since this was already
quite large I kept it separate.

> ptrace.h?

Oops, a left over from some debugging I suspect - removed.

> > +/* PCI-X Configuration registers */
> > +#define PCI_VENID			0x00
> > +#define PCI_DEVID			0x02
> > +#define PCI_COMMAND			0x04
> > ...
> 
> These don't belong here -- just use the common definitions
> from pci_regs.h. The extended config registers starting at 0x40
> are obviously fine here.

Removed, except for the ones that use names that match the chip
documentation.

> How about a temporary
> 	void __iomem *base = PCIX_UNIT_BASE;
> as a shortcut so you don't have to write PCIX_UNIT_BASE every time.

I believe it's clearer the way it is.

> > +#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> > +	/* 512MB of DMA capable RAM is available - mapped at 0x70000000
> > +	 * Note :- 0x70000000 is *not* on a 512MB boundary so it
> > +	 * must be mapped in two parts */
> > +	/* Window#0 256MB and enable */
> > +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK0);
> > +	/* Window#1 256MB and enable */
> > +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK1);
> > +
> > +	/* Window base address setting */
> > +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> > +	writel(0x70000004, PCIX_UNIT_BASE + PCI_PTBADDR0L);
> > +	/* Memory Base Address[63:32] */
> > +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR0M);
> > +
> > +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> > +	writel(0x80000004, PCIX_UNIT_BASE + PCI_PTBADDR1L);
> > +	/* Memory Base Address[63:32] */
> > +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR1M);
> 
> If you write PHYS_OFFSET into PCI_PTBADDR1L, you don't need
> the #ifdef, and the code gets reusable on platforms that have
> yet another phys offset.

That wouldn't allow for the differences in size of DMA capable RAM. I know
it could be computed but I think this makes it clearer.

> > +	realview_pb_pcix_sync();
> > +	udelay(1500); /* Allow hardware to settle */
> 
> You should not need to delay for that long. What is the problem
> here? If the sync operation actually does a sync, you should not
> need to wait again, right?

This is copied from the NEC docs and example code. It isn't really a sync
(as in waiting for something) it's more a device to get the hardware into a
known state. It works and I don't have time to do the testing required if I
start changing things like that which could be critical.

> > +void realview_pb_pcix_set_attr(unsigned int tag)
> > +{
> > +	/* Get Device and Funcion number */
> > +	u32 data = readl(PCIX_UNIT_BASE + PCI_PCIXSTAT) & 0x0ff;
> > +	/* attribute set */
> > +	writel(tag | (data << 8), PCIX_UNIT_BASE + PCI_CFGATTR);
> > +}
> 
> Should this function be static? It appears to be only used in this
> file.
> > +int realview_pb_pcix_set_config(u32 bus, u32 dev, u32 func, int
> offset)

True, I thought I'd found all of those type of cases - fixed.

> > +{
> > +	u32 mode;
> > +	u32 config_addr;
> > +
> > +	writel(0x000307F7, PCIX_UNIT_BASE + PCI_PERRSTAT); /* clear error
> bit */
> > +	writew(0xfb30, PCIX_UNIT_BASE + PCI_STATUS);	   /* error bit
> clear */
> 
> I would guess that you need locking here, two drivers might
> simultaneously be
> accessing config space on different CPUs, or you might have kernel
> preemption
> enabled and get preempted between the register accesses.

Hmm... you could be correct, however we have done a lot of testing on SMP
systems with no problems. I'll have a chat with Catalin about this.

> Why are these functions called realview_pb_pci_* while the others are
> called
> realview_pb_pcix_*? I would expect that the pci name refers to the
> Xilinx
> pci bus while the pcix name is the NEC pci-x.

The original author probably cloned the pci code as a starting point. I've
fixed them.

> > +static int __init pci_realview_pb_setup(int nr, struct pci_sys_data
> *sys)
> > +{
> > +	if (machine_is_realview_pb11mp())
> > +		irq_gic_start = IRQ_PB11MP_GIC_START;
> > +	else
> > +		irq_gic_start = IRQ_PBA8_GIC_START;
> 
> Can you remove the board specific tests from the common file? Just pass
> the
> interrupt number through an init function that can get called by the
> board file, which will make reuse much easier if other platforms use
> the same hardware.

There will not be any more mach-realview board designs, certainly none that
use this root complex.

> > +	sys->io_offset = REALVIEW_PB_PCI_IO_BASE;
> 
> Why do you need to set io_offset?

I haven't investigated this. Is it something that is really wrong? Or just a
different way of doing things?

> Really no swizzling? That is very unusual, almost everyone needs to set
> pci_common_swizzle here to make bridges work.

No generic swizzling, it's done during the bus scan because it's very
non-standard due to the hardware design.

> > +static int __init realview_pb_pci_init(void)
> > +{
> > +	if (machine_is_realview_pb11mp() ||
> > +	    machine_is_realview_pba8() || machine_is_realview_pbx())
> > +		pci_common_init(&realview_pb_pci);
> > +	return 0;
> > +}
> > +
> > +subsys_initcall(realview_pb_pci_init);
> 
> Why not call this from the board file?

Don't know, as I said before I'm not the original author and we changed as
little as possible while getting it to work.

Regards,

Colin
