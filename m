From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jan 2018 13:43:04 +0000
Subject: [PATCH 04/16] arm64: capabilities: Prepare for fine grained
 capabilities
In-Reply-To: <9a9e5aeb-dfc7-9602-c00e-80ea32d66c15@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-5-suzuki.poulose@arm.com>
 <20180123173346.GB5862@e103592.cambridge.arm.com>
 <9a9e5aeb-dfc7-9602-c00e-80ea32d66c15@arm.com>
Message-ID: <20180125134301.GH5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 06:45:01PM +0000, Suzuki K Poulose wrote:
> Dave,
> 
> Thanks a lot for taking the time to review the patch and for
> opening up the discussion ! See my comments below.
> 
> On 23/01/18 17:33, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:27:57PM +0000, Suzuki K Poulose wrote:
> >>We use arm64_cpu_capabilities to represent CPU ELF HWCAPs exposed
> >>to the userspace and the CPU hwcaps used by the kernel, which
> >>include cpu features and CPU errata work arounds.
> >>
> >>At the moment we have the following restricions:
> >>
> >>  a) CPU feature hwcaps (arm64_features) and ELF HWCAPs (arm64_elf_hwcap)
> >>    - Detected mostly on system wide CPU feature register. But
> >>      there are some which really uses a local CPU's value to
> >>      decide the availability (e.g, availability of hardware
> >>      prefetch). So, we run the check only once, after all the
> >>      boot-time active CPUs are turned on.
> >>    - Any late CPU which doesn't posses all the established features
> >>      is killed.
> >>    - Any late CPU which possess a feature *not* already available
> >>      is allowed to boot.
> >>
> >>  b) CPU Errata work arounds (arm64_errata)
> >>    - Detected mostly based on a local CPU's feature register.
> >>      The checks are run on each boot time activated CPUs.
> >>    - Any late CPU which doesn't have any of the established errata
> >>      work around capabilities is ignored and is allowed to boot.
> >>    - Any late CPU which has an errata work around not already available
> >>      is killed.
> >>
> >>However there are some exceptions to the cases above.
> >>
> >>1) KPTI is a feature that we need to enable when at least one CPU needs it.
> >>    And any late CPU that has this "feature" should be killed.
> >>2) Hardware DBM feature is a non-conflicting capability which could be
> >>    enabled on CPUs which has it without any issues, even if the CPU is
> >>    brought up late.
> >>
> >>So this calls for a lot more fine grained behavior for each capability.
> >>And if we define all the attributes to control their behavior properly,
> >>we may be able to use a single table for the CPU hwcaps (not the
> >>ELF HWCAPs, which cover errata and features). This is a prepartory step
> >>to get there. We define type for a capability, which for now encodes the
> >>scope of the check. i.e, whether it should be checked system wide or on
> >>each local CPU. We define two types :
> >>
> >>   1) ARM64_CPUCAP_BOOT_SYSTEM_FEATURE - Implies (a) as described above.
> >>   1) ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM - Implies (b) as described above.
> >
> >I'm a bit confused by the naming here.
> 
> 
> I understand they are not well documented.  I will try to explain here and
> stick it in somewhere, in the next revision.
> 
> There are 3 aspects for any capability.
> 
> 1) SCOPE: How is the capability detected ?
> i.e, whether it should be detected based on at least one CPU's ID register
> (e.g, MIDR) (SCOPE_CPU_LOCAL) or System wide value (like ELF HWCAP)(SCOPE_SYSTEM)
> 
> This is fairly straight forward and hasn't changed much. The only
> change we need is to allow for CPU "Features" that could be detected on
> a local CPU. So, "LOCAL" tag has been added to the capabilities which
> are CPU local.

I think my confusion here is mostly semantic, so I won't worry too
much about it for now as I review the patches.

<aside>

It is confusing code to dive into though: there is too much overlap
and ambiguity between the intuitive meanings of "feature", "capability",
"erratum" etc.  I think this is just the way the code evolved:
"capability" is an intuitive word to describe that the system can do
something, but it's a strange word to use for the presence of an
erratum that must be worked around.

The immutable properties of CPUs, and the desicion taken by Linux about
what to do with them, are two quite different things.  I find it easy to
confuse myself about which is being referred to when we talk about
"capabilities", partly because the intuitive meaning of this word often
seems to point to the wrong answer.

Choosing different words might help, but precise definitions and
consistent would also help.

Here, "detecting" sounds like discovery of an immutable characteristic
of something, but really in the System-wide case you're talking about
making a policy decision (i.e., what tradeoff to make between working
with the boot and/or early CPUs, and working with late CPUs that we
haven't seen yet).  It would be equally valid to make a different
decision and reject some _early_ CPUs in the hopes that this will
result in a better performing system (perhaps because we can now
enable a desirable feature globally, or perhaps to minimise likelihood
of rejecting late CPUs).

</aside>

Anyway, this isn't a high priority.  It's just something that takes a
little time to get my head around...

> 2) WHEN: When is the capability "enabled" or in other words, when does the
> kernel start using the capability. At the moment there is only
> one place. After all the CPUs are brought up during the kernel init, from
> setup_cpu_features. (But this will change when we add support for enabling
> some capabilities very early during the boot, based on the boot CPU. e.g, VHE
> and GIC CPUIF - for NMI).
> 
> For now, unless you see "EARLY", in the type, everything is enabled from
> setup_cpu_features.

Agreed -- I'd forgotten about this.  To what extent is this orthogonal
to 1/3/4?

