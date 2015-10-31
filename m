From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 31 Oct 2015 18:07:38 +0800
Subject: [PATCH 1/2] clocksource: replace cycle_last validation with an
 equal way
In-Reply-To: <alpine.DEB.2.11.1510301533310.4032@nanos>
References: <1445952073-7260-1-git-send-email-yangyingliang@huawei.com>
 <1445952073-7260-2-git-send-email-yangyingliang@huawei.com>
 <alpine.DEB.2.11.1510301533310.4032@nanos>
Message-ID: <563492EA.90206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/10/30 22:56, Thomas Gleixner wrote:
> Yang,
>
> On Tue, 27 Oct 2015, Yang Yingliang wrote:
>
>> Mask the cycle values before subtraction. So we can use this
>> validation while the clocksource mask is not 64-bits.
>>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   kernel/time/timekeeping_internal.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
>> index 4ea005a..984f02e 100644
>> --- a/kernel/time/timekeeping_internal.h
>> +++ b/kernel/time/timekeeping_internal.h
>> @@ -15,7 +15,7 @@ extern void tk_debug_account_sleep_time(struct timespec64 *t);
>>   #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
>>   static inline cycle_t clocksource_delta(cycle_t now, cycle_t last, cycle_t mask)
>>   {
>> -	cycle_t ret = (now - last) & mask;
>> +	cycle_t ret = (now & mask) - (last & mask);
>
> I agree the original code is broken for all masks which are !=
> CLOCKSOURCE_MASK(64).
>
> But your change does not work for actual wraparounds. You probably
> cannot trigger it for the 56bits of the arm architected timer, but
> that does not make it more correct.
>
> Assume a CLOCKSOURCE_MASK(32) and that the timer wrapped around since
> we last read it.
>
> last = 0xffffffff
> now = 0x01
>
> So:
>
> 	ret = (0x01 & 0xffffffff) - (0xffffffff & 0xffffffff);
> -->	ret = 0x01 - 0xffffffff;
> -->	ret = ffffffff00000002;
>
> -->	(s64) ret is < 0 !!!
>
> This is wrong as the clocksource legitimately wrapped around since we
> accessed it last.
>
> The correct solution to this is:
>
>      	ret = (now - last) & mask;
> 	
> 	negative = ret & ~(mask >> 1);
>
> 	return negative ? 0 : ret;

Thanks for your advise.
I will resend this patch.

Regards,
Yang
