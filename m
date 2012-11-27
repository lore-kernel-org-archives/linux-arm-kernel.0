From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Nov 2012 13:03:11 +0000
Subject: [PATCH 1/1] ARM: ux500: Fix u9540 booting issues
In-Reply-To: <201211271236.01493.arnd@arndb.de>
References: <1354008890-10476-1-git-send-email-lee.jones@linaro.org>
 <201211271236.01493.arnd@arndb.de>
Message-ID: <20121127130311.GE2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2012, Arnd Bergmann wrote:

> On Tuesday 27 November 2012, Lee Jones wrote:
> 
> > The u9540 stopped booting after the v3.7 merge window due to
> > a lack of common clk support and early PRCMU initialisation.
> > In this patch we rectify these issues, placing the u9540
> > development board back into a successfully booting state.
> 
> > -       if (cpu_is_u8500_family())
> > +       if (cpu_is_u8500_family() || cpu_is_u9540())
> >                 u8500_clk_init();
> > -       else if (cpu_is_u9540())
> > -               u9540_clk_init();
> >         else if (cpu_is_u8540())
> >                 u8540_clk_init();
> 
> It certainly doesn't /look/ right, even if it works.  Can you explain why
> u8540_clk_init works and u9540_clk_init doesn't?

Because it's empty. :)

Common clk doesn't support the u9540 yet, and even when it does,
most (all?) of the clocks will be identical to the u9540 in any
case.

I believe Linus wants to apply this with a TODO, to ensure the
board is at least bootable. This whole section is in the wrong
place anyway IMHO, and needs moving out to somewhere less hacky,
rather than initialising clocks and the PRCMU from .init_irq.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
