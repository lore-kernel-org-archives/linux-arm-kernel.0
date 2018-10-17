From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Oct 2018 18:13:26 +0100
Subject: [PATCH] kvm: arm64: fix caching of host MDCR_EL2 value
In-Reply-To: <20181017164210.16094-1-mark.rutland@arm.com>
References: <20181017164210.16094-1-mark.rutland@arm.com>
Message-ID: <a9599220-4351-181a-1150-facead06996d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/18 17:42, Mark Rutland wrote:
> At boot time, KVM stashes the host MDCR_EL2 value, but only does this
> when the kernel is not running in hyp mode (i.e. is non-VHE). In these
> cases, the stashed value of MDCR_EL2.HPMN happens to be zero, which can
> lead to CONSTRAINED UNPREDICTABLE behaviour.
> 
> Since we use this value to derive the MDCR_EL2 value when switching
> to/from a guest, after a guest have been run, the performance counters
> do not behave as expected. This has been observed to result in accesses
> via PMXEVTYPER_EL0 and PMXEVCNTR_EL0 not affecting the relevant
> counters, resulting in events not being counted. In these cases, only
> the fixed-purpose cycle counter appears to work as expected.
> 
> Fix this by always stashing the host MDCR_EL2 value, regardless of VHE.

FWIW,

Tested-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 1e947bad0b63b351 ("arm64: KVM: Skip HYP setup when already running in HYP")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Christopher Dall <christoffer.dall@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm at lists.cs.columbia.edu
> ---
>   virt/kvm/arm/arm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index c92053bc3f96..8fb31a7cc22c 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1295,8 +1295,6 @@ static void cpu_init_hyp_mode(void *dummy)
>   
>   	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
>   	__cpu_init_stage2();
> -
> -	kvm_arm_init_debug();
>   }
>   
>   static void cpu_hyp_reset(void)
> @@ -1320,6 +1318,8 @@ static void cpu_hyp_reinit(void)
>   		cpu_init_hyp_mode(NULL);
>   	}
>   
> +	kvm_arm_init_debug();
> +
>   	if (vgic_present)
>   		kvm_vgic_init_cpu_hardware();
>   }
> 
