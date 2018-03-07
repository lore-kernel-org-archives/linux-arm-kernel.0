From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 7 Mar 2018 16:06:09 +0000
Subject: [PATCH 2/2] kvm: arm/arm64: vgic-v3: Tighten synchronization for
 guests using v2 on v3
In-Reply-To: <20180307124055.13800-3-marc.zyngier@arm.com>
References: <20180307124055.13800-1-marc.zyngier@arm.com>
 <20180307124055.13800-3-marc.zyngier@arm.com>
Message-ID: <7c494456-adc9-b8d4-208c-7a5dded8a790@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/03/18 12:40, Marc Zyngier wrote:
> On guest exit, and when using GICv2 on GICv3, we use a dsb(st) to
> force synchronization between the memory-mapped guest view and
> the system-register view that the hypervisor uses.
> 
> This is incorrect, as the spec calls out the need for "a DSB whose
> required access type is both loads and stores with any Shareability
> attribute", while we're only synchronizing stores.
> 
> We also lack an isb after the dsb to ensure that the latter has
> actually been executed before we start reading stuff from the sysregs.
> 
> The fix is pretty easy: turn dsb(st) into dsb(sy), and slap an isb()
> just after.

It's a shame that the spec indeed asks for the biggest available hammer,
but: so be it!

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  virt/kvm/arm/hyp/vgic-v3-sr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/hyp/vgic-v3-sr.c b/virt/kvm/arm/hyp/vgic-v3-sr.c
> index f5c3d6d7019e..b89ce5432214 100644
> --- a/virt/kvm/arm/hyp/vgic-v3-sr.c
> +++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
> @@ -215,7 +215,8 @@ void __hyp_text __vgic_v3_save_state(struct kvm_vcpu *vcpu)
>  	 * are now visible to the system register interface.
>  	 */
>  	if (!cpu_if->vgic_sre) {
> -		dsb(st);
> +		dsb(sy);
> +		isb();
>  		cpu_if->vgic_vmcr = read_gicreg(ICH_VMCR_EL2);
>  	}
>  
> 
