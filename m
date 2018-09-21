From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 17:05:27 +0100
Subject: [PATCH v5 03/27] arm64: alternative: Apply alternatives early in
 boot process
In-Reply-To: <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-4-git-send-email-julien.thierry@arm.com>
 <3becf020-b230-beb8-b304-d8097377f234@arm.com>
 <78781d82-e5c4-c590-6c0c-e7d2db456bf9@arm.com>
Message-ID: <86fty2x2d4.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2018 17:49:09 +0100,
Julien Thierry <julien.thierry@arm.com> wrote:
> 
> Hi James,
> 
> On 12/09/18 11:29, James Morse wrote:
> > Hi Julien,
> > 
> > On 28/08/18 16:51, Julien Thierry wrote:
> >> From: Daniel Thompson <daniel.thompson@linaro.org>
> >> 
> >> Currently alternatives are applied very late in the boot process (and
> >> a long time after we enable scheduling). Some alternative sequences,
> >> such as those that alter the way CPU context is stored, must be applied
> >> much earlier in the boot sequence.
> >> 
> >> Introduce apply_boot_alternatives() to allow some alternatives to be
> >> applied immediately after we detect the CPU features of the boot CPU.
> > 
> > 
> >> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> >> index b5d6039..70c2604 100644
> >> --- a/arch/arm64/kernel/alternative.c
> >> +++ b/arch/arm64/kernel/alternative.c
> >> @@ -145,7 +145,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
> >>   	} while (cur += d_size, cur < end);
> >>   }
> >>   -static void __apply_alternatives(void *alt_region, bool
> >> is_module)
> >> +static void __apply_alternatives(void *alt_region,  bool is_module,
> >> +				 unsigned long feature_mask)
> > 
> > Shouldn't feature_mask be a DECLARE_BITMAP() maybe-array like cpu_hwcaps?
> > This means it keeps working when NR_CAPS grows over 64, which might happen
> > sooner than we think for backported errata...
> > 
> > 
> >> @@ -155,6 +156,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
> >>   	for (alt = region->begin; alt < region->end; alt++) {
> >>   		int nr_inst;
> >>   +		if ((BIT(alt->cpufeature) & feature_mask) == 0)
> >> +			continue;
> >> +
> >>   		/* Use ARM64_CB_PATCH as an unconditional patch */
> >>   		if (alt->cpufeature < ARM64_CB_PATCH &&
> >>   		    !cpus_have_cap(alt->cpufeature))
> >> @@ -213,7 +217,7 @@ static int __apply_alternatives_multi_stop(void *unused)
> >>   		isb();
> >>   	} else {
> >>   		BUG_ON(alternatives_applied);
> >> -		__apply_alternatives(&region, false);
> >> +		__apply_alternatives(&region, false, ~boot_capabilities);
> > 
> > Ah, this is tricky. There is a bitmap_complement() for the DECLARE_BITMAP()
> > stuff, but we'd need a second array...
> > 
> > We could pass the scope around, but then __apply_alternatives() would need to
> > lookup the struct arm64_cpu_capabilities up every time. This is only a problem
> > as we have one cap-number-space for errata/features, but separate sparse lists.
> > 
> 
> Since for each alternative we know the cpufeature associated with it,
> the "lookup" is really just accessing an array with the given index,
> so that could be an option.
> 
> > (I think applying the alternatives one cap at a time is a bad idea as we would
> > need to walk the alternative region NR_CAPS times)
> > 
> > 
> >> @@ -227,6 +231,24 @@ void __init apply_alternatives_all(void)
> >>   	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
> >>   }
> >>   +/*
> >> + * This is called very early in the boot process (directly after we run
> >> + * a feature detect on the boot CPU). No need to worry about other CPUs
> >> + * here.
> >> + */
> >> +void __init apply_boot_alternatives(void)
> >> +{
> >> +	struct alt_region region = {
> >> +		.begin	= (struct alt_instr *)__alt_instructions,
> >> +		.end	= (struct alt_instr *)__alt_instructions_end,
> >> +	};
> >> +
> >> +	/* If called on non-boot cpu things could go wrong */
> >> +	WARN_ON(smp_processor_id() != 0);
> > 
> > Isn't the problem if there are multiple CPUs online?
> > 
> 
> Yes, that makes more sense. I'll change this.
> 
> > 
> >> +	__apply_alternatives(&region, false, boot_capabilities);
> >> +}
> >> +
> >>   #ifdef CONFIG_MODULES
> >>   void apply_alternatives_module(void *start, size_t length)
> >>   {
> > 
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 3bc1c8b..0d1e41e 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -52,6 +52,8 @@
> >>   DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
> >>   EXPORT_SYMBOL(cpu_hwcaps);
> >>   +unsigned long boot_capabilities;
> >> +
> >>   /*
> >>    * Flag to indicate if we have computed the system wide
> >>    * capabilities based on the boot time active CPUs. This
> >> @@ -1375,6 +1377,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
> >>   		if (!cpus_have_cap(caps->capability) && caps->desc)
> >>   			pr_info("%s %s\n", info, caps->desc);
> >>   		cpus_set_cap(caps->capability);
> > 
> > Hmm, the bitmap behind cpus_set_cap() is what cpus_have_cap() in
> > __apply_alternatives() looks at. If you had a call to __apply_alternatives after
> > update_cpu_capabilities(SCOPE_BOOT_CPU), but before any others, it would only
> > apply those alternatives...
> > 
> > (I don't think there is a problem re-applying the same alternative, but I
> > haven't checked).
> > 
> 
> Interesting idea. If someone can confirm that patching alternatives
> twice is safe, I think it would make things simpler.

It may not be safe for dynamic alternatives, where the patch code is
generated at runtime and may rely on the original text (to extract a
register number, for example -- see kvm_update_va_mask).

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
