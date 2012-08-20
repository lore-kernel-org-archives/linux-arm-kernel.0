From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Aug 2012 13:55:32 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120820121055.GA26991@opensource.wolfsonmicro.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-6-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ7bMBytyDppV2sB1d1sUbDpPRqAQVOq8k4UOYdmg+Mkw@mail.gmail.com>
 <201208140942.54773.arnd@arndb.de>
 <CACRpkdYbOBEPNbCdfi+=gupdqS8_7t7MpOgXs7VCVTs8Y3j_mQ@mail.gmail.com>
 <20120820083640.GH8450@gmail.com>
 <20120820121055.GA26991@opensource.wolfsonmicro.com>
Message-ID: <20120820125531.GA20242@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 01:10:55PM +0100, Mark Brown wrote:
> On Mon, Aug 20, 2012 at 09:36:43AM +0100, Lee Jones wrote:
> > On Tue, Aug 14, 2012 at 12:44:37PM +0200, Linus Walleij wrote:
> 
> > > Yes but I think I saw this other patch set from Lee, hitting
> > > irqdomain, OF and MFD to actually fix this ... or did I get
> > > it wrong?
> 
> > No, you're not wrong.
> 
> > Historically (in my patches) xb8500_irq_get_virq() was used by drivers
> > to obtain a VIRQ when not using Device Tree. Now the MFD core handles
> > conversion there is little requirement for it. In fact there are no
> > more users for db8500_irq_get_virq() and only one user for 
> > ab8500_irq_get_virq() and that's itself. I guess we can rid them and
> > call irq_get_mapping() directly instead.
> 
> Oh dear.  Unfortunately whoever added this support to the MFD core did
> so in such a manner that it's only supported for device tree systems
> and only for devices which express the MFD cells as device tree nodes
> which means that most devices can't it - db8500 has got a reasonably
> unusual combination there.

Right, that was the initial intention. It would be a trivial semantic
change if drivers without DT support wished to use the functionality
though. However, the only examples I found of a non-DT enabled driver
that could make good use of it in order to strip out some cruft would
be the Arizona and one of the Samsung drivers, and they each have
their own hand-rolled methods of hwirq -> virq conversion now, so any
change to support them would result in multiple invocations of
irq_create_mapping which would likely cause breakage.
 
-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
