From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 4 Aug 2013 08:50:46 +0400
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <201308032145.41860.arnd@arndb.de>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
 <20130802195552.2f95c855fc20d6b3a205e40f@mail.ru>
 <201308032145.41860.arnd@arndb.de>
Message-ID: <20130804085046.6e6cb18954a57dbddeee814d@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Aug 2013 21:45:41 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

[...]
> > +static void __iomem __init *clps711x_ioremap_one(phys_addr_t reg)
> > +{
> > +       void __iomem *ret;
> > +
> > +       if (!request_mem_region(clps711x_intc->phys_base + reg, SZ_4, NULL))
> > +               return ERR_PTR(-EBUSY);
> > +
> > +       ret = ioremap(clps711x_intc->phys_base + reg, SZ_4);
> > +       if (!ret)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       return ret;
> 
> Another unrelated comment: Doing repeated ioremap() and request_mem_region calls
> is rather wasteful as every single call will consume resources. Better do a single
> ioremap in the probe function and just add the offsets later.

Registers are not arranged linearly for each submodule, so for example there are
registers for LCD, Timers, PWM, UART etc. between INTMR1 and INTMR2.
Single request cannot be used here, since it block access to these holes from drivers.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
