From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Oct 2010 15:02:48 +0100
Subject: [PATCH 1/6] Realview PCIX support - add main support module code
In-Reply-To: <20101020130253.22199.48589.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
	<20101020130253.22199.48589.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101028140248.GD3122@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 02:02:54PM +0100, Colin Tuckley wrote:
> +#include <mach/platform.h>
> +#include <asm/io.h>

linux/io.h

> +static void pcie_fix_sizes(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +	int rrq;
> +	int max_rrq = 4096;
> +
> +	/* Set the max read request size for all devices to the
> +	 * smallest in the tree. So far, the only device we've seen
> +	 * that fails without this is the Marvell Yukon 88E8053 but
> +	 * this may fix other devices too.
> +	 */
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
> +		rrq = pcie_get_readrq(pdev);
> +		if (rrq > 0 && rrq < max_rrq)
> +			max_rrq = rrq;
> +	}
> +
> +	pdev = NULL;	/* reset scan */
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
> +		rrq = pcie_get_readrq(pdev);
> +		printk(KERN_DEBUG "%s: %02x:%02x %04x/%04x : RRQSZ %d -> %d\n",
> +				__func__, pdev->bus->number, pdev->devfn,
> +				pdev->vendor, pdev->device, rrq, max_rrq);
> +		pcie_set_readrq(pdev, max_rrq);
> +	}
> +}
> +
> +static int __init realview_pcie_fixups(void)
> +{
> +	pcie_fix_sizes();
> +	return 0;
> +}
> +late_initcall(realview_pcie_fixups);

Shouldn't this be done as a PCI quirk rather than walking the entire list
of PCI devices at some point after drivers have potentially initialised
and bound to these devices?
