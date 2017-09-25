From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 25 Sep 2017 18:54:05 -0500
Subject: [PATCH 1/3] PCI: designware: only register MSI controller when
 MSI irq line is valid
In-Reply-To: <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828142307.30061-1-l.stach@pengutronix.de>
 <20170828142307.30061-2-l.stach@pengutronix.de>
 <20170831165817.GD18250@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170925235405.GJ15970@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 11:58:17AM -0500, Bjorn Helgaas wrote:
> [+cc Kishon, Thomas, Niklas, Jesper, Zhou, Gabriele, Xiaowei, Binghui,
> Stanimir, Pratyush, Kukjin, Krzysztof, Richard, Murali, Minghuan, Mingkai,
> Roy]
> 
> Sorry about the unwieldy cc list.  It seems like this affects every
> DesignWare-based driver.
> 
> On Mon, Aug 28, 2017 at 04:23:05PM +0200, Lucas Stach wrote:
> > The MSI part of the controller isn't essential, so the host controller can
> > be registered without the MSI controller being present. This allows the
> > host to work in PCIe legancy interrupt only mode, if the IRQ line for the
> 
> s/legancy/legacy/
> 
> > MSI controller is missing.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/dwc/pcie-designware-host.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> > index d29c020da082..8494089f088d 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -381,7 +381,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	if (ret)
> >  		pci->num_viewport = 2;
> >  
> > -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
> >  		if (!pp->ops->msi_host_init) {
> >  			pp->irq_domain = irq_domain_add_linear(dev->of_node,
> >  						MAX_MSI_IRQS, &msi_domain_ops,
> > @@ -412,7 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >  	bridge->ops = &dw_pcie_ops;
> >  	bridge->map_irq = of_irq_parse_and_map_pci;
> >  	bridge->swizzle_irq = pci_common_swizzle;
> > -	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +	if (IS_ENABLED(CONFIG_PCI_MSI) && pp->msi_irq > 0) {
> >  		bridge->msi = &dw_pcie_msi_chip;
> >  		dw_pcie_msi_chip.dev = dev;
> >  	}
> 
> Here are the callers of dw_pcie_host_init():
> 
>   armada8k_add_pcie_port
>   artpec6_add_pcie_port       # sets pp->msi_irq
>   dra7xx_add_pcie_port
>   dw_plat_add_pcie_port       # sets pp->msi_irq
>   exynos_add_pcie_port        # sets pp->msi_irq
>   hisi_add_pcie_port
>   imx6_add_pcie_port          # sets pp->msi_irq
>   kirin_add_pcie_port
>   ks_dw_pcie_host_init        # sets pp->ops->msi_host_init
>   ls_add_pcie_port            # sets pp->ops->msi_host_init
>   qcom_pcie_probe             # sets pp->msi_irq
>   spear13xx_add_pcie_port
> 
> For the drivers that set pp->msi_irq (artpec6, dw_plat, exynos, imx6,
> qcom), it seems like you'd want a similar follow-up change for all of
> them to make the MSI IRQ optional, but you only changed imx6.  What
> about the others?
> 
> For the drivers that don't set pp->msi_irq and don't set
> pp->ops->msi_host_init (armada8k, dra7xx, hisi, kirin, spear13xx),
> this patch means they no longer set up pp->irq_domain.  Do you intend
> that?

Ping, I'm looking for a v2 that addresses this.  No hurry, just
making sure you're not waiting on me.

Bjorn
