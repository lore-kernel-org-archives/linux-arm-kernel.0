From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 29 Aug 2013 16:42:23 +0100
Subject: [PATCH v6 4/5] drivers: clocksource: add support for ARM
 architected timer event stream
In-Reply-To: <20130829153914.GA10707@darko.cambridge.arm.com>
References: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377788142-21388-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130829153914.GA10707@darko.cambridge.arm.com>
Message-ID: <521F6BDF.2050909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/13 16:39, Catalin Marinas wrote:
> On Thu, Aug 29, 2013 at 03:55:41PM +0100, Sudeep KarkadaNagesha wrote:
>> From: Will Deacon <will.deacon@arm.com>
>>
>> The ARM architected timer can generate events (used for waking up
>> CPUs executing the wfe instruction) at a frequency represented as a
>> power-of-2 divisor of the clock rate.
>>
>> An event stream might be used:
>> - To impose a time-out on a wfe polling loop.
>> - To safeguard against any programming error in case an expected event
>>   is not generated.
>> - To implement wfe-based timeouts for userspace locking implementations.
>>
>> This patch computes the event stream frequency aiming for a period
>> of 100us between events. It uses ARM/ARM64 specific backends to configure
>> and enable the event stream.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> [sudeep: moving ARM/ARM64 changes into separate patches
>>          and adding Kconfig option]
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> ---
>>  drivers/clocksource/Kconfig          | 14 ++++++++++++++
>>  drivers/clocksource/arm_arch_timer.c | 15 +++++++++++++++
>>  include/clocksource/arm_arch_timer.h |  2 ++
>>  3 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index b7b9b04..49f1f6e 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -74,6 +74,20 @@ config ARM_ARCH_TIMER
>>  	bool
>>  	select CLKSRC_OF if OF
>>  
>> +config ARM_ARCH_TIMER_EVTSTREAM
>> +	bool "Support for ARM architected timer event stream generation"
>> +	default y if ARM_ARCH_TIMER
>> +	help
>> +	  This option enables support for event stream generation based on
>> +	  the ARM architected timer. It is used for waking up CPUs executing
>> +	  the wfe instruction at a frequency represented as a power-of-2
>> +	  divisor of the clock rate. An event stream might be mainly useful
>> +	  for wfe-based timeouts for userspace locking implementations.
> 
> I would be a bit more assertive here, something like "the main use of
> the event stream is wfe-based timeouts of userspace locking
> implementations."
> 
>> +	  It might also be useful for imposing timeout on a wfe or even
>> +	  safeguarding against any programming errors in case an expected
> 
> Maybe "imposting timeout on wfe to safeguard against ...". We already
> mentioned wfe-based timeout above.
> 
Ok will fix this Kconfig description.

> Otherwise, for the whole series:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
Thanks.

Regards,
Sudeep
