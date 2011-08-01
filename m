From: linux@bohmer.net (Remy Bohmer)
Date: Mon, 1 Aug 2011 10:42:35 +0200
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
In-Reply-To: <20110731150707.GA2975@n2100.arm.linux.org.uk>
References: <1312124593-6088-1-git-send-email-linux@bohmer.net>
	<20110731150707.GA2975@n2100.arm.linux.org.uk>
Message-ID: <CANqCtQJwUsLXfA408GzAr0rQtc2DRjtKqP8-m2UBUGEy-YP5dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2011/7/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> +++ b/arch/arm/Kconfig
>> @@ -296,6 +296,7 @@ config ARCH_AT91
>> ? ? ? select HAVE_CLK
>> ? ? ? select CLKDEV_LOOKUP
>> ? ? ? select ARM_PATCH_PHYS_VIRT if MMU
>> + ? ? select HAVE_SCHED_CLOCK if ATMEL_TCB_CLKSRC
>> ? ? ? help
>> ? ? ? ? This enables support for systems based on the Atmel AT91RM9200,
>> ? ? ? ? AT91SAM9 and AT91CAP9 processors.
>> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
>> index 9a46370..f9028e4 100644
>> --- a/arch/arm/kernel/sched_clock.c
>> +++ b/arch/arm/kernel/sched_clock.c
>> @@ -20,6 +20,13 @@ static void (*sched_clock_update_fn)(void);
>>
>> ?static void sched_clock_poll(unsigned long wrap_ticks)
>> ?{
>> + ? ? /*
>> + ? ? ?* The sched_clock_update_fn may be initialised AFTER first call to
>> + ? ? ?* time_init()
>> + ? ? ?*/
>> + ? ? if (unlikely(!sched_clock_update_fn))
>> + ? ? ? ? ? ? return;
>
> NAK. ?I've said this before - sched_clock _must_ be up and running by the
> time this function is called - because shortly after this call is when
> the scheduler initializes, and the scheduler wants sched_clock() working
> at that point.

OK, I know that too, but the jiffies based fallback does it even
worse, since it does not run at all...  (It only updates in steps of a
couple of 100msecs and stops after a while, and even does not display
a real time...) This sched_clock implementation at least works before
the drivers are being initialised...

Anyway, do you have a better suggestion how to fix this? The tcb
clocksource is loaded during a arch_initcall(), perhaps we need
something before that point.
I do not see an easy way to integrate it in MACHINE_START(.timer).
Would 'late_time_init' be a better solution?

Kind regards,

Remy
