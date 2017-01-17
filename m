From: david.engraf@sysgo.com (David Engraf)
Date: Tue, 17 Jan 2017 10:29:02 +0100
Subject: [PATCH] tcb_clksrc: Use 32 bit tcb as sched_clock
In-Reply-To: <e9fa8375-70e9-e621-954e-48c3190171ad@linaro.org>
References: <20170111135059.21318-1-david.engraf@sysgo.com>
 <e9fa8375-70e9-e621-954e-48c3190171ad@linaro.org>
Message-ID: <d509dc18-58e8-36bc-74dc-0acca5f8f7ad@sysgo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.01.2017 um 10:13 schrieb Daniel Lezcano:
> On 11/01/2017 14:50, David Engraf wrote:
>> On newer boards the TC can be read as single 32 bit value without locking.
>> Thus the clock can be used as reference for sched_clock which is much more
>> accurate than the jiffies implementation.
>>
>> Tested on a Atmel SAMA5D2 board.
>
> Is this change backward compatible ?

The way how the driver reads the clock hasn't been changed. I've only 
introduced the call to sched_clock_register() which will use this clock 
for the scheduler as long as no better clock is already used. So I don't 
see a backward compatibility problem.

Best regards
- David

>
>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>> ---
>>  drivers/clocksource/tcb_clksrc.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
>> index d4ca996..745844e 100644
>> --- a/drivers/clocksource/tcb_clksrc.c
>> +++ b/drivers/clocksource/tcb_clksrc.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/io.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/atmel_tc.h>
>> +#include <linux/sched_clock.h>
>>
>>
>>  /*
>> @@ -56,11 +57,16 @@ static u64 tc_get_cycles(struct clocksource *cs)
>>  	return (upper << 16) | lower;
>>  }
>>
>> -static u64 tc_get_cycles32(struct clocksource *cs)
>> +static u32 tc_get_cv32(void)
>>  {
>>  	return __raw_readl(tcaddr + ATMEL_TC_REG(0, CV));
>>  }
>>
>> +static u64 tc_get_cycles32(struct clocksource *cs)
>> +{
>> +	return tc_get_cv32();
>> +}
>> +
>>  static struct clocksource clksrc = {
>>  	.name           = "tcb_clksrc",
>>  	.rating         = 200,
>> @@ -69,6 +75,11 @@ static struct clocksource clksrc = {
>>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>>  };
>>
>> +static u64 notrace tc_read_sched_clock(void)
>> +{
>> +	return tc_get_cv32();
>> +}
>> +
>>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>>
>>  struct tc_clkevt_device {
>> @@ -339,6 +350,9 @@ static int __init tcb_clksrc_init(void)
>>  		clksrc.read = tc_get_cycles32;
>>  		/* setup ony channel 0 */
>>  		tcb_setup_single_chan(tc, best_divisor_idx);
>> +
>> +		/* register sched_clock on chips with single 32 bit counter */
>> +		sched_clock_register(tc_read_sched_clock, 32, divided_rate);
>>  	} else {
>>  		/* tclib will give us three clocks no matter what the
>>  		 * underlying platform supports.
>>
>
>
