From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 29 Sep 2014 14:11:44 -0600
Subject: [PATCH v4] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1411888107-27640-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20140929201144.GB15712@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28, 2014 at 03:08:27PM +0800, Minghuan Lian wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
> ...

This looks pretty good to me.  I have a couple trivial comments below.
Anybody else have any suggestions?  I'd like to get this merged in the next
day or two so we can get this into v3.18.

I'd like a MAINTAINERS update, too, so I know who to expect patches and
acks from.

> +static irqreturn_t ls_pcie_msi_irq_handler(int irq, void *data)
> +{
> +	struct pcie_port *pp = data;
> +	struct ls_pcie *pcie = to_ls_pcie(pp);
> +	unsigned int msi_irq;
> +
> +	/* clear the interrupt */
> +	regmap_write(pcie->scfg, SCFG_SPIMSICLRCR,
> +		     MSI_LS1021A_DATA(pcie->index));
> +
> +	msi_irq = irq_find_mapping(pp->irq_domain, 0);
> +	if (!msi_irq) {
> +		/*
> +		 * that's weird who triggered this?
> +		 * just clear it
> +		 */
> +		dev_err(pcie->dev, "unexpected MSI\n");

Scott suggested either using dev_dbg or rate-limiting this dev_err.

> +static int ls_add_pcie_port(struct ls_pcie *pcie)
> +{
> +	struct pcie_port *pp;
> +	int ret;
> +
> +	if (!pcie)
> +		return -EINVAL;

Unnecessary NULL pointer check (we already checked it below).

Bjorn
