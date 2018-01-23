From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 23 Jan 2018 17:33:49 +0000
Subject: [PATCH 04/16] arm64: capabilities: Prepare for fine grained
 capabilities
In-Reply-To: <20180123122809.16269-5-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-5-suzuki.poulose@arm.com>
Message-ID: <20180123173346.GB5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:27:57PM +0000, Suzuki K Poulose wrote:
> We use arm64_cpu_capabilities to represent CPU ELF HWCAPs exposed
> to the userspace and the CPU hwcaps used by the kernel, which
> include cpu features and CPU errata work arounds.
> 
> At the moment we have the following restricions:
> 
>  a) CPU feature hwcaps (arm64_features) and ELF HWCAPs (arm64_elf_hwcap)
>    - Detected mostly on system wide CPU feature register. But
>      there are some which really uses a local CPU's value to
>      decide the availability (e.g, availability of hardware
>      prefetch). So, we run the check only once, after all the
>      boot-time active CPUs are turned on.
>    - Any late CPU which doesn't posses all the established features
>      is killed.
>    - Any late CPU which possess a feature *not* already available
>      is allowed to boot.
> 
>  b) CPU Errata work arounds (arm64_errata)
>    - Detected mostly based on a local CPU's feature register.
>      The checks are run on each boot time activated CPUs.
>    - Any late CPU which doesn't have any of the established errata
>      work around capabilities is ignored and is allowed to boot.
>    - Any late CPU which has an errata work around not already available
>      is killed.
> 
> However there are some exceptions to the cases above.
> 
> 1) KPTI is a feature that we need to enable when at least one CPU needs it.
>    And any late CPU that has this "feature" should be killed.
> 2) Hardware DBM feature is a non-conflicting capability which could be
>    enabled on CPUs which has it without any issues, even if the CPU is
>    brought up late.
> 
> So this calls for a lot more fine grained behavior for each capability.
> And if we define all the attributes to control their behavior properly,
> we may be able to use a single table for the CPU hwcaps (not the
> ELF HWCAPs, which cover errata and features). This is a prepartory step
> to get there. We define type for a capability, which for now encodes the
> scope of the check. i.e, whether it should be checked system wide or on
> each local CPU. We define two types :
> 
>   1) ARM64_CPUCAP_BOOT_SYSTEM_FEATURE - Implies (a) as described above.
>   1) ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM - Implies (b) as described above.

I'm a bit confused by the naming here.

I'm not keen on the word "strict" because it doesn't really mean
anything unless the rule to be strictly enforced is documented, and
then doesn't really add anything: you could take the view that either
there's an (enforced) rule or there's no rule at all.

In this case, (b) seems the "relaxed" case anyway: we allow these
capabilities to be enabled/disabled differently on different CPUs,
rather than requiring the same configuration on all CPUs (KPTI).

I think there are 2 x 2 orthogonal options:

A FEATURE capability must be disabled on every CPU where the feature is
not present.  A feature capability is considered desirable, and should
be enabled when possible.

An ERRATUM capability must be enabled on every CPU where the erratum is
present.  An erratum capability is considered undesirable, and should
be disabled when possible.

(An erratum is the inverse of a feature with respect to desirability,
enablement and presence.)

and:

A GLOBAL capability must be enabled on all CPUs or disabled on all CPUs.
(Thus, a decision must be taken during boot, based on desirability/
undesirability of each capability and based on the assumption that
late CPUs won't violate the decision -- unless this assumption is
overridden by a cmdline arg etc.)

A LOCAL capability may freely be enabled on some CPUs while disabled on
other CPUs.

(Thus, LOCAL is precisely the inverse of GLOBAL.)


So:

	ARM64_CPUCAP_GLOBAL_FEATURE	(hwcap case)
	ARM64_CPUCAP_LOCAL_FEATURE	(DBM case)
	ARM64_CPUCAP_GLOBAL_ERRATUM	(KPTI case)
	ARM64_CPUCAP_LOCAL_ERRATUM	(regular CPU erratum case).

("PERCPU" could be substituted for "LOCAL" if we want to be clearer
about the way in which LOCAL is more permissive.)


Anyway, so much for bikeshedding.  Does the above make any sense?

This only affects the naming in any case, not what the code does.

[...]

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h

[...]

>  struct arm64_cpu_capabilities {
>  	const char *desc;
>  	u16 capability;
> -	int def_scope;			/* default scope */
> +	u16 type;

u16?

There are 2 types in this patch, and (I presume) another 2 later.

Using an enum probably costs at most 2 bytes per capability, which seems
a reasonable price to pay for potentially better compile-time checking.

(Similarly for capability, though it's probably pointless churn to
change that now it's established.)

>  	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
>  	/* Called on all active CPUs for all  "available" capabilities */
>  	int (*enable)(const struct arm64_cpu_capabilities *caps);
> @@ -116,6 +123,11 @@ struct arm64_cpu_capabilities {
>  	};
>  };

[...]

Cheers
---Dave
