From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 23 Dec 2016 15:53:19 +0530
Subject: [PATCH v2 03/10] dt-bindings: perf: hisi: Add Devicetree bindings
 for Hisilicon SoC PMU
In-Reply-To: <20161219163702.c7wvqsaa4jcztthh@rob-hp-laptop>
References: <1481129759-159533-1-git-send-email-anurup.m@huawei.com>
 <20161219163702.c7wvqsaa4jcztthh@rob-hp-laptop>
Message-ID: <585CFB17.1070407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 19 December 2016 10:07 PM, Rob Herring wrote:
> On Wed, Dec 07, 2016 at 11:55:59AM -0500, Anurup M wrote:
>> 1) Device tree bindings for Hisilicon SoC PMU.
>> 2) Add example for Hisilicon L3 cache and MN PMU.
>> 3) Add child nodes of L3C and MN in djtag bindings example.
>>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   .../devicetree/bindings/arm/hisilicon/djtag.txt    | 25 ++++++
>>   .../devicetree/bindings/arm/hisilicon/pmu.txt      | 98 ++++++++++++++++++++++
>>   2 files changed, 123 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>> index 733498e..c885507 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
>> @@ -27,6 +27,31 @@ Example 1: Djtag for CPU die
>>   		scl-id = <0x02>;
>>   
>>   		/* All connecting components will appear as child nodes */
>> +
>> +		pmul3c0 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x02>;
>> +		};
>> +
>> +		pmul3c1 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x04>;
>> +		};
>> +
>> +		pmul3c2 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x01>;
>> +		};
>> +
>> +		pmul3c3 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x08>;
>> +		};
>> +
>> +		pmumn0 {
>> +			compatible = "hisilicon,hisi-pmu-mn-v1";
>> +			module-id = <0x0b>;
>> +		};
>>   	};
>>   
>>   Example 2: Djtag for IO die
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> new file mode 100644
>> index 0000000..e2160ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> @@ -0,0 +1,98 @@
>> +Hisilicon SoC HiP05/06/07 ARMv8 PMU
>> +===================================
>> +
>> +The Hisilicon SoC chips like HiP05/06/07 etc. consist of various independent
>> +system device PMUs such as L3 cache (L3C) and Miscellaneous Nodes(MN). These
>> +PMU devices are independent and have hardware logic to gather statistics and
>> +performance information.
>> +
>> +HiSilicon SoC chip is encapsulated by multiple CPU and IO dies. The CPU die
>> +is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
>> +in HiP05/06/07 chips are further grouped as CPU clusters (CCL) which includes
>> +4 cpu-cores each.
>> +e.g. In the case of HiP05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
>> +The L3 cache is further grouped as 4 L3 cache banks in a SCCL.
>> +
>> +The Hisilicon SoC PMU DT node bindings for uncore PMU devices are as below.
>> +For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
>> +the parent node will be the djtag node of the corresponding CPU die (SCCL).
>> +
>> +L3 cache
>> +---------
>> +The L3 cache is dedicated for each SCCL. Each SCCL in HiP05/06/07 chips have 4
>> +L3 cache banks. Each L3 cache bank have separate DT nodes.
>> +
>> +Required properties:
>> +
>> +	- compatible : This value should be as follows
>> +		(a) "hisilicon,hisi-pmu-l3c-v1" for v1 hw in HiP05/06 chips
>> +		(b) "hisilicon,hisi-pmu-l3c-v2" for v2 hw in HiP07 chip
> Use SoC specific compatible strings.

Ok.

>> +
>> +	- module-id : This property is a combination of two values in the below order.
>> +		      a) Module ID: The module identifier for djtag.
>> +		      b) Instance or Bank ID: This will identify the L3 cache bank
>> +			 or instance.
> Needs a vendor prefix.

Ok. Shall change to "hisi-module-id". Also modify for all vendor 
specific properties.

>> +
>> +Optional properties:
>> +
>> +	- interrupt-parent : A phandle indicating which interrupt controller
>> +		this PMU signals interrupts to.
>> +
>> +	- interrupts : Interrupt lines used by this L3 cache bank.
> How many interrupts and what are they?

A single interrupt. Shall modify as  "Interrupt line used by the L3 
cache bank".

Thanks,
Anurup

>> +
>> +	*The counter overflow IRQ is not supported in v1 hardware (HiP05/06).
>> +
>> +Miscellaneous Node
>> +------------------
>> +The MN is dedicated for each SCCL and hence there are separate DT nodes for MN
>> +for each SCCL.
> Similar comments here.
>
>> +
>> +Required properties:
>> +
>> +	- compatible : This value should be as follows
>> +		(a) "hisilicon,hisi-pmu-mn-v1" for v1 hw in HiP05/06 chips
>> +		(b) "hisilicon,hisi-pmu-mn-v2" for v2 hw in HiP07 chip
>> +
>> +	- module-id : Module ID to input for djtag.
>> +
>> +Optional properties:
>> +
>> +	- interrupt-parent : A phandle indicating which interrupt controller
>> +		this PMU signals interrupts to.
>> +
>> +	- interrupts : Interrupt lines used by this PMU.
>> +
>> +	*The counter overflow IRQ is not supported in v1 hardware (HiP05/06).
>> +
>> +Example:
>> +
>> +	djtag0: djtag at 80010000 {
>> +		compatible = "hisilicon,hisi-djtag-v1";
>> +		reg = <0x0 0x80010000 0x0 0x10000>;
>> +		scl-id = <0x02>;
>> +
>> +		pmul3c0 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x02>;
>> +		};
>> +
>> +		pmul3c1 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x04>;
>> +		};
>> +
>> +		pmul3c2 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x01>;
>> +		};
>> +
>> +		pmul3c3 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			module-id = <0x04 0x08>;
>> +		};
>> +
>> +		pmumn0 {
>> +			compatible = "hisilicon,hisi-pmu-mn-v1";
>> +			module-id = <0x0b>;
>> +		};
>> +	};
>> -- 
>> 2.1.4
>>
