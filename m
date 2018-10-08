From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Oct 2018 17:18:18 +0100
Subject: [PATCH] KVM: arm64: remove the unnecessary function check
In-Reply-To: <1535708579-12233-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1535708579-12233-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <afbb853e-ef22-dde4-d17d-6802264f1ce9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/18 10:42, Shaokun Zhang wrote:
> init_common_resources always return 0 and it is redundant to check the
> return value, let's make it void to simplify the code.
> 
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>   virt/kvm/arm/arm.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index c92053b..66a29c9 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1406,13 +1406,11 @@ static inline void hyp_cpu_pm_exit(void)
>   }
>   #endif
>   
> -static int init_common_resources(void)
> +static void init_common_resources(void)
>   {
>   	/* set size of VMID supported by CPU */
>   	kvm_vmid_bits = kvm_get_vmid_bits();
>   	kvm_info("%d-bit VMID\n", kvm_vmid_bits);
> -
> -	return 0;
>   }
>   
>   static int init_subsystems(void)
> @@ -1655,9 +1653,7 @@ int kvm_arch_init(void *opaque)
>   		}
>   	}
>   
> -	err = init_common_resources();
> -	if (err)
> -		return err;
> +	init_common_resources();
>   
>   	in_hyp_mode = is_kernel_in_hyp_mode();
>   
> 

Although I agree this looks pretty superfluous at the moment, I'd rather 
keep init_common_resources as it is at the moment, as we may well end-up 
with more stuff in it, which could fail.

Another possibility would be to merge everything in init_subsystems, but 
that'd require careful investigation, specially with the stuff that is 
currently pending for 4.20.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
