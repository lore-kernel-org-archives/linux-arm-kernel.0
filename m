From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 4 Aug 2013 22:46:54 +0200
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <20130804085046.6e6cb18954a57dbddeee814d@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <201308032145.41860.arnd@arndb.de>
 <20130804085046.6e6cb18954a57dbddeee814d@mail.ru>
Message-ID: <201308042246.54776.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 August 2013, Alexander Shiyan wrote:
> On Sat, 3 Aug 2013 21:45:41 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> [...]
> > > +static void __iomem __init *clps711x_ioremap_one(phys_addr_t reg)
> > > +{
> > > +       void __iomem *ret;
> > > +
> > > +       if (!request_mem_region(clps711x_intc->phys_base + reg, SZ_4, NULL))
> > > +               return ERR_PTR(-EBUSY);
> > > +
> > > +       ret = ioremap(clps711x_intc->phys_base + reg, SZ_4);
> > > +       if (!ret)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       return ret;
> > 
> > Another unrelated comment: Doing repeated ioremap() and request_mem_region calls
> > is rather wasteful as every single call will consume resources. Better do a single
> > ioremap in the probe function and just add the offsets later.
> 
> Registers are not arranged linearly for each submodule, so for example there are
> registers for LCD, Timers, PWM, UART etc. between INTMR1 and INTMR2.
> Single request cannot be used here, since it block access to these holes from drivers.

Well, you could still have a single ioremap() but separate request_mem_region()
calls then. Each ioremap() actually installs a full page anyway.

Alternatively, you could use the syscon driver to provide access to all the registers.

	Arnd
