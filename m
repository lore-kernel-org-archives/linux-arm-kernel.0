From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 02 Jul 2013 18:24:31 +0100
Subject: [PATCH 4/4] drivers: clocksource: add CPU PM notifier for ARM
 architected timer
In-Reply-To: <1372781381.3689.27.camel@linaro1.home>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1371575223-21702-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1372781381.3689.27.camel@linaro1.home>
Message-ID: <51D30CCF.5020808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/13 17:09, Jon Medhurst (Tixy) wrote:
> On Tue, 2013-06-18 at 18:07 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Few control settings done in architected timer as part of initialisation
>> are lost when CPU enters deeper power states. They need to be re-initialised
>> when the CPU is (warm)reset again.
>>
>> This patch moves all such initialisation into separate function that can
>> be used both in cold and warm CPU reset paths. It also adds CPU PM
>> notifiers to do the timer initialisation on warm resets.
>>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  drivers/clocksource/arm_arch_timer.c | 51 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 11aaf06..1c691b1 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/device.h>
>>  #include <linux/smp.h>
>>  #include <linux/cpu.h>
>> +#include <linux/cpu_pm.h>
>>  #include <linux/clockchips.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/of_irq.h>
>> @@ -123,10 +124,20 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
>>  	return 0;
>>  }
>>  
>> -static int __cpuinit arch_timer_setup(struct clock_event_device *clk)
>> +static void arch_timer_initialise(void)
>>  {
>>  	int evt_stream_div, pos;
>>  
>> +	/* Find the closest power of two to the divisor */
>> +	evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ;
>> +	pos = fls(evt_stream_div);
>> +	if (pos > 1 && !(evt_stream_div & (1 << (pos - 2))))
>> +		pos--;
>> +	arch_counter_set_user_access(min(pos, 15));
> 
> Would it not be good to calculate the value once in arch_timer_setup
> rather than repeatedly in this function? The calculations aren't that
> expensive, but when I gave these patches a spin on TC2 I noticed that
> this function gets called >500 times a second, so it seems a bit
> wasteful.
> 
Makes sense, will save the divider and re-use it.

Regards,
Sudeep
