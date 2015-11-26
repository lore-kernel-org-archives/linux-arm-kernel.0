From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2015 00:05:51 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
Message-ID: <20151126000551.GU8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 06:09:13PM -0500, Nicolas Pitre wrote:
> 3) In fact I was wondering if the overhead of the branch and back is 
>    really significant compared to the non trivial cost of a idiv 
>    instruction and all the complex infrastructure required to patch 
>    those branches directly, and consequently if the performance 
>    difference is actually worth it versus simply doing (2) alone.

I definitely agree with you on this, given that modern CPUs which
are going to be benefitting from idiv are modern CPUs with a branch
predictor (and if it's not predicting such unconditional calls and
returns it's not much use as a branch predictor!)

I think what we need to see is the performance of existing kernels,
vs patching the idiv instructions at every callsite, vs patching
the called function itself.

> > +#ifdef CONFIG_ARM_PATCH_UIDIV
> > +/* "sdiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 4" if we're on pj4 w/o MP */
> > +static u32 __attribute_const__ sdiv_instruction(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > +		if (cpu_is_pj4_nomp())
> > +			return __opcode_to_mem_thumb32(0xee300691);
> > +		return __opcode_to_mem_thumb32(0xfb90f0f1);
> > +	}
> > +
> > +	if (cpu_is_pj4_nomp())
> > +		return __opcode_to_mem_arm(0xee300691);
> > +	return __opcode_to_mem_arm(0xe710f110);
> > +}
> > +
> > +/* "udiv r0, r0, r1" or "mrc p6, 1, r0, CR0, CR1, 0" if we're on pj4 w/o MP */
> > +static u32 __attribute_const__ udiv_instruction(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> > +		if (cpu_is_pj4_nomp())
> > +			return __opcode_to_mem_thumb32(0xee300611);
> > +		return __opcode_to_mem_thumb32(0xfbb0f0f1);
> > +	}
> > +
> > +	if (cpu_is_pj4_nomp())
> > +		return __opcode_to_mem_arm(0xee300611);
> > +	return __opcode_to_mem_arm(0xe730f110);
> > +}

Any reason the above aren't marked with __init_or_module as well, as
the compiler can choose not to inline them?

> > +
> > +static void __init_or_module patch(u32 **addr, size_t count, u32 insn)
> > +{
> > +	for (; count != 0; count -= 4)
> > +		**addr++ = insn;
> > +}
> > +
> > +void __init_or_module patch_udiv(void *addr, size_t size)
> > +{
> > +	patch(addr, size, udiv_instruction());
> > +}
> > +
> > +void __init_or_module patch_sdiv(void *addr, size_t size)
> > +{
> > +	return patch(addr, size, sdiv_instruction());
> > +}
> > +
> > +static void __init patch_aeabi_uidiv(void)
> > +{
> > +	extern char __start_udiv_loc[], __stop_udiv_loc[];
> > +	extern char __start_idiv_loc[], __stop_idiv_loc[];
> > +	unsigned int mask;
> > +
> > +	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
> > +		mask = HWCAP_IDIVT;
> > +	else
> > +		mask = HWCAP_IDIVA;
> > +
> > +	if (!(elf_hwcap & mask))
> > +		return;
> > +
> > +	patch_udiv(__start_udiv_loc, __stop_udiv_loc - __start_udiv_loc);
> > +	patch_sdiv(__start_idiv_loc, __stop_idiv_loc - __start_idiv_loc);

I'm left really concerned about this.  We're modifying code with all
the caches on, and the above is not only missing any coherency of the
I/D paths, it's also missing any branch predictor maintanence.  So, if
we've executed any divisions at this point, the predictor could already
predicted one of these branches that's being modified.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
