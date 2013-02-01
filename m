From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 12:34:30 +0000
Subject: [PATCH, RFC] default machine descriptor for multiplatform
In-Reply-To: <510BAB55.30603@ti.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <1638002.UJ7zfj1Wn5@wuerfel> <510BAB55.30603@ti.com>
Message-ID: <201302011234.30592.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Santosh Shilimkar wrote:
> This is indeed a nice update towards consolidation. Though
> on OMAP, we need to do some work to effectively get rid
> of machine, time and irq inits. Will add this task in my
> TODO queue.

There is no urgent need to get all board files to have empty
machine descriptors, I would not expect that to happen for
the more complex platforms like omap any time soon.

You currently use quite a number of callbacks:

DT_MACHINE_START(OMAP5_DT, "Generic OMAP5 (Flattened Device Tree)")
        .reserve        = omap_reserve,
        .smp            = smp_ops(omap4_smp_ops),
        .map_io         = omap5_map_io,
        .init_early     = omap5_init_early,
        .init_irq       = omap_gic_of_init,
        .handle_irq     = gic_handle_irq,
        .init_machine   = omap_generic_init,
        .timer          = &omap5_timer,
        .dt_compat      = omap5_boards_compat,
        .restart        = omap44xx_restart,
MACHINE_END

and I see nothing wrong with that. For simpler platforms that
after migrating out init_irq and init_timer have only one
or two callbacks left, it may be more interesting to actually
go all the way and remove all of them if possible.

	Arnd
