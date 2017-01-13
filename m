From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Jan 2017 14:42:04 +0000
Subject: [PATCH 2/3] KVM: arm64: Access CNTHCTL_EL2 bit fields correctly
 on VHE systems
In-Reply-To: <d496020c-a097-ffd5-adb7-7edb7c1a214e@arm.com>
References: <1484307093-29153-1-git-send-email-marc.zyngier@arm.com>
 <1484307093-29153-3-git-send-email-marc.zyngier@arm.com>
 <20170113123612.GA31994@cbox>
 <d496020c-a097-ffd5-adb7-7edb7c1a214e@arm.com>
Message-ID: <20170113144204.GB2472@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 13, 2017 at 01:30:29PM +0000, Marc Zyngier wrote:
> [+ Suzuki, who wrote the whole cpus_have_const_cap thing]
> 
> On 13/01/17 12:36, Christoffer Dall wrote:
> > On Fri, Jan 13, 2017 at 11:31:32AM +0000, Marc Zyngier wrote:

> >> +static inline bool has_vhe(void)
> >> +{
> >> +	if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
> >> +		return true;
> >> +
> >> +	return false;
> >> +}
> >> +
> > 
> > I was experimenting with using has_vhe for some of the optimization code
> > I was writing, and I saw a hyp crash as a result.  That made me wonder
> > if this is really safe in Hyp mode?
> > 
> > Specifically, there is no guarantee that this will actually be inlined
> > in the caller, right?  At least that's what I can gather from trying to
> > understand the semantics of the inline keyword in the GCC manual.
> 
> Indeed, there is no strict guarantee that this is enforced. We should
> probably have __always_inline instead. But having checked the generated
> code for __timer_restore_state, the function is definitely inlined
> (gcc 6.2). Happy to queue an extra patch changing that.

> > Further, are we guaranteed that the static branch gets compiled into
> > something that doesn't actually look at cpu_hwcap_keys, which is not
> > mapped in hyp mode?

If I disable CONFIG_JUMP_LABEL (which lives under "General setup", with
teh title "Optimize very unlikely/likely branches"), I see adrp; add;
ldr sequences accessing cpu_hwcap_keys when using cpus_have_const_cap()
in hyp code, even with the patch below.

Do we have the whole kernel image mapped around hyp, so that this would
work by relative offset? Do we have a guarantee that adrp+add is used?

Thanks,
Mark.

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index b4989df..4710469 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -105,10 +105,11 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>  
>  /* System capability check for constant caps */
> -static inline bool cpus_have_const_cap(int num)
> +static __always_inline bool cpus_have_const_cap(int num)
>  {
> -	if (num >= ARM64_NCAPS)
> -		return false;
> +	BUILD_BUG_ON(!__builtin_constant_p(num));
> +	BUILD_BUG_ON(num >= ARM64_NCAPS);
> +
>  	return static_branch_unlikely(&cpu_hwcap_keys[num]);
>  }
>  
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 439f6b5..1257701 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -81,7 +81,7 @@ static inline bool is_kernel_in_hyp_mode(void)
>  	return read_sysreg(CurrentEL) == CurrentEL_EL2;
>  }
>  
> -static inline bool has_vhe(void)
> +static __always_inline bool has_vhe(void)
>  {
>  	if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
>  		return true;
> 
> 
> But that's probably another patch or two. Thoughts?
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
