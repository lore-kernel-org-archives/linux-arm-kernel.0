From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 15 Sep 2012 09:53:01 +0200
Subject: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
In-Reply-To: <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
Message-ID: <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > --- a/drivers/pci/setup-irq.c
> > +++ b/drivers/pci/setup-irq.c
> > @@ -17,6 +17,14 @@
> >  #include <linux/ioport.h>
> >  #include <linux/cache.h>
> >
> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> > +{
> > +#ifdef CONFIG_PCI_DEBUG
> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> > +              pci_name(dev));
> 
> pr_debug()?
> Or even better, dev_dbg()?

The problem with pr_debug() and dev_dbg() is that they will be compiled
out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
is configured and make this dev_dbg()?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120915/e0fef5be/attachment.sig>
