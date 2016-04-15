From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 15 Apr 2016 13:23:06 +0300
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <20160414203457.GM5995@atomide.com>
References: <20160404151200.GA4652@atomide.com> <5703BA6B.1080208@ti.com>
 <20160411212845.GJ5995@atomide.com> <570CC54E.6020703@ti.com>
 <20160412163750.GR5995@atomide.com> <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com> <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com> <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com>
Message-ID: <5710C10A.6040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/16 23:34, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [160414 12:38]:
>>
>> Yes it has registers, but it has no prcm level existence, it is part of McBSP
>> module. I guess when the OMAP3 was designed the HW people did not wanted to
>> create new version of the McBSP core for McBSP2/3 so they attached a new core
>> to the McBSP cores with different targets, etc, but w/o external dependency.
> 
> Yeah well we do have a bunch of modules that don't need any separate
> functional clock and are clocked only by the interface clock. So in this
> case McBSP and sidetone are both consumers for the clock we just happen
> to call McBSP interface clock. They should be able to share that no
> problem.
> 
>>>> OK. I will go with the assumption that the sidetone hwmod can be removed (as
>>>> it is not correct) and rework my current series to use pdata callback for the
>>>> iclk autogate allow/deny. With this set the ST will be operational in legacy
>>>> and DT boot.
>>>
>>> Sorry, no I did not want to drop the sidetone hwmod, I was just trying to
>>> come up with ideas on how to make the driver changes easier. It sounds like
>>> you already figured out the driver changes part though with two drivers.
>>
>> If I need to keep the sidetone hwmod around I don't see how it can be done in
>> a safe and clean way. It is part of McBSP module, it is accessible only if the
>> McBSP module is enabled, you can not enable the Sidetone alone you need to go
>> and enable the McBSP module. I don't think it is a good idea to let two
>> separate hwmods to poke around the same PRCM bits. Have not checked, but I
>> don't think we have refcounting for the PRCM register bits.
> 
> Yeah there's no refcounting on the PRCM, but the clock framework has it
> for the share McBSP interface clock.

The hwmod checks the bits described by prcm.omap2. If two hwmods are set up to
manage/monitor the same bits in PRCM, what will happen when the two driver
does pm_runtime?

CM_ICLKEN_PER[0] = 1
McBSP2: runtime_get_sync()
CM_ICLKEN_PER[0] = 0
...
CM_ICLKEN_PER[0] = 0
McBSP2.ST: runtime_get_sync() // hwmod might complain as the idlest was not 1?
CM_ICLKEN_PER[0] = 0
...
CM_ICLKEN_PER[0] = 0
McBSP2.ST: runtime_put_sync()
CM_ICLKEN_PER[0] = 0 // hwmod might warn that the module did not went idle?
...
CM_ICLKEN_PER[0] = 0
McBSP2: runtime_put_sync()
CM_ICLKEN_PER[0] = 1


We can hack this around by adding HWMOD_NO_IDLEST to the sidetone hwmod I
guess. As the sidetone does not have PRCM level control - it is part of McBSP.

> Then there are two separate sets of sysconfig registers that PM runtime should manage.

The sidetone core's sysconfig register is internal to McBSP module. This is
what the TRM has to say about McBSPi.ST_SYSCONFIG_REG[0] AUTOIDLE bit:
- When this bit is asserted (set to 1), the McBSPi_ICLK clock auto-gating is
enabled and this clock is disabled internally to the SIDETONE feature, thus
reducing power consumption, but not to the McBSP module that contains this
feature.
After reset, the automatic clock gating is enabled; thus, this bit must be
disabled by software for activated SIDETONE feature.
- When this bit is set to 0, the McBSPi_ICLK clock auto-gating is disabled and
this clock is enabled. The SIDETONE feature can be used normally.

The ST_SYSCONFIG_REG is internal to the McBSP module the ST is integrated into.

> And then there's the clock autogating issue.
> 
> Note that we do have an issue with the omap4 and later clkctrl registers
> that don't have refcounting. Tero's clkctrl work will sort out that
> issue. I don't think we have a similar issue with omap3.
> 
> So from that point of view the two separate hwmod modules should work
> just fine sharing the clock.
> 
>> I have things working w/o the two drivers with pdata callback both in legacy
>> and DT case and it is pretty neat looking, thanks for the suggestion! I'm
>> still figuring out the needed amount of callbacks from McBSP to ST and from ST
>> to McBSP. We for sure going to need enable_stage1,2 probably three as well.
>> But this crossing driver boundaries needs a bit more time to figure out.
> 
> Yeah I still think we need to struct device instances, one to manage
> McBSP and the other to manage sidetone :)

I'm still not convinced about the benefits of creating separate device for the
ST core of McBSP.
>From my point of view:
McBSP2 module consist of:
- McBSP core
 - clock generator subcore
 - tx subcore
 - rx subcore
- Sidetone core

it is one piece of IP.
I don't know why the hw guys decided to not extend the McBSP IP itself with
the sidetone feature, I'm sure they had their reasons to not touch the McBSP
core, but to add another core to the McBSP module.

The documentation also treats the Sidetone as an additional feature to the
McBSP core functionality.

-- 
P?ter
