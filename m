From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Oct 2011 00:19:37 +0100
Subject: [PATCH 4/5 v4] Realview PCIX support - add main support module
	code
In-Reply-To: <20111007142834.19554.69753.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
	<20111007142834.19554.69753.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007231937.GC25689@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 03:28:55PM +0100, Colin Tuckley wrote:
> +	/* Upstream port of 8518 device */
> +	if (unlikely(dev->device == 0x8518 && dev->bus->primary == 0)) {
> +		BUG_ON(pcie_bridge);	/* Can't be already assigned */
> +		pcie_bridge = dev;
> +	}

I thought one of my previous review points on this was that it was
completely unsafe to match only on dev->device, rather than on both
dev->device and dev->vendor.  Device IDs are allocated by individual
vendors and are meaningless without also checking the vendor ID.

> +
> +	if (pcie_bridge) {
> +		if (dev->bus->primary >= pcie_bridge->bus->secondary &&
> +		    dev->bus->primary <= pcie_bridge->bus->subordinate) {
> +			/*
> +			 * The problem is that in PCIE in different slots a device
> +			 * could still get the same slot/pin/devslot triplet. Therefore
> +			 * we check the slot/pin/devslot triplet of an underlying PCIE port.
> +			 *
> +			 * pin	slot:	0	1	2	3	4
> +			 * #A(1)	56	55	54	57	56
> +			 * #B(2)	57	56	55	54	57
> +			 * #C(3)	54	57	56	55	54
> +			 * #D(4)	55	54	57	56	55
> +			 */
> +
> +			if (dev->bus->self) {
> +				/* We do have a bus above us
> +				 * Device is right behind a PCIE hub port, and its not a PCIE
> +				 * hub port itself. */
> +				if (dev->bus->self->device == 0x8518 &&
> +				    dev->device != 0x8518) {
> +					/* Depend on devslot of 8518 port we're connected to */
> +					devslot = PCI_SLOT(dev->bus->self->devfn);
> +					/* These are the two cases for PCIE ports on PB boards.
> +					 * Any other downstream bus topology (e.g. with further
> +					 * PCIE bridges) does not scramble, and get the same
> +					 * irq number as the upstream bus. */
> +					irq = irq_gic_start + 54 + ((devslot & 3) + (pin - 1)) % 4;
> +				} else if ((dev->bus->self->class & 0xff0000) == 0x060000 &&
> +					   (dev->class & 0xff0000) != 0x060000) {
> +					/* It's a device behind a bridge that isn't an 8518 */
> +					irq = irq_gic_start + 54 + ((devslot & 3) + pin +
> +					      PCI_SLOT(dev->bus->self->bus->self->devfn) - 1) % 4;
> +				} else {
> +					/* It's another bridge */
> +					irq = dev->bus->self->irq;
> +				}
> +			} else
> +				irq = 0;
> +
> +			printk(KERN_INFO "PCI Express irq mapping: device: 0x%x, slot %d, pin %d, devslot %d, irq: %d\n",
> +			       dev->device, slot, pin, devslot, irq);
> +
> +			return irq;
> +		}
> +	}
> +
> +	/*
> +	 * pin  slot:	0	1	2	3
> +	 * #A		53	52	51	50
> +	 * #B		50	53	52	51
> +	 * #C		51	50	53	52
> +	 * #D		52	51	50	53
> +	 */
> +
> +	irq = irq_gic_start + 50 + (((pin - 1) + 3 - (devslot & 3)) & 3);
> +
> +	printk(KERN_INFO "PCI map irq: slot %d, pin %d, devslot %d, irq: %d\n",
> +	       slot, pin, devslot, irq);
> +
> +	return irq;
> +
> +}
> +
> +static struct hw_pci realview_pb_pcix __initdata = {
> +	.swizzle		= NULL,

And I thought we'd got to the point where we had a swizzle here.

This patch looks like a backwards step - and would mean that any card
plugged in which has a PCI-to-PCI bridge on it will not work.
