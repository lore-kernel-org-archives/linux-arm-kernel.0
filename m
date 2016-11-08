From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 8 Nov 2016 21:21:45 +0530
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <2030692.HPgjBCTYG6@wuerfel>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2467231.EbVekJun1R@wuerfel>
 <c68064fa-a274-2e22-88a6-5fe388debf2b@huawei.com>
 <2030692.HPgjBCTYG6@wuerfel>
Message-ID: <5821F491.1010603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 November 2016 05:15 PM, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 11:23:35 AM CET John Garry wrote:
>> On 07/11/2016 20:08, Arnd Bergmann wrote:
>>> On Monday, November 7, 2016 2:15:10 PM CET John Garry wrote:
>>>> Hi Arnd,
>>>>
>>>> The new bus type tries to model the djtag in a similar way to I2C/USB
>>>> driver arch, where we have a host bus adapter and child devices attached
>>>> to the bus. The child devices are bus driver devices and have bus
>>>> addresses. We think of the djtag as a separate bus, so we are modelling
>>>> it as such.
>>>>
>>>> The bus driver offers a simple host interface for clients to read/write
>>>> to the djtag bus: bus accesses are hidden from the client, the host
>>>> drives the bus.
>>> Ok, in that case we should probably start out by having a bus specific
>>> DT binding, and separating the description from that of the bus master
>>> device.
>> OK
>>
>>> I'd suggest requiring #address-cells=<1> and #size-cells=<0> in the master
>>> node, and listing the children by reg property. If the address is not
>>> easily expressed as a single integer, use a larger #address-cells value.
>> We already have something equivalent to reg in "module-id" (see patch
>> 02/11), which is the slave device bus address; here's a sample:
>> +		/* For L3 cache PMU */
>> +		pmul3c0 {
>> +			compatible = "hisilicon,hisi-pmu-l3c-v1";
>> +			scl-id = <0x02>;
>> +			num-events = <0x16>;
>> +			num-counters = <0x08>;
>> +			module-id = <0x04>;
>> +			num-banks = <0x04>;
>> +			cfgen-map = <0x02 0x04 0x01 0x08>;
>> +			counter-reg = <0x170>;
>> +			evctrl-reg = <0x04>;
>> +			event-en = <0x1000000>;
>> +			evtype-reg = <0x140>;
>> +		};
>>
>> FYI, "module-id" is our own internal hw nomenclature.
> Yes, that was my interpretation as well. Please use the standard
> "reg" property for this then.
Hi Arnd,

Firstly my apologies for a mistake in the bindings example in ([PATCH 
02/11 ..]).
The module-id property is a list as defined in the PMU bindings patch 
([PATCH v1 05/11] dt-bindings .. <https://lkml.org/lkml/2016/11/2/323>).

+	djtag0: djtag at 0 {
+		compatible = "hisilicon,hip05-cpu-djtag-v1";
+			pmul3c0 {
+				compatible = "hisilicon,hisi-pmu-l3c-v1";
+				scl-id = <0x02>;
+				num-events = <0x16>;
+				num-counters = <0x08>;
+				module-id = <0x04 0x04 0x04 0x04>;
+				num-banks = <0x04>;
+				cfgen-map = <0x02 0x04 0x01 0x08>;
+				counter-reg = <0x170>;
+				evctrl-reg = <0x04>;
+				event-en = <0x1000000>;
+				evtype-reg = <0x140>;
+			};


The L3 cache in hip05/06/07 chips consist of 4 banks (each bank has PMU 
registers).

In hip05/06 all L3 cache banks are identified with same module-id.
module-id = <0x04 0x04 0x04 0x04>;

But in the case hip07 chip(djtag v2), each L3 cache bank has different 
module-id
module-id = <0x01 0x02 0x03 0x04>;

So in this case Please share your opinion on how to model it.

Some more detail of L3 cache PMU.
------------------------------------------------
The hip05/06/07 chips consists of a multiple Super CPU cluster (16 CPU 
cores). we call it SCCL.
The L3 cache( 4 banks) is shared by all CPU cores in a SCCL.
Each L3 cache bank has PMU registers. We always take the sum of the 
counters to show in perf.
Taking individual L3 cache count is not meaningful as there is no 
mapping of CPU cores to individual
L3 cache banks.

Please share your suggestion.

Thanks,
Anurup
>>> Another option that we have previously used was to actually pretend that
>>> a vendor specific bus is an i2c bus and use the i2c probing infrastructure,
>>> but that only makes sense if the software side closely resembles i2c
>>> (this was the case for Allwinner I think, but I have not looked at
>>> your driver in enough detail to know if it is true here as well).
>>>
>> OK, let me check this. By chance do you remember the specific AllWinner
>> driver/hw?
> drivers/i2c/busses/i2c-sun6i-p2wi.c
>
> 	Arnd
