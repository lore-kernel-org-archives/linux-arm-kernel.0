From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 12 May 2015 13:46:47 +0200
Subject: [PATCH v2] AHCI: Add generic MSI-X interrupt support to SATA PCI
 driver
In-Reply-To: <20150511171810.GB29499@rric.localhost>
References: <1430725538-22162-1-git-send-email-rric@kernel.org>
 <20150504160652.GB1971@htj.duckdns.org>
 <20150511171810.GB29499@rric.localhost>
Message-ID: <20150512114647.GN10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tejun,

On 11.05.15 19:18:10, Robert Richter wrote:
> > > +static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
> > > +                           struct ahci_host_priv *hpriv)
> > > +{
> > > +   struct msi_desc *desc;
> > > +
> > > +   __ahci_init_interrupts(pdev, n_ports, hpriv);
> > > +
> > > +   if (!pdev->msix_enabled)
> > > +           return pdev->irq;
> > > +
> > > +   desc = msix_get_desc(pdev, 0);  /* first entry */
> > > +   if (!desc)
> > > +           return -ENODEV;
> > > +
> > > +   return desc->irq;
> > > +}
> >
> > Can we please do this properly?  We should be able to move port priv
> > allocation to host allocaotion time and add and use pp->irq instead,
> > right?
> 
> I started working implementing this.
> 
> Will send an updated patch set once finished.

A couple of questions here.

If we store the irq for each port separate in host->ports[i]->irq,
then there are duplicates for !AHCI_HFLAG_MULTI_MSI. We can not
iterate over all ports then to initialize the interrupt. Instead we
need to check for !AHCI_HFLAG_MULTI_MSI and store in that case the irq
in host->irq. This would avoid initializing duplicates and makes
host->ports[i]->irq only useful for multi-msi. Right now multi-msi
uses a base irq + index to register all irqs. This makes
host->ports[i]->irq obsolete at all.

Now, adding host->irq would change the function interface of
ahci_host_activate() to:

 int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);

I don't think this is worth the effort as all internal and external
drivers need to be changed basically from:

 ahci_host_activate(host, irq, &ahci_sht);

to:

 host->irq = irq;
 ahci_host_activate(host, &ahci_sht);

This looks not very useful to do. Since irq is used only a single
time, there is no reason to store it in the host's data structure. It
also makes the interface more error prone since host->irq might not be
setup. Apart from that there is an abi change.

I agree that we will need the implemention of host->ports[i]->irq for
the case there irqs are no longer in sequential order as this might be
the case for per-port msi-x interrupts. But this is not the focus of
my implementation and as long there is no hardware for this available,
it wouldn't make sense to implement this at all.

So how to proceed? I could send you patches that implement host->irq
for a single per-host interrupt, and also one that reworks multi-port
interrupts to use host->ports[i]->irq. But I don't see any benefit
here. That said, I would better keep my patch here as it is. That do
you think?

Thanks,

-Robert
