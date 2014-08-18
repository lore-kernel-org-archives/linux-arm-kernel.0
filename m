From: tthayer@opensource.altera.com (Thor Thayer)
Date: Mon, 18 Aug 2014 09:44:38 -0500
Subject: [PATCHv9 3/3] arm: dts: Add Altera SDRAM controller bindings
In-Reply-To: <53F14DC2.70000@gmail.com>
References: <1406744573-609-1-git-send-email-tthayer@opensource.altera.com>
 <1406744573-609-4-git-send-email-tthayer@opensource.altera.com>
 <53F14DC2.70000@gmail.com>
Message-ID: <53F21156.70400@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/17/2014 07:50 PM, Rob Herring wrote:
> On 07/30/2014 01:22 PM, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Add the Altera SDRAM controller bindings and device tree changes to the Altera SoC project.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2: Changes to SoC SDRAM EDAC code.
>>
>> v3: Implement code suggestions for SDRAM EDAC code.
>>
>> v4: Remove syscon from SDRAM controller bindings.
>>
>> v5: No Change, bump version for consistency.
>>
>> v6: Only map the ctrlcfg register as syscon.
>>
>> v7: No change. Bump for consistency.
>>
>> v8: No change. Bump for consistency.
>>
>> v9: Changes to support a MFD SDRAM controller with nested EDAC.
>> ---
>>   .../devicetree/bindings/arm/altera/socfpga-sdr.txt |   13 +++++++++++++
>>   arch/arm/boot/dts/socfpga.dtsi                     |   10 ++++++++++
>>   2 files changed, 23 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/altera/socfpga-sdr.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdr.txt
>> new file mode 100644
>> index 0000000..2bb1ddf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdr.txt
>> @@ -0,0 +1,13 @@
>> +Altera SOCFPGA SDRAM Controller
>> +The SDRAM controller is implemented as a MFD so various drivers may
>> +nest under this main SDRAM controller binding.
>> +
>> +Required properties:
>> +- compatible : "altr,sdr";
>> +- reg : Should contain 1 register range(address and length)
>> +
>> +Example:
>> +	sdr at 0xffc25000 {
>> +		compatible = "altr,sdr";
>> +		reg = <0xffc25000 0x1000>;
>> +	};
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index 4676f25..ecb306d 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -603,6 +603,16 @@
>>   			};
>>   		};
>>   
>> +		sdr at 0xffc25000 {
>> +			compatible = "altr,sdr";
>> +			reg = <0xffc25000 0x1000>;
>> +
>> +			sdramedac at 0 {
>> +				compatible = "altr,sdram-edac";
>> +				interrupts = <0 39 4>;
>> +			};
> This doesn't match the documentation, but I don't think this is a move
> in the right direction anyway. Because Linux has/wants an MFD driver is
> not a reason to add a sub node. It is a single h/w block and DT should
> reflect that.
>
> Rob
Hi Rob,

Thanks for reviewing. After discussions with the community and 
internally, I reverted to using the syscon case in revision 10. I 
apologize for the confusion but the syscon method seems to be a cleaner 
solution. I submitted the sycon version on 8/11/14.

Thanks,

Thor
