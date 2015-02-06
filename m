From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 6 Feb 2015 16:04:34 -0600
Subject: [PATCHv6 5/5] arm: dts: Add Altera L2 Cache and OCRAM EDAC entries
In-Reply-To: <20150206192444.GF10324@leverpostej>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
 <1420772036-3112-6-git-send-email-tthayer@opensource.altera.com>
 <20150206192444.GF10324@leverpostej>
Message-ID: <54D53A72.10101@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

On 02/06/2015 01:24 PM, Mark Rutland wrote:
> On Fri, Jan 09, 2015 at 02:53:56AM +0000, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Adding the device tree entries and bindings needed to support
>> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
>> an earlier patch to declare and setup On-chip RAM properly.
>> http://www.spinics.net/lists/devicetree/msg51117.html
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2: Remove OCRAM declaration and reference prior patch.
>>
>> v3-5: No Change
>>
>> v6: Change to nested EDAC device nodes based on community
>>      feedback. Remove L2 syscon. Use consolidated binding.
>> ---
>>   .../bindings/arm/altera/socfpga-edac.txt           |   46 ++++++++++++++++++++
>>   arch/arm/boot/dts/socfpga.dtsi                     |   20 +++++++++
>>   2 files changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-edac.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-edac.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-edac.txt
>> new file mode 100644
>> index 0000000..4bf32e1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-edac.txt
>> @@ -0,0 +1,46 @@
>> +Altera SoCFPGA Error Detection and Correction [EDAC]
>> +
>> +Required Properties:
>> +- compatible : Should be "altr,edac"
>
> Is there a single large EDAC block that happens to perform EDAC
> functions for various components, or various small EDAC blocks that
> happen to be close to each other in the MMIO space?
>

There is a sequential grouping of ECC registers containing IP specific 
ECC enable and ECC error injection bits. A number of these registers 
have the same bit definitions but a few such as L2 cache are different.

If I understand your question, I'd characterize these as various small 
EDAC blocks that happen to be close to each other in the MMIO space.

There is no master - these IP memories are meant to be individually enabled.

>> +- #address-cells: must be 1
>> +- #size-cells: must be 1
>> +- ranges : standard definition, should translate from local addresses
>
> Surely these just need to be suitable for mapping the child nodes, and
> you shouldn't care about their precise values?
>

If you are saying that I place the base address in the parent and then 
just include the offset from the parent registers [0 for L2 cache and 4 
for OCRAM] in each child then I'll need to research how to do that. I 
think our clock manager may do this.

>> +
>> +Subcomponents:
>> +
>> +L2 Cache ECC
>> +Required Properties:
>> +- compatible : Should be "altr,l2-edac"
>> +- reg : Address and size for ECC error interrupt clear registers.
>> +- interrupts : Should be single bit error interrupt, then double bit error
>> +	interrupt. Note the rising edge type.
>> +
>> +On Chip RAM ECC
>> +Required Properties:
>> +- compatible : Should be "altr,ocram-edac"
>> +- reg : Address and size for ECC error interrupt clear registers.
>> +- iram : phandle to On-Chip RAM definition.
>> +- interrupts : Should be single bit error interrupt, then double bit error
>> +	interrupt. Note the rising edge type.
>
> Do these actually differ in programming interface, or just w.r.t. the
> component they are used to monitor?

The interface is similar but the bit definitions for ECC Enable and bit 
injection are different between these two IPs. However, these 
differences are taken care of with different const data structures in 
altera_edac.c.

>
> It would be good to have an explicit link to what they monitor rather
> than relying on there being single instances with particular compatible
> strings. That will make this easier to generalise for multiple instances
> in future SoCs that may reuse the EDAC block.
>

You're suggesting a phandle to the L2 cache similar to the phandle the 
OCRAM uses? The probe function would then grab the appropriate const 
data structure based on where the phandle pointed, correct?

> This doesn't look too bad, but I'd like to hear some response to this
> and my other queries before I can say whether this is a good way of
> describing the hardware; it all looks a bit vague.
>
> As an aside, please place the documentation at the start of the series,
> before the driver rework. The dts patches can come after the docs and
> code patches.
>

I will do that. Thanks for reviewing.

> Thanks,
> Mark.
>
>> +
>> +Example:
>> +
>> +	soc_ecc {
>> +		compatible = "altr,edac";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		l2edac at ffd08140 {
>> +			compatible = "altr,l2-edac";
>> +			reg = <0xffd08140 0x4>;
>> +			interrupts = <0 36 1>, <0 37 1>;
>> +		};
>> +
>> +		ocramedac at ffd08144 {
>> +			compatible = "altr,ocram-edac";
>> +			reg = <0xffd08144 0x4>;
>> +			iram = <&ocram>;
>> +			interrupts = <0 178 1>, <0 179 1>;
>> +		};
>> +	};
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index 252c3d1..e546e47 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -618,6 +618,26 @@
>>   			interrupts = <0 39 4>;
>>   		};
>>
>> +		soc_ecc {
>> +			compatible = "altr,edac";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			l2edac at ffd08140 {
>> +				compatible = "altr,l2-edac";
>> +				reg = <0xffd08140 0x4>;
>> +				interrupts = <0 36 1>, <0 37 1>;
>> +			};
>> +
>> +			ocramedac at ffd08144 {
>> +				compatible = "altr,ocram-edac";
>> +				reg = <0xffd08144 0x4>;
>> +				iram = <&ocram>;
>> +				interrupts = <0 178 1>, <0 179 1>;
>> +			};
>> +		};
>> +
>>   		L2: l2-cache at fffef000 {
>>   			compatible = "arm,pl310-cache";
>>   			reg = <0xfffef000 0x1000>;
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
