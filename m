From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 15:36:17 +0000
Subject: [PATCH 1/2] ARM: irq: Call irqchit_init if no init_irq
 function is specified
In-Reply-To: <201303281525.42334.arnd@arndb.de>
References: <1364463704-13692-1-git-send-email-maxime.ripard@free-electrons.com>
 <51545832.1050504@gmail.com> <20130328145155.GB3368@n2100.arm.linux.org.uk>
 <201303281525.42334.arnd@arndb.de>
Message-ID: <20130328153617.GC3368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 03:25:42PM +0000, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Russell King - ARM Linux wrote:
> > Better:
> > 
> > #ifdef CONFIG_OF
> >         if (!machine_desc->init_irq)
> >                 irqchip_init();
> >         else
> > #endif
> >                 machine_desc->init_irq();
> > 
> > which means we don't even get the test if !OF, and if someone mistakenly
> > sets this to NULL for a !OF platform, they get to know about it.
> 
> Right. With the new IS_DEFINED() macro, we could even turn this into
> 
> 	if (IS_DEFINED(CONFIG_OF) && !machine_desc->init_irq)
> 		irqchip_init();
> 	else
> 		machine_desc->init_irq();
> 
> to the same effect.

Provided irqchip_init() keeps its prototype visible, then yes.
