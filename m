From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 2 Sep 2010 18:32:10 -0500
Subject: [PATCH v2] ep93xx: move clock initialization earlier
In-Reply-To: <1283438347-22257-1-git-send-email-mika.westerberg@iki.fi>
References: <1283438347-22257-1-git-send-email-mika.westerberg@iki.fi>
Message-ID: <0D753D10438DA54287A00B0270842697644485C436@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 02, 2010 7:39 AM, Mika Westerberg wrote:
> Commit 7cfe24947 ("ARM: AMBA: Add pclk support to AMBA bus infrastructure")
> changed AMBA bus to handle the PCLK automatically. However, in EP93xx clock
> initialization is arch_initcall which is done later than AMBA device
> identification. This causes amba_get_enable_pclk() to fail resulting device
> where UARTs are not functional.
> 
> So change ep93xx_clock_init() to be postcore_initcall.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>

It appears the place that the clocks are added varies widely on the various
arch/arm/mach-* ports:

mach-bcmring and mach-versatile do it as part of MACHINE_START.init_machine

mach-davinci and mach-w90x900 do it as part of MACHINE_START.map_io

mach-ep93xx, mach-pnx4008, mach-vexpress, and plat-stmp3xxx do it as an arch_initcall

mach-imx, mach-mx25, mach-mx3, mach-mxc91231, and mach-shmobile do it as
part of MACHINE_START.timer.init

mach-mmp does it as a postcore_initcall

mach-nomadik, mach-u300, and mach-ux500 do it as part of MACHINE_START.init_irq

mach-realview does it as a core_initcall

mach-integrator has both a MACHINE_START.init_machine and an arch_initcall

mach-pxa has a MACHINE_START.init_machine, a postcore_initcall, and a core_initcall

Based on that, I guess changing it on mach-ep93xx to a postcore_initcall is fine.
Unless Russell has an overall opinion on what the best initialization point would
be.

So FWIW, on the ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
