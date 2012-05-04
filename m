From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 4 May 2012 17:17:36 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120426180719.GC20186@mudshark.cambridge.arm.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com> <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com> <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
 <20120426180719.GC20186@mudshark.cambridge.arm.com>
Message-ID: <4FA45580.8070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 04/26/2012 01:07 PM, Will Deacon wrote:
> On Wed, Apr 04, 2012 at 12:15:24PM +0100, Will Deacon wrote:
>> On Wed, Apr 04, 2012 at 12:29:49AM +0100, Paul Walmsley wrote:
>>>
>>> Part of the problem is that the clockdomain data for the emu_sys 
>>> clockdomain is wrong.  Here's something to try to fix it.  It might just 
>>> be enough to get it to work.
>>
>> Hmm, doesn't seem to work but I do see the following in dmesg when I try to
>> use perf:
>>
>>  powerdomain: waited too long for powerdomain emu_pwrdm to complete transition
>>
>> which is new with your patch.
> 
> Sorry to nag, but does anybody have a clue where to go from here? I can
> start digging in the OMAP PM code, but it's all new territory for me.

I did a little playing around with this today and I think that I have figured out why this was not working (see below). Please can you try the following patch? I tried this on top of your series for perf/omap4. 

Paul, FYI. If this works for Will then I can re-base on top of the latest linux-omap and submit to the mailing list.

Also, the above error about the emu_pwrdm is odd too. I noticed that the emu_pwrdm is always in the transitioning state. And when I say always, I mean that even if I check the power domain state while u-boot is running it is in the transitioning state. So even before the kernel starts. 

Cheers
Jon 

>From 9137ff9c1b382232de7443db0b51b7555846fb62 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jon-hunter@ti.com>
Date: Fri, 4 May 2012 16:48:45 -0500
Subject: [PATCH] ARM: OMAP4: Disable auto enable for EMU CLKDM

The flag CLKDM_CAN_HWSUP allows the clock-domain to automatically transition
to the enabled and disabled state. This means that as soon as we force a
software wake-up on the clock domain, the clock domain will be allowed to idle
and put back into the hardware auto state. For the EMU clock domain this is not
what we want. We want to keep the clock domain in the software wakeup state
while the clock domain is being used and put it back in to the hardware auto
state when we have finished using the clock domain.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..dd2cd96 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-	.flags		  = CLKDM_CAN_HWSUP,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_DISABLE_AUTO,
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
-- 
1.7.5.4
