From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 10:35:55 +0100
Subject: [PATCH 1/3] dt-bindings: add Marvell core PLL and clock divider
 PMU documentation
In-Reply-To: <20151127203932.GP8644@n2100.arm.linux.org.uk>
References: <E1a24wj-0004iw-Rf@rmk-PC.arm.linux.org.uk>
 <20151127202114.GA613@rob-hp-laptop>
 <20151127203932.GP8644@n2100.arm.linux.org.uk>
Message-ID: <5659757B.7060904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.11.2015 21:39, Russell King - ARM Linux wrote:
> On Fri, Nov 27, 2015 at 02:21:14PM -0600, Rob Herring wrote:
>> On Thu, Nov 26, 2015 at 10:23:21PM +0000, Russell King wrote:
>>> Add documentation for the Marvell clock divider driver, which is used
>>> to source clocks for the AXI bus, video decoder, GPU and LCD blocks.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>> ---
>>>  .../bindings/clock/dove-divider-clock.txt          | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/dove-divider-clock.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/dove-divider-clock.txt b/Documentation/devicetree/bindings/clock/dove-divider-clock.txt
>>> new file mode 100644
>>> index 000000000000..0c602de279e5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/dove-divider-clock.txt
>>> @@ -0,0 +1,28 @@
>>> +PLl divider based Dove clocks
>>> +
>>> +Marvell Dove has a 2GHz PLL, which feeds into a set of dividers to provide
>>> +high speed clocks for a number of peripherals.  These dividers are part of
>>> +the PMU, and thus this node should be a child of the PMU node.
>>
>> It seems a bit strange to just be documenting these clocks. What about 
>> the rest of the SOC clocks?
> 
> This is all that this pair of registers provide.
> 
> The SoC has other clocks handled by other DT nodes - for Dove, we now
> have:
> 
>         gate_clk: clock-gating-ctrl at 0038 {
>                 compatible = "marvell,dove-gating-clock";
>                 reg = <0x0038 0x4>;
>                 clocks = <&core_clk 0>;
>                 #clock-cells = <1>;
>         };
>         divider_clk: core-clock at 0064 {
>                 compatible = "marvell,dove-divider-clock";
>                 reg = <0x0064 0x8>;
>                 #clock-cells = <1>;
>         };
>         core_clk: core-clocks at 0214 {
>                 compatible = "marvell,dove-core-clock";
>                 reg = <0x0214 0x4>;
>                 #clock-cells = <1>;
>         };
> 
> and all three of these are part of the PMU register block.  I'm not sure
> why the mvebu maintainers decided to minutely describe the PMU like this,
> but unfortunately that's the structure we have.
> 
> What's more silly is that the "dove-core-clock" appears to disagree in
> terminology with the manual - there's a "Core PLL" which supplies the
> dividers in the "divider_clk" block, and is entirely separate from the
> CPU PLL which "core_clk" is describing.
> 
> IMHO, it would've been cleaner to have these components registered
> separately from a central PMU driver (as I'm doing with the power
> domains, resets and IRQs that are part of the PMU), but my view is
> limited to Dove and not the other mvebu clocks, so there may be a good
> reason for it.
> 

Rob, Russell,

the main reason why dove clocks are the way they are is that back
when we thought of the bindings for mvebu SoC clocks, CCF and DT was
in its very beginning. Looking back, some decisions shouldn't have
been made that way. Also, we tried to describe Dove and the other SoCs
similarily, but Dove is always a little odd.

>From todays point of view, I certainly agree with Russell that all
PMU related stuff is best kept in a single PMU node.

Thanks for providing the patches, I appreciate the extra work of
separating those from your working trees.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Sebastian
