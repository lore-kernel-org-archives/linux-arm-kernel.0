From: robherring2@gmail.com (Rob Herring)
Date: Sat, 25 Jun 2011 16:20:59 -0500
Subject: [RFC PATCH 2/4] ARM: dt: register local timers as early platform
	devices
In-Reply-To: <20110625204742.GB15026@ponder.secretlab.ca>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-3-git-send-email-marc.zyngier@arm.com>
	<20110625204742.GB15026@ponder.secretlab.ca>
Message-ID: <4E06513B.4030706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On 06/25/2011 03:47 PM, Grant Likely wrote:
> On Fri, Jun 24, 2011 at 03:10:57PM +0100, Marc Zyngier wrote:
>> Use of_early_platform_populate() to collect nodes with the
>> "localtimer" compatible property and register them with
>> the early platform "bus".
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kernel/time.c |    4 ++++
>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>> index 32d0df8..08a28ef 100644
>> --- a/arch/arm/kernel/time.c
>> +++ b/arch/arm/kernel/time.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/timer.h>
>>  #include <linux/irq.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/of_platform.h>
>>  
>>  #include <linux/mc146818rtc.h>
>>  
>> @@ -156,6 +157,9 @@ static void __init __arm_late_time_init(void)
>>  		arm_late_time_init();
>>  
>>  #ifdef CONFIG_LOCAL_TIMER_DEVICES
>> +#ifdef CONFIG_OF_FLATTREE
>> +	of_early_platform_populate("localtimer");
>> +#endif
> 
> Rather than #ifdeffing around the function call, it is often cleaner
> to have an #else in the header file that defines an empty static
> inline.
> 
>>  	early_platform_driver_register_all("localtimer");
>>  	early_platform_driver_probe("localtimer", 1, 0);
> 
> I suggested in my other reply that early_platform_driver should not be
> used.  It looks like it is already being used, so I'll back off a bit
> from that position.  However, the structure of the code really
> shouldn't be any different between clock devices being statically
> declared vs. clock data being obtained from the DT.
> 

It's not really already being used. It is added in Marc's previous patch
series to move timers to drivers/clocksource.

Deferring driver probe doesn't really help for timers as they have to be
up early. If early platform drivers shouldn't be used, then why was it
accepted into the kernel in the first place? It doesn't make sense that
it is okay for one arch (sh), but not another (arm), or that it is okay
for non-DT, but not for DT.

Rob
