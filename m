From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 23 Apr 2012 11:58:37 +0530
Subject: [PATCH 00/19] ARM: OMAP4 device off support
In-Reply-To: <1334934436.2149.49.camel@sokoban>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
 <1334926721.2149.40.camel@sokoban> <87vckupkxj.fsf@ti.com>
 <1334933002.2149.44.camel@sokoban>
 <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
 <1334934436.2149.49.camel@sokoban>
Message-ID: <CAM=Q2cv7saQXuOCieGZ3TgUG0NNxSdmME9orAw=tHdkRrDEsqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 8:37 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On Fri, 2012-04-20 at 20:21 +0530, Datta, Shubhrajyoti wrote:
>> On Fri, Apr 20, 2012 at 8:13 PM, Tero Kristo <t-kristo@ti.com> wrote:
>> > On Fri, 2012-04-20 at 06:55 -0700, Kevin Hilman wrote:
>> >> Tero Kristo <t-kristo@ti.com> writes:
>> >>
>> >> [...]
>> >>
>> >> >> I tried your branch on gp/emu devices but could not reproduce this issue.
>> >> >> My observation is that while resuming, omap_hsmmc.1 eMMC is
>> >> >> trying to turn on phoenix vaux1 regulator via i2c which fails due
>> >> >> to controller timeout.
>> >> >> Note: eMMC is present only on sdp/blaze
>> >> >
>> >> > Did you try this with off-mode enabled and did you check the device
>> >> > actually goes to off? (see pm_debug/count and verify core off count is
>> >> > increasing.) And as said, I was only able to see this problem on a blaze
>> >> > device, panda works fine. But yes, you are probably right and it is not
>> >> > an MMC driver issue but I2C.
>> >>
>> >> Can you try the patch below? ?It sounds like the same problem.
>> >
>> > Doesn't help with this one. I guess I2C loses context during device off
>> > and it is not restored properly.
>> >
>> > -Tero
>> Could you try the following patch
>>
>> https://lkml.org/lkml/2012/3/30/345
>
> That does the trick, after this it is working fine on blaze, and this
> also fixes the timeout issues seen on panda board (meaning wake-up from
> device off is much faster.)

Thats great.
Feel free to try the following.
I2C conditional restore"
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg66859.html

Also cooked a below rfc/untested patch for mmc restore.



>From c28ec76f8a20c3ce59b72245ab9f3bc293b1ac43 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti D <shubhrajyoti@ti.com>
Date: Mon, 23 Apr 2012 11:52:54 +0530
Subject: [RFC PATCH] hsmmc: omap: Support for device off

Attempt to have device off support. Current the function hsmmc_get_context_loss
is made NULL for OMAP4. Remove it as post Terro's patches context may be lost.
Also it is good to have no assumptions of the context loss in the
driver.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/hsmmc.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index b0268ea..2361f24 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,17 +32,11 @@ static u16 control_mmc1;

 #define HSMMC_NAME_LEN 9

-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-
 static int hsmmc_get_context_loss(struct device *dev)
 {
        return omap_pm_get_dev_context_loss_count(dev);
 }

-#else
-#define hsmmc_get_context_loss NULL
-#endif
-
 static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
                                  int power_on, int vdd)
 {
--
1.7.0.4
