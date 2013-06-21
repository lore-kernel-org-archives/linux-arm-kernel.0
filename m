From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 21 Jun 2013 08:15:28 +0100
Subject: [PATCH v3 02/10] clocksource:arm_global_timer: Add ARM global
 timer support.
In-Reply-To: <201306202102.30478.arnd@arndb.de>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737121-9295-1-git-send-email-srinivas.kandagatla@st.com>
 <201306202102.30478.arnd@arndb.de>
Message-ID: <51C3FD90.8010505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/13 20:02, Arnd Bergmann wrote:
> On Thursday 20 June 2013, Srinivas KANDAGATLA wrote:
>> +static u64 gt_counter_read(void)
>> +{
>> +       u64 counter;
>> +       u32 lower;
>> +       u32 upper, old_upper;
>> +
>> +       upper = __raw_readl(gt_base + GT_COUNTER1);
>> +       do {
>> +               old_upper = upper;
>> +               lower = __raw_readl(gt_base + GT_COUNTER0);
>> +               upper = __raw_readl(gt_base + GT_COUNTER1);
>> +       } while (upper != old_upper);
>> +
>> +       counter = upper;
>> +       counter <<= 32;
>> +       counter |= lower;
>> +       return counter;
>> +}
> 
> Please replace __raw_readl etc with the non-__raw variants
> throughout the code.
> 
> The __raw accessors are not endian safe and are not meant
> for device drivers. If you are worried about latency from
> extra barriers, use readl_relaxed().
Endian safe is good point. I will move to using readl/writel which does
both ordering and byteswapping.
And use relaxed versions in gt_counter_read to reduce the latency.

looks like smp_twd.c too needs this type of change.

Thanks,
srini

> 
> 	Arnd
> 
