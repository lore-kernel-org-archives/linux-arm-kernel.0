From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 7 Feb 2012 17:09:17 +0530
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
Message-ID: <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2012 at 4:55 PM, stephane eranian <eranian@googlemail.com> wrote:
> On Tue, Feb 7, 2012 at 12:09 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Tue, Feb 7, 2012 at 4:23 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>>> ( Removing dead "linux-arm-kernel at lists.arm.linux.org.uk" and adding
>>> correct list
>>>
>>> On Tue, Feb 7, 2012 at 4:07 PM, stephane eranian <eranian@googlemail.com> wrote:
>>>> Hi,
>>>>
>>>> Ok, with Santosh's patch this is much better almost as expected, still
>>>> 10-15% off.
>>>>
>> [....]
>>
>>>> So the fix does help. I am wondering why we're not getting closer to
>>>> 10k samples. But that
>>>> may be due to some overhead somewhere in there.
>>>>
>>
>> There might be still a small corner case where few reads
>> might return the stale value. Counter need at least 1 32K
>> clock cycle for the sync. udelay is not accurate but
>> it will at least give min. 1/32768, so it should be
>> fine.
>>
>> May be you can try out below patch and see if it helps.
>>
>> Regards
>> Santosh
>>
>> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
>> index 5f0f229..014d8bd 100644
>> --- a/arch/arm/plat-omap/counter_32k.c
>> +++ b/arch/arm/plat-omap/counter_32k.c
>> @@ -18,6 +18,7 @@
>> ?#include <linux/err.h>
>> ?#include <linux/io.h>
>> ?#include <linux/clocksource.h>
>> +#include <linux/delay.h>
>>
>> ?#include <asm/sched_clock.h>
>>
>> @@ -38,6 +39,8 @@ static void __iomem *timer_32k_base;
>>
>> ?static u32 notrace omap_32k_read_sched_clock(void)
>> ?{
>> + ? ? ? /* Counter might take 1 clock cycle for OCP sync */
>> + ? ? ? udelay(31);
>> ? ? ? ?return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
>> ?}
> That's worse with this patch (on top of the previous one).
>
Thanks for the test. Forget about the last change
