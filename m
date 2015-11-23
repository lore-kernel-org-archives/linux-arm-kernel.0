From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 23 Nov 2015 09:30:42 +0100
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add pll and clock nodes
In-Reply-To: <20151123152158.483aa6b5@xhacker>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-7-git-send-email-jszhang@marvell.com>
 <564F8B73.7070403@gmail.com> <20151123152158.483aa6b5@xhacker>
Message-ID: <5652CEB2.9030902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.11.2015 08:21, Jisheng Zhang wrote:
> On Fri, 20 Nov 2015 22:06:59 +0100
> Sebastian Hesselbarth wrote:
>> On 20.11.2015 09:42, Jisheng Zhang wrote:
>>> Add syspll, mempll, cpupll, gateclk and berlin-clk nodes.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> ---
[...]
>>> +		syspll: syspll {
>>> +			compatible = "marvell,berlin-pll";
>>> +			reg = <0xea0200 0x14>, <0xea0710 4>;
>>> +			#clock-cells = <0>;
>>> +			clocks = <&osc>;
>>> +			bypass-shift = /bits/ 8 <0>;
>>> +		};
>>> +
>>> +		gateclk: gateclk {
>>> +			compatible = "marvell,berlin4ct-gateclk";
>>> +			reg = <0xea0700 4>;
>>> +			#clock-cells = <1>;
>>> +		};
>>> +
>>> +		clk: clk {
>>> +			compatible = "marvell,berlin4ct-clk";
>>> +			reg = <0xea0720 0x144>;
>>
>> Looking at the reg ranges, I'd say that they are all clock related
>> and pretty close to each other:
>>
>> gateclk: reg = <0xea0700 4>;
>> bypass:  reg = <0xea0710 4>;
>> clk:     reg = <0xea0720 0x144>;
>
> Although these ranges sit close, but we should represent HW structure as you
> said.

Then how do you argue that you have to share the gate clock register
with every PLL? The answer is quite simple: You are not separating by
HW either but existing SW API.

If you would really want to just describe the HW, then you'd have to
have a single node for _all_ clocks that get controlled by 0xea0700/0x4,
feed some 32+ clocks into the node, and out again. Obviously, this
isn't what we want, right?

So, the idea of berlin2 sysctrl nodes (and similar other SoCs) is: Some
SoCs just dump some functions into a bunch of registers with no
particular order. We'd never find a good representation for that in DT,
so we don't bother to try but let the driver implementation deal with
the mess. Using "simple-mfd" is a nice solution to scattered registers
please have a look at it and come up with a cleaner separation for bg4
clock.

> First of all, let me describe the clks/plls in BG4CT. BG4CT contains:
>
> two kinds of PLL: normal PLL and AVPLL. These PLLs are put with their users
> together. For example: mempll pll registers <0xf7940034, 0x14> is put together
> with mem controller registers. AVPLL control registers are put with AV devices.

Why didn't you choose to have a memory-controller node that provides
mempll clock then? I am open to having multiple nodes providing clocks
but having a node for every clock in any subsystem is something I'll
not even think about.

> You can also check mempll, cpupll and syspll ranges:
>
> cpupll: <0x922000 0x14>
>
> mempll: <0x940034 0x14>
>
> syspll: <0xea0200 0x14>
>
>
> We have three normal PLLS: cpupll, mempll and syspll. All these three PLLs use
> 25MHZ osc as clocksource. These plls can be bypassed. when syspll is bypassed
> the 25MHZ osc is directly output to syspllclk. When mempll/cpupll is bypassed,
> its corresponding fastrefclk is directly output to ddrphyclk/cpuclk:
>
>
>         ---25MHZ osc----------|\
>             ________            | |-- syspllclk
>         ---| SYSPLL |---------|/
>
>
>
>         ---cpufastrefclk------|\
>             ________            | |-- cpuclk
>         ---| CPUPLL |---------|/
>
>
>         ---memfastrefclk------|\
>             ________            | |-- ddrphyclk
>         ---| MEMPLL |---------|/
>
> NOTE: the fastrefclk is the so called normal clk below.
>
>
>
> two kinds of clk: normal clk and gate clk. The normal clk supports changing
> divider, selecting clock source, disabling/enabling etc. The gate clk only
> supports disabling/enabling. normal clks use syspllclk as clocksource, while
> gate clks use perifsysclk as clocksource.
>
>
> So what's the representing HW structure in fact? Here is my proposal:
> 1. have mempll, cpupll and syspll node in dts

No.

> 2. one gateclk node in dts for gateclks

No.

> 3. one normalclk node in dts for normal clks

No.

> 4. one ccf clock-mux for cpuclk, ddrphyclk and syspllclk.

No.

> what do you think?

I think that the current separation is not a good one. I am open for
suggestions but I am not accepting single PLL/clock nodes.

>  From another side, let's have a look at driver/clk/mvebu. As can be seen,
> different clks register are close each other, for example, gateclk and coreclk
> in arch/arm/boot/dts/armada-xp.dtsi.
>
> And drivers/clk/sunxi, arch/arm/boot/dts/sun7i-a20.dtsi, the pll4, pll12, gt_clk
> and ahb*, apb* etc...
>
> why these SoCs don't merge clocks/gates/plls to a single clock complex node?
> I think that's because they are representing real HW structure.

These SoC (at least mvebu) didn't merge them into a single clock
complex node because nobody had a better idea or an impression of
the consequences. Looking back with the idea of syscon/simple-mfd
we probably would have chosen to separate differently.

>> So, please just follow the OF/driver structure we already
>> have for Berlin2.

To repeat: "please just follow the OF/driver structure we already
have for Berlin2"

Sebastian

>>> +			#clock-cells = <1>;
>>> +			clocks = <&syspll>;
>>> +		};
>>> +
>>>   		soc_pinctrl: pin-controller at ea8000 {
>>>   			compatible = "marvell,berlin4ct-soc-pinctrl";
>>>   			reg = <0xea8000 0x14>;
>>>
>>
>
