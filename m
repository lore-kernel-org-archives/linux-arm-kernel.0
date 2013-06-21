From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Jun 2013 08:33:34 +0200
Subject: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <20130620185707.GA8888@mithrandir>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir>
Message-ID: <20130621083334.281444c3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Thu, 20 Jun 2013 20:57:08 +0200, Thierry Reding wrote:

> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 2c10752..4bc0c8f 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -30,19 +30,35 @@ static int pci_msi_enable = 1;
> >  
> >  /* Arch hooks */
> >  
> > -#ifndef arch_msi_check_device
> > -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> > +int default_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
> > +{
> > +	return default_setup_msi_irq(dev, desc);
> > +}
> > +
> > +void default_teardown_msi_irq(unsigned int irq)
> > +{
> > +}
> > +
> > +void __weak arch_teardown_msi_irq(unsigned int irq)
> > +{
> > +	return default_teardown_msi_irq(irq);
> > +}
> > +
> > +int default_msi_check_device(struct pci_dev *dev, int nvec, int type)
> >  {
> >  	return 0;
> >  }
> > -#endif
> 
> I don't think keeping the default_*() for these three is necessary,
> given that they don't do anything and therefore no architecture is
> likely to call them when overriding.

Ok. I was just keeping them for the sake of consistency with the other
calls that do have a default behavior, but if it's considered not
useful, I'll get rid of them in v4.

Thanks for your comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
