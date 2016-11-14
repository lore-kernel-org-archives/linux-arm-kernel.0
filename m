From: anurupvasu@gmail.com (Anurup M)
Date: Mon, 14 Nov 2016 05:36:44 +0530
Subject: [RESEND PATCH v1 05/11] dt-bindings: perf: hisi: Add Devicetree
 bindings for Hisilicon SoC PMU
In-Reply-To: <20161110183040.GD10137@leverpostej>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-6-git-send-email-anurup.m@huawei.com>
 <20161110183040.GD10137@leverpostej>
Message-ID: <58290014.2020401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 11 November 2016 12:00 AM, Mark Rutland wrote:
> Hi,
>
> On Thu, Nov 03, 2016 at 01:42:01AM -0400, Anurup M wrote:
>> 	1) Device tree bindings for Hisilicon SoC PMU.
>> 	2) Add example for Hisilicon L3 cache, MN and DDRC PMU.
>>
>> Signed-off-by: Anurup M<anurup.m@huawei.com>
>> Signed-off-by: Shaokun Zhang<zhangshaokun@hisilicon.com>
>> ---
>>   .../devicetree/bindings/arm/hisilicon/pmu.txt      | 127 +++++++++++++++++++++
>>   1 file changed, 127 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> new file mode 100644
>> index 0000000..e7b35e0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> @@ -0,0 +1,127 @@
>> +Hisilicon SoC hip05/06/07 ARMv8 PMU
>> +===================================
>> +
>> +The Hisilicon SoC chips like hip05/06/07 etc. consist of varous independent
>> +system device PMU's such as L3 cache (L3C), Miscellaneous Nodes(MN) and DDR
> s/PMU's/PMUs/
OK.
>> +comtroller. These PMU devices are independent and have hardware logic to
> s/comtroller/controller/
>
>> +gather statistics and performance information.
>> +
>> +HiSilicon SoC chip is encapsulated by multiple CPU and IO die's. The CPU die
> s/die's/dies/
OK.
>> +is called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
>> +is further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
>> +e.g. In the case of hip05/06/07, each SCCL has 1 L3 cache and 1 MN PMU device.
>> +
>> +The Hisilicon SoC PMU DT node bindigs for uncore PMU devices are as below.
> s/bindigs/bindings/
OK. Thanks. I shall make sure with spell checker before sending v2.
>> +For PMU devices like L3 cache. MN etc. which are accessed using the djtag,
>> +the parent node will be the djtag node of the corresponding CPU die(SCCL).
>> +
>> +For uncore PMU devices there are some common required properties as detailed
>> +below.
>> +
>> +Required properties:
>> +	- compatible : This field contain two values. The first value is
>> +		always "hisilicon" and second value is the Module type as shown
>> +		in below examples:
> Just say:
>
>   - Compatible: should contain one of:
OK.
>> +		(a) "hisilicon,hisi-pmu-l3c-v1" for Hisilicon SoC L3C PMU
>> +			device (Version 1)
>> +		(b) "hisilicon,hisi-pmu-mn-v1" for Hisilicon SoC MN PMU
>> +			device (Version 1)
>> +		(c) "hisilicon,hisi-pmu-ddrc-v1" for Hisilicon SoC DDRC PMU
>> +			device (Version 1)
>> +		The hip05/06/07 chips have v1 hardware for L3C, MN and DDRC.
>> +
>> +	- scl-id : The Super Cluster ID. This can be the ID of the CPU die
>> +		   or IO die in the chip.
> What's this needed for?
This is used as suffix to the PMU name. hisi_l3c<scl-id>. (hisi_l3c2 - 
for scl-id = 2).
This is to identify the pmu correspond to which CPU die in the socket.
>> +	- num-events : No of events supported by this PMU device.
>> +
>> +	- num-counters : No of hardware counters available for counting.
> This isn't probeable or well-known?
My idea is to have the common properties of SoC PMU added here.
The num-events, num-counters etc. So that handling can be made common in 
the driver.
Is it not recommended? Please share your comments.
>> +
>> +L3 cache
>> +--------
>> +The L3 cache is dedicated for each SCCL and hence there are separate DT nodes
>> +for L3 cache for each SCCL. For L3 cache PMU the additional required properties
>> +are
>> +	- counter-reg : Counter register offset.
>> +
>> +	- evtype-reg : Event select register offset.
>> +
>> +	- evctrl-reg : Event counting control(LAUCTRL) register offset.
> Surely for a given revision of the chip these offsets are known? i.e.
> surely the compatible string implies specific offsets?
>
>> +	- event-en : Event enable value.
> Huh?
As for the hip05/06 and 07 chips, the above four properties are same, I 
shall
move them to the driver.

The below two properties (module-id, cfgen-map) differs between chips 
hip05/06 and hip07.
There were moved here so as to have minimal changes in driver across 
chips hip05/06/07.

OR whether it is more recommended to have the of_device_id .data set 
accordingly for handling
different chip versions?

Please suggest.
>> +	- module-id : Module ID to input for djtag. This property is an array of
>> +		      module_id for each L3 cache banks.
>> +
>> +	- num-banks : Number of banks or instances of the device.
> What's a bank? Surely they have separate instances of the PMU?
Yes each bank is a separate instance of PMU.
If it is recommended to have each L3 cache bank registered as separate 
PMU with perf, then this property will be removed.
> What order are these in?
The bank number will start from "1" till "4" for L3 cache as there are 
four banks in hip05/06/07 chips.
>> +	- cfgen-map : Config enable array to select the bank.
> Huh?
>
>> +Miscellaneous Node
>> +-------------------
>> +The MN is dedicated for each SCCL and hence there are separate DT nodes for MN
>> +for each SCCL. For MN PMU the additional required properties are
>> +	- counter-reg : Counter register offset.
>> +
>> +	- evtype-reg : Event select register offset.
>> +
>> +	- evctrl-reg : Event counting control register offset.
> Likewise, surely this is well-known for a given revision of the chip?
>
>> +
>> +	- module-id : Module ID to input for djtag. As MN doesnot have multiple banks
>> +		      this property is a single value.
>> +
>> +	- cfgen-map : Config enable to select the bank. For MN it is a single value
>> +
>> +	- event-en : Event enable value.
> Same comments as for the L3 cache nodes
>
>
> [...]
>
>> +DDR controller
>> +--------------
>> +Each SCCL in Hip05/06/07 chips have 2 DDR channels and hence 2 DDR controllers.
>> +There are separate DT nodes for each DDR channel.
>> +For DDRC PMU the additional required properties are
>> +
>> +	- ch-id : DDRC Channel ID.
> Why is this necessary?
This is used as suffix to the PMU name. hisi_ddrc<scl-id>_<ch-id>. 
(hisi_ddrc2_0 - for scl-id = 2, ddrc channel = 0).
This is to identify the pmu correspond to which DDRC channel.

Thanks,
Anurup
> Thanks,
> Mark.
>
>> +	- reg : Register base address and range for the DDRC channel.
>> +
>> +Example:
>> +	/* DDRC for CPU die scl #2 Channel #1 for hip05 */
>> +	pmu_sccl0_ddrc1: pmu_ddrc1 at 80358000 {
>> +		 compatible = "hisilicon,hisi-pmu-ddrc-v1";
>> +		 scl-id = <0x02>;
>> +		 ch-id = <0x1>;
>> +		 num-events = <0x0D>;
>> +		 num-counters = <0x04>;
>> +		 reg = <0x80358000 0x10000>; /* TOTEMC DDRC1 */
>> +	 };
>> -- 
>> 2.1.4
>>
