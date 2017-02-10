From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Feb 2017 16:39:08 +0000
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <25202835.AdbHsoUg0y@wuerfel>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
 <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <25202835.AdbHsoUg0y@wuerfel>
Message-ID: <20170210163908.GL27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 02:05:43PM +0100, Arnd Bergmann wrote:
> And I really don't like adding new top-level for a platform here, it
> brings us back to the same problems we had before we moved most platforms
> to ARCH_MULTIPLATFORM, and it doesn't solve the remaining problems we still
> have:

It's the least evil solution.

> - In some platforms, the decision would have to be done on a per-board
>   level, as each board can have its memory at a different location
>   base on which chipselect line got connected to the RAM and NOR flash
>   respectively

Right, but that's something we _had_ solved before multiplatform came
along.

> - Some (few) platforms actually have separate top-level Kconfig options
>   but are actually very closely related and you could have a kernel
>   for all of them even with !MMU and XIP_KERNEL. The most important
>   one here is ARM Versatile/Realview/Integrator/Vexpress that have
>   more in common than things we put behind a common Kconfig option in
>   other platforms.

If you think that Versatile + Realview + Integrator + Vexpress should
be lumped into one kernel image for !MMU and XIP_KERNEL then you're
wrong - from what I remember, their RAM and flash locations are quite
different which rules it out.

The biggest thing that matters for !MMU and XIP_KERNEL is the location
of flash and RAM.  If those are not compatible, !MMU and XIP_KERNEL
has no chance of working.

> - CONFIG_DEBUG_UNCOMPRESS has a very similar requirements to
>   XIP_KERNEL and !MMU, and we currently allow it for any machine,
>   with a lot of flexibility in configuring that always breaks
>   running on any machine other than the one you are targetting.

Right, but that's debug, not core kernel configuration.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
