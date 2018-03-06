From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 6 Mar 2018 11:05:36 -0800
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <20180306124002.GA13950@amd>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
Message-ID: <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Thanks for sharing your time on reviewing it. Please see my answers inline.

-Jae

On 3/6/2018 4:40 AM, Pavel Machek wrote:
> Hi!
> 
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> new file mode 100644
>> index 000000000000..8a86f346d550
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> @@ -0,0 +1,73 @@
>> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> 
> Are these SoCs x86-based?
> 

Yes, these are ARM SoCs. Please see Andrew's answer as well.

>> +Required properties:
>> +- compatible
>> +	"aspeed,ast2400-peci" or "aspeed,ast2500-peci"
>> +	- aspeed,ast2400-peci: Aspeed AST2400 family PECI controller
>> +	- aspeed,ast2500-peci: Aspeed AST2500 family PECI controller
>> +
>> +- reg
>> +	Should contain PECI registers location and length.
> 
> Other dts documents put it on one line, reg: Should contain ...
> 
>> +- clock_frequency
>> +	Should contain the operation frequency of PECI hardware module.
>> +	187500 ~ 24000000
> 
> specify this is Hz?
> 

I'll add a description. Thanks!

>> +- rd-sampling-point
>> +	Read sampling point selection. The whole period of a bit time will be
>> +	divided into 16 time frames. This value will determine which time frame
>> +	this controller will sample PECI signal for data read back. Usually in
>> +	the middle of a bit time is the best.
> 
> English? "This value will determine when this controller"?
> 

Could I change it like below?:

"This value will determine in which time frame this controller samples 
PECI signal for data read back"

>> +	0 ~ 15 (default: 8)
>> +
>> +- cmd_timeout_ms
>> +	Command timeout in units of ms.
>> +	1 ~ 60000 (default: 1000)
>> +
>> +Example:
>> +	peci: peci at 1e78b000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x1e78b000 0x60>;
>> +
>> +		peci0: peci-bus at 0 {
>> +			compatible = "aspeed,ast2500-peci";
>> +			reg = <0x0 0x60>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			interrupts = <15>;
>> +			clocks = <&clk_clkin>;
>> +			clock-frequency = <24000000>;
>> +			msg-timing-nego = <1>;
>> +			addr-timing-nego = <1>;
>> +			rd-sampling-point = <8>;
>> +			cmd-timeout-ms = <1000>;
>> +		};
>> +	};
>> \ No newline at end of file
> 
