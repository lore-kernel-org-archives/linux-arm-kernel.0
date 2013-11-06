From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 6 Nov 2013 17:19:48 +0900
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <1410337.86GqGttdXc@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoRrDT49NXFS6rxMYnp9es_9mj+SjKpFfWja1s8V3W1nfw@mail.gmail.com>
 <1410337.86GqGttdXc@avalon>
Message-ID: <CANqRtoSJoC7DNwTze9MYzk1RhPOm4YEr7KkBdPnRX_7nefrjLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Wed, Nov 6, 2013 at 8:47 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> (And a question for Mike below)
>
> On Tuesday 05 November 2013 16:56:40 Magnus Damm wrote:
>> On Tue, Oct 29, 2013 at 11:55 PM, Laurent Pinchart wrote:
>> > The R8A7790 has several clocks that are too custom to be supported in a
>> > generic driver. Those clocks can be divided in two categories:
>> >
>> > - Fixed rate clocks with multiplier and divisor set according to boot
>> >   mode configuration
>> >
>> > - Custom divider clocks with SoC-specific divider values
>> >
>> > This driver supports both.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>> > ---

>> > +void __init r8a7790_clocks_init(u32 mode)
>> > +{
>> > +       cpg_mode = mode;
>> > +
>> > +       of_clk_init(NULL);
>> > +}
>>
>> Hi Laurent,
>>
>> Thanks a lot for your efforts on this. In general I think it all looks good,
>
> Thank you.
>
>> I have however one question regarding the "probe" interface between the SoC
>> code in arch/arm/mach-shmobile and drivers/clk. The code above in
>> r8a7790_clocks_init() looks a bit spaghetti-style to me, perhaps it is
>> possible to make it cleaner somehow?
>
> Isn't it just a loop ? :-) The clocks handled by this driver are "special",
> they need to be initialized manually.

Spaghetti-O's? =) I agree that some special handling is needed.

>> I realize that you need some way to read out the mode pin setting, and that
>> is currently provided by the SoC code in arch/arm/mach-shmobile/. Today it
>> seems that you instead of letting the drivers/clk/ code call SoC code to get
>> the mode pin setting (and add a SoC link dependency) you simply feed the
>> settings to the clk code from the SoC code using the parameter to
>> r8a7790_clocks_init(). This direction seems good to me. I'm however not too
>> keen on the current symbol dependency in the "other" direction.
>>
>> If possible I'd like to keep the interface between the SoC code and the
>> driver code to "standard" driver model functions. For instance, using
>> of_clk_init(NULL) from the SoC code seems like a pretty good standard
>> interface - without any link time dependencies. So with the current code,
>> the r8a7790_clocks_init() function somehow goes against this no-symbol-
>> dependency preference that I happen to have. =)
>>
>> Would it for instance be possible let the SoC code read out the mode pin
>> setting, and then pass the current setting using the argument of
>> of_clk_init() to select different dividers? That way the symbol dependency
>> goes away. Or maybe it becomes too verbose?
>
> The of_clk_init() argument is an array of struct of_device_id that is used by
> the clock core to match device tree nodes. I don't really see how you would
> like to use it to pass the boot mode pins state to the driver.

Yeah, it seems that interface isn't such a good match. Thanks.

> There is currently no dedicated API (at least to my knowledge) to pass clock
> configuration information between arch/arm and drivers/clk. Here's a couple of
> methods that can be used.
>
> - Call a drivers/clk function from platform code with the clock configuration
> information and store that information in a driver global variable for later
> use (this is the method currently used by this patch).
>
> - Call a platform code function from driver code to read the configuration.
> This is pretty similar to the above, with a dependency in the other direction.
>
> - Read the value directly from the hardware in the clock driver. This doesn't
> feel really right, as that's not the job of the clock driver. In a more
> general case this solution might not always be possible, as reading the
> configuration might require access to resources not available to drivers.
>
> - Create a standard API for this purpose. It might be overengineering.
>
> - Use AUXDATA filled by platform code.
>
> There might be other solutions I haven't thought of. I went for the first
> method as there's already 8 other clock drivers that expose an initialization
> function to platform code. I might just have copied a mistake though.

Thanks for listing these. I have come across another option:

Use of_update_property() and of_property_read_u32() to pass using a
property, see below.

> Mike, do you have an opinion on this ? In a nutshell, the code clocks are
> fixed factor but their factor depend on a boot mode configuration. The
> configuration value is thus needed when instantiating the clocks. It can be
> read from a hardware register, outside of the clocks IP core.

Yeah, I too would be interested to hear what Mike thinks about this matter.

Please see below for a prototype patch on top of your code that shows
the driver side of my DT property proposal. The omitted SoC side
becomes slightly more complicated but that code can be shared between
multiple R-Car SoCs so I think it should be acceptable size-wise.

With this patch applied the interface between the driver and the SoC
code is a DT property (that needs documentation) and
of_clk_init(NULL). No more evil link time symbol dependencies between
arch/ and drivers/...

 drivers/clk/shmobile/clk-r8a7790.c |   15 ++++++---------
 include/linux/clk/shmobile.h       |   19 -------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

--- 0018/drivers/clk/shmobile/clk-r8a7790.c
+++ work/drivers/clk/shmobile/clk-r8a7790.c     2013-11-06 16:59:59.000000000 +0
900
@@ -12,7 +12,6 @@

 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
-#include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -70,8 +69,6 @@ static const struct clk_div_table cpg_sd
        { 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
 };

-static u32 cpg_mode __initdata;
-
 #define CPG_SDCKCR                     0x00000074

 static void __init r8a7790_cpg_clocks_init(struct device_node *np)
@ -80,6 +77,12 @@ static void __init r8a7790_cpg_clocks_in
        struct r8a7790_cpg *cpg;
        struct clk **clks;
        unsigned int i;
+       u32 cpg_mode;
+
+       if (of_property_read_u32(node, "cpg-mode", &cpg_mode)) {
+               pr_err("%s: failed to determine CPG mode\n", __func__);
+               return;
+       }

        cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
        clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
@ -168,9 +171,3 @@ static void __init r8a7790_cpg_clocks_in
 CLK_OF_DECLARE(r8a7790_cpg_clks, "renesas,r8a7790-cpg-clocks",
               r8a7790_cpg_clocks_init);

-void __init r8a7790_clocks_init(u32 mode)
-{
-       cpg_mode = mode;
-
-       of_clk_init(NULL);
-}
--- 0018/include/linux/clk/shmobile.h
+++ /dev/null   2013-06-03 21:41:10.638032047 +0900
@@ -1,19 +0,0 @@
-/*
- * Copyright 2013 Ideas On Board SPRL
- *
- * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef __LINUX_CLK_SHMOBILE_H_
-#define __LINUX_CLK_SHMOBILE_H_
-
-#include <linux/types.h>
-
-void r8a7790_clocks_init(u32 mode);
-
-#endif

Cheers,

/ magnus
