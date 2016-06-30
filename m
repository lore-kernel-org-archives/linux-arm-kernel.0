From: anurupvasu@gmail.com (Anurup M)
Date: Thu, 30 Jun 2016 15:37:08 +0530
Subject: [PATCH 1/8] arm64:perf: Add Devicetree bindings for Hisilicon SoC
 PMU
In-Reply-To: <20160628102311.GC31744@leverpostej>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
 <1467107429-55477-2-git-send-email-anurup.m@huawei.com>
 <20160628102311.GC31744@leverpostej>
Message-ID: <5774EF4C.5070106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 28 June 2016 03:53 PM, Mark Rutland wrote:
> Hi,
>
> On Tue, Jun 28, 2016 at 05:50:22AM -0400, Anurup M wrote:
>> 	1) Device tree bindings for Hisilicon PMU.
>> 	2) Add example for Hisilicon LLC PMU.
>>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> ---
>>   .../devicetree/bindings/arm/hisilicon/pmu.txt      | 32 ++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> new file mode 100644
>> index 0000000..7584a81
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
>> @@ -0,0 +1,32 @@
>> +Hisilicon SoC HIP05 ARMv8 PMU
>> +
>> +Required Properties:
>> +	- compatible : This field contain two values. The first value is
>> +		always "hisilicon" and second value is the PMU type as shown
>> +		in below examples:
>> +		(a) "hisilicon,hip05-llc" for Hisiliocn SoC L3 cache PMU
>> +		(b) "hisilicon,hip05-ddrc" for Hisiliocn SoC DDRC PMU
>> +		(c) "hisilicon,hip05-mn" for Hisiliocn SoC MN PMU
> That wording is rather confusing. Use:
>
> 	- compatible: must contain one of:
> 	  * "hisilicon,hip05-llc" for HIP05 L3 cache PMU
> 	  * "hisilicon,hip05-ddrc" for HIP05 DDRC PMU
> 	  * "hisilicon,hip05-mn" for HIP05 MN PMU
>
> What exactly is an "MN"?
I shall add the description in the bindings.
>
> I assume that these nodes actually describe the whole interface for
> controlling the L3/DDRC/MN, so it's probably worth dropping the "PMU"
> from the description, even if we only support the PMU in Linux.
Agreed. I shall remove "PMU".
>
> No reg properties?
These nodes are accessed via djtag interface which again refers to the 
system-controller node phandle.
I shall describe them in the bindings along with the djtag driver patch 
series.
>
>> +
>> +Optional Properties:
>> +
>> +	- djtag	: Some PMU registers are accessed via the Djtag interface
>> +		This field contains two values. The first value is the djtag
>> +		node phandle and second value is the Super CPU Cluster ID.
> What is a Djtag node? What is a "Super CPU Cluster ID"?
>
> I think you need additional bindings for these. I cannot understand the
> binding without a description of those.
I shall add them in the bindings along with the djtag driver patch series.
>
>> +	- interrupt-parent : A phandle indicating which interrupt controller
>> +		this PMU signals interrupts to.
>> +
>> +	- interrupts : Interrupt lines used by this PMU. If the PMU has
>> +		multiple banks, then all IRQ lines are listed in this
>> +		property.
> In which order?
If multiple (N) banks, then the order of IRQ lines to be from bank 0 to 
bank N.
I shall mention them more clearly in the description.
>
>> +
>> +Example:
>> +	llc0: llc at 0 {
> That unit address (the '@0') shouldn't be there, given the lack of a reg
> property.
Ok.

>
>> +		compatible = "hisilicon,hip05-llc";
>> +		djtag = <&djtag0 2>; /* DJTAG node for Super CPU Cluster 2
>> +				      * (starts from 1) */
>> +		interrupt-parent = <&mbigen_pc>;
>> +		interrupts = <141 4>,<142 4>,
>> +			 <143 4>,<144 4>; /* IRQ lines for 4 L3 cache banks */
>> +	};
>> -- 
>> 2.1.4
> Thanks,
> Mark.
Thanks,
Anurup
