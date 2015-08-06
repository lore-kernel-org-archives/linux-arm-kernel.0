From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Aug 2015 10:56:21 +0100
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
 <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
Message-ID: <20150806095621.GB17691@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 05:46:03PM -0700, Timur Tabi wrote:
> Catalin,
> 
> I know this patch is three years old, but I have a question about it:
> 
> On Fri, Sep 7, 2012 at 9:26 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > +static void ipi_cpu_stop(unsigned int cpu)
> > +{
> > +       if (system_state == SYSTEM_BOOTING ||
> > +           system_state == SYSTEM_RUNNING) {
> > +               raw_spin_lock(&stop_lock);
> > +               pr_crit("CPU%u: stopping\n", cpu);
> > +               dump_stack();
> > +               raw_spin_unlock(&stop_lock);
> > +       }
> > +
> > +       set_cpu_online(cpu, false);
> > +
> > +       local_fiq_disable();
> > +       local_irq_disable();
> > +
> > +       while (1)
> > +               cpu_relax();
> > +}
> 
> Why do you display a message and dump the stack when a CPU is stopped?
>  I ask because emergency_restart() calls this function, and so
> whenever I want to do an "emergency" reboot, it dumps the stack for
> each core.  On an ARM64 system with lots of cores, this produces a ton
> of output.  That makes emergency_restart() almost useless.

This code was inherited from arch/arm which initially was always dumping
the stack but it later gained the system_state check. Unless it's useful
to anyone for debugging purposes, I'm ok with removing it.

-- 
Catalin
