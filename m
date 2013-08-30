From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 30 Aug 2013 15:36:06 +0100
Subject: [Patch v3 2/3] ARM: dts: Document the CCI PMU DT bindings
In-Reply-To: <1377871180.3655.41.camel@linaro1.home>
References: <1377183748-5717-1-git-send-email-punit.agrawal@arm.com>
 <1377183748-5717-3-git-send-email-punit.agrawal@arm.com>
 <1377871180.3655.41.camel@linaro1.home>
Message-ID: <5220ADD6.1020006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On 30/08/13 14:59, Jon Medhurst (Tixy) wrote:
> On Thu, 2013-08-22 at 16:02 +0100, Punit Agrawal wrote:
>> The CCI PMU can profile bus transactions at the master and slave
>> interfaces of the CCI. The PMU can be used to observe an aggregated
>> view of the bus traffic between the various components connected to the
>> CCI.
>>
>> Introduce a binding for the CCI PMU. The PMU node will be a sub-node of
>> the CCI node.
>>
>> Cc: devicetree at vger.kernel.org
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/cci.txt |   46 +++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
>> index 024c03d..551119e 100644
>> --- a/Documentation/devicetree/bindings/arm/cci.txt
>> +++ b/Documentation/devicetree/bindings/arm/cci.txt
>> @@ -85,6 +85,42 @@ specific to ARM.
>>   				    corresponding interface programming
>>   				    registers.
>>
>> +	- CCI PMU node
>> +
>> +		Parent node must be CCI interconnect node.
>> +
>> +		A CCI pmu node must contain the following properties:
>> +
>> +		- compatible
>> +			Usage: required
>> +			Value type: <string>
>> +			Definition: must be "arm,cci-400-pmu"
>> +
>> +		- reg:
>> +			Usage: required
>> +			Value type: Integer cells. A register entry, expressed
>> +				    as a pair of cells, containing base and
>> +				    size.
>> +			Definition: the base address and size of the
>> +				    corresponding interface programming
>> +				    registers.
>> +
>> +		- interrupts:
>> +			Usage: required
>> +			Value type: Integer cells. Array of interrupt specifier
>> +				    entries, as defined in
>> +				    ../interrupt-controller/interrupts.txt.
>> +			Definition: list of counter overflow interrupts, one per
>> +				    counter. The interrupts must be specified
>> +				    starting with the cycle counter overflow
>> +				    interrupt, followed by counter0 overflow
>> +				    interrupt, counter1 overflow interrupt,...
>> +				    ,counterN overflow interrupt.
>> +
>> +				    The CCI PMU has an interrupt signal for each
>> +				    counter. The number of interrupts must be
>> +				    equal to the number of counters.
>> +
>>   * CCI interconnect bus masters
>>
>>   	Description: masters in the device tree connected to a CCI port
>> @@ -169,6 +205,16 @@ Example:
>>   			interface-type = "ace";
>>   			reg = <0x5000 0x1000>;
>>   		};
>> +
>> +		pmu at 9000 {
>> +			 compatible = "arm,cci-400-pmu";
>> +			 reg = <0x9000 0x5000>;
>> +			 interrupts = <0 101 4>,
>> +				      <0 102 4>,
>> +				      <0 103 4>,
>> +				      <0 104 4>,
>> +				      <0 105 4>;
>> +		};
>>   	};
>>
>>   This CCI node corresponds to a CCI component whose control registers sits
>
>
> It's not shown in the diff above, but the documentation gives the
> following for the cci node:
>
> 		ranges = <0x0 0x0 0x2c090000 0x6000>;
>
> which doesn't include the PMU nodes, so should that 0x6000 also be
> changed to 0x10000 (the full range of addresses in the TRM).
>

You're right. Now that I am adding support for the PMU, this range 
should be extended to include the rest of the CCI addresses. I'll update 
it in the next version.

Cheers,
Punit
