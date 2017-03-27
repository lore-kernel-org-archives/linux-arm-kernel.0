From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Mar 2017 09:56:28 +0200
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com>
 <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com>
 <20170323173030.GA24630@mai>
 <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com>
Message-ID: <20170327075628.GE24630@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 01:51:47PM +0000, Marc Zyngier wrote:

[?... ]

> > Hi Marc,
> > 
> > I have been through the driver after applying the patchset. Again thanks for
> > taking care of this. It is not a simple issue to solve, so here is my minor
> > contribution.
> > 
> > The resulting code sounds like over-engineered because the errata check and its
> > workaround are done at the same place/moment, that forces to deal with an array
> > with element from different origin.
> > 
> > I understand you wanted to create a single array to handle the errata
> > information from the DT, ACPI and CAPS. But IMHO, it does not fit well.
> > 
> > I would suggest to create 3 arrays: ACPI, DT and CAPS.
> > 
> > Those arrays contains the errata id *and* an unique private id.
> > 
> > At boot time, you go through the corresponding array and fill a list of
> > detected errata with the private id.
> > 
> > On the other side, an array with the private id and its workaround makes the
> > assocation. The private id is the contract between the errata and the workaround.
> > 
> > So the errata handling will occur in two steps:
> >  1. Boot => errata detection
> >  2. CPU up => workaround put in place
> > 
> > With this approach, you can write everything on a per cpu basis, getting rid of
> > 'global' / 'local'.
> > 
> > What is this different from your approach ?
> > 
> >  - no match_id
> >  - clear separation of errata and workaround
> >  - Simpler code
> >  - clear the scene for a more generic errata framework
> > 
> > That said, now it would make sense to create a generic errata framework to be
> > filled by the different arch at boot time and retrieve from the different
> > subsystem in an agnostic way. Well, may be that is a long term suggestion.
> > 
> > What do you think ?
> 
> I don't think this buys us anything at all. Separating detection and
> enablement is not always feasible. In your example above, you assume
> that all errata are detectable at boot time. Consider that with CPU
> hotplug, we can bring up a new core at any time, possibly with an
> erratum that you haven't detected yet.

I guess it has to pass through an init function before being powered on.
 
> And even then, what do we get: we trade a simple match ID for a list we
> build at runtime, another private ID, and additional code to perform
> that match. The gain is not obvious to me...
>
> What would such a generic errata framework look like? A table containing
> match functions returning a boolean, used to decide whether you need to
> call yet another function with a bunch of arbitrary parameters.
> 
> In my experience, such a framework will be either an empty shell
> (because you need to keep it as generic as possible), or will be riddled
> with data structures ending up being the union of all the possible cases
> you've encountered in the kernel. Not a pretty sight.

I disagree but I can understand you don't see the point to write a generic
framework while the patchset does the job.

Let's refocus on the patchset itself.

Can you do the change to have a percpu basis errata in order to remove
local/global ?

Something as below:

 
 static
-bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
-					 const void *arg)
+bool arch_timer_check_cap_erratum(const struct arch_timer_erratum_workaround *wa,
+				  const void *arg)
 {
-	return cpus_have_cap((uintptr_t)wa->id);
+	return cpus_have_cap((uintptr_t)wa->id) | this_cpu_has_cap((uintptr_t)wa->id);
 }
 
 static
-bool arch_timer_check_local_cap_erratum(const struct arch_timer_erratum_workaround *wa,
-					const void *arg)
-{
-	return this_cpu_has_cap((uintptr_t)wa->id);
-}
-
-
-static
 bool arch_timer_check_acpi_oem_erratum(const struct arch_timer_erratum_workaround *wa,
 				       const void *arg)
 {
@@ -458,17 +450,9 @@ arch_timer_iterate_errata(enum arch_timer_erratum_match_type type,
 }
 
 static
-void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa,
-				  bool local)
+void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa)
 {
-	int i;
-
-	if (local) {
-		__this_cpu_write(timer_unstable_counter_workaround, wa);
-	} else {
-		for_each_possible_cpu(i)
-			per_cpu(timer_unstable_counter_workaround, i) = wa;
-	}
+	__this_cpu_write(timer_unstable_counter_workaround, wa);
 
 	static_branch_enable(&arch_timer_read_ool_enabled);
 
@@ -489,18 +473,16 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 {
 	const struct arch_timer_erratum_workaround *wa;
 	ate_match_fn_t match_fn = NULL;
-	bool local = false;
 
 	switch (type) {
 	case ate_match_dt:
 		match_fn = arch_timer_check_dt_erratum;
 		break;
 	case ate_match_global_cap_id:
-		match_fn = arch_timer_check_global_cap_erratum;
+		match_fn = arch_timer_check_cap_erratum;
 		break;
 	case ate_match_local_cap_id:
-		match_fn = arch_timer_check_local_cap_erratum;
-		local = true;
+		match_fn = arch_timer_check_cap_erratum;
 		break;
 	case ate_match_acpi_oem_info:
 		match_fn = arch_timer_check_acpi_oem_erratum;
@@ -522,9 +504,9 @@ static void arch_timer_check_ool_workaround(enum arch_timer_erratum_match_type t
 			return;
 	}
 
-	arch_timer_enable_workaround(wa, local);
-	pr_info("Enabling %s workaround for %s\n",
-		local ? "local" : "global", wa->desc);
+	arch_timer_enable_workaround(wa);
+	pr_info("Enabling %s workaround for cpu %d\n",
+		wa->desc, smp_processor_id());
 }
 
 #define erratum_handler(fn, r, ...)					\


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
