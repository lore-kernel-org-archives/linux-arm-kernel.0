From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Oct 2013 21:23:39 +0100
Subject: [PATCH] ARM: mach-iop32x: iq31244: Replace if-then-else with a
 switch statement
In-Reply-To: <CAHuBVBbDk_bgJ9-R-tr9qrt7O3i6NEF6m2QeWnpU5UCxPC9DrA@mail.gmail.com>
References: <1378135394-31092-1-git-send-email-valentin.ilie@gmail.com>
 <CAHuBVBbDk_bgJ9-R-tr9qrt7O3i6NEF6m2QeWnpU5UCxPC9DrA@mail.gmail.com>
Message-ID: <20131002202339.GT12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 06:19:28PM +0300, Valentin Ilie wrote:
> On 2 September 2013 18:23, Valentin Ilie <valentin.ilie@gmail.com> wrote:
> > Convert a compound if-else blob to a switch statement.
> >
> > Signed-off-by: Valentin Ilie <valentin.ilie@gmail.com>
> > ---
> >  arch/arm/mach-iop32x/iq31244.c | 29 +++++++++++------------------
> >  1 file changed, 11 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
> > index f2cd296..3415f11 100644
> > --- a/arch/arm/mach-iop32x/iq31244.c
> > +++ b/arch/arm/mach-iop32x/iq31244.c
> > @@ -101,28 +101,21 @@ void __init iq31244_map_io(void)
> >  static int __init
> >  ep80219_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >  {
> > -       int irq;
> > -
> > -       if (slot == 0) {
> > -               /* CFlash */
> > -               irq = IRQ_IOP32X_XINT1;
> > -       } else if (slot == 1) {
> > -               /* 82551 Pro 100 */
> > -               irq = IRQ_IOP32X_XINT0;
> > -       } else if (slot == 2) {
> > -               /* PCI-X Slot */
> > -               irq = IRQ_IOP32X_XINT3;
> > -       } else if (slot == 3) {
> > -               /* SATA */
> > -               irq = IRQ_IOP32X_XINT2;
> > -       } else {
> > +       switch (slot) {
> > +       case 0: /* CFlash */
> > +               return IRQ_IOP32X_XINT1;
> > +       case 1: /* 82551 Pro 100 */
> > +               return IRQ_IOP32X_XINT0;
> > +       case 2: /* PCI-X Slot */
> > +               return IRQ_IOP32X_XINT3;
> > +       case 3: /* SATA */
> > +               return IRQ_IOP32X_XINT2;
> > +       default:
> >                 printk(KERN_ERR "ep80219_pci_map_irq() called for unknown "
> >                         "device PCI:%d:%d:%d\n", dev->bus->number,
> >                         PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> > -               irq = -1;
> > +               return -1;
> >         }
> > -
> > -       return irq;
> >  }
> >
> >  static struct hw_pci ep80219_pci __initdata = {
> > --
> > 1.8.1.2
> >
> 
> Can someone look into this?

The fact that no one has responded suggests that there is no current
maintainer for this.  It's far better to leave the code as-is because
we know that _that_ used to work fine.  Changing it even for cleanups
means that the replacement code has not been exercised on real hardware
and risks regressions.
