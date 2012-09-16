From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 16 Sep 2012 08:50:38 +0200
Subject: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
In-Reply-To: <CAErSpo6WaFv=CXtiWeDDvThjZRBRJKfJMgovuMjjZRpQGK-WJA@mail.gmail.com>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com>
 <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
 <CAErSpo6WaFv=CXtiWeDDvThjZRBRJKfJMgovuMjjZRpQGK-WJA@mail.gmail.com>
Message-ID: <20120916065038.GB11030@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:23:33PM -0600, Bjorn Helgaas wrote:
> On Sat, Sep 15, 2012 at 1:53 AM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
> >> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
> >> <thierry.reding@avionic-design.de> wrote:
> >> > --- a/drivers/pci/setup-irq.c
> >> > +++ b/drivers/pci/setup-irq.c
> >> > @@ -17,6 +17,14 @@
> >> >  #include <linux/ioport.h>
> >> >  #include <linux/cache.h>
> >> >
> >> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
> >> > +{
> >> > +#ifdef CONFIG_PCI_DEBUG
> >> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
> >> > +              pci_name(dev));
> >>
> >> pr_debug()?
> >> Or even better, dev_dbg()?
> >
> > The problem with pr_debug() and dev_dbg() is that they will be compiled
> > out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
> > is configured and make this dev_dbg()?
> 
> Sorry, fat-fingered the previous empty response.
> 
> We already have this in drivers/pci/Makefile:
> 
>     ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> 
> so dev_dbg() should be perfect.

Yeah, this occurred to me as well and I was just about to look it up
when I read your response. I'll make it dev_dbg() then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120916/4e0ee8a5/attachment.sig>
