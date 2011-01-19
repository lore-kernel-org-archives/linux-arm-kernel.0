From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 13:00:20 +0000
Subject: [PATCH 2/6] Realview PCIX support - add main support module code
In-Reply-To: <20101222140404.29725.35846.stgit@e102602-lin.cambridge.arm.com>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
	<20101222140404.29725.35846.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20110119130020.GD31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I thought someone picked up on the swizzling (or lack of it) but maybe
not.

On Wed, Dec 22, 2010 at 02:04:04PM +0000, Colin Tuckley wrote:
> +/* Maps scrambled IRQ pins to IRQ lines. Scrambling depends on device slot. */
> +static int __init pci_realview_pb_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	int irq;
> +	int devslot = PCI_SLOT(dev->devfn);
> +
> +	/* Upstream port of 8518 device */
> +	if (unlikely(dev->device == 0x8518 && dev->bus->primary == 0)) {
> +		BUG_ON(pcie_bridge);	/* Can't be already assigned */
> +		pcie_bridge = dev;
> +	}
> +
> +	if (pcie_bridge) {
> +		if (dev->bus->primary >= pcie_bridge->bus->secondary &&
> +		    dev->bus->primary <= pcie_bridge->bus->subordinate) {
> +			/*
> +			 * The problem is that in PCIE in different slots a device
> +			 * could still get the same slot/pin/devslot triplet. Therefore
> +			 * we check the slot/pin/devslot triplet of an underlying PCIE port.
> +			 *
> +			 * slot   pin	 irq
> +			 * 0	  #A(1)  56
> +			 * 0	  #B(2)  57
> +			 * 0	  #C(3)  54
> +			 * 0	  #D(4)  55
> +			 * 1	  #A(1)  55
> +			 * 1	  #B(2)  56
> +			 * 1	  #C(3)  57
> +			 * 1	  #D(4)  54
> +			 * 2	  1	 54
> +			 * 2	  2	 55
> +			 * 2	  3	 56
> +			 * 2	  4	 57
> +			 * 3	  1	 57
> +			 * 3	  2	 54
> +			 * 3	  3	 55
> +			 * 3	  4	 56
> +			 * 4	  1	 56
> +			 * 4	  2	 57
> +			 * 4	  3	 54
> +			 * 4	  4	 55
> +			 */

Isn't this is the standard PCI IRQ layout - four interrupt lines rotated
one place across each socket?  It's easier to see (and a shorter comment)
to lay it out as it appears on the board:

				slot:   0       1       2       3       4
				pin A   56      55      54      57      56
				pin B   57      56      55      54      57
				pin C   54      57      56      55      54
				pin D   55      54      57      56      55

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

You should not be dealing with bridges behind slots in this code.  That's
what the swizzle function is for, and PCI defines a standard swizzling
method for devices behind bridges, and that algorithm is implemented by
pci_common_swizzle (which should be in the .swizzle initializer.)

If pci_is_root_bus(dev->bus) for your PCIe bridge doesn't return true,
then the standard swizzling will go all the way to the PCI root bridge,
which is probably not what you want.  In that case, you need to
implement your own version of pci_common_swizzle which knows to stop
at the PCIe bridge when it finds it, or the PCI root bridge.

Note that you almost certainly should not be matching the PCIe bridge
by PCI device number alone.  PCI device numbers are not unique - only
when coupled with the vendor number do they become (more or less) unique.

The slot and pin arguments from the swizzle function are then passed into
the map_irq function.  I suggest you keep the normal pin numbering, but
(maybe) define a PCIE_SLOT offset for PCIe slots, which you can then use
to detect whether we want the PCIe IRQ numbers or PCI IRQ numbers.
