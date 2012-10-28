From: horms@verge.net.au (Simon Horman)
Date: Sun, 28 Oct 2012 19:44:38 +0900
Subject: [PATCH 12/12] ARM: mach-shmobile: Use DT_MACHINE for mackerel
In-Reply-To: <20121028103711.4e89deb3@skate>
References: <1351391173-32379-1-git-send-email-horms@verge.net.au>
 <1351391173-32379-13-git-send-email-horms@verge.net.au>
 <20121028103711.4e89deb3@skate>
Message-ID: <20121028104438.GC10073@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 28, 2012 at 10:37:11AM +0100, Thomas Petazzoni wrote:
> Dear Simon Horman,
> 
> On Sun, 28 Oct 2012 11:26:13 +0900, Simon Horman wrote:
> 
> > -MACHINE_START(MACKEREL, "mackerel")
> > +static const char *mackerel_boards_compat_dt[] __initdata = {
> > +	"renesas,mackerel",
> > +	NULL,
> > +};
> > +
> > +DT_MACHINE_START(MACKEREL_DT, "mackerel")
> >  	.map_io		= sh7372_map_io,
> >  	.init_early	= sh7372_add_early_devices,
> >  	.init_irq	= sh7372_init_irq,
> > @@ -1659,4 +1664,5 @@ MACHINE_START(MACKEREL, "mackerel")
> >  	.init_machine	= mackerel_init,
> >  	.init_late	= sh7372_pm_init_late,
> >  	.timer		= &shmobile_timer,
> > +	.dt_compat  = mackerel_boards_compat_dt,
> >  MACHINE_END
> 
> Not sure what is the status of mach-shmobile with regard to the device
> tree, but one of the idea of the device tree is to avoid having one .c
> file per board, and therefore one DT_MACHINE_START definition per
> board. There should be only only DT_MACHINE_START definition per SoC or
> SoC family, with the DT giving the detailed hardware description.
> 
> Of course, during a transition period, not all your drivers may have DT
> bindings, and therefore some devices may need to be probed in the "old"
> way (manual registration of platform_device). In that case, your
> ->init_machine() hook can call initialization function on a per-board
> basis by testing if the machine is such or such board.
> 
> See arch/arm/mach-kirkwood/board-dt.c for an example. The advantage is
> that with this solution, the board specific C files are progressively
> reducing in size as more and more devices get registered through the
> Device Tree, until the point where they become empty and can be removed.

Hi Thomas,

shmobile is very much in the transition phase and we are, patch by patch,
working towards full(er) DT support for boards, SoCs and drivers. I am not
sure that now is the right time to jump to a approach similar to that taken
by mach-kirkwood/board-dt.c.
