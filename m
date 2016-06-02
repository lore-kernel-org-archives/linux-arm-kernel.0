From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 11:46:04 +0200
Subject: [PATCH 2/3] PCI: host: new PCI host controller driver for Marvell
 Armada 3700
In-Reply-To: <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <3112077.0RPfokLCAs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 11:09:44 AM CEST Thomas Petazzoni wrote:

> +static bool advk_pcie_link_up(struct advk_pcie *pcie)
> +{
> +	int timeout;
> +	u32 ltssm_state;
> +	u32 val;
> +
> +	timeout = PCIE_LINKUP_TIMEOUT;
> +	do {
> +		val = advk_readl(pcie, CFG_REG);
> +		ltssm_state = (val >> LTSSM_SHIFT) & LTSSM_MASK;
> +		timeout--;
> +	/* Use ltssm < LTSSM_L0 instead of ltssm != LTSSM_L0 */
> +	} while (ltssm_state < LTSSM_L0 && timeout > 0);
> +
> +	return (timeout > 0);
> +}

Maybe wait for some amount of time to have passed here (using 
time_before(jiffies, end)) rather than a number of retries,
for robustness and determinism.

> +	/* Point PCIe unit MBUS decode windows to DRAM space. */
> +	for (i = 0; i < 8; i++)
> +		advk_pcie_set_ob_win(pcie, i, 0, 0, 0, 0, 0, 0, 0);

Is this actually mbus based, or is the comment copied from some
other Marvell driver?

> +static int advk_pcie_setup_msi_irq(struct msi_controller *chip,
> +				   struct pci_dev *pdev,
> +				   struct msi_desc *desc)
> +{
> +	struct advk_pcie *pcie = pdev->bus->sysdata;
> +	struct msi_msg msg;
> +	int virq, hwirq;
> +	phys_addr_t msi_msg_phys;
> +
> +	/* We support MSI, but not MSI-X */
> +	if (desc->msi_attrib.is_msix)
> +		return -EINVAL;
> +
> +	hwirq = advk_pcie_alloc_msi(pcie);
> +	if (hwirq < 0)
> +		return hwirq;
> +
> +	virq = irq_create_mapping(pcie->msi_domain, hwirq);
> +	if (!virq) {
> +		advk_pcie_free_msi(pcie, hwirq);
> +		return -EINVAL;
> +	}

What is the version of the GIC in the Armada 3700? If you have GICv3
or GICv2m, could you use that instead of the built-in MSI logic?

We typically handle this using the msi-map or msi-parent properties
pointing to either the gic or the PCI host, depending on which one
you want to use, but either of them should work, and the GIC should
be more efficient because you can distribute the interrupts of the
PCI devices over all CPUs by workload, rather than having to
multiplex all MSI through a single GIC interrupt.

	Arnd
