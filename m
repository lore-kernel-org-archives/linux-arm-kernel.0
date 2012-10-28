From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 10:37:11 +0100
Subject: [PATCH 12/12] ARM: mach-shmobile: Use DT_MACHINE for mackerel
In-Reply-To: <1351391173-32379-13-git-send-email-horms@verge.net.au>
References: <1351391173-32379-1-git-send-email-horms@verge.net.au>
 <1351391173-32379-13-git-send-email-horms@verge.net.au>
Message-ID: <20121028103711.4e89deb3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Horman,

On Sun, 28 Oct 2012 11:26:13 +0900, Simon Horman wrote:

> -MACHINE_START(MACKEREL, "mackerel")
> +static const char *mackerel_boards_compat_dt[] __initdata = {
> +	"renesas,mackerel",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(MACKEREL_DT, "mackerel")
>  	.map_io		= sh7372_map_io,
>  	.init_early	= sh7372_add_early_devices,
>  	.init_irq	= sh7372_init_irq,
> @@ -1659,4 +1664,5 @@ MACHINE_START(MACKEREL, "mackerel")
>  	.init_machine	= mackerel_init,
>  	.init_late	= sh7372_pm_init_late,
>  	.timer		= &shmobile_timer,
> +	.dt_compat  = mackerel_boards_compat_dt,
>  MACHINE_END

Not sure what is the status of mach-shmobile with regard to the device
tree, but one of the idea of the device tree is to avoid having one .c
file per board, and therefore one DT_MACHINE_START definition per
board. There should be only only DT_MACHINE_START definition per SoC or
SoC family, with the DT giving the detailed hardware description.

Of course, during a transition period, not all your drivers may have DT
bindings, and therefore some devices may need to be probed in the "old"
way (manual registration of platform_device). In that case, your
->init_machine() hook can call initialization function on a per-board
basis by testing if the machine is such or such board.

See arch/arm/mach-kirkwood/board-dt.c for an example. The advantage is
that with this solution, the board specific C files are progressively
reducing in size as more and more devices get registered through the
Device Tree, until the point where they become empty and can be removed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
