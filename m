From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Jan 2014 11:13:37 +0100
Subject: [PATCH v2 03/15] watchdog: orion: Use atomic access for shared
 registers
In-Reply-To: <3381968.dYvuFs4ZXV@wuerfel>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <3381968.dYvuFs4ZXV@wuerfel>
Message-ID: <20140121101337.GB13396@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 10:54:37AM +0100, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 06:12:29 Ezequiel Garcia wrote:
> >         writel(~WDT_INT_REQ, BRIDGE_CAUSE);
> >  
> >         /* Enable watchdog timer */
> > -       reg = readl(wdt_reg + TIMER_CTRL);
> > -       reg |= WDT_EN;
> > -       writel(reg, wdt_reg + TIMER_CTRL);
> > +       atomic_io_modify(wdt_reg + TIMER_CTRL, WDT_EN, WDT_EN);
> 
> As mentioned in my comment for patch 2, it seems that the exported
> orion_timer_ctrl_clrset() function would be more appropriate for this.

Hi Arnd

As Sebastian points out, Armada 370 XP does not have this function. 

> 
> >         /* Enable reset on watchdog */
> > -       reg = readl(RSTOUTn_MASK);
> > -       reg |= WDT_RESET_OUT_EN;
> > -       writel(reg, RSTOUTn_MASK);
> > +       atomic_io_modify(RSTOUTn_MASK, WDT_RESET_OUT_EN, WDT_RESET_OUT_EN);
> 
> And this register already has an abstraction in
> arch/arm/mach-mvebu/system-controller.c. I would prefer to find a way
> to generalize that. I can see multiple ways to do that:

Please be aware that arch/arm/mach-mvebu/system-controller.c is
currently DT only. We need a solution which works for both with DT and
without DT, since orion5x and mv78xx0 none DT boards are not going
away soon.

     Andrew
 
