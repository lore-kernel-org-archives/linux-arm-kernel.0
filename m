From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 13 Jan 2012 15:41:04 +0100
Subject: omap clocksource timer selection: dmtimer OR 32K-Sync timer
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A8317A4E2E@DBDE01.ent.ti.com>
 <CAMQu2gxYQOHX8n2RLfkLBw5hQMdvH389DfrguLtzpLcpmqBQMA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A8317A4FD9@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gxkBV87YQE7SPmLXh0RZBR+SNHzHE5H-PVjuef+1UZp8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 2:42 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> On Fri, Jan 13, 2012 at 18:19:24, Shilimkar, Santosh wrote:
>> On Fri, Jan 13, 2012 at 1:21 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>> > Hi,
>> >
>> > In case of AM33xx family of devices, we do not have 32K Sync timer
>> > (32K Counter) available; and the current implementation is based on
>> > compile-time option, where clock-source is chosen by something like,
>> >
>> > File - arch/arm/mach-omap2/timer.c
>> >
>> > #ifdef CONFIG_OMAP_32K_TIMER
>> > static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
>> > {
>> > ...
>> > }
>> > #else
>> > static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
>> > {
>> > ...
>> > }
>> > #endif
>> >
>> >
>> > But in order to support multi-omap build, we must
>> > make run-time decision to use the timer for kernel clock-source, either of -
>> >
>> > ?- DMTIMER
>> > ?- 32K Sync Timer
>> >
>> > The DMTIMER is already migrated to the HWMOD framework, but 32K Timer code
>> > has not yet migrated to it. So the question here is,
>> >
>> > 1) Does it make sense to migrate counter_32k.c to search entry in hwmod
>> > ? table and if 32k_sync timer is available in hwmod table then use 32K
>> > ? timer for Kernel clock-source
>> > ? OR
>> > ? Fall back to DMTIMER.
>> >
>> > ? OMAP4 hwmod table already has entry,
>> >
>> > ? static struct omap_hwmod omap44xx_counter_32k_hwmod = {
>> > ? ? ? ? .name ? ? ? ? ? = "counter_32k",
>> > ? ...
>> > ? };
>> >
>> > ? We need to have similar entries in all devices where 32K timer is present.
>> >
>> > 2) OR simply add another cpu_is_am33xx() and then fall back to dmtimer?
>> > ? Just to prove this, everything works here, I modified the code for this
>> > ? and tested it on both AM335x EVM and AM37xEVM and it works fine for me.
>> >
>> >
>> > Any comments?? OR Better approach? OR anything which I am missing here?
>> >
>> You can register both the clock sources together with different
>> rating. Based on rating
>> timer code will automatically pick the better clock-source of two.
>> Ratings is based on the resolution of the timer.
>>
> Santosh,
>
> ?- Still current compile time implementation must be changed/cleaned, right?
Yes. But that should be trivial.

> ?- The 32k timer doesn't exist at all on AM33xx device, so you can not
> ? (and should not) Register this timer.
>
Well there are many init call happens on various IP's which are not supported
across SOCs.

Look at L2X0 cache init for example. In such cases you just return by not
doing anything on that hardware IP.

Regards
Santosh
