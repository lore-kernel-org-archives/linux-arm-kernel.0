From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 12 Feb 2017 23:50:20 +0530
Subject: [PATCH] clocksource: add __ro_after_init to cyclecounter
In-Reply-To: <CAKv+Gu99ZqLwzPtq1+MjvHt8BrzZDvCe=-Owy5mucsTqXSB+Qw@mail.gmail.com>
References: <1486840818-22214-1-git-send-email-bhumirks@gmail.com>
 <CAKv+Gu99ZqLwzPtq1+MjvHt8BrzZDvCe=-Owy5mucsTqXSB+Qw@mail.gmail.com>
Message-ID: <CAOH+1jEg4ZyrAvGxK51XDQGJ1XErAnKCCqgkG=EJaaGmntQMkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 12, 2017 at 2:01 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 11 February 2017 at 19:20, Bhumika Goyal <bhumirks@gmail.com> wrote:
>> The object cyclecounter of type cyclecounter is not getting modified
>> after getting initialized by arch_counter_register. Apart from
>> initialization in arch_counter_register it is also passed as an argument
>> to the function timecounter_init but this argument is of type const.
>> Therefore, add __ro_after_init to its declaration.
>>
>
> I think adding __ro_after_init is fine if this struct is never
> modified after init. But the reference in the commit log to the
> constness of the timecounter_init() argument  makes no sense: that
> only means timecounter_init() will not modify the object, which allows
> pointers to const objects to be passed to it as well. The opposite is
> not true, though: there is no requirement whatsoever that objects
> passed into const pointer arguments should be const themselves.
>
>

Yes, true. I will change the commit log and send a v2. Thanks for explaining.

Thanks,
Bhumika

>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 4c8c3fb..a10506b 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -580,7 +580,7 @@ static u64 arch_counter_read_cc(const struct cyclecounter *cc)
>>         .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
>>  };
>>
>> -static struct cyclecounter cyclecounter = {
>> +static struct cyclecounter cyclecounter __ro_after_init = {
>>         .read   = arch_counter_read_cc,
>>         .mask   = CLOCKSOURCE_MASK(56),
>>  };
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
