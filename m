From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 12 Oct 2013 18:09:56 -0700
Subject: [PATCH] ARM: KVM: drop arbitrary limitation to 4 CPU VMs
In-Reply-To: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
References: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131013010956.GA8200@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:17:08PM +0100, Marc Zyngier wrote:
> It appears we have an arbitrary limitation where we refuse to
> create more than 4 virtual A15 in a single VM.
> 
> This limitation doesn't make much sense (the number 4 probably
> comes from the maximum number of CPUs in a A15 cluster, but
> KVM doesn't have any notion of cluster), and directly
> contradicts CONFIG_MAX_VCPUS.

So this comes from the early days where I looked at the A15 TRM and the
MPIDR bit field for the CPU ID is limited to 2 bits.  Exactly because
I wasn't sure what remifications (if any) it would have to start
populating this register with cluster id = (vcpu_id / 4) and cpu id =
(vcpu_id % 4) I put this nice arbitrary restriction in there.

I think we need to fix how we show this register to the guest
otherwise... No?

-Christoffer

> 
> Just remove this code altogether.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/reset.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
> index c02ba4a..8e259d2 100644
> --- a/arch/arm/kvm/reset.c
> +++ b/arch/arm/kvm/reset.c
> @@ -33,8 +33,6 @@
>   * Cortex-A15 Reset Values
>   */
>  
> -static const int a15_max_cpu_idx = 3;
> -
>  static struct kvm_regs a15_regs_reset = {
>  	.usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
>  };
> @@ -63,8 +61,6 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  
>  	switch (vcpu->arch.target) {
>  	case KVM_ARM_TARGET_CORTEX_A15:
> -		if (vcpu->vcpu_id > a15_max_cpu_idx)
> -			return -EINVAL;
>  		reset_regs = &a15_regs_reset;
>  		vcpu->arch.midr = read_cpuid_id();
>  		cpu_vtimer_irq = &a15_vtimer_irq;
> -- 
> 1.8.2.3
> 
> 
