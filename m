From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Jan 2018 18:05:23 +0530
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
Message-ID: <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 09:59 PM, David Lechner wrote:
> On 01/08/2018 08:00 AM, Sekhar Nori wrote:
>> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>>> This adds a new binding for the PLL IP blocks in the mach-davinci family
>>> of processors. Currently, only the SYSCLKn and AUXCLK outputs are
>>> needed,
>>> but in the future additional child nodes could be added for OBSCLK and
>>> BPDIV.
>>>
>>> Note: Although these PLL controllers are very similar to the TI Keystone
>>> SoCs, we are not re-using those bindings. The Keystone bindings use a
>>> legacy one-node-per-clock binding. Furthermore, the mach-davinici SoCs
>>
>> Not sure what is meant by "legacy one-node-per-clock binding"
> 
> It's a term I picked up from of_clk_detect_critical()
> 
> ?* Do not use this function. It exists only for legacy Device Tree
> ?* bindings, such as the one-clock-per-node style that are outdated.
> ?* Those bindings typically put all clock data into .dts and the Linux
> ?* driver has no clock data, thus making it impossible to set this flag
> ?* correctly from the driver. Only those drivers may call
> ?* of_clk_detect_critical from their setup functions.

Okay, I still don't understand the outdated style. I looked at clocks
defined in arch/arm/boot/dts/stih407-clock.dtsi which is the only file
that uses clock-critical and don't particularly see anything wrong with
the way clocks are defined there.

Anyway, I guess we digress. As long as this patch series is not using
the "legacy style", we are good :)

>>> have a slightly different PLL register layout and a number of quirks
>>> that
>>> can't be handled by the existing bindings, so the keystone bindings
>>> could
>>> not be used as-is anyway.
>>
>> Right, I think different register layout between the processors is the
>> main reason for a new driver. This should be sufficient reason IMO.
>>
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>> ? .../devicetree/bindings/clock/ti/davinci/pll.txt?? | 47
>>> ++++++++++++++++++++++
>>> ? 1 file changed, 47 insertions(+)
>>> ? create mode 100644
>>> Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>> b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>> new file mode 100644
>>> index 0000000..99bf5da
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
>>> @@ -0,0 +1,47 @@
>>> +Binding for TI DaVinci PLL Controllers
>>> +
>>> +The PLL provides clocks to most of the components on the SoC. In
>>> addition
>>> +to the PLL itself, this controller also contains bypasses, gates,
>>> dividers,
>>> +an multiplexers for various clock signals.
>>> +
>>> +Required properties:
>>> +- compatible: shall be one of:
>>> +??? - "ti,da850-pll0" for PLL0 on DA850/OMAP-L138/AM18XX
>>> +??? - "ti,da850-pll1" for PLL1 on DA850/OMAP-L138/AM18XX
>>
>> These PLLs are same IP so they should use the same compatible. You can
>> initialize both PLLs for DA850 based on the same compatible.
>>
> 
> But they are not exactly the same. For example, PLL0 has 7 PLLDIV clocks
> while
> PLL1 only has 3. PLL0 has PREDIV while PLL1 does not. PLL0 has certain
> SYSCLKs
> that are fixed-ratio but PLL1 does not have any of these. There are even
> more
> differences, but these are the ones we are actually using.

We need each element of the PLLC to be modeled individually as a clock
node. That is, PLL should only model the multiplier, the dividers
including post and prediv should be modeled as divider clocks (hopefully
being able to use the clk-divider.c library). The sysclks can be
fixed-factor-clock type clocks.

Without this flexible mechanism, we cannot (at least later) model things
like DIV4.5 clock which is the only clock which derives from the output
of PLL multiplier before the post divider is applied.

Since with DT there are are no retakes, we need to get this right the
first time and modifying later will not be an option.

> 
> So, if we use the same compatible, we either have to come up with device
> tree
> bindings to describe all of this (yuck) or I suppose we can look at the
> REVID
> register to electronically determine exactly what we have. I went with the
> simpler option of just creating two different compatible strings.

Thanks,
Sekhar
