From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 10:24:34 +0100
Subject: [PATCH 06/12] arm64: psci: account for Trusted OS instances
In-Reply-To: <CAJ5Y-ea=adURPf+kQC4QfROdk7ZiWwuM78qnHfBi7CV1L6BbRw@mail.gmail.com>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-7-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-ea=adURPf+kQC4QfROdk7ZiWwuM78qnHfBi7CV1L6BbRw@mail.gmail.com>
Message-ID: <20150518092434.GA3551@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 04:06:39PM +0100, Ashwin Chaugule wrote:
> On 8 May 2015 at 07:36, Mark Rutland <mark.rutland@arm.com> wrote:
> > Software resident in the secure world (a "Trusted OS") may cause CPU_OFF
> > calls for the CPU it is resident on to be denied. Such a denial would be
> > fatal for the kernel, and so we must detect when this can happen before
> > the point of no return.
> >
> > This patch implements Trusted OS detection for PSCI 0.2+ systems, using
> > MIGRATE_INFO_TYPE and MIGRATE_INFO_UP_CPU. When a trusted OS is detected
> > as resident on a particular CPU, attempts to hot unplug that CPU will be
> > denied early, before they can prove fatal.
> >
> > Trusted OS migration is not implemented by this patch. Implementation of
> > migratable UP trusted OSs seems unlikely, and the right policy for
> > migration is unclear (and will likely differ across implementations). As
> > such, it is likely that migration will require cooperation with Trusted
> > OS drivers.
> >
> > PSCI implementations prior to 0.1 do not provide the facility to detect
> > the presence of a Trusted OS, nor the CPU any such OS is resident on, so
> > without additional information it is not possible to handle Trusted OSs
> > with PSCI 0.1.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/psci.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index 7324db9..25e2610 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -43,6 +43,19 @@ struct psci_power_state {
> >         u8      affinity_level;
> >  };
> >
> > +/*
> > + * The CPU any Trusted OS is resident on. The trusted OS may reject CPU_OFF
> > + * calls to its resident CPU, so we must avoid issuing those. We never migrate
> > + * a Trusted OS even if it claims to be capable of migration -- doing so will
> > + * require cooperation with a Trusted OS driver.
> > + */
> > +static int resident_cpu = -1;
> > +
> > +static bool psci_tos_resident_on(int cpu)
> > +{
> > +       return cpu == resident_cpu;
> > +}

[...]

> > +/*
> > + * Detect the presence of a resident Trusted OS which may cause CPU_OFF to
> > + * return DENIED (which would be fatal).
> > + */
> > +static void __init psci_init_migrate(void)
> > +{
> > +       unsigned long cpuid;
> > +       int type, cpu = -1;
> > +
> > +       type = psci_ops.migrate_info_type();
> > +
> > +       if (type == PSCI_0_2_TOS_MP) {
> > +               pr_info("Trusted OS migration not required\n");
> > +               return;
> > +       }
> > +
> > +       if (type == PSCI_RET_NOT_SUPPORTED) {
> > +               pr_info("MIGRATE_INFO_TYPE not supported.\n");
> > +               return;
> > +       }
> > +
> > +       if (type != PSCI_0_2_TOS_UP_MIGRATE &&
> > +           type != PSCI_0_2_TOS_UP_NO_MIGRATE) {
> > +               pr_err("MIGRATE_INFO_TYPE returned unknown type (%d)\n", type);
> > +               return;
> > +       }
> > +
> > +       cpuid = psci_ops.migrate_info_up_cpu();
> 
> [..]
> 
> > +       cpu = get_logical_index(cpuid);
> > +       resident_cpu = cpu >= 0 ? cpu : -1;
> > +
> > +       pr_info("Trusted OS resident on physical CPU 0x%lx\n", cpuid);
> > +}

[...]

> > @@ -449,6 +505,11 @@ static int cpu_psci_cpu_disable(unsigned int cpu)
> >         /* Fail early if we don't have CPU_OFF support */
> >         if (!psci_ops.cpu_off)
> >                 return -EOPNOTSUPP;
> > +
> > +       /* Trusted OS will deny CPU_OFF */
> > +       if (psci_tos_resident_on(cpu))
> 
> IIUC, you're denying CPU_OFF even if MIGRATE_INFO_TYPE = 2. Is that correct?
> 

Yes, though only for the CPU the TOS is resident on.

It's not clear what the right policy is w.r.t. migration, and it's
probably going to depend on the TOS and workload. It's also not clear
whether there are migrateable UP TOS instances out there.

So for the moment this just ensures we won't accidentally bring the
system down in the presence of a UP TOS (migrateable or otherwise).

Thanks.
Mark.
