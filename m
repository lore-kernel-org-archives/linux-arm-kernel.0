From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Apr 2016 10:34:28 +0300
Subject: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
In-Reply-To: <20160413152829.GQ5995@atomide.com>
References: <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com> <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com> <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com> <20160411212845.GJ5995@atomide.com>
 <570CC54E.6020703@ti.com> <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com> <20160413152829.GQ5995@atomide.com>
Message-ID: <570F4804.4050006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/16 18:28, Tony Lindgren wrote:
>>> Oh but not with EXPORT_SYMBOL so not usable except for built-in code.
>>> Probably best to keep it that way IMO..
>>
>> It is up to Tero if he want to keep omap2_clk_allow/deny_idle() only be usable
>> for built in code. It is there just because of OMAP3 McBSP2/3 sidetone support
>> on the other hand. It is a fair assumption that it could be used by the driver.
> 
> The problem with EXPORT_SYMBOL is that it tends to then suddenly then get
> used all over the drivers. And we've seen what that means..

:) Yes, I agree.

>>>> Why not to remove the callback for legacy also and handle it in the driver? It
>>>> is less ugly in my opinion.
>>>> Going via the pdata callback is just going to cement the current setup.
>>>
>>> Sure, maybe you can have a piece of built-in driver code to do that?
>>
>> You mean something like:
>> int omap3_mcbsp23_ick_for_sidetone_force(struct clk *clk, bool force_on)
>> {
>> 	if (!clk)
>> 		return 0;
>>
>> 	if (force_on)
>> 		return omap2_clk_deny_idle(clk);
>> 	else
>> 		return omap2_clk_allow_idle(clk);
>> }
>> EXPORT_SYMBOL(omap3_mcbsp23_ick_for_sidetone_force);
> 
> Yeah that's something I was thinking.
> 
>> Looks similarly hackish as with the pdata callback, but if I were to choose,
>> the pdata callback might be a bit more polite hack if we do not look at how we
>> will have the pdata crafted for DT boot.
> 
> Well the pdata solution avoids exporting custom functions to all the
> drivers.

True. In this light the pdata callback is much sensible thing to do.
I will look at the DT side of crafting out this.

>> If we were to split the McBSP driver into half - not literally as the ST
>> support has small amount of code right now, we would consider all possibility
>> to not introduce regression and keep things working along the way. There will
>> be a point were the code need to be shuffled..
> 
> You could just create the sidetone child device manually on probe in the
> driver as needed. That way you'd have two devices to do the PM runtime
> on. I think that was Paul's main concern as they are separate modules.

You mean that not to have separate compatible for the McBSP module's Sidetone
core?
If yes, then it is a valid thing to remove the hwmod data for the sidetone,
like I did in this series.

> It still leaves the chance of bugs with flush of posted writes. But might
> make things easier to deal with in small steps?

The only 'benefit' I see with separated driver for McBSP core and Sidetone
core is that the register writes will happen to the cores in separate drivers.

If the McBSP driver creates the device for the sidetone driver, then passing
the needed callbacks and data to it is going to be cleaner. Registering back
the callbacks to McBSP is what need to be figured out, so it is simple and
clean. Either with a callback to McBSP to set the ST callbacks or have the
callback struct used by ST via pdata to have places for the ST to McBSP
callbacks and when the driver loads it is going to set up those.

>>>> I have reasonably clean patches (6 of them) on top of this three which would
>>>> remove the arch code for the iclk handling and implements it in the mcbsp
>>>> driver w/o changing the architecture of the McBSP driver itself. Both DT and
>>>> legacy boot works. The only part I was not happy about the one where I looked
>>>> up the mcbsp2/3_ick, but I think I have found much cleaner way to do it
>>>> (meaning that the code will not look hackish at all).
>>>> If you want to see, I can make this change and I can send the whole thing as
>>>> RFC and continue the discussion around that?
>>>
>>> Sure, especially if that helps with splitting up the modules too.
>>
>> To start with the hwmod data is wrong for mcbsp2/3 mcbsp2/3_sidetone:
>> static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
>> 	.name		= "mcbsp2",
>> 	.class		= &omap3xxx_mcbsp_hwmod_class,
>> 	.mpu_irqs	= omap3xxx_mcbsp2_irqs,
>> 	.sdma_reqs	= omap2_mcbsp2_sdma_reqs,
>> 	.main_clk	= "mcbsp2_fck",
>> 	.prcm		= {
>> 		.omap2 = {
>> 			.prcm_reg_id = 1,
>> 			.module_bit = OMAP3430_EN_MCBSP2_SHIFT,
>> 			.module_offs = OMAP3430_PER_MOD,
>> 			.idlest_reg_id = 1,
>> 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
>> 		},
>> 	},
>> 	.opt_clks	= mcbsp234_opt_clks,
>> 	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
>> 	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
>> };
>>
>> static struct omap_hwmod omap3xxx_mcbsp2_sidetone_hwmod = {
>> 	.name		= "mcbsp2_sidetone",
>> 	.class		= &omap3xxx_mcbsp_sidetone_hwmod_class,
>> 	.mpu_irqs	= omap3xxx_mcbsp2_sidetone_irqs,
>> 	.main_clk	= "mcbsp2_fck",
>> 	.prcm		= {
>> 		.omap2 = {
>> 			.prcm_reg_id = 1,
>> 			 .module_bit = OMAP3430_EN_MCBSP2_SHIFT,
>> 			.module_offs = OMAP3430_PER_MOD,
>> 			.idlest_reg_id = 1,
>> 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
>> 		},
>> 	},
>> };
>>
>> The McBSP2_ST main_clk is mcbsp2_ick, not mcbsp2_fck (ch 21.3.2.2.6 in
>> OMAP36xx TRM).
>> The sidetone should not have prcm section at all as it does not have control
>> over it's clocks in that level. Giving the same PRCM registers and bits for
>> both McBSP and it's sidetone is wrong. What should be expected if McBSP is
>> enabled and we disable the ST via pm_runtime? Will the hwmod toggle bits in
>> PRCM? If it does, the McBSP will looses it's clocks...
> 
> I think for omap3 we're just using the clk_get/set. For omap4, the issue
> is different as the clkctrl registers are used directly.

If I remove the prcm section for the ST hwmod:
[   87.784820] omap_hwmod: mcbsp2_sidetone: _wait_target_ready failed: -22
[   87.784851] omap-mcbsp 49022000.mcbsp: use pm_runtime_put_sync_suspend() in
driver?

When first try to use the audio.
So the hwmod code at least was checking the idlest bit.

>> While the McBSP and ST regions are different, the ST is part of the McBSP from
>> PRCM point of view so not sure how this could be worked around with separated
>> drivers.
> 
> Just create the struct device as a child for ST as needed from McBSP?

OK. I will go with the assumption that the sidetone hwmod can be removed (as
it is not correct) and rework my current series to use pdata callback for the
iclk autogate allow/deny. With this set the ST will be operational in legacy
and DT boot.
>From there I can start to draft out the needed architecture to separate the ST
core handing into a new driver and when it looks good I can make the change.
How this sounds?


-- 
P?ter
