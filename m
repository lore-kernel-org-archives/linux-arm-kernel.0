From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Nov 2014 15:12:41 +0000
Subject: ARM: shmobile: sh73a0: CPU1 failed to come online (Re: [PATCH
 0/4] ARM: shmobile: r8a7740/armadillo: Migrate to generic l2c OF)
In-Reply-To: <CAMuHMdWyUJ81G2CLpYScm9qB0KMia0PReBQ8oXdu+Z2P6AWWNg@mail.gmail.com>
References: <CAMuHMdWyUJ81G2CLpYScm9qB0KMia0PReBQ8oXdu+Z2P6AWWNg@mail.gmail.com>
Message-ID: <20141117151241.GR4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 02:57:46PM +0100, Geert Uytterhoeven wrote:
> I tried to convert sh73a0, but it doesn't work, due to problems
> bringing up the second
> CPU core.
> 
> Details:
>   - l2x0_of_init() is called much earlier than l2x0_init().
>     When the L2 cache is enabled, initialization of the second CPU core of
>     sh73a0 (Dual-core Cortex-A9) fails.

Missing L2 cache flushes for (any) the secondary core data/trampoline?

>   - As jiffies are not yet incrementing at that point (they are on r8a7791?),
>     timeouts don't work, and the kernel hangs at the
>     wait_for_completion_timeout() call in arch/arm/kernel/smp.c:__cpu_up().

That sounds bad:

start_kernel() -> rest_init() -> kernel_thread(kernel_init)

kernel_init() -> kernel_init_freeable() -> smp_init() -> (for each CPU) cpu_up()

By the time we get to rest_init(), init_IRQ(), time_init(),
local_irq_enable(), late_time_init(), calibrate_delay(), etc have all
been called, so if jiffies is not incrementing in __cpu_up(), that's
a big problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
