From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 13 Jan 2015 10:41:27 +0100
Subject: ARM: shmobile: sh73a0: CPU1 failed to come online (Re: [PATCH
 0/4] ARM: shmobile: r8a7740/armadillo: Migrate to generic l2c OF)
In-Reply-To: <20141117151241.GR4042@n2100.arm.linux.org.uk>
References: <CAMuHMdWyUJ81G2CLpYScm9qB0KMia0PReBQ8oXdu+Z2P6AWWNg@mail.gmail.com>
 <20141117151241.GR4042@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdVjE21YiC-wTpjePQCnA2XZYjJZeEe3iOy8J-vpuPmFjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 4:12 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 17, 2014 at 02:57:46PM +0100, Geert Uytterhoeven wrote:
>> I tried to convert sh73a0, but it doesn't work, due to problems
>> bringing up the second
>> CPU core.
>>
>> Details:
>>   - l2x0_of_init() is called much earlier than l2x0_init().
>>     When the L2 cache is enabled, initialization of the second CPU core of
>>     sh73a0 (Dual-core Cortex-A9) fails.
>
> Missing L2 cache flushes for (any) the secondary core data/trampoline?

Thanks, I added a few cache flushes, so far it didn't help...

>>   - As jiffies are not yet incrementing at that point (they are on r8a7791?),
>>     timeouts don't work, and the kernel hangs at the
>>     wait_for_completion_timeout() call in arch/arm/kernel/smp.c:__cpu_up().
>
> That sounds bad:
>
> start_kernel() -> rest_init() -> kernel_thread(kernel_init)
>
> kernel_init() -> kernel_init_freeable() -> smp_init() -> (for each CPU) cpu_up()
>
> By the time we get to rest_init(), init_IRQ(), time_init(),
> local_irq_enable(), late_time_init(), calibrate_delay(), etc have all
> been called, so if jiffies is not incrementing in __cpu_up(), that's
> a big problem.

That was due to the missing arm,cortex-a9-twd-timer timer, which also
broke CONFIG_CPU_IDLE=y.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
