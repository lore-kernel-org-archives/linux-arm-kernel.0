From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Jan 2018 00:22:11 +0530
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
 <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
 <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
Message-ID: <5aacc350-6236-2e4f-35bb-a681fc9d47e7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 January 2018 08:31 AM, David Lechner wrote:
> On 01/09/2018 06:35 AM, Sekhar Nori wrote:
>> On Monday 08 January 2018 09:59 PM, David Lechner wrote:
>>> On 01/08/2018 08:00 AM, Sekhar Nori wrote:
>>>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:

>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>>> b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>>> new file mode 100644
>>>>> index 0000000..99bf5da
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>>> @@ -0,0 +1,47 @@
>>>>> +Binding for TI DaVinci PLL Controllers
>>>>> +
>>>>> +The PLL provides clocks to most of the components on the SoC. In
>>>>> addition
>>>>> +to the PLL itself, this controller also contains bypasses, gates,
>>>>> dividers,
>>>>> +an multiplexers for various clock signals.
>>>>> +
>>>>> +Required properties:
>>>>> +- compatible: shall be one of:
>>>>> +??? - "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
>>>>> +??? - "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
>>>>
>>>> These PLLs are same IP so they should use the same compatible. You can
>>>> initialize both PLLs for DA850 based on the same compatible.
>>>>
>>>
>>> But they are not exactly the same. For example, PLL0 has 7 PLLDIV clocks
>>> while
>>> PLL1 only has 3. PLL0 has PREDIV while PLL1 does not. PLL0 has certain
>>> SYSCLKs
>>> that are fixed-ratio but PLL1 does not have any of these. There are even
>>> more
>>> differences, but these are the ones we are actually using.
>>
>> We need each element of the PLLC to be modeled individually as a clock
>> node.
> 
> I gave this a good think while I have been working on this series
> and I came to the conclusion that we really don't need to do this.
> These components are all internal to the PLL IP block, so the
> compatible string is enough to tell us what we have. They only
> thing we need really in the device tree bindings are the connections
> that are external to the IP block.
> 
> 
>> That is, PLL should only model the multiplier, the dividers
>> including post and prediv should be modeled as divider clocks (hopefully
>> being able to use the clk-divider.c library). The sysclks can be
>> fixed-factor-clock type clocks.
>>
>> Without this flexible mechanism, we cannot (at least later) model things
>> like DIV4.5 clock which is the only clock which derives from the output
>> of PLL multiplier before the post divider is applied.
>>
>> Since with DT there are are no retakes, we need to get this right the
>> first time and modifying later will not be an option.
>>
> 
> So, the full device tree binding would look something like this:
> 
> +
> +??? pll0: clock-controller at 11000 {
> +??????? compatible = "ti,da850-pll0";
> +??????? reg = <0x11000 0x1000>;
> +??????? clocks = <&ref_clk>, <&pll1_sysclk 3>, <&pll1_obsclk>;
> +??????? clock-names = "oscin", pll1_sysclk3", "pll1_osbclk";
> +??????? oscin-square-wave;
> +
> +??????? pll0_sysclk: sysclk {
> +??????????? #clock-cells = <1>;
> +??????? };
> +
> +??????? pll0_auxclk: auxclk {
> +??????????? #clock-cells = <0>;
> +??????? };
> +
> +??????? pll0_div45: div4.5 {
> +??????????? #clock-cells = <0>;
> +??????? };
> +
> +??????? pll0_obsclk: obsclk {
> +??????????? #clock-cells = <0>;
> +??????????? assigned-clocks = <&pll0_sysclk 1>;
> +??????????? assigned-clock-names = "ocsrc";
> +??????? };
> +??? };

Well, I guess this will work as well. And I am probably biased towards
the style I mentioned because AM335x and other TI OMAP processors
follow that.

To make it easy to review that we have all bases covered, can you model
the all PLLC0 and PLLC1 (input and output) clocks for the next version?

> 
> There are three clocks coming into the IP block and there are 11 clocks
> going out (sysclk is 7 clocks). And you can specify the board-specific
> configuration, like having the "oscin-square-wave" flag when a square wave
> is used instead of a crystal oscillator and you can assign the multiplexer

Ideally the OSCIN vs CLKIN selection should be another clock mux whose
output is one of the input clocks to PLL controller. But I can see the
difficulty in handling that as the mux itself is controlled by the PLL
controller.

> input that will be used by obsclk. (And, this binding is totally compatible
> with the binding I have already proposed - although, I see now it would
> be better to go ahead and add the clocks-names property.)

Also, please add the oscin-square-wave to the binding definition too.

For the benefit of others reviewing and not familiar with the hardware,
the users guide for DA850 is here:
http://www.ti.com/lit/ug/spruh77c/spruh77c.pdf

and the PLL block diagram is on page 143 (Figure 8-1).

Thanks,
Sekhar
