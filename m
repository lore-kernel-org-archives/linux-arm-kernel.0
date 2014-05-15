From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 15 May 2014 08:53:47 +0200
Subject: [PATCH 2/8] clk: berlin: add clock binding docs for Marvell
 Berlin2 SoCs
In-Reply-To: <20140515044106.19795.57249@quantum>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1399839881-29895-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140514223230.19795.63328@quantum> <5373F9A0.6000702@gmail.com>
 <20140515044106.19795.57249@quantum>
Message-ID: <5374647B.1070006@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 06:41 AM, Mike Turquette wrote:
> Quoting Sebastian Hesselbarth (2014-05-14 16:17:52)
>> On 05/15/2014 12:32 AM, Mike Turquette wrote:
>>> Quoting Sebastian Hesselbarth (2014-05-11 13:24:35)
>>>> +avpll: pll at ea0040 {
>>>> +       compatible = "marvell,berlin2-avpll";
>>>> +       #clock-cells = <2>;
>>>> +       reg = <0xea0050 0x100>;
>>>> +       clocks = <&refclk>;
>>>> +};
>>>
>>> Thanks for submitting the series. It looks good. I do have some comments
>>> about the DT bindings though. I'm encouraging new bindings (and
>>> especially new platforms or existing platforms that are only now
>>> converting over to CCF) to not put their per-clock data into DTS. This
>>> has scalability problems, is unpopular with the DT crowd and sometimes
>>> makes it hard to do things like set CLK_SET_RATE_PARENT flags for
>>> individual clocks.
>>
>> Ok, so you are proposing the have a single node for all the SoCs
>> internal plls and clocks. The individual SoCs will have to deal
>> with the differences in a single driver, right?
> 
> To be precise, I'm talking about modeling an IP block as a single node.
> So if you have one clock generator IP block then you have one node. If
> you have more than one clock generator block then you have more than one
> node. Re-using the qcom example there are compatible strings for two
> different clock generator blocks named gcc and mmcc, respectively. So
> two DT nodes in the case for msm platforms that have one gcc instance
> and one rcg instance.

Hmm, I'd argue that you'd identify an IP block by the price tag is
carries. You can buy a single PLL but given the vast amount of different
register sets for PLLs, it is hard to identify what still count for the
same IP.

> Additionally other IP blocks may have internal clocks that can be
> modeled as part of that node. OMAP's Display SubSystem (DSS) and Image
> Signal Processor (ISP) blocks all have internal clocks that are modeled
> through the clock framework. (There are no DT bindings for that stuff,
> but the concept still applies)

Agreed. If we hit any clock mux/divider/gate in any other register set,
I wouldn't think of putting it into the core clock driver but the IP
driver instead.

>>> If you have a strong reason to do it the way that you originally posted
>>> then let me know.
>>
>> Actually, the intermediate patch set sent before this one had a single
>> DT clock node. The most important draw-back of a single clock node
>> is that Berlin's global registers are more like a register dumpster.
>> Vital other registers, e.g. reset, are intermixed with clock registers.
> 
> Yeah, this is pretty common. The compatible string should reflect the IP
> block as a whole, not just the clocks part of it. Lots of vendors have
> PRCMs or PRCMUs or CARs or whatever.
> 
> Check out the recent series to have the reset bits and regulator support
> added to the qcom binding[1]. (I'm using qcom quite a bit in my examples
> but they are not the first to add reset control to their clock driver. I
> think Tegra did it first...)

Yeah, I have to think about it a while. The register block we are
talking about contains - from what I remember from the ~20k lines
include - pinctrl, padctrl, reset, clocks, secondary cpu boot related
registers.

Maybe it is time to admit that these registers will never be split into
separate blocks but should be dealt with a single node.

>> Given the lack of public datasheets (I look everything up in some
>> auto-generated BSP includes), I like the current approach because it
>> helps to get in at least some structure to the register mess ;)
>>
>> Considering the postponed of_clk_create_name() helper, that would allow
>> us to remove at least the names from DT again. Another option would be
>> a syscon node for the registers, that clk, reset, pinctrl drivers can
>> access. But IIRC early syscon support isn't settled, yet?
> 
> Yeah, I'm not sure of the state of syscon. And modeling this stuff in
> the clock driver isn't the end of the world. There might be better
> places than drivers/clk/* for sure... I sometimes joke that the name of
> the IP block determines where the code lands. If it is Power, Reset &
> Clock Manager (several platforms use this acronym) then it can end up in
> drivers/clk or drivers/reset really easily. Same for Clock and Reset IP
> blocks (Tegra).
> 
>>
>> So, my current idea is:
>> - take this as is, stabilize berlin branches for v3.16
>> - review of_clk_create_name() and of_clk_get_parent_name() to allow
>>   to remove clock-output-names properties from Berlin (and other) dtsis
>> - maybe switch to early syscon if it is available in v3.16
>>
>> I know this would likely break DT ABI policy, but hey who else boots
>> mainline Linux on his Chromecast currently except me :P
> 
> I'm not a big fan of DT stable ABI, but if you plan on changing it for
> 3.17 why not just do it the right way the first time? And switching to
> syscon is not a hard requirement. I'm OK with you putting the reset and
> regulator stuff in the clock driver if that makes the most sense for
> your platform (especially if registers are shared and the same locks
> need to be used, etc).
> 
> What do you think?

Currently, I think that a single node for the global registers with reg
property and different nodes for clock/reset and pinctrl would be best.
I think I can workaround missing early syscon with atomic_io for now and
have a syscon provided regmap later:

global: registers at ea0000 {
	compatible = "marvell,berlin2-global-registers";
	reg = <0xea0000 0x400>;
};

pinctrl: pin-controller {
	compatible = "marvell,berlin2-pinctrl";
	...
};

clocks: clocks {
	compatible = "marvell,berlin2-clocks";
	#clock-cells = <1>;
	/* or clocks and reset FWIW */
};

or on a sub-node basis:

global: registers at ea0000 {
	compatible = "marvell,berlin2-global-registers";
	reg = <0xea0000 0x400>;
	#clock-cells = <1>;
	#reset-cells = <1>;

	pinctrl: pin-controller {
		compatible = "marvell,berlin2-pinctrl";
		...
	};
};

But I haven't made up my mind, yet.

Sebastian
