From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 10 Feb 2017 14:17:14 +0000
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <25202835.AdbHsoUg0y@wuerfel>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
 <SG2PR06MB11650C805DD754EE5C9E56C78A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <25202835.AdbHsoUg0y@wuerfel>
Message-ID: <SG2PR06MB11650D666A5942A0060A85368A440@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 10, 2017, Arnd Bergmann wrote:
> I also couldn't come up with something working when I looked at this, and
> it wouldn't solve the related problem of platforms that we want to be able
> to use with or without MMU: You can't make the decision of whether allow
> an MMU based on the number of platforms since most platform options can
> only be offered depending on the setting of CONFIG_MMU.


How about this idea (from a high level only):

1. At a top level, you would have 2 options:
   * "Allow multiple platforms to be selected"
   * "Single platform Only"

2. If SINGLE is selected, you still get all the choices that you
   get with MULTI, except as soon as you click a single ARCH_xx, all
   other ARCH_yy options are automatically 'unselected' and disappear
   from the menus. To change your mind, you simply uncheck that box
   and magically everything re-appears.

3. The current single platform ARCHs that are currently still sitting
   at the top level get moved to go sit with everyone else, except
   they will have "depends on SINGLE" so they will not show up
   when MULTI is selected.

4. XIP_KERNEL can only be selected if you have SINGLE selected.

The new restriction is that if you want XIP_KERNEL, you are
only going to get 1 (and only 1) ARCH_xx.

Of course the only way this is going to happen is by modifying kbuild
system to create a new 'mode' or something (but let's not get concerned
with the details until a high level agreement can be made).


> - In some platforms, the decision would have to be done on a per-board
>   level, as each board can have its memory at a different location
>   base on which chipselect line got connected to the RAM and NOR flash
>   respectively

This idea only effects ARCH_xx. You can still select multiple MACH_xx if
you want after you've selected your ARCH_xx.


> - Some (few) platforms actually have separate top-level Kconfig options
>   but are actually very closely related and you could have a kernel
>   for all of them even with !MMU and XIP_KERNEL. The most important
>   one here is ARM Versatile/Realview/Integrator/Vexpress that have
>   more in common than things we put behind a common Kconfig option in
>   other platforms.

So, this one gets squashed because for XIP_KERNEL, you have to pick
just 1 ARCH_xx.


> - CONFIG_DEBUG_UNCOMPRESS has a very similar requirements to
>   XIP_KERNEL and !MMU, and we currently allow it for any machine,
>   with a lot of flexibility in configuring that always breaks
>   running on any machine other than the one you are targetting.

Since the purpose of this is "debugging" a single platform, could you
put this under the "depends on SINGLE" category?


What I'm trying to understand is if:
A. There is something that can be agreed upon (whether it's technically
   feasible still needs to be worked out)

B. It doesn't work today, and there's no way to make everyone happy,
   so go hack your own Kconfig files and just live with it.


Chris
