From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 15 Aug 2013 10:10:02 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
Message-ID: <520C9AEA.6030507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

Thanks for a review of the bindings.

On 14/08/13 22:03, Kumar Gala wrote:
>
> On Jul 23, 2013, at 4:19 AM, Punit Agrawal wrote:
>
>> The CCI PMU can profile bus transactions at the master and slave
>> interfaces of the CCI. The PMU can be used to observe an aggregated view
>> of the bus traffic between the various components connected to the CCI.
>>
>> Extend the existing CCI driver to support the PMU by registering a perf
>> backend for it.
>>
>> Document the device tree binding to describe the CCI PMU.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Nicolas Pitre <nico@linaro.org>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> ---
>> Documentation/devicetree/bindings/arm/cci.txt |   38 ++
>> drivers/bus/arm-cci.c                         |  642 +++++++++++++++++++++++++
>> 2 files changed, 680 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
>> index 92d36e2..5bc95e5 100644
>> --- a/Documentation/devicetree/bindings/arm/cci.txt
>> +++ b/Documentation/devicetree/bindings/arm/cci.txt
>> @@ -79,6 +79,34 @@ specific to ARM.
>> 				    corresponding interface programming
>> 				    registers.
>>
>> +	- CCI PMU node
>> +
>> +		Node name must be "pmu".
>> +		Parent node must be CCI interconnect node.
>> +
>> +		A CCI pmu node must contain the following properties:
>> +
>> +		- compatible
>> +			Usage: required
>> +			Value type: <string>
>> +			Definition: must be set to one of
>> +				    "arm,cci-400-pmu"
>> +				    "arm,cci-400-pmu,rev0"
>> +				    "arm,cci-400-pmu,rev1"
>
> Do you really mean only one?  Seems like ""arm,cci-400-pmu,rev0", "arm,cci-400-pmu" would be valid.
>

Hmm... yes both would be valid. But...

The event numbering scheme changed between Rev 0 and Rev 1 of the CCI. 
If the revision is specified then it is used to get the event ranges to 
validate the events. If not, i.e., "arm,cci-400-pmu" is used, then the 
driver tries to find the the revision by reading the peripheral id 
registers.

I was trying to make the bindings robust in the face of change in 
behaviour between different revisons of the IP.

>> +
>> +		- reg:
>> +			Usage: required
>> +			Value type: <prop-encoded-array>
>> +			Definition: the base address and size of the
>> +				    corresponding interface programming
>> +				    registers.
>> +
>> +		- interrupts:
>> +			Usage: required
>> +			Value type: <prop-encoded-array>
>> +			Definition: comma-separated list of unique PMU
>> +				    interrupts
>
> What is the list of interrupts related to, should there be an associated interrupts-names
>

For the CCI PMU, each interrupt signal corresponds to the overflow of a 
performance counter.

Here again, I was trying to be robust in the face of differing hardware 
configurations - specially the scenario where multiple interrupt lines 
from the CCI PMU are tied together to generate a single interrupt to the 
CPU.

Cheers,
Punit

>> +
>> * CCI interconnect bus masters
>>
>> 	Description: masters in the device tree connected to a CCI port
>> @@ -163,6 +191,16 @@ Example:
>> 			interface-type = "ace";
>> 			reg = <0x5000 0x1000>;
>> 		};
>> +
>> +		pmu at 9000 {
>> +			 compatible = "arm,cci-400-pmu,rev0";
>> +			 reg = <0x9000 0x5000>;
>> +			 interrupts = <0 101 4>,
>> +				      <0 102 4>,
>> +				      <0 103 4>,
>> +				      <0 104 4>,
>> +				      <0 105 4>;
>> +		};
>> 	};
>>
>
> [ snip ]
>
> - k
>
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
>
>
>
