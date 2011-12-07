From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 7 Dec 2011 15:17:31 +0100
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <20111206165215.GE31337@atomide.com>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
 <20111205211136.GF14542@n2100.arm.linux.org.uk>
 <20111205231909.GA31337@atomide.com> <20111206000232.GC31337@atomide.com>
 <20111206165215.GE31337@atomide.com>
Message-ID: <4EDF757B.8020200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Marc

Hi Tony,

On 12/6/2011 5:52 PM, Tony Lindgren wrote:
> * Tony Lindgren<tony@atomide.com>  [111205 15:34]:
>> * Tony Lindgren<tony@atomide.com>  [111205 14:51]:
>>> * Russell King - ARM Linux<linux@arm.linux.org.uk>  [111205 12:40]:
>>>> Tony,
>>>>
>>>> Can you please treat this with the utmost urgency.  If I don't get a
>>>> reply from you within the next two hours, then I'm committing this
>>>> merge resolution whether or not it's correct for you - as I have other
>>>> stuff which needs to be committed to my tree and I can't wait any
>>>> longer for your reply.
>>>
>>> Sorry only now saw this. Looking at it now.
>>
>> Here's what I would do:
>>
>> 1. Apply Santosh' omap2plus_defconfig patches first into devel-stable at
>>     commit 53fadbdd83039bb1181e4ff76123d612cdf26c37 (Merge branch
>>     'irqchip-consolidation' ...). The patches in question are 7188/1 and
>>     patch 7189/1.
>>
>> 2. Pull Will's for-rmk branch on top of that
>>
>> 3. Run git mergetool which produces the resolution you posted earlier
>>
>> 4. Before committing apply the following build fix and run git update-index
>>     arch/arm/mach-omap2/display.c. This came from the DSS fixes in -rc4.
>>
>> Then it all builds and boots fine.
> 
> Added the following fix into patch system as 7194/1. Russell, can you
> please apply that one into your devel-stable so we have a common
> base for folks to base other omap patches on?

Please note that we still have a regression for the OMAP3/4 DT boot on this branch.
The board-generic.c file was not updated for all the machine descriptors inside it
during irqchip-consolidation series.

The following patch fixes that.

Regards,
Benoit 

---
>From 0c8b4ed454ab9d5cbb267eaf236d0b14c7c6896a Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Wed, 7 Dec 2011 13:46:55 +0100
Subject: [PATCH] ARM: OMAP2+: board-generic: Add missing handle_irq callbacks

The following commit: 6b2f55d7851aa358d3a99cff344c560c4967f042,
is adding the support for the CONFIG_MULTI_IRQ_HANDLER but did
not update all the machine descriptors supported in the DT
board-generic.c file.
It thus break the DT boot on OMAP3 and OMAP4 boards.

Add the proper handle_irq callbacks for OMAP3 and OMAP4 generic
machine descriptors.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-omap2/board-generic.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 63b5416..e493877 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -17,6 +17,7 @@
 #include <linux/i2c/twl.h>
 
 #include <mach/hardware.h>
+#include <asm/hardware/gic.h>
 #include <asm/mach/arch.h>
 
 #include <plat/board.h>
@@ -103,6 +104,7 @@ DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.map_io		= omap242x_map_io,
 	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
+	.handle_irq	= omap2_intc_handle_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
 	.dt_compat	= omap242x_boards_compat,
@@ -140,6 +142,7 @@ DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
 	.map_io		= omap3_map_io,
 	.init_early	= omap3430_init_early,
 	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.init_machine	= omap3_init,
 	.timer		= &omap3_timer,
 	.dt_compat	= omap3_boards_compat,
@@ -158,6 +161,7 @@ DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
 	.map_io		= omap4_map_io,
 	.init_early	= omap4430_init_early,
 	.init_irq	= gic_init_irq,
+	.handle_irq	= gic_handle_irq,
 	.init_machine	= omap4_init,
 	.timer		= &omap4_timer,
 	.dt_compat	= omap4_boards_compat,
-- 
1.7.0.4
