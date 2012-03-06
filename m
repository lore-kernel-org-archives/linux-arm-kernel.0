From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 06 Mar 2012 09:51:42 +0530
Subject: [PATCHv4 5/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
In-Reply-To: <alpine.DEB.2.00.1203052057050.6649@utopia.booyaka.com>
References: <1330701475-22576-1-git-send-email-t-kristo@ti.com>
 <1330701475-22576-6-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1203052057050.6649@utopia.booyaka.com>
Message-ID: <4F5590D6.8030707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Tuesday 06 March 2012 09:32 AM, Paul Walmsley wrote:
> Hi
>
> a few comments:
>
> On Fri, 2 Mar 2012, Tero Kristo wrote:
>
>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>
>> IO Daisychain feature has to be triggered whenever there is a change in
>> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
>>
>> Now devices can idle independent of the powerdomain, there can be a
>> window where device is idled and corresponding powerdomain can be
>> ON/INACTIVE state. In such situations, since both module wake up is
>> enabled at padlevel as well as io daisychain sequence is triggered,
>> there will be 2 PRCM interrupts (Module async wake up via swakeup and
>> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
>> Padlevel WKST bit in the first interrupt, module specific interrupt
>> handler will not triggered for the second time
>>
>> Also look at detailed explanation given by Rajendra at
>> http://www.spinics.net/lists/linux-serial/msg04480.html
>>
>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
>>   arch/arm/mach-omap2/pm.c         |   15 +++++++++++++++
>>   arch/arm/mach-omap2/pm.h         |    1 +
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 5192cab..56adbfb 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>
> ...
>
>> @@ -1535,8 +1536,10 @@ static int _enable(struct omap_hwmod *oh)
>>   	/* Mux pins for device runtime if populated */
>>   	if (oh->mux&&  (!oh->mux->enabled ||
>>   			((oh->_state == _HWMOD_STATE_IDLE)&&
>> -			 oh->mux->pads_dynamic)))
>> +			 oh->mux->pads_dynamic))) {
>>   		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>> +		omap_trigger_io_chain();
>
> Looks racy: if two hwmods with dynamic mux entries go idle at the same
> time, or one goes idle while another one is enabled, won't the calls to
> omap_trigger_io_chain() race?  Locking is per-hwmod and there's no locking
> in omap_trigger_io_chain() or the functions it calls.

I agree, this needs locking to avoid races.

>
> Also, won't this result in needless resets of the I/O chain?  Seems like
> we'd only need to do this when the next power state of the enclosing
> powerdomain will enter either RETENTION or OFF.  And even then, it
> presumably should only happen when the last active device in that
> powerdomain is going idle?

Yes, the module async wakeups will work as long as the power domain
enclosing the module is not in OSWR or OFF, so ideally this trigger
should happen only when all modules in the given powerdomain are
disabled and we plan to program the Powerdomain down to OSWR or
OFF state. With what we are doing today we end up with periods when we
have multiple wakeups (a module wakeup as well as an IO wakeup).
The last we discussed this with Kevin, there wasn't a better place where
we could trigger this, with no usecounting at powerdomain level you
didn't know when the last active device in the powerdomain was going
idle.
But now with Tero's series which adds usecounting at power/voltage
domain level, maybe its possible, but I need to look more.
Do you already have an idea on where this would fit better, so we
avoid this multiple wakeup scenario?

regards,
Rajendra

>
>
> - Paul
