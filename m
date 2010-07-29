From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 29 Jul 2010 23:41:44 +0200
Subject: [PATCH] ARM: fix regression in RealView after the introduction of
	pclk
In-Reply-To: <20100729135639.GE18923@n2100.arm.linux.org.uk>
References: <1280408722-31995-1-git-send-email-linus.walleij@stericsson.com>
	<20100729135639.GE18923@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=xcFsL7vCtG31v0yWfkBV+vYqQZ4z=_p-=wZnH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> I think this can just be made core_initcall() rather than going to the
> lengths that this patch does - all we need to do is ensure that the
> clocks are registered before the machine init code is called, and
> core_initcall() will do that for us.

Yep that is true, currently. More like this then:

From: Linus Walleij <linus.walleij@stericsson.com>
Date: Thu, 29 Jul 2010 23:04:20 +0200
Subject: [PATCH] ARM: fix regression in RealView after the
introduction of pclk v2

The patch to add the apb_pclk to the AMBA/PrimeCell bus broke
RealView, since the clockdevice is not registered at probe() time.
This moves clock initialization to a core_initcall()

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-realview/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index d8179ea..a54fbda 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -370,7 +370,7 @@ static int __init clk_init(void)

        return 0;
 }
-arch_initcall(clk_init);
+core_initcall(clk_init);

 /*
  * CLCD support.
-- 
1.7.2

There is a reason why we have it on the interrupt init in ux500
though, and that is that we want to use the clock framework to
get the clock for the timer. If we want to fix up the hardcoded
way it is currently done in plat-versatile/timer-sp.c we would need
a change like this across the versatiles.

But I'll make a separate patch doing all that across the
versatiles so it get put in context, this fix is  fine in the meantime.

Yours,
Linus Walleij
