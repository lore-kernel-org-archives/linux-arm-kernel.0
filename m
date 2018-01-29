From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jan 2018 17:14:10 +0000
Subject: [PATCH 08/16] arm64: capabilities: Group handling of features
 and errata
In-Reply-To: <cdd7ab66-9d9e-286d-cb39-c1684bde9c19@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-9-suzuki.poulose@arm.com>
 <20180126114708.GP5862@e103592.cambridge.arm.com>
 <cdd7ab66-9d9e-286d-cb39-c1684bde9c19@arm.com>
Message-ID: <20180129171410.GB5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 12:31:18PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 11:47, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:01PM +0000, Suzuki K Poulose wrote:
> >>So far we have had separate routes for triggering errata and feature
> >
> >"triggering errata" ? ;)
> >
> 
> :-). Should have been "triggering errata and feature capability *checks*.
> 
> >Maybe "[...] for determining whether to activate errata workarounds and
> >whether to enable feature capabilities."
> >
> 
> 
> >>capabilities. Also, we never allowed "features" based on local CPU
> >>and "errata" based on System wide safe registers. This patch
> >>groups the handling of errata and features and also allows them
> >>to have all the possible scopes.
> >>
> >>So, we now run through the arm64_features and arm64_errata:
> >
> >when?
> 
> with this patch.

I mean, when at runtime?

> >What about late cpus?
> >
> 
> We don't detect any new capabilities on them. They continue to get
> verified against the enabled capabilities.
> 
> >>  1) with SCOPE_LOCAL_CPU filter on each boot time enabeld CPUs,
> >>     via update_cpu_local_capabilities().
> >
> >"each [...] enabeld CPUs" -> "each [...] enabled CPU"
> >
> >Also, changing "boot time" -> "boot-time" helps avoid this being misread
> >as "on each boot", which could be taken to mean "each time a CPU comes
> >online".  I'm guessing that's not the intended meaning here.
> 
> OK

[...]

> >[Gaah, stupid git diff making function insertion look like function
> >modification.  Sometimes --patience does a better job, but there seems
> >no foolproof solution...  If you do a respin, it might be worth trying
> >it.]
> 
> Will try, thanks for the suggestion. I didn't know about that :-)

YMMV though.  The output is different, but it's not always better...

> >>-static void __init setup_feature_capabilities(void)
> >>+static void __init setup_system_capabilities(void)
> >>  {
> >>-	update_cpu_capabilities(arm64_features,
> >>-				ARM64_CPUCAP_TYPE_ALL, "detected feature:");
> >>-	enable_cpu_capabilities(arm64_features, ARM64_CPUCAP_TYPE_ALL);
> >>+	/*
> >>+	 * We have finalised the system wide safe feature registers,
> >>+	 * finalise the capabilities that depend on it.
> >>+	 */
> >>+	update_system_capabilities();
> >>+	/* Enable all the available capabilities */
> >>+	enable_cpu_capabilities(ARM64_CPUCAP_TYPE_ALL);
> >
> >So setup_system_capabilities() enables _non_ system-wide capabilities/
> >errata workarounds too?
> 
> >Maybe this function should just have a different name, like
> >"setup_boot_capabilities" or similar?
> 
> The problem with setup_boot_capabilities() is that it could conflict with
> "coming soon" setup_boot_cpu_capabilities(). May be,
> 
> setup_boot_time_system_capabilities().

Maybe.  If no name leaps out as better, maybe it's not worth changing
it.

> >
> >   }
> >>  DEFINE_STATIC_KEY_FALSE(arm64_const_caps_ready);
> >>@@ -1422,9 +1435,7 @@ void __init setup_cpu_features(void)
> >>  	u32 cwg;
> >>  	int cls;
> >>-	/* Set the CPU feature capabilies */
> >>-	setup_feature_capabilities();
> >>-	enable_errata_workarounds();
> >>+	setup_system_capabilities();
> >>  	mark_const_caps_ready();
> >>  	setup_elf_hwcaps(arm64_elf_hwcaps);
> >
> >I wonder whether we could unify the elf hwcaps handling too.
> 
> I was thinking about it today. The only catch is how do we know
> if we have "the capability", as it is spread across multiple bitmasks.
> (HWCAP, COMPAT_HWCAP, COMPAT_HWCAP2).

An easy-ish solution might be to maintain our own bitmap in the style
of cpu_hwcaps, and set bits in parallel with the elf_hwcap etc. bits.
Or, add a method that knows how to set/query the appropriate bit.

I guess we could do this later.  It's certainly not urgent.

Cheers
---Dave
