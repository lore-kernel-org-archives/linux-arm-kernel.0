From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 1 Oct 2018 17:13:27 +0100
Subject: [PATCH 2/2] KVM: arm64: Drop __cpu_init_stage2 on the VHE path
In-Reply-To: <20181001130656.36999-3-marc.zyngier@arm.com>
References: <20181001130656.36999-1-marc.zyngier@arm.com>
 <20181001130656.36999-3-marc.zyngier@arm.com>
Message-ID: <22605c91-53f1-239d-e6bf-1d9cf617bdbb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 10/01/2018 02:06 PM, Marc Zyngier wrote:
> __cpu_init_stage2 doesn't do anything anymore on arm64, and is
> totally non-sensical if running VHE (as VHE is 64bit only).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   virt/kvm/arm/arm.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 91c464c9cd21..4ce99bb223bc 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1310,16 +1310,10 @@ static void cpu_hyp_reinit(void)
>   {
>   	cpu_hyp_reset();
>   
> -	if (is_kernel_in_hyp_mode()) {
> -		/*
> -		 * __cpu_init_stage2() is safe to call even if the PM
> -		 * event was cancelled before the CPU was reset.
> -		 */
> -		__cpu_init_stage2();
> +	if (is_kernel_in_hyp_mode())
>   		kvm_timer_init_vhe();

The patch looks good to me. However, if we ever add something there in
the future, this caller site could be lost. Is it worth a comment ?

Besides,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
