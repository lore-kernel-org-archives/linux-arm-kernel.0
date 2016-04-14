From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Apr 2016 22:37:07 +0300
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <20160414165514.GL5995@atomide.com>
References: <20160402001753.GR9329@atomide.com> <57026205.6020105@ti.com>
 <20160404151200.GA4652@atomide.com> <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com> <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com> <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com> <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com>
Message-ID: <570FF163.1050603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2016 07:55 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160414 00:35]:
>> On 04/13/16 18:28, Tony Lindgren wrote:
>>>
>>> You could just create the sidetone child device manually on probe in the
>>> driver as needed. That way you'd have two devices to do the PM runtime
>>> on. I think that was Paul's main concern as they are separate modules.
>>
>> You mean that not to have separate compatible for the McBSP module's Sidetone
>> core?
>> If yes, then it is a valid thing to remove the hwmod data for the sidetone,
>> like I did in this series.
> 
> No, I meant keep the sidetone hwmod, it really is there in the hardware.

Hrm, the Sidetone is there, yes. It is part of the McBSP module and the hwmod
for the sidetone is not correct. From hwmod (or PRCM) point of view there is
no sidetone module, there is only McBSP module which consist of McBSP core and
Sidetone core.

> I meant only probe the sidetone in the McBSP probe so you have two
> struct dev and two hwmod entries in the McBSP driver. I don't know if
> this actually makes things easier or not though.

But the hwmod for the sidetone is wrong, there should not have been hwmod for
the sidetone to start with.

>>> It still leaves the chance of bugs with flush of posted writes. But might
>>> make things easier to deal with in small steps?
>>
>> The only 'benefit' I see with separated driver for McBSP core and Sidetone
>> core is that the register writes will happen to the cores in separate drivers.
>>
>> If the McBSP driver creates the device for the sidetone driver, then passing
>> the needed callbacks and data to it is going to be cleaner. Registering back
>> the callbacks to McBSP is what need to be figured out, so it is simple and
>> clean. Either with a callback to McBSP to set the ST callbacks or have the
>> callback struct used by ST via pdata to have places for the ST to McBSP
>> callbacks and when the driver loads it is going to set up those.
> 
> OK yeah makes sense to me.
> 
>> If I remove the prcm section for the ST hwmod:
>> [   87.784820] omap_hwmod: mcbsp2_sidetone: _wait_target_ready failed: -22
>> [   87.784851] omap-mcbsp 49022000.mcbsp: use pm_runtime_put_sync_suspend() in
>> driver?
>>
>> When first try to use the audio.
>> So the hwmod code at least was checking the idlest bit.
> 
> Yes the module is really there for sidetone, and it really has hardware
> registers :)

Yes it has registers, but it has no prcm level existence, it is part of McBSP
module. I guess when the OMAP3 was designed the HW people did not wanted to
create new version of the McBSP core for McBSP2/3 so they attached a new core
to the McBSP cores with different targets, etc, but w/o external dependency.

>> OK. I will go with the assumption that the sidetone hwmod can be removed (as
>> it is not correct) and rework my current series to use pdata callback for the
>> iclk autogate allow/deny. With this set the ST will be operational in legacy
>> and DT boot.
> 
> Sorry, no I did not want to drop the sidetone hwmod, I was just trying to
> come up with ideas on how to make the driver changes easier. It sounds like
> you already figured out the driver changes part though with two drivers.

If I need to keep the sidetone hwmod around I don't see how it can be done in
a safe and clean way. It is part of McBSP module, it is accessible only if the
McBSP module is enabled, you can not enable the Sidetone alone you need to go
and enable the McBSP module. I don't think it is a good idea to let two
separate hwmods to poke around the same PRCM bits. Have not checked, but I
don't think we have refcounting for the PRCM register bits.

I have things working w/o the two drivers with pdata callback both in legacy
and DT case and it is pretty neat looking, thanks for the suggestion! I'm
still figuring out the needed amount of callbacks from McBSP to ST and from ST
to McBSP. We for sure going to need enable_stage1,2 probably three as well.
But this crossing driver boundaries needs a bit more time to figure out.

-- 
P?ter
