From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Oct 2010 23:16:32 +0200
Subject: [PATCH 1/6] Realview PCIX support - add main support module code
In-Reply-To: <20101020130253.22199.48589.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<20101020130253.22199.48589.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <201010202316.33540.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 October 2010 15:02:54 Colin Tuckley wrote:
> This patch adds pcix.c - the main pci sub-system code for
> the RealView boards which have PCI and PCIe interfaces
> via a custom NEC northbridge chip and two bridges.

How about merging this patch with into the last one? No point
adding code that doesn't even get seen by the compiler.

> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/ptrace.h>

ptrace.h?

> +/* PCI-X Configuration registers */
> +#define PCI_VENID			0x00
> +#define PCI_DEVID			0x02
> +#define PCI_COMMAND			0x04
> ... 

These don't belong here -- just use the common definitions
from pci_regs.h. The extended config registers starting at 0x40
are obviously fine here.

> +static void realview_pb_pcix_unit_init(void)
> +{
> +	u32 data = readl(PCIX_UNIT_BASE + PCI_UNITCNT);
> +
> +	if (data & 0x10)
> +		writel(0x00000000, PCIX_UNIT_BASE + PCI_PRST); /* Assert PCI reset */
> +	else {
> +		printk(KERN_ERR "Error: PCI-X unit not in PCI-X mode.\n");
> +		writel(data | 0x80000000, PCIX_UNIT_BASE + PCI_UNITCNT);
> +	}
> +
> +	writew(0x0006, PCIX_UNIT_BASE + PCI_COMMAND); /* Master-Memory enable */
> +	writew(0xfb30, PCIX_UNIT_BASE + PCI_STATUS);  /* Error bit clear */

How about a temporary

	void __iomem *base = PCIX_UNIT_BASE;

as a shortcut so you don't have to write PCIX_UNIT_BASE every time.
> +#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
> +	/* 512MB of DMA capable RAM is available - mapped at 0x70000000
> +	 * Note :- 0x70000000 is *not* on a 512MB boundary so it
> +	 * must be mapped in two parts */
> +	/* Window#0 256MB and enable */
> +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK0);
> +	/* Window#1 256MB and enable */
> +	writel(0x0fff0001, PCIX_UNIT_BASE + PCI_PTMEMMSK1);
> +
> +	/* Window base address setting */
> +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> +	writel(0x70000004, PCIX_UNIT_BASE + PCI_PTBADDR0L);
> +	/* Memory Base Address[63:32] */
> +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR0M);
> +
> +	/* Memory Base Address, Ptrefetch Disable, 64bit */
> +	writel(0x80000004, PCIX_UNIT_BASE + PCI_PTBADDR1L);
> +	/* Memory Base Address[63:32] */
> +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTBADDR1M);

If you write PHYS_OFFSET into PCI_PTBADDR1L, you don't need
the #ifdef, and the code gets reusable on platforms that have
yet another phys offset.

> +	/* OnChipBus Address#0[35:24] */
> +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTMEMSEG0);
> +	/* OnChipBus Address#1[35:24] */
> +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PTMEMSEG1);
> +
> +	/* 66MHz, 64bit device */
> +	writel(0x00010000, PCIX_UNIT_BASE + PCI_PCIXSTAT);
> +	/* Interrupt Mask */
> +	writel(0x00000000, PCIX_UNIT_BASE + PCI_PINTXMASK);
> +	/* Enable PCI error status */
> +	writel(0x000307f7, PCIX_UNIT_BASE + PCI_PERRMASK);
> +	/* Clear PCI error status */
> +	writel(0x000307f7, PCIX_UNIT_BASE + PCI_PERRSTAT);
> +	/* Enable count out */
> +	writel(0x10FFFFFF, PCIX_UNIT_BASE + PCI_CNTOTIMER);
> +
> +	realview_pb_pcix_sync();
> +	udelay(1500); /* Allow hardware to settle */

You should not need to delay for that long. What is the problem
here? If the sync operation actually does a sync, you should not
need to wait again, right?

Also, you don't seem to be in atomic context, so you can just
use msleep(2) instead.

> +void realview_pb_pcix_set_attr(unsigned int tag)
> +{
> +	/* Get Device and Funcion number */
> +	u32 data = readl(PCIX_UNIT_BASE + PCI_PCIXSTAT) & 0x0ff;
> +	/* attribute set */
> +	writel(tag | (data << 8), PCIX_UNIT_BASE + PCI_CFGATTR);
> +}

Should this function be static? It appears to be only used in this
file.

> +int realview_pb_pcix_set_config(u32 bus, u32 dev, u32 func, int offset)

Same here.

> +{
> +	u32 mode;
> +	u32 config_addr;
> +
> +	writel(0x000307F7, PCIX_UNIT_BASE + PCI_PERRSTAT); /* clear error bit */
> +	writew(0xfb30, PCIX_UNIT_BASE + PCI_STATUS);	   /* error bit clear */

I would guess that you need locking here, two drivers might simultaneously be
accessing config space on different CPUs, or you might have kernel preemption
enabled and get preempted between the register accesses.

> +int realview_pb_pci_read_config(struct pci_bus *pbus, u32 devfn,
> +				     int offset, int size, u32 *data)
> +{
> +	u32 bus = pbus->number;
> +	u32 slot = PCI_SLOT(devfn);
> +	u32 function = PCI_FUNC(devfn);

Here too.

Why are these functions called realview_pb_pci_* while the others are called
realview_pb_pcix_*? I would expect that the pci name refers to the Xilinx
pci bus while the pcix name is the NEC pci-x.

> +static int __init pci_realview_pb_setup(int nr, struct pci_sys_data *sys)
> +{
> +	if (machine_is_realview_pb11mp())
> +		irq_gic_start = IRQ_PB11MP_GIC_START;
> +	else
> +		irq_gic_start = IRQ_PBA8_GIC_START;

Can you remove the board specific tests from the common file? Just pass the
interrupt number through an init function that can get called by the
board file, which will make reuse much easier if other platforms use the
same hardware.

> +	sys->io_offset = REALVIEW_PB_PCI_IO_BASE;

Why do you need to set io_offset?

> +static void __init pci_realview_pb_preinit(void)
> +{
> +	u32 data = readl(__io_address(REALVIEW_SYS_PCI_STAT));
> +	data &= ~0x00000100; /* Clear the Clock Control bit */
> +	writel(data, __io_address(REALVIEW_SYS_PCI_STAT));
> +	udelay(1500); /* Allow hardware to settle */
> +}

msleep

> +static struct hw_pci realview_pb_pci __initdata = {
> +	.swizzle		= NULL,

Really no swizzling? That is very unusual, almost everyone needs to set 
pci_common_swizzle here to make bridges work.

> +static int __init realview_pb_pci_init(void)
> +{
> +	if (machine_is_realview_pb11mp() ||
> +	    machine_is_realview_pba8() || machine_is_realview_pbx())
> +		pci_common_init(&realview_pb_pci);
> +	return 0;
> +}
> +
> +subsys_initcall(realview_pb_pci_init);

Why not call this from the board file?

	Arnd
