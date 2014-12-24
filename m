From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 24 Dec 2014 08:16:57 +0200
Subject: [PATCH 5/8] irqchip: Conexant CX92755 interrupts controller driver
In-Reply-To: <16151065.LjzHK8TaOo@wuerfel>
References: <cover.1419318109.git.baruch@tkos.co.il>
 <7997c913e9f6debc09fd62c788b8ac6bd330d4f3.1419318109.git.baruch@tkos.co.il>
 <16151065.LjzHK8TaOo@wuerfel>
Message-ID: <20141224061657.GI2481@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Dec 23, 2014 at 10:02:18PM +0100, Arnd Bergmann wrote:
> On Tuesday 23 December 2014 09:58:42 Baruch Siach wrote:
> > +static void __exception_irq_entry digicolor_handle_irq(struct pt_regs *regs)
> > +{
> > +       u32 status, hwirq;
> > +
> > +       do {
> > +               status = readl(digicolor_irq_base + IC_INT0STATUS_LO);
> > +               if (status) {
> > +                       hwirq = ffs(status) - 1;
> > +               } else {
> > +                       status = readl(digicolor_irq_base + IC_INT0STATUS_XLO);
> > +                       if (status)
> > +                               hwirq = ffs(status) - 1 + 32;
> > +                       else
> > +                               return;
> > +               }
> > +
> > +               handle_domain_irq(digicolor_irq_domain, hwirq, regs);
> > +       } while (1);
> > +}
> > 
> 
> Have you tried using the generic_irqchip code for this? The hardware
> seems simple enough.

Thanks for the tip. I'll look into converting to GENERIC_IRQ_CHIP for next 
version.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
