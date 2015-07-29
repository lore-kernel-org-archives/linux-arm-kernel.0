From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jul 2015 19:29:06 +0100
Subject: question about detect hard lockups without NMIs using secondary
 cpus
In-Reply-To: <CADUS3onib4DYYtPo7RfLAYiN4fpspzcFCx86-pJwuLc37hz3dQ@mail.gmail.com>
References: <CADUS3onib4DYYtPo7RfLAYiN4fpspzcFCx86-pJwuLc37hz3dQ@mail.gmail.com>
Message-ID: <20150729182905.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 12:03:46AM +0800, yoma sophian wrote:
> hi all:
> below link introduced how to emulate NMIs on systems where they are
> not available by using timer interrupts on other cpus.
> 
> http://article.gmane.org/gmane.linux.kernel/1419661
> 
> in kernel/watchdog.c
>     --> watchdog_overflow_callback
>           if (is_hardlockup()) {
>            ...........................
>                 if (hardlockup_panic)
>                         panic("Watchdog detected hard LOCKUP on cpu %d",
>                               this_cpu); /*************/
>                 else
>                         WARN(1, "Watchdog detected hard LOCKUP on cpu %d",
>                              this_cpu);
>              .......................
>         }
> 
> I have some questions:
> a.
> in SMP system, suppose 4 cores, and hardlockup_panic is 1.
> Core0 find Core1 hard lcokup in hardIRQ context
> the panic function, above with '*' marked, will fail on
> smp_send_stop(), and we will have no idea where core1 is trapped in,
> right?

watchdog_overflow_callback() is only ever entered for the failed core.
What you missed out on is:

	int this_cpu = smp_processor_id();

which gets the CPU number of the CPU executing this code.  So, Core 0
will never find Core 1 having locked up via this code path.

> b.
> things will get worse if we are running single core system if hard
> lockup happen.
> We even have no idea what happen.

Basically, without NMIs (or FIQs in ARM speak) lockups with IRQs off are
undetectable by the kernel other than "the system stopped responding".

In a SMP system, there are mechanisms by which other CPUs can detect a
locked-up CPU, and they can call trigger_all_cpu_backtrace() - and that
can only get a trace out of the locked up CPU if it uses FIQs.  A CPU
which has locked up in an IRQs-off region won't be able to receive an
IRQ or IPI by definition.

Work has been going on for the last 9 months to try and bring a working
trigger_all_cpu_backtrace() implementation, initially with IRQs and
later with FIQs.

In previous merge windows, we have moved forward with getting some FIQ
changes merged, and in the next merge window, I have patches queued up
(available in linux-next) which add IRQ-based trigger_all_cpu_backtrace()
support.

The next piece of the puzzle is sorting out the patches which bring FIQ
based trigger_all_cpu_backtrace() support - but even if we do, that won't
be available everywhere - for example, it won't be available if your kernel
runs in the non-secure world with a secure monitor, because FIQs generally
aren't usable in that world.

The only other alternative is a hardware JTAG debugger to inspect the
state of all CPUs in the system.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
