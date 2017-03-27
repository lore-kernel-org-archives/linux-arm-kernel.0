From: anurupvasu@gmail.com (Anurup M)
Date: Mon, 27 Mar 2017 12:04:06 +0530
Subject: [PATCH v6 07/11] drivers: perf: hisi: Add support for Hisilicon
 SoC event counters
In-Reply-To: <20170324115707.GD22771@leverpostej>
References: <1489127311-112778-1-git-send-email-anurup.m@huawei.com>
 <20170321165252.GA29116@leverpostej> <58D4F277.7080006@gmail.com>
 <20170324115707.GD22771@leverpostej>
Message-ID: <58D8B25E.90308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 24 March 2017 05:27 PM, Mark Rutland wrote:
>> +/* hip05/06 chips L3C bank identifier */
>> >+static u32 l3c_bankid_map_v1[MAX_BANKS] = {
>> >+    0x02, 0x04, 0x01, 0x08,
>> >+};
>> >+
>> >+/* hip07 chip L3C bank identifier */
>> >+static u32 l3c_bankid_map_v2[MAX_BANKS] = {
>> >+    0x01, 0x02, 0x03, 0x04,
>> >+};
>> >
>> >Is my approach OK? or can be improved?
> I think it would make more sense for this to be described in the DT.

Ok. Shall describe it in DT.

> [...]
>
>> I shall handle the error internally and propagate it until a void
>> >function (pmu->start, pmu->stop, pmu->del etc. are void).
>> >e.g. in the scenario pmu->add ---> pmu->start. If start fail,
>> >pmu->add cannot catch it and continues.
>> >the counter index could be cleared when pmu->del is called later.
>> >
>> >Is this fine? Any suggestion to handle it?
> Propagating it up to a void function, only to silently fail is not good.
>
> Given it seems this should only happen if there is a major HW problem,
> I'd be happier with a BUG_ON() in the djtag accessors.

Yes, it occur only when major HQ problem. I would add BUG_ON in djtag 
and simplify callers.

> [...]
>
>>> > >In the absence of pmu::{enable,disable}, you must disallow groups, since
>>> > >their events will be enabled for different periods of time.
>> >
>> >For L3 cache and MN PMU, pmu::{enable,disable}is present. But in
>> >case of Hisilicon DDRC PMU,
>> >it is not available. It only support continuous counting. I shall
>> >disallow groups when adding support
>> >for DDRC PMU.
> Given this code does not currently support the DDRC, please simplify
> the coder to assume these callbacks always exist. We can alter it when
> DDRC support arrives.

Ok. Sure. Shall remove all similar checks added for DDRC in this file to 
simplify.

Thanks,
Anurup

> Thanks,
> Mark.
