From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 22 Oct 2015 11:21:30 -0500
Subject: [PATCH v4 6/6] PCI: layerscape: add ls_pcie_msi_host_init
In-Reply-To: <20151021213416.GJ1583@localhost>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
 <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
 <20151021213416.GJ1583@localhost>
Message-ID: <20151022162130.GA21237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Thomas for MSI driver file placement question + PCI MSI driver
structure]

Hi Minghuan,

Your reply was base64-encoded and thus rejected by the vger mailing lists.
I mentioned this before
(http://lkml.kernel.org/r/20151011191027.GA29221 at localhost).   You might
want to fix your mail strategy, because it's really hard to carry on a
conversation if nobody can hear your side :)

But I'll include your response here again by hand.

Minghuan wrote:
> On Wed, Oct 21, 2015 at 04:34:16PM -0500, Bjorn Helgaas wrote:
> > Hi Minghuan,
> > 
> > On Fri, Oct 16, 2015 at 03:19:20PM +0800, Minghuan Lian wrote:
> > > Layerscape PCIe has its own MSI implementation. The patch registers
> > > ls_pcie_msi_host_init() to avoid using Designware's MSI.
> > > 
> > > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> > > ---
> > > Change log
> > > v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a
> > > 
> > >  drivers/pci/host/pci-layerscape.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> > > index c53692a..8fac6c8 100644
> > > --- a/drivers/pci/host/pci-layerscape.c
> > > +++ b/drivers/pci/host/pci-layerscape.c
> > > @@ -150,14 +150,31 @@ static void ls_pcie_host_init(struct pcie_port *pp)
> > >  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
> > >  }
> > >  
> > > +static int ls_pcie_msi_host_init(struct pcie_port *pp,
> > > +				 struct msi_controller *chip)
> > > +{
> > > +	struct device_node *msi_node;
> > > +	struct device_node *np = pp->dev->of_node;
> > > +
> > > +	msi_node = of_parse_phandle(np, "msi-parent", 0);
> > > +	if (!msi_node) {
> > > +		dev_err(pp->dev, "failed to find msi-parent\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	return 0;
> > 
> > I don't see how this can be right.  I think it's OK if you want to enforce
> > the presence of "msi-parent", but the other implementations of
> > .msi_host_init (ks_dw_pcie_msi_host_init() and the default implementation
> > in dw_pcie_host_init()) both set pp->irq_domain and call
> > irq_create_mapping().
> > 
> > You don't do either of those, so I don't see how MSIs can work, because I
> > assume the generic DesignWare code will depend on pp->irq_domain.  If
> > you're planning to add more Layerscape-specific MSI support later, I think
> > you should wait and include this patch with that work.

> Regarding MSI, both LS1021a and LS1043a use SCFG to implement it. I have submitted patch:
> https://patchwork.kernel.org/patch/7411131/
> https://patchwork.kernel.org/patch/7411141/

> While ls2085a use ITS for it, we just re-use the ITS driver.

> I notice some platform MSI driver files were placed in pci/host
> folder not irqchip.  If it is ok, I would like to change driver
> folder and re-submitted the MSI patch.

I suppose you're referring to drivers/pci/host/pci-xgene-msi.c.  
That file doesn't really have much PCI stuff in it.  It does call
pci_msi_create_irq_domain(), but that's really the only PCI interface or
data structure it uses.  So I don't know if drivers/pci/host or
drivers/irqchip is the best place for it and for your
irq-ls-scfg-msi.c.

The connection between pci-xgene-msi.c and pci-xgene.c is not very
clear to me, and that's sort of what I'm complaining about here.
You're overriding a default MSI initialization method.  Usually that
means you do the same thing as the default method, but in a different
way.  You aren't doing the same thing at all, which makes the code
hard to review.

Maybe a comment about how the MSI controller gets connected to devices
below this host bridge would be enough.

Bjorn
