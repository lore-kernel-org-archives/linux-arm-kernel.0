From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Feb 2017 10:57:02 +0000
Subject: [PATCH] ARM: Kconfig: select GENERIC_CLOCKEVENTS_BROADCAST also
 on UP
In-Reply-To: <20170130135348.GS27312@n2100.armlinux.org.uk>
References: <20170120163230.9357-1-l.stach@pengutronix.de>
 <20170130135348.GS27312@n2100.armlinux.org.uk>
Message-ID: <20170207105701.GT27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 01:53:48PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 20, 2017 at 05:32:30PM +0100, Lucas Stach wrote:
> > Quite a few systems have deeper idle states where the local timer tick
> > stops to fire, that rely on the GENERIC_CLOCKEVENTS_BROADCAST
> > infrastructure to switch to a global (non-stopping) clockevent device.
> > This is also true on UP systems, so select GENERIC_CLOCKEVENTS_BROADCAST
> > unconditionally.
> > 
> > Instead only select ARCH_HAS_TICK_BROADCAST if SMP is present, as this
> > is only implemented for SMP systems.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: Only select GENERIC_CLOCKEVENTS_BROADCAST if the architecture
> >     supports GENERIC_CLOCKEVENTS.
> 
> Provided this solves the problems identified by the 0-day builder with
> your previous patch, please submit it to the patch system, thanks.

I think this causes OMAP builds to fail:

arch/arm/mach-omap2/timer.c:325:8: error: expected identifier or '(' before 'void'
arch/arm/mach-omap2/timer.c:325:15: error: expected ')' before numeric constant

     #if !defined(CONFIG_SMP) && defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
>>>> void tick_broadcast(const struct cpumask *mask)
     {
     }
     #endif

vs

     # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
     #  ifdef CONFIG_ARCH_HAS_TICK_BROADCAST
     extern void tick_broadcast(const struct cpumask *mask);
     #  else
>>>> #   define tick_broadcast       NULL
     #  endif
     extern int tick_receive_broadcast(void);
     # endif

So, I'm dropping this change.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