> 3) WHERE: Where all do we apply the "enable" for a given capability, when it
> is to be enabled. Do we run it on all CPUs or only on the CPUs with the capability.
> We don't deal with this in the infrastructure and we run the enable callback
> on all CPUs irrespective of when the CPU is booted. It is upto the callback
> to decide if it needs to take some action on a given CPU.
> 
> 
> 4) CONFLICT: How should we treat a conflict of a capability on a CPU which
> boots after the capability was enabled in the kernel (as per 2, it could
> be earlier or after smp CPUs are brought up) ?
> 
> Here are the possible combinations, representing a Conflict:
> 
> 	System		| Late Booting CPU
> a)	   y		|   n
> b) 	   n		|   y
> 
> (a) Is considered safe for features like Erratum and KPTI where some
> actions have to be taken to make the system behave in desirable manner.
> However (a) is not considered safe for some features we advertise to the
> user (e.g, ELF HWCAP)
> 
> (b) Is considered safe for most of the features (except KPTI and Software
> prefetching), while it is unsafe for Errata, as we couldn't possibly take
> any action as the time for applying the actions (enabling as per (2) above)
> has passed already.
> 
> 
> So we have the following cases :
>  i)   a_Safe && b_not_Safe
>  ii)  a_not_Safe && b_Safe
>  iii) a_Safe && b_Safe

Is this the same as saying that the CONFLICT type (iii) is not
applicable to capabilites that are not decided globally?

> I have used "STRICT" tag for category (i) and "WEAK" for (iii). (ii) doesn't
> have any tag. I acknowledge that this scheme is not particularly intuitive.
> However I have tried to explain the behavior of "each" defined type in a
> comment above.
> 
> >
> >I'm not keen on the word "strict" because it doesn't really mean
> >anything unless the rule to be strictly enforced is documented, and
> >then doesn't really add anything: you could take the view that either
> >there's an (enforced) rule or there's no rule at all.
> 
> As I mentioned above, each type is documented on the rules. But the tags
> are not particularly helpful.
> 
> >
> >In this case, (b) seems the "relaxed" case anyway: we allow these
> >capabilities to be enabled/disabled differently on different CPUs,
> >rather than requiring the same configuration on all CPUs (KPTI).
> >
> >I think there are 2 x 2 orthogonal options:
> >
> >A FEATURE capability must be disabled on every CPU where the feature is
> >not present.  A feature capability is considered desirable, and should
> >be enabled when possible.
> >
> >An ERRATUM capability must be enabled on every CPU where the erratum is
> >present.  An erratum capability is considered undesirable, and should
> >be disabled when possible.
> >
> >(An erratum is the inverse of a feature with respect to desirability,
> >enablement and presence.)
> 
> I would really like to avoid tagging the capabilities FEATURE/ERRATUM
> to indicate their behavior, because :
> 
> 1) We could be naming a "feature" ERRATUM, where it is really not one.
> e.g, KPTI is a security feature and not an erratum.
> 
> 2) We could be "marking" all "CPU Errata" unsafe when detected late.
> e.g, Cortex-A55 errata 1024718, can be safely handled by disabling the
> DBM feature and the conflict can be "ignored" (even though it is not
> handled via capability).

That's a fair point.  "Erratum" is describing a set of constraints
between the CPUs and kernel that is typical of errata handing, but could
also apply to other features.  So I guess it's not the best choice of
word.

> So using the FEATURE/ERRATA will cause further confusion on the real
> type of the capability. Hence, it would be better if we came up with
> something other to make it clear.

I guess it may not be quite as clear-cut as I'm hoping...

> >and:
> >
> >A GLOBAL capability must be enabled on all CPUs or disabled on all CPUs.
> >(Thus, a decision must be taken during boot, based on desirability/
> >undesirability of each capability and based on the assumption that
> >late CPUs won't violate the decision -- unless this assumption is
> >overridden by a cmdline arg etc.)
> >
> >A LOCAL capability may freely be enabled on some CPUs while disabled on
> >other CPUs.
> 
> As discussed in (3) above, I would like to leave it to the "enable()" method
> to decide where actions are need, to avoid adding more combinations of tags
> to the type names. We continue to invoke enable() on all CPUs.

Sure -- if the decisions are made enable() methods rather than blanket
rules, then we don't need a distinct capability type for every possible
case.  For the very common cases like the ELF HWCAPs it may be worth it,
but not for fiddly one-off things.

> >(Thus, LOCAL is precisely the inverse of GLOBAL.)
> >
> >
> >So:
> >
> >	ARM64_CPUCAP_GLOBAL_FEATURE	(hwcap case)
> >	ARM64_CPUCAP_LOCAL_FEATURE	(DBM case)
> >	ARM64_CPUCAP_GLOBAL_ERRATUM	(KPTI case)
> >	ARM64_CPUCAP_LOCAL_ERRATUM	(regular CPU erratum case).
> >
> >("PERCPU" could be substituted for "LOCAL" if we want to be clearer
> >about the way in which LOCAL is more permissive.)
> 
> In general, I understand the names could get some improved scheme.
> I think if we come up with some nice tag for types i, ii & ii in section (4)
> we should be good to go.

This is always something that could be reexamined later.

I think I understand the basic ideas here a bit better now -- thanks.

[...]

> >>diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> >
> >[...]
> >
> >>  struct arm64_cpu_capabilities {
> >>  	const char *desc;
> >>  	u16 capability;
> >>-	int def_scope;			/* default scope */
> >>+	u16 type;
> >
> >u16?
> >
> >There are 2 types in this patch, and (I presume) another 2 later.
> >
> >Using an enum probably costs at most 2 bytes per capability, which seems
> >a reasonable price to pay for potentially better compile-time checking.
> 
> Actually, I chose u16 to align the structure a bit, following the "capability" field.
> We use it more like bit mask to check how to deal with the cap, rather than a single number
> which represents something. I agree that we get more type safety with the enum,
> but felt suited for more like an abstract quantity.

If it's a bitmask then u16 seems a bit more natural.

Cheers
---Dave
