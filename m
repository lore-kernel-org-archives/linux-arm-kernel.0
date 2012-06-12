From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 12 Jun 2012 07:07:13 +0200
Subject: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
In-Reply-To: <4FD660F9.7030807@wwwdotorg.org>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de>
 <4FD660F9.7030807@wwwdotorg.org>
Message-ID: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren wrote:
> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> > This commit adds support for message signaled interrupts to the Tegra
> > PCIe controller. Based on code by Krishna Kishore <kthota@nvidia.com>.
> 
> > diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
> 
> > +static irqreturn_t tegra_pcie_msi_irq(int irq, void *data)
> ...
> > +			irq = irq_find_mapping(pcie->msi->domain, index);
> > +			if (irq) {
> > +				if (test_bit(index, pcie->msi->used))
> > +					generic_handle_irq(irq);
> 
> This invokes the handler first ...
> 
> ...
> > +			/* clear the interrupt */
> > +			afi_writel(pcie, 1 << offset, AFI_MSI_VEC0 + i * 4);
> > +			/* see if there's any more pending in this vector */
> > +			reg = afi_readl(pcie, AFI_MSI_VEC0 + i * 4);
> 
> ... then clears the interrupt status in the PCIe controller. Won't that
> lose interrupts if one is raised between when the handler clears the
> root-cause, and when this code clears the received interrupt status?

It certainly doesn't follow the conventional way of clearing the interrupt
first. I carried this from the original MSI patch, but I'll move the
interrupt clearing up and retest.

> > +static int tegra_pcie_disable_msi(struct platform_device *pdev)
> 
> Should this free pcie->msi->pages?

Yes it should. I actually mention making that change in the changelog but
in fact didn't.

> Why allocate pcie->msi separately; why not include the fields directly
> into struct tegra_pcie_info *pcie?

For one I find this easier to read. If this wasn't a separate structure, each
of the individual fields would get an msi_ prefix anyway so there isn't much
to be gained from keeping them directly in tegra_pcie_info.

Second, and more importantly, this will keep the size of struct
tegra_pcie_info smaller if PCI_MSI is not selected because there is just one
unused pointer instead of five unused fields.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/ca927330/attachment.sig>
