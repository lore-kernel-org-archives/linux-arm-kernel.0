From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 28 Mar 2017 15:34:38 +0200
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <e0e0a3d7-2252-5fd6-3247-c128208fd9b9@arm.com>
References: <20170320174829.28182-1-marc.zyngier@arm.com>
 <20170320174829.28182-7-marc.zyngier@arm.com>
 <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com>
 <20170323173030.GA24630@mai>
 <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com>
 <20170327075628.GE24630@mai>
 <e0e0a3d7-2252-5fd6-3247-c128208fd9b9@arm.com>
Message-ID: <20170328133438.GB2123@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 02:07:30PM +0100, Marc Zyngier wrote:
> On 27/03/17 08:56, Daniel Lezcano wrote:
> > On Fri, Mar 24, 2017 at 01:51:47PM +0000, Marc Zyngier wrote:
> > 
> > [ ... ]
> > 
> >>> Hi Marc,
> >>>
> >>> I have been through the driver after applying the patchset. Again thanks for
> >>> taking care of this. It is not a simple issue to solve, so here is my minor
> >>> contribution.
> >>>
> >>> The resulting code sounds like over-engineered because the errata check and its
> >>> workaround are done at the same place/moment, that forces to deal with an array
> >>> with element from different origin.
> >>>
> >>> I understand you wanted to create a single array to handle the errata
> >>> information from the DT, ACPI and CAPS. But IMHO, it does not fit well.
> >>>
> >>> I would suggest to create 3 arrays: ACPI, DT and CAPS.
> >>>
> >>> Those arrays contains the errata id *and* an unique private id.
> >>>
> >>> At boot time, you go through the corresponding array and fill a list of
> >>> detected errata with the private id.
> >>>
> >>> On the other side, an array with the private id and its workaround makes the
> >>> assocation. The private id is the contract between the errata and the workaround.
> >>>
> >>> So the errata handling will occur in two steps:
> >>>  1. Boot => errata detection
> >>>  2. CPU up => workaround put in place
> >>>
> >>> With this approach, you can write everything on a per cpu basis, getting rid of
> >>> 'global' / 'local'.
> >>>
> >>> What is this different from your approach ?
> >>>
> >>>  - no match_id
> >>>  - clear separation of errata and workaround
> >>>  - Simpler code
> >>>  - clear the scene for a more generic errata framework
> >>>
> >>> That said, now it would make sense to create a generic errata framework to be
> >>> filled by the different arch at boot time and retrieve from the different
> >>> subsystem in an agnostic way. Well, may be that is a long term suggestion.
> >>>
> >>> What do you think ?
> >>
> >> I don't think this buys us anything at all. Separating detection and
> >> enablement is not always feasible. In your example above, you assume
> >> that all errata are detectable at boot time. Consider that with CPU
> >> hotplug, we can bring up a new core at any time, possibly with an
> >> erratum that you haven't detected yet.
> > 
> > I guess it has to pass through an init function before being powered on.
> 
> Sure, I never said that the CPU would appear ex-nihilo. But that
> somewhat defeats your boot detection vs workaround application construct.
> 
> >> And even then, what do we get: we trade a simple match ID for a list we
> >> build at runtime, another private ID, and additional code to perform
> >> that match. The gain is not obvious to me...
> >>
> >> What would such a generic errata framework look like? A table containing
> >> match functions returning a boolean, used to decide whether you need to
> >> call yet another function with a bunch of arbitrary parameters.
> >>
> >> In my experience, such a framework will be either an empty shell
> >> (because you need to keep it as generic as possible), or will be riddled
> >> with data structures ending up being the union of all the possible cases
> >> you've encountered in the kernel. Not a pretty sight.
> > 
> > I disagree but I can understand you don't see the point to write a generic
> > framework while the patchset does the job.
> 
> It is not about this series. Far from it. I'm convinced that a generic
> errata framework cannot be written without being either completely
> devoid of any useful semantic, or be the union of all possible
> semantics. There is simply too much diversity in the problem space. But
> feel free to prove me wrong! ;-)

I still think we can write something generic. However, as I have just recently
went through the errata handling, I'm certainly missing something. So perhaps,
if I have spare time, I can have a closer look and write some skeleton.

> > Let's refocus on the patchset itself.
> > 
> > Can you do the change to have a percpu basis errata in order to remove
> > local/global ?
> > 
> > Something as below:
> > 
> >  
> >  static
> > -bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
> > -					 const void *arg)
> > +bool arch_timer_check_cap_erratum(const struct arch_timer_erratum_workaround *wa,
> > +				  const void *arg)
> >  {
> > -	return cpus_have_cap((uintptr_t)wa->id);
> > +	return cpus_have_cap((uintptr_t)wa->id) | this_cpu_has_cap((uintptr_t)wa->id);
> 
> Not quite. Here, you're making all capability-based errata to be be
> global (if a single CPU in the system has a capability, then by
> transitivity cpus_have_cap returns true). If that's a big-little system,
> you end-up applying the workaround to all CPUs, including those unaffected.
> 
> I'd rather drop cpus_have_cap altogether and rely on individual CPU
> matching (since we don't have a need for a global capability erratum
> handling yet).

Ok, thanks.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
