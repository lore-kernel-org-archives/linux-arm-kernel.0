From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Jun 2017 12:44:16 +0100
Subject: [PATCH] psci: add debugfs for runtime instrumentation
In-Reply-To: <CAKfTPtBj3RBd+d_LERYdUxoQ706L6wrs5+L+MOTL7aoZmAkZ8w@mail.gmail.com>
References: <1497601420-8783-1-git-send-email-vincent.guittot@linaro.org>
 <20170616114737.GM20092@leverpostej>
 <CAKfTPtBj3RBd+d_LERYdUxoQ706L6wrs5+L+MOTL7aoZmAkZ8w@mail.gmail.com>
Message-ID: <20170619114415.GI10246@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 04:26:20PM +0200, Vincent Guittot wrote:
> On 16 June 2017 at 13:47, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Jun 16, 2017 at 10:23:40AM +0200, Vincent Guittot wrote:
> >> Add debugfs to display runtime instrumentation results that can be collected
> >> by PSCI firmware.
> >
> > Could you elaborate on this please? e.g.
> 
> yes sorry. I should have given more details about it
> 
> >
> > * What is instrumented?
> 
> The ARM Trusted Firwware that implements PSCI, also has a Performance
> Measurement Framework (PMF) that can be used to save some timetamps
> when running psci firmware. On top of PMF, serveral services have been
> implemented like the PSCI residency stats and the runtime
> instrumentation service. The latter saves timestamp when a PSCI
> service is entered and then leaved or when cache maintenance is
> executed durign psci call. With these timestamps, we can measure the
> duration of some part of code of the PSCI firmware.

Ok. So PMF is an ATF concept, and not a PSCI concept (as it's not
defined by the PSCI spec).

[...]

> > * On which platforms is this available, and when?
> 
> The code that save the timestamp is generic and as result available
> for all platforms that implement PSCI. Nevertheless, each platfrom has
> to enable the SMC service. At now, juno and hikey has enable the
> service and hikey960 should some soon as well

Ok. So this is available on a subset of platforms using ATF.

[...]

> >> +config ARM_PSCI_INSTRUMENTATION
> >> +     bool "ARM PSCI Run Time Instrumentation"
> >> +     depends on ARM_PSCI_FW && CPU_IDLE && DEBUG_FS
> >> +     help
> >> +       Enable debugfs interface for PSCI FW in which you can retrieve
> >> +       runtime instrumentation values of the PSCI firmware like time to
> >> +       enter or leave a cpu suspend state or time to flush cache.
> >
> > Looking at the latest published spec (ARM DEN 0022D), PSCI doesn't
> > provide such information, as there's only PSCI_STAT_{COUNT,RESIDENCY}.
> 
> This use the same Performance Measurement Framework as
> PSCI_STAT_{COUNT,RESIDENCY}

Sure, but that's an ATF implementation detail, and not something defined
by the PSCI spec.

FWIW, I'm more than happy to add support for PSCI_STAT_{COUNT,RESIDENCY}
since these are in the spec.

> > What mechanisms are you using here?
> 
> More details can be founded here
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/firmware-design.md#13--performance-measurement-framework

Thanks. This all sounds IMP DEF, with platforms able to provide their
own monitors.

> > As far as I can tell, these are not part of the PSCI standard, and I'm
> > not aware of any documentation.
> >
> > I'm very much not keen on using IMPLEMENTATION DEFINED functionality in
> > the PSCI driver, as IMP DEF stuff always creates long-term maintenance
> > problems. You'll need to convince me that this is worth supporting.
> 
> I will try.
> 
> I have put it in psci.c as it is really about measurement latenccy of
> psci firmware but it can probably be put somewhere else if it is more
> relevant. The only link between current psci driver and this feature
> is the call to psci_update_all_rt_instr() in psci_cpu_suspend_enter()
> to make sure that we have coherent timestamp
> Thinking a bit more about this, we can probably use the cpu_pm_exit

To be honest, the more I think about this, the less keen I am on having
it in the kernel.

It's all IMP DEF, and will need additional info in DT or ACPI to be safe
to invoke (even ignoring usable), and has subtle interactions with the
PSCI driver. It's of limited utility to a very small number of
developers.

[...]

> >> +     /* Test if runtime instrumentation is enable */
> >> +     if (!psci_rt_instr_enable()) {
> >
> > This is an unconditional initcall, so this simply is not safe.
> 
> you're right, it should be called only if/when psci driver has been probed

Even where PSCI is present, I don't believe it's safe to invoke this.
It's a SiP call, which a vendor may have used for any other purpose.

So at minimum, we'd need a description in the DT in order to know that
we can invoke this. Since it's all IMP DEF, we'd need all the monitors
described too, and at that point it's complex enough, and so tailored to
ATF's internals that I really don't want this in the kernel.

So sorry, but given all of the above, I have to NAK support for this ATF
feature.

If we can get some more useful performance monitors into the PSCI spec,
I am more than happy to support those.

Thanks,
Mark.
