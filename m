From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 2 Oct 2018 10:41:11 +0200
Subject: [PATCH 2/2] KVM: arm64: Drop __cpu_init_stage2 on the VHE path
In-Reply-To: <20181001130656.36999-3-marc.zyngier@arm.com>
References: <20181001130656.36999-1-marc.zyngier@arm.com>
 <20181001130656.36999-3-marc.zyngier@arm.com>
Message-ID: <dd7708db-53e0-3048-4fdb-c1c8e7a09de5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 10/1/18 3:06 PM, Marc Zyngier wrote:
> __cpu_init_stage2 doesn't do anything anymore on arm64, and is
> totally non-sensical if running VHE (as VHE is 64bit only).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  virt/kvm/arm/arm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 91c464c9cd21..4ce99bb223bc 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1310,16 +1310,10 @@ static void cpu_hyp_reinit(void)
>  {
>  	cpu_hyp_reset();
>  
> -	if (is_kernel_in_hyp_mode()) {
> -		/*
> -		 * __cpu_init_stage2() is safe to call even if the PM
> -		 * event was cancelled before the CPU was reset.
> -		 */
> -		__cpu_init_stage2();
> +	if (is_kernel_in_hyp_mode())
>  		kvm_timer_init_vhe();
> -	} else {
> +	else
>  		cpu_init_hyp_mode(NULL);
> -	}
>  
>  	if (vgic_present)
>  		kvm_vgic_init_cpu_hardware();
> 
