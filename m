From: john.garry@huawei.com (John Garry)
Date: Wed, 9 Nov 2016 09:06:14 +0000
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <5821F491.1010603@gmail.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <2467231.EbVekJun1R@wuerfel>
 <c68064fa-a274-2e22-88a6-5fe388debf2b@huawei.com>
 <2030692.HPgjBCTYG6@wuerfel> <5821F491.1010603@gmail.com>
Message-ID: <d009dcdc-2258-ed6a-53be-2211c7493051@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>>> I'd suggest requiring #address-cells=<1> and #size-cells=<0> in the
>>>> master
>>>> node, and listing the children by reg property. If the address is not
>>>> easily expressed as a single integer, use a larger #address-cells
>>>> value.
>>> We already have something equivalent to reg in "module-id" (see patch
>>> 02/11), which is the slave device bus address; here's a sample:
>>> +        /* For L3 cache PMU */
>>> +        pmul3c0 {
>>> +            compatible = "hisilicon,hisi-pmu-l3c-v1";
>>> +            scl-id = <0x02>;
>>> +            num-events = <0x16>;
>>> +            num-counters = <0x08>;
>>> +            module-id = <0x04>;
>>> +            num-banks = <0x04>;
>>> +            cfgen-map = <0x02 0x04 0x01 0x08>;
>>> +            counter-reg = <0x170>;
>>> +            evctrl-reg = <0x04>;
>>> +            event-en = <0x1000000>;
>>> +            evtype-reg = <0x140>;
>>> +        };
>>>
>>> FYI, "module-id" is our own internal hw nomenclature.
>> Yes, that was my interpretation as well. Please use the standard
>> "reg" property for this then.
> Hi Arnd,
>
> Firstly my apologies for a mistake in the bindings example in ([PATCH
> 02/11 ..]).
> The module-id property is a list as defined in the PMU bindings patch
> ([PATCH v1 05/11] dt-bindings .. <https://lkml.org/lkml/2016/11/2/323>).
>
> +    djtag0: djtag at 0 {
> +        compatible = "hisilicon,hip05-cpu-djtag-v1";
> +            pmul3c0 {
> +                compatible = "hisilicon,hisi-pmu-l3c-v1";
> +                scl-id = <0x02>;
> +                num-events = <0x16>;
> +                num-counters = <0x08>;
> +                module-id = <0x04 0x04 0x04 0x04>;
> +                num-banks = <0x04>;
> +                cfgen-map = <0x02 0x04 0x01 0x08>;
> +                counter-reg = <0x170>;
> +                evctrl-reg = <0x04>;
> +                event-en = <0x1000000>;
> +                evtype-reg = <0x140>;
> +            };
>
>
> The L3 cache in hip05/06/07 chips consist of 4 banks (each bank has PMU
> registers).
>
> In hip05/06 all L3 cache banks are identified with same module-id.
> module-id = <0x04 0x04 0x04 0x04>;
>
> But in the case hip07 chip(djtag v2), each L3 cache bank has different
> module-id
> module-id = <0x01 0x02 0x03 0x04>;
>
> So in this case Please share your opinion on how to model it.
>

My suggestion is to have a single PMU per module, whether that is 4 
banks or 1 bank per module, as this makes the driver simpler.

I think you mentioned that a separate PMU per bank does not make much 
sense, and you would rather treat all banks as a single bank and 
aggregrate their perf statstics under a single PMU: Can you just use a 
script in userspace which can do this aggregration work if you have 
separate PMUs?

Maybe perf guys have a view on this also.

John

> Some more detail of L3 cache PMU.
> ------------------------------------------------
> The hip05/06/07 chips consists of a multiple Super CPU cluster (16 CPU
> cores). we call it SCCL.
> The L3 cache( 4 banks) is shared by all CPU cores in a SCCL.
> Each L3 cache bank has PMU registers. We always take the sum of the
> counters to show in perf.
> Taking individual L3 cache count is not meaningful as there is no
> mapping of CPU cores to individual
> L3 cache banks.
>
> Please share your suggestion.
>
> Thanks,
> Anurup
