From: david@lechnology.com (David Lechner)
Date: Tue, 19 Dec 2017 17:12:30 -0600
Subject: [PATCH v3 4/5] ARM: davinci: convert to common clock framework
In-Reply-To: <b8025b62-c7c0-29f8-388d-d84816adf688@ti.com>
References: <1512785711-15064-1-git-send-email-david@lechnology.com>
 <1512785711-15064-5-git-send-email-david@lechnology.com>
 <b8025b62-c7c0-29f8-388d-d84816adf688@ti.com>
Message-ID: <4d7e4751-490b-5dfc-ef75-195fe41719b7@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 07:47 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Saturday 09 December 2017 07:45 AM, David Lechner wrote:
>> This converts the clocks in mach-davinci to the common clock framework.
>>
>> Most of the patch just involves renaming struct clk to struct davinci_clk.
>> There is also a struct clk_hw added to provide the bridge between the
>> existing clock implementation and the common clock framework.
>>
>> The clk_get_parent and clk_set_parent callbacks are dropped because all
>> clocks currently (effectivly) have a single parent, in which case the
>> common clock framework does not want you to implement these functions
>> yourself.
>>
>> clk_unregister() is dropped because it is not used anywhere in
>> mach-davinci.
>>
>> EXPORT_SYMBOL() is removed from functions not used outside of mach-davinci.
>>
>> Fixed checkpatch.pl warning about bare use of unsigned in dump_clock().
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> The cleanups leading upto this patch look fine, but I am not sure about
> this patch itself. Ideally, we should have moved to drivers/clk also.
> And shared code with keystone too since the PSC and PLL implementations
> of the two architectures are quite similar.
> 
> I could think of this as an intermediate step while we get there, but I
> am afraid of the churn that would cause. For example, if we reuse
> keystone driver, we will be using clk_psc and we can get rid of the
> davinci_clk that this patch introduces.
> 
> So unless there is big roadblock to moving to drivers/clk, we should
> probably do that in one shot.
> 

Yes, this is intended as an intermediate step. My thinking was that it 
would be better to do one thing at a time, so if something breaks, it 
will be easier to find the problem than if we try to do everything at 
once. But, you are right, there will be quite a few extra intermediate 
steps required, for example, I have realized that in order to use the 
davinci_clk concurrently with other clocks in the common clock 
framework, at least the parent pointer and children linked list will 
have to be removed, introducing another intermediate step.

While avoiding the davinci_clk step would be ideal, there is quite a bit 
that needs to be done first before this will be possible. And the 
downside I see to doing it this way is that no one will be able to test 
any of the preparatory patches because they depend on the common clock 
framework. We won't even be able to compile them until all the pieces 
are in place and we can enable the common clock kernel configuration option.

Here is a list of some of the issues I know about so far preventing me 
from doing everything at once at this point in time:

* Reentrancy of clk_enable() on non-SMP systems is broken in the common 
clock framework [1][2], but this reentrancy is needed for the DA8xx USB 
PHY PLL clock [3].

* drivers/remoteproc/da8xx_remoteproc.c calls 
davinci_clk_reset_{assert,deassert}() in arch/arm/mach-davinci/clock.c. 
This needs to be moved to the PSC driver in drivers/clk. The reset 
framework in drivers/reset looks ideal for handling this, but it is 
currently device tree only and it looks like we need it to work on 
non-device tree boards. So, our options are: to move this hack to the 
PSC driver in drivers/clk/ *or* to update the reset framework to work 
with non-device tree boards *or* convert all of the mach-davinci boards 
to device tree only.

* The device tree bindings for "ti,keystone,psc-clock" are not the best 
and I am really not keen on reusing them. What makes sense to me would 
be to define a device tree node that represents the entire PSC IP block 
with child nodes for each clock output. Something like this:

power-controller at 2350000 {
	compatible = "ti,davinci-psc";
	reg = <0x2350000 0xb00>;

	...

	clkhyperlink0: clkhyperlink0 {
		#clock-cells = <0>;
		clock-output-names = "hyperlink-0";
		clocks = <&chipclk12>;
		power-domain = <5>;
		module-domain = <12>;
	};

	...
};

But the keystone bindings assign the entire PSC register space to each 
clock individually (twice). And the really ugly part is that the module 
domain and the power domain numbers of each PSC "clock" is embedded in 
the register address. So, if you have reg = <0x02350030 0xb00>, 
<0x02350014 0x400>; what this really means is that the clock driver will 
iomap 0x02350000 (notice the 00 instead of the 30 and 14 at the end of 
each register and that the base 0x02350000 is essentially listed twice 
with two different sizes) and it means that this particular clock has a 
module domain of 12 (0x30 / 4 = 12, 4 comes from the fact these are 
32-bit registers) and a power domain of 5 (0x14 / 4 = 5). You can find 
the numbers 12 and 5 easily in the SRM, but the numbers used in the 
device tree bindings are pretty meaningless. Furthermore, the driver 
itself stores the base address in a global variable which won't work for 
DA8XX since it has two PSCs instead of one. So, for this case, I'm 
really tempted to just write a new driver with better device tree 
bindings rather than trying to fix up the keystone driver to make it 
compatible with davinci and better device tree bindings while still 
maintaining backwards compatibility with wacky device tree bindings.

* The keystone PLL driver and device tree bindings are in better shape, 
but they cannot be used as-is with davinci family processors since the 
registers are laid out differently. I have a work-in-progress patch for 
this that I started quite a while back [4][5].

* All of the keystone clock drivers are currently device tree only, so 
they will need to be modified *or* as mentioned above all mach-davinci 
boards could be converted to device tree only.

[1]: https://patchwork.kernel.org/patch/10108437/
[2]: https://patchwork.kernel.org/patch/10115483/
[3]: https://patchwork.kernel.org/patch/9449741/
[4]: 
https://github.com/dlech/ev3dev-kernel/commit/5e7bf2070aa03283b605d7b86864758d24f83aa8
[5]: 
https://github.com/dlech/ev3dev-kernel/commit/1e34686ff57a673c8655eaedacec4d65d48f93b3


---

Also, a bit more background on my motivation here. Really, all I want is 
to be able to use the "pwm-clock" device tree bindings to supply a clock 
to a Bluetooth chip. But the driver for it requires the common clock 
framework.

This is just a spare time project for me, which is why I have just done 
the bare minimum to get CONFIG_COMMON_CLK enabled rather than trying to 
fix all of the hard problems to do thing the "right way". As you have 
seen above, there is still quite a bit of work remaining to be done, 
especially when doing this just for fun. It is probably just wishful 
thinking, but I kind of hoped that if I was able to get things this far, 
maybe some other interested parties might be able to help with one of 
the various pieces.

One way or another, I suppose I will get my Bluetooth clock eventually. :-)
