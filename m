From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Mar 2017 16:36:33 +0200
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <ec5e673c-6d02-fc88-9913-b0f9261da05e@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com>
 <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com>
 <20170323173030.GA24630@mai>
 <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com>
 <20170327075628.GE24630@mai>
 <e0e0a3d7-2252-5fd6-3247-c128208fd9b9@arm.com>
 <20170328133438.GB2123@mai>
 <ec5e673c-6d02-fc88-9913-b0f9261da05e@arm.com>
Message-ID: <20170328143633.GC2123@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 03:07:52PM +0100, Marc Zyngier wrote:

[ ... ]

> >>> -bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
> >>> -					 const void *arg)
> >>> +bool arch_timer_check_cap_erratum(const struct arch_timer_erratum_workaround *wa,
> >>> +				  const void *arg)
> >>>  {
> >>> -	return cpus_have_cap((uintptr_t)wa->id);
> >>> +	return cpus_have_cap((uintptr_t)wa->id) | this_cpu_has_cap((uintptr_t)wa->id);
> >>
> >> Not quite. Here, you're making all capability-based errata to be be
> >> global (if a single CPU in the system has a capability, then by
> >> transitivity cpus_have_cap returns true). If that's a big-little system,
> >> you end-up applying the workaround to all CPUs, including those unaffected.
> >>
> >> I'd rather drop cpus_have_cap altogether and rely on individual CPU
> >> matching (since we don't have a need for a global capability erratum
> >> handling yet).
> > 
> > Ok, thanks.
> 
> Quick update. I've just implemented this, and found out that getting rid
> of local/global has an unfortunate effect:
> 
> Since we only probe the global errata (using ACPI for example) on the
> boot CPU path, we lose propagation of the erratum across the secondary
> CPUs. One way of solving this is to convert the secondary boot path to
> be aware of DT vs ACPI vs detection method of the month. Which isn't
> easy, since by the time we boot secondary CPUs, we don't have the
> pointers to the various ACPI tables anymore. Also, assuming we were
> careful and saved the pointers, the tables may have been unmapped. Fun.

My proposal was supposed to prevent that. The detecion is done in the
subsystems, ACPI detects ACPI errata, DT detects DT errata and CPU detects CPU
errata. The drivers get the errata and enable the workaround. The id
association <-> errata self contains errata types (void *, char *, int). So
everything can be done in a CPU basis without local / global dance.

> Given that, I'm reintroducing the global/local flag for good. It's not
> pretty, but it doesn't require reinventing new ways of dealing with CPUs
> booting late.



-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
