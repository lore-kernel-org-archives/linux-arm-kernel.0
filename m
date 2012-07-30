From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 30 Jul 2012 18:26:57 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain
 transitioning to OFF when in-use
In-Reply-To: <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
 <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1207111441300.25585@utopia.booyaka.com>
 <500028B3.1040309@ti.com>
 <alpine.DEB.2.00.1207131418500.25585@utopia.booyaka.com>
 <50045D17.9050704@ti.com>
 <alpine.DEB.2.00.1207161228470.28834@utopia.booyaka.com>
Message-ID: <50171841.40309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 07/16/2012 01:38 PM, Paul Walmsley wrote:
> Hi Jon,
> 
> On Mon, 16 Jul 2012, Jon Hunter wrote:
> 
>> Yes I see that makes sense. However, patch #7 has already changed the
>> mapping of the flags. I had intended that patch #7 and #8 would be
>> applied together. However, I could see that patch #7 can be taken just
>> to eliminate using the SW_SLEEP state. So basically, what I am saying is
>> does patch #7 have any value without #8?
> 
> Certainly not as much value as it had before.  But my understanding, which 
> is possibly incorrect, matches what you wrote in patch #7's description:
> 
> "For OMAP4 devices, SW_SLEEP is equivalent to HW_AUTO and NO_SLEEP is 
> equivalent to SW_WKUP. The only difference between HW_AUTO and SW_SLEEP 
> for OMAP4 devices is that the PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt 
> status is set in case of SW_SLEEP transition, and not set in case of 
> HW_AUTO transition."
> 
> We don't use that PRM_IRQSTATUS_MPU.TRANSITION_ST interrupt bit.  So if 
> SW_SLEEP and HW_AUTO really have identical meanings otherwise, then I 
> suppose we might as well use the one that does what we need with no 
> extraneous side-effects?  My recollection from a conversation with Beno?t 
> a few months ago was that this was his view as well.
> 
>> That's fine with me. We can always workaround such issues by adding flags.
>>
>> I can give this a try this week and let you know how it goes.
> 
> Okay, great.  No rush on my account.

I have been testing your patch [1] on OMAP3 and found that the EMU
clock domain was not being disabled for two reasons. 

1. When HWMOD attempts to disable the clock domain for OMAP2/3 devices 
   we simply return without doing anything. Not sure if it is safe to 
   remove this but I can do some more testing on OMAP2/3. 

commit a0307bd539ecef976793679a1c4ff0d47b22c4bd
Author: Jon Hunter <jon-hunter@ti.com>
Date:   Mon Jul 30 18:04:06 2012 -0500

    ARM: OMAP2/3: Allow HWMOD to disable clock domains
    
    Currently when HWMOD attempts to disable a clock domain on OMAP2/3 devices we
    will return from the function clkdm_hwmod_disable() without actually disabling
    the clock domain. Per the comment this is deliberate because initially HWMOD
    OMAP2/3 devices did not support clock domains. However, clock domains are now
    supported by HWMOD for these devices and so allow HWMOD to disable the clock
    domains.
    
    XXX - Tested on OMAP3430 beagle board, but needs more testing on OMAP2/3

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 011186f..8f7a941 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1075,10 +1075,6 @@ int clkdm_hwmod_enable(struct clockdomain *clkdm, struct omap_hwmod *oh)
  */
 int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
 {
-       /* The clkdm attribute does not exist yet prior OMAP4 */
-       if (cpu_is_omap24xx() || cpu_is_omap34xx())
-               return 0;
-
        /*
         * XXX Rewrite this code to maintain a list of enabled
         * downstream hwmods for debugging purposes?


2. I need to make the following changes to your patch. The change to
   omap2_clkdm_clk_disable() was needed to get the EMU to turn off.
   At the same time I thought we should make the same change to
   omap2_clkdm_clk_enable().

diff --git a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
index 09385a9..c94b2fb 100644
--- a/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
@@ -223,7 +223,8 @@ static int omap2_clkdm_clk_enable(struct clockdomain *clkdm)
                _enable_hwsup(clkdm);
        } else {
                if (clkdm->flags & CLKDM_CAN_FORCE_WAKEUP)
-                       omap2_clkdm_wakeup(clkdm);
+                       (cpu_is_omap24xx()) ? omap2_clkdm_wakeup(clkdm) :
+                               omap3_clkdm_wakeup(clkdm);
        }
 
        return 0;
@@ -257,7 +258,8 @@ static int omap2_clkdm_clk_disable(struct clockdomain *clkdm)
                _enable_hwsup(clkdm);
        } else {
                if (clkdm->flags & CLKDM_CAN_FORCE_SLEEP)
-                       omap2_clkdm_sleep(clkdm);
+                       (cpu_is_omap24xx()) ? omap2_clkdm_sleep(clkdm) :
+                               omap3_clkdm_sleep(clkdm);
        }


I need to do more testing but wanted to give you this feedback and
get your comments.

Cheers
Jon

[1] http://marc.info/?l=linux-arm-kernel&m=134212814812557&w=2
