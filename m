From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 5 Aug 2013 22:16:31 +0400
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201308042257.58707.arnd@arndb.de>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <20130804085046.6e6cb18954a57dbddeee814d@mail.ru>
 <201308042246.54776.arnd@arndb.de>
 <201308042257.58707.arnd@arndb.de>
Message-ID: <20130805221631.f740b0d39de0e14e641f477c@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Aug 2013 22:57:58 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sunday 04 August 2013, Arnd Bergmann wrote:
> > On Sunday 04 August 2013, Alexander Shiyan wrote:
> > > On Sat, 3 Aug 2013 21:45:41 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > > [...]
> > > > > +static void __iomem __init *clps711x_ioremap_one(phys_addr_t reg)
> > > > > +{
> > > > > +       void __iomem *ret;
> > > > > +
> > > > > +       if (!request_mem_region(clps711x_intc->phys_base + reg, SZ_4, NULL))
> > > > > +               return ERR_PTR(-EBUSY);
> > > > > +
> > > > > +       ret = ioremap(clps711x_intc->phys_base + reg, SZ_4);
> > > > > +       if (!ret)
> > > > > +               return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +       return ret;
> > > > 
> > > > Another unrelated comment: Doing repeated ioremap() and request_mem_region calls
> > > > is rather wasteful as every single call will consume resources. Better do a single
> > > > ioremap in the probe function and just add the offsets later.
> > > 
> > > Registers are not arranged linearly for each submodule, so for example there are
> > > registers for LCD, Timers, PWM, UART etc. between INTMR1 and INTMR2.
> > > Single request cannot be used here, since it block access to these holes from drivers.
> > 
> > Well, you could still have a single ioremap() but separate request_mem_region()
> > calls then. Each ioremap() actually installs a full page anyway.
> > 
> > Alternatively, you could use the syscon driver to provide access to all the registers.
> 
> There is another problem, which is that you have overlapping register ranges
> in the DT if the interrupt controller device node contains all the registers
> including those that are used by the other drivers. Using the syscon driver
> would solve that, too.
> 
> Rethinking the whole situation, I wonder if the EOI registers could be accessed
> by the individual drivers instead, if they are in their register sets anyway.

Unfortunately, no.

> Handling them in the irqchip driver probably seemed like a logical solution
> when the code was initially written, but if you move that access into the
> device drivers, you can probably remove the irqchip driver entirely and just
> use the generic irqchip implementation.

ioremap for a whole set of CPU registers is called from map_io, so ioremap
returns already mapped address, that is, it's just converting physical to
virtual addresses.

-- 
Alexander Shiyan <shc_work@mail.ru>
