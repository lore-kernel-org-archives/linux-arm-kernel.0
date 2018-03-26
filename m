From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 26 Mar 2018 10:53:53 +0200
Subject: [PATCH] KVM: arm/arm64: vgic-its: Fix potential overrun in
 vgic_copy_lpi_list
In-Reply-To: <20180323152112.19054-1-marc.zyngier@arm.com>
References: <20180323152112.19054-1-marc.zyngier@arm.com>
Message-ID: <8e067ab9-f1a1-be28-57e1-5bcdc541633e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Andre,
On 23/03/18 16:21, Marc Zyngier wrote:
> vgic_copy_lpi_list() parses the LPI list and picks LPIs targetting
> a given vcpu. We allocate the array containing the intids before taking
> the lpi_list_lock, which means we can have an array size that is not
> equal to the number of LPIs.
> 
> This is particularily obvious when looking at the path coming from
> vgic_enable_lpis, which is not a command, and thus can run in parallel
> with commands:
> 
> vcpu 0:                                        vcpu 1:
> vgic_enable_lpis
>   its_sync_lpi_pending_table
>     vgic_copy_lpi_list
>       intids = kmalloc_array(irq_count)
>                                                MAPI(lpi targeting vcpu 0)
>       list_for_each_entry(lpi_list_head)
>         intids[i++] = irq->intid;
> 
> At that stage, we will happily overrun the intids array. Boo. An easy
> fix is is to break once the array is full. The MAPI command will update
> the config anyway, and we won't miss a thing. We also make sure that
> lpi_list_count is read exactly once, so that further updates of that
> value will not affect the array bound check.
My bad, sorry. I did not understand the existing check at the time I
submitted.

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> Cc: stable at vger.kernel.org
> Fixes: ccb1d791ab9e ("KVM: arm64: vgic-its: Fix pending table sync")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 465095355666..44ee2f336440 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -316,21 +316,24 @@ static int vgic_copy_lpi_list(struct kvm_vcpu *vcpu, u32 **intid_ptr)
>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>  	struct vgic_irq *irq;
>  	u32 *intids;
> -	int irq_count = dist->lpi_list_count, i = 0;
> +	int irq_count, i = 0;
>  
>  	/*
> -	 * We use the current value of the list length, which may change
> -	 * after the kmalloc. We don't care, because the guest shouldn't
> -	 * change anything while the command handling is still running,
> -	 * and in the worst case we would miss a new IRQ, which one wouldn't
> -	 * expect to be covered by this command anyway.
> +	 * There is an obvious race between allocating the array and LPIs
> +	 * being mapped/unmapped. If we ended up here as a result of a
> +	 * command, we're safe (locks are held, preventing another
> +	 * command). If coming from another path (such as enabling LPIs),
> +	 * we must be carefull not to overrun the array.
>  	 */
> +	irq_count = READ_ONCE(dist->lpi_list_count);
>  	intids = kmalloc_array(irq_count, sizeof(intids[0]), GFP_KERNEL);
>  	if (!intids)
>  		return -ENOMEM;
>  
>  	spin_lock(&dist->lpi_list_lock);
>  	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
> +		if (i == irq_count)
> +			break;
>  		/* We don't need to "get" the IRQ, as we hold the list lock. */
>  		if (irq->target_vcpu != vcpu)
>  			continue;
> 
