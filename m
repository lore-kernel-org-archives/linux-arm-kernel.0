From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 29 Jul 2013 11:41:41 -0700
Subject: [PATCH] time: sched_clock: fix integer overflow
In-Reply-To: <20130729055939.GK5161@tarshish>
References: <232c026d1b8d2556679aea56cf77a6811f9a96c5.1374054369.git.baruch@tkos.co.il>
 <20130729055939.GK5161@tarshish>
Message-ID: <51F6B765.9030404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/13 22:59, Baruch Siach wrote:
> Hi Thomas, John,
>
> On Wed, Jul 17, 2013 at 12:46:53PM +0300, Baruch Siach wrote:
>> The expression '(1 << 32)' happens to evaluate as 0 on ARM, but it evaluates as
>> 1 on xtensa and x86_64. This zeros sched_clock_mask, and breaks sched_clock().
>> Set the type of 1 to 'unsigned long long' to get the value we need.
> Ping? -rc3 is out, and this bug (which currently breaks xtensa) is not fixed 
> yet. Please consider applying.

Looks good to me.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

>
>> Reported-by: Max Filippov <jcmvbkbc@gmail.com>
>> Tested-by: Max Filippov <jcmvbkbc@gmail.com>
>> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>>  kernel/time/sched_clock.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
>> index a326f27..0b479a6 100644
>> --- a/kernel/time/sched_clock.c
>> +++ b/kernel/time/sched_clock.c
>> @@ -121,7 +121,7 @@ void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
>>  	BUG_ON(bits > 32);
>>  	WARN_ON(!irqs_disabled());
>>  	read_sched_clock = read;
>> -	sched_clock_mask = (1 << bits) - 1;
>> +	sched_clock_mask = (1ULL << bits) - 1;
>>  	cd.rate = rate;
>>  
>>  	/* calculate the mult/shift to convert counter ticks to ns. */
>> -- 


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
