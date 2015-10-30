From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Oct 2015 09:35:00 +0000
Subject: [PATCH v2 1/3] gpio: xgene: add support to configure GPIO line
 as input, output or external IRQ pin
In-Reply-To: <CAFopSPQtuVxSn4SkVHtf-0AZE7MqRJ3XQMutCubzMd8CztA8CA@mail.gmail.com>
References: <1445842175-11446-1-git-send-email-yvo@apm.com>
 <1445842175-11446-2-git-send-email-yvo@apm.com>
 <CACRpkdbWKmRKXL=+57KQVYYRc79tgGwCi=7p4LSBwFgUwgz-gw@mail.gmail.com>
 <CAFopSPQtuVxSn4SkVHtf-0AZE7MqRJ3XQMutCubzMd8CztA8CA@mail.gmail.com>
Message-ID: <20151030093500.7ad59365@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Oct 2015 12:41:03 +0700
Quan Nguyen <qnguyen@apm.com> wrote:

> Forgive me for not turn on plain text mode my last email.
> 
> Hi Linus,
> 
> My name is Quan Nguyen, I'm working with Y Vo on this patch.
> 
> Allow me to explain as below:
> 
> In current implementation, gic irq resources were used in both sbgpio
> and gpios-key nodes, and this causes confusion.
> To avoid this, we introduce sbgpio driver as interrupt controller, it
> now provides 6 external irq pins mapped from gpio line 8-13. The
> gpio-keys node now uses sbgpio irq resources instead.
> 
> -- Quan
> 
> 
> On Thu, Oct 29, 2015 at 8:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Oct 26, 2015 at 7:49 AM, Y Vo <yvo@apm.com> wrote:
> >
> >> Add support to configure GPIO line as input, output or external IRQ pin.
> >>
> >> Signed-off-by: Y Vo <yvo@apm.com>
> >
> > As I will say again, this description is too terse, add lots of information
> > on how IRQs work on this controller please. I get confused.
> 
> How about:
> +++++++++++++++++++++++++++++++++
> Enable X-Gene standby GPIO driver as interrupt controller, it provides
> 6 external irq pins via gpio line 8-13.
> +++++++++++++++++++++++++++++++++
> >
> > (...)
> >
> >> +#define XGENE_GPIO8_HWIRQ              0x48
> >> +#define XGENE_GPIO8_IDX                        8
> > (...)
> >> +#define XGENE_HWIRQ_TO_GPIO(hwirq)     ((hwirq) + XGENE_GPIO8_IDX)
> >> +#define XGENE_GPIO_TO_HWIRQ(gpio)      ((gpio) - XGENE_GPIO8_IDX)
> >> +#define GIC_IRQ_TO_GPIO_IRQ(hwirq)     ((hwirq) - XGENE_GPIO8_HWIRQ)
> >> +#define GPIO_IRQ_TO_GIC_IRQ(hwirq)     ((hwirq) + XGENE_GPIO8_HWIRQ)
> >
> > I'm a bit uneasy about this, maybe I just don't get it.
> >
> > What is this indexing into "GIC IRQ" that is starting to happen
> > here?
> >
> > The GIC (if that is drivers/irqchip/irq-gic.c) has a totally dynamic IRQ
> > translation and the Linux IRQs it is using may change. I am worried
> > that there is some reliance here on Linux IRQ having certain numbers
> > because there is certainly no ABI like that.
> >
> > Is this 0x48 really an index into the *hardware* offset in the GIC?
> >
> > And if it is: why are we not getting this hardware information from the
> > device tree like all other interrupt numbers and offsets?
> >
> > I'm worried about this.
> 
> The SPI40(0x48) through SPI45(0x4D) from GIC are mapped as external
> IRQ0 - IRQ5 in this GPIO block, so it is hardware offset not mapped
> irq number.
> 
> Below is detail:
> 
> + GIC: SPI40 (hwirq=0x48)  <=> SB-GPIO: (hwirq=0) (gpio line 8)
> + GIC: SPI41 (hwirq=0x49)  <=> SB-GPIO: (hwirq=1) (gpio line 9)
> ...
> + GIC: SPI45 (hwirq=0x4D)  <=> SB-GPIO: (hwirq=5) (gpio line 13)
> 
> These defines are to help translating between Gic hardware irq and
> SBGPIO hardware irq number.
> 
> >
> >> -       u32 *irq;
> >> +       void __iomem *regs;
> >> +       struct irq_domain *gic_domain;
> >> +       struct irq_domain *irq_domain;
> >
> > And there is some secondary gic_domain here, which is confusing
> > since the GIC does have an IRQ domain too.
> >
> > I think I want a clear explanation to how this GPIO controller interacts
> > with the GIC, and I want it to be part of the patch, as comments in the
> > code and in the commit message (which is way too small for a complex
> > patch like this).
> >
> > Otherwise I have no chance to understand what is really going on here.
> 
> SBGPIO currently is not capable to mask/unmask/... irqs, so these will
> rely on the parent (GIC) instead. To do so, we need keep a parent
> domain reference here "struct irq_domain *gic_domain" so we can find
> correspond parent irq in runtime.

All this only means one thing: this should be implemented as a
hierarchical domain, just like any other "random widget stacked on top
of the GIC". Digging into the internals of the GIC driver is not
acceptable anymore, and this patch is just horrible.

There is plenty of examples in the tree for you to look at and rewrite
that code using the abstractions that are already in place.

In the meantime, I am NAKing this patch. Please include the irqchip
maintainers in the next iteration of this series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
