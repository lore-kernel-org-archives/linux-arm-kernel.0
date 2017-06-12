From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 12 Jun 2017 14:54:16 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the Atmel
 ARM TC blocks
In-Reply-To: <20170608084026.GB2244@mai>
References: <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai> <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai> <20170607152750.tksmyf5p3oajbsac@piout.net>
 <20170607210848.GJ2345@mai> <20170607231715.ns2vcxza2eexnzjs@piout.net>
 <20170608074236.62924f01@bbrezillon> <20170608074446.GM2345@mai>
 <20170608101334.4e60aa4c@bbrezillon> <20170608084026.GB2244@mai>
Message-ID: <eada48f9-55b5-859d-d37e-4c9e938bc29d@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/2017 ? 10:40, Daniel Lezcano a ?crit :
> On Thu, Jun 08, 2017 at 10:13:34AM +0200, Boris Brezillon wrote:
>> On Thu, 8 Jun 2017 09:44:46 +0200
>> Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>> +Mark Rutland, +Rob Herring
>>
>> Mark doesn't seem to be CCed.
> 
> Ah, yes. Thanks for fixing this.
> 
>>>
>>>
>>> Alexandre, Boris, have a look at https://www.spinics.net/lists/arm-kernel/msg572652.html
>>>
>>> That will tell you the story.
>>
>> Then we're in a deadlock situation here. I'm tired of hearing this kind
>> of argument "DT is only supposed to describe HW, not configuration, bla
>> bla". The truth is, we already have plenty of bindings that do not
>> strictly describe HW.
>>
>> A simple example: ECC configuration on NAND devices. This is clearly a
>> configuration thing, the NAND controller is usually able to support
>> several kind of strength+ECC-block-size config, but we are able to
>> overload this with the nand-ecc-xxx properties. Another example, still
>> MTD related: MTD partitions, this is purely a software configuration,
>> still we allow users to pass this information in the DT. You want
>> another one? What about the linux,code and linux,input-type properties
>> described here [1]?
>>
>> So please, let's not use these "this is not decribing HW" or "this is
>> linux specific" arguments every time someone tries to encode something
>> that can be considered a configuration detail.
>>
>> Let's be pragmatic. How you want to use your timer counter blocks (I'm
>> talking about atmel TCBs) is clearly board specific. Whether you want
>> to use the PIT for your clocksource or use one or 2 channels of a TCB
>> at a specific resolution is again board specific. We need a solution to
>> assign timer channels to a linux function, and I'm not convinced
>> passing this information through the command line makes much more sense
>> than specifying it in the DT (and it's definitely less intuitive, since
>> you have to reference something defined in the DT from the cmdline).
>>
>> Now, in his review, Mark says:
>>
>> "
>> To me it sounds like what we need is Linux infrastructure that allows
>> one to register a device as having both clockevent/clocksource
>> functionality.
>>
>> That way, we can choose to do something sane at boot time, and if the
>> user really wants specific devices used in specific ways, they can
>> request that.
>> "
>>
>> Does that mean that, after adding this "HW timer" infrastructure, we
>> would have a standard way to assign a function to a specific timer
>> block from the DT? How is this different from what I suggest below
>> (note the linux, prefix on my linux,timer-function property, which
>> clearly shows that this is Linux specific)?
> 
> I like the 'chosen' approach with the nodes you are proposing below. Thanks for
> the constructive suggestion. The binding description matches perfectly what we
> are trying to achieve.
> 
> Rob? what do you think?

I'm following this work from a distance but as we've just celebrated the
1st anniversary for this patch series (11 June 2016), I propose that we
now make up our mind quickly. Everybody seem to be on the same page and
willing to make this rework move forward.

In Microchip/Atmel we would like to actually use this TCB rework both
internally and in our mainline work to avoid having to rely on our own
out-of-tree implementation.

The newly-added samv7 cortex-M can't boot without this series and a use
of our current cortex-A SoCs with TrustZone in Secure World (SWd) is not
possible with current mainline code only. On these two examples, the
current timer on which we rely, the PIT, is not present.

So you probably understand that more than one year without real progress
begins to be a little bit frustrating for the AT91 users...

Regards,


