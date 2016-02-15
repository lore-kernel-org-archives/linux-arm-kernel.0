From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Feb 2016 19:23:17 +0000
Subject: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
In-Reply-To: <56C22105.6050900@arm.com>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <56C21DD0.40508@arm.com>
 <CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
 <56C22105.6050900@arm.com>
Message-ID: <20160215192316.GO10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 07:03:33PM +0000, Marc Zyngier wrote:
> On 15/02/16 18:54, Rafael J. Wysocki wrote:
> > That would explain it, thanks.
> > 
> > So it looks like we should always use irq_work_queue() on UP even if
> > CONFIG_SMP is set, shouldn't we?
> 
> Something like that, yes. CONFIG_SMP is not an indication of an SMP
> system anymore (we've even dropped the config option on arm64).
> 
> Hopefully num_possible_cpus() is reliable enough to let you do the right
> thing...

CONFIG_SMP just says whether to include support for SMP.  It doesn't
mandate running on a SMP system. :)

I've been looking around the usages of irq_work_queue_on in kernel/
in -rc4, and some places seem to check for "this CPU":

        /*
         * It is possible that a restart caused this CPU to be
         * chosen again. Don't bother with an IPI, just see if we
         * have more to push.
         */
        if (unlikely(cpu == rq->cpu))
                goto again;

        /* Try the next RT overloaded CPU */
        irq_work_queue_on(&rt_rq->push_work, cpu);

I'm not sure about tell_cpu_to_push().

It's also called via tick_nohz_full_kick_cpu(), and the core scheduler
avoids calling this for the current CPU:

        if (tick_nohz_full_cpu(cpu)) {
                if (cpu != smp_processor_id() ||
                    tick_nohz_tick_stopped())
                        tick_nohz_full_kick_cpu(cpu);

I'm not sure about add_nr_running() in kernel/sched/sched.h - I think
that _could_ be a problem even without Rafael's cpufreq change.

So... the question is what do we do with irq_work_queue_on() in general
when called on non-SMP systems.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
