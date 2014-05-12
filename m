From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 May 2014 18:41:25 +0100
Subject: [PATCH v3 07/19] KVM: ARM: vgic: abstract access to the ELRSR
 bitmap
In-Reply-To: <20140509140603.GH3362@lvm> (Christoffer Dall's message of "Fri,
 9 May 2014 15:06:03 +0100")
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-8-git-send-email-marc.zyngier@arm.com>
 <20140509140603.GH3362@lvm>
Message-ID: <87iopaj3ne.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09 2014 at  3:06:03 pm BST, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Apr 16, 2014 at 02:39:39PM +0100, Marc Zyngier wrote:
>> Move the GICH_ELRSR access to its own function, and add it to the
>> vgic_ops structure.
>> 
>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  include/kvm/arm_vgic.h |  1 +
>>  virt/kvm/arm/vgic.c    | 20 ++++++++++++++++----
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 17bbe51..01013ec 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -84,6 +84,7 @@ struct vgic_lr {
>>  struct vgic_ops {
>>  	struct vgic_lr	(*get_lr)(const struct kvm_vcpu *, int);
>>  	void	(*set_lr)(struct kvm_vcpu *, int, struct vgic_lr);
>> +	u64	(*get_elrsr)(const struct kvm_vcpu *vcpu);
>>  };
>>  
>>  struct vgic_dist {
>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>> index bac37b8..04206a8 100644
>> --- a/virt/kvm/arm/vgic.c
>> +++ b/virt/kvm/arm/vgic.c
>> @@ -1022,9 +1022,16 @@ static void vgic_v2_set_lr(struct kvm_vcpu *vcpu, int lr,
>>  		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
>>  }
>>  
>> +static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
>> +{
>> +	const u32 *elrsr = vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
>> +	return *(u64 *)elrsr;
>> +}
>> +
>>  static const struct vgic_ops vgic_ops = {
>>  	.get_lr			= vgic_v2_get_lr,
>>  	.set_lr			= vgic_v2_set_lr,
>> +	.get_elrsr		= vgic_v2_get_elrsr,
>>  };
>>  
>>  static inline struct vgic_lr vgic_get_lr(const struct kvm_vcpu *vcpu, int lr)
>> @@ -1038,6 +1045,11 @@ static inline void vgic_set_lr(struct kvm_vcpu *vcpu, int lr,
>>  	vgic_ops.set_lr(vcpu, lr, vlr);
>>  }
>>  
>> +static inline u64 vgic_get_elrsr(struct kvm_vcpu *vcpu)
>> +{
>> +	return vgic_ops.get_elrsr(vcpu);
>> +}
>> +
>>  static void vgic_retire_lr(int lr_nr, int irq, struct kvm_vcpu *vcpu)
>>  {
>>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>> @@ -1278,14 +1290,15 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>>  {
>>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
>>  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
>> +	u64 elrsr = vgic_get_elrsr(vcpu);
>> +	unsigned long *elrsr_ptr = (unsigned long *)&elrsr;
>
> looks to me like you're changing functionality here,
> vgic_process_maintenance() called below can modify the elrsr bitmap, but
> you're copying it into elrsr (local variable) here.  Why du you even
> need the temporary elrsr variable here, and not just declare elrsr_ptr btw.?

Duh. Nice one. The whole reason for elrsr_ptr is to have a pointer to an
unsigned long which the bitmap ops can use... Don't say a word, I know.

>>  	int lr, pending;
>>  	bool level_pending;
>>  
>>  	level_pending = vgic_process_maintenance(vcpu);
>>  
>>  	/* Clear mappings for empty LRs */
>> -	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_v2.vgic_elrsr,
>> -			 vgic_cpu->nr_lr) {
>> +	for_each_set_bit(lr, elrsr_ptr, vgic_cpu->nr_lr) {
>>  		struct vgic_lr vlr;
>>  
>>  		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
>> @@ -1298,8 +1311,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
>>  	}
>>  
>>  	/* Check if we still have something up our sleeve... */
>> -	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_v2.vgic_elrsr,
>> -				      vgic_cpu->nr_lr);
>> +	pending = find_first_zero_bit(elrsr_ptr, vgic_cpu->nr_lr);
>>  	if (level_pending || pending < vgic_cpu->nr_lr)
>>  		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
>>  }
>> -- 
>> 1.8.3.4
>> 
> -Christoffer
>

-- 
Jazz is not dead. It just smells funny.