>>> On Thu, Jun 08, 2017 at 07:42:36AM +0200, Boris Brezillon wrote:
>>>> Le Thu, 8 Jun 2017 01:17:15 +0200,
>>>> Alexandre Belloni <alexandre.belloni@free-electrons.com> a ?crit :
>>>>   
>>>>> On 07/06/2017 at 23:08:48 +0200, Daniel Lezcano wrote:  
>>>>>>> I was going to agree but this is not flexible enough because the
>>>>>>> quadrature decoder always uses the first two channels. So on some
>>>>>>> products, we may have:
>>>>>>>  - TCB0:
>>>>>>>    o channels 0,1: qdec
>>>>>>>    o channel 2: clocksource
>>>>>>>
>>>>>>>  - TCB1:
>>>>>>>    o channels 0,1: qdec
>>>>>>>    o channel 2: clockevent
>>>>>>>
>>>>>>> This avoids wasting TCB channels.    
>>>>>>
>>>>>> Ok. In this case you can check if the interrupt is specified for the node, if
>>>>>> yes, then it is a clockevent.
>>>>>>     
>>>>>
>>>>> But currently it is always specified in the SoC's dtsi. I don't find
>>>>> that too practical to push that to the board's dts. Also, lying by
>>>>> omission (the IRQ is always wired) in the DT is not different from
>>>>> having a property selecting which timer is the clocksource and which is
>>>>> the clockevent.
>>>>>   
>>>>
>>>> I agree with Alexandre here. Really, there's not much we can do to
>>>> detect which timer should be used as a clockevent and which one should
>>>> be used as a clocksource except explicitly specifying it in the DT.
>>>> Having an interrupt defined in one case (clockevent) and undefined in
>>>> the other case (clocksource), is just as hack-ish as the detection logic
>>>> Alexandre developed to avoid explicitly specifying the function
>>>> assigned to a specific timer.
>>>>
>>>> Can we please find a solution that makes everyone happy (DT,
>>>> clocksoure/clockevent and at91 maintainers)?
>>>>
>>>> How about adding a linux,timer-function property to specify which
>>>> function this timer is providing?
>>>>
>>>> Something like that for example:
>>>>
>>>> 	tcb0: timer at fff7c000 {
>>>> 		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <0>;
>>>> 		reg = <0xfff7c000 0x100>;
>>>> 		interrupts = <18 4>;
>>>> 		clocks = <&tcb0_clk>, <&clk32k>;
>>>> 		clock-names = "t0_clk", "slow_clk";
>>>>
>>>> 		timer at 0 {
>>>> 			compatible = "atmel,tcb-timer";
>>>> 			reg = <0>, <1>;
>>>> 			linux,timer-function = "clocksource";
>>>> 		};
>>>>
>>>> 		timer at 2 {
>>>> 			compatible = "atmel,tcb-timer";
>>>> 			reg = <2>;
>>>> 			linux,timer-function = "clockevent";
>>>> 		};
>>>> 	};
>>>>
>>>> Alternatively, we could have a property or a node in chosen describing which
>>>> timer should be used:
>>>>
>>>> 	chosen {
>>>> 		clockevent {
>>>> 			timer = <&timer2>;
>>>> 		};
>>>>
>>>> 		clocksource {
>>>> 			timer = <&timer0>;
>>>> 		};
>>>>
>>>> 		/*
>>>> 		 * or
>>>> 		 *
>>>> 		 * clockevent = <&timer2>;
>>>> 		 * clocksource = <&timer0>;
>>>> 		 *
>>>> 		 * but I think the clocksource/clockevent node approach
>>>> 		 * is more future proof in case we need to add extra
>>>> 		 * information like the expected resolution/precision or
>>>> 		 * anything that could be tweakable.
>>>> 		 */
>>>> 	};
>>>>
>>>> 	tcb0: timer at fff7c000 {
>>>> 		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <0>;
>>>> 		reg = <0xfff7c000 0x100>;
>>>> 		interrupts = <18 4>;
>>>> 		clocks = <&tcb0_clk>, <&clk32k>;
>>>> 		clock-names = "t0_clk", "slow_clk";
>>>>
>>>> 		timer0: timer at 0 {
>>>> 			compatible = "atmel,tcb-timer";
>>>> 			reg = <0>, <1>;
>>>> 		};
>>>>
>>>> 		timer2: timer at 2 {
>>>> 			compatible = "atmel,tcb-timer";
>>>> 			reg = <2>;
>>>> 		};
>>>> 	};  
>>>
>>
>> [1]http://elixir.free-electrons.com/linux/latest/source/Documentation/devicetree/bindings/input/gpio-keys.txt
> 


-- 
Nicolas Ferre
