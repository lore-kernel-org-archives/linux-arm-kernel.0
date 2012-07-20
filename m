From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 20 Jul 2012 17:24:03 -0500
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
Message-ID: <5009DA83.4040909@ti.com>
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

I have been testing this today and is working well for OMAP4. However, I
noticed that this is not working for OMAP3. The problem for OMAP3 is
that we don't have hwmod support for the debugss in OMAP3 and so the
flag CLKDM_CAN_ENABLE_AUTO is shutting down the EMU PD on boot. To be
honest it is clear to me now that PMU support on OMAP3 needs some work
as it is dependent on the ETM driver as highlighted by Will.

So I think that this patch will work but I need to create a hwmod for
OMAP3's debugss. Are you able to generate this or just Benoit? I could
probably create something by hand but did not know if we could
auto-generate.

Cheers
Jon
