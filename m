From: tthayer@opensource.altera.com (Thor Thayer)
Date: Tue, 12 Jan 2016 17:19:20 -0600
Subject: [PATCHv7 1/3] ARM: dts: Add Altera L2 Cache and OCRAM EDAC entries
In-Reply-To: <20151111232156.GA31910@rob-hp-laptop>
References: <1445979483-8035-1-git-send-email-dinguyen@opensource.altera.com>
 <20151111232156.GA31910@rob-hp-laptop>
Message-ID: <569589F8.4090206@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob.

On 11/11/2015 05:21 PM, Rob Herring wrote:
> On Tue, Oct 27, 2015 at 03:58:03PM -0500, dinguyen at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Adding the device tree entries and bindings needed to support
>> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
>> an earlier patch to declare and setup On-chip RAM properly.
>> http://www.spinics.net/lists/devicetree/msg51117.html
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>> v7: No Change
>> v6: Change to nested EDAC device nodes based on community
>>      feedback. Remove L2 syscon. Use consolidated binding.
>> v3-5: No Change
>> v2: Remove OCRAM declaration and reference prior patch.
>> ---
>>   .../bindings/arm/altera/socfpga-edac.txt           | 46 ++++++++++++++++++++++
>>   arch/arm/boot/dts/socfpga.dtsi                     | 20 ++++++++++
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
> What is the actual block name? I doubt it happens to match the kernel
> subsystem.
>
OK. I'll rename to altr,socfpga-ecc-manager

>> +- #address-cells: must be 1
>> +- #size-cells: must be 1
>> +- ranges : standard definition, should translate from local addresses
>
> What is the point of having 2 levels? I think you can remove it.
>
The L2 cache ECC and On-Chip RAM ECC are contiguous registers in the 
ecc-manager block. I may not understand your question but it seems like 
2 levels is correct in that case.

>> +
>> +Subcomponents:
>> +
>> +L2 Cache ECC
>> +Required Properties:
>> +- compatible : Should be "altr,l2-edac"
>
> Same comment about name. It should also have the chip name in it.
>
OK. I will add socfpga to all of the compatible fields.

>> +- reg : Address and size for ECC error interrupt clear registers.
>> +- interrupts : Should be single bit error interrupt, then double bit error
>> +	interrupt. Note the rising edge type.
>> +
>> +On Chip RAM ECC
>> +Required Properties:
>> +- compatible : Should be "altr,ocram-edac"
>
> Ditto.
>
>> +- reg : Address and size for ECC error interrupt clear registers.
>> +- iram : phandle to On-Chip RAM definition.
>
> This should probably be standardized and put into the SRAM binding.
> There's 2 cases to consider: phandle to all of SRAM and phandle to
> sub-node of SRAM.
>
OK. We are currently allocating all our On-Chip RAM (SRAM) to the pool 
so I think the phandle to all of SRAM is fine, right?

Thank you for reviewing.

Thor

>> +- interrupts : Should be single bit error interrupt, then double bit error
>> +	interrupt. Note the rising edge type.
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
