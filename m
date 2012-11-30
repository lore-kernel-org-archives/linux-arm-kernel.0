From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 17:39:13 -0500
Subject: [PATCH v4 02/13] ARM: KVM: Keep track of currently running vcpus
In-Reply-To: <20121128124743.GD21671@mudshark.cambridge.arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154430.3061.64584.stgit@chazy-air>
 <20121128124743.GD21671@mudshark.cambridge.arm.com>
Message-ID: <CANM98qKD2Q2vu5LzX4eX2J58otkPqHcXNTsFMSQFhGSmNVWrQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 7:47 AM, Will Deacon <will.deacon@arm.com> wrote:
> Just a bunch of typos in this one :)
>
> On Sat, Nov 10, 2012 at 03:44:30PM +0000, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> When an interrupt occurs for the guest, it is sometimes necessary
>> to find out which vcpu was running at that point.
>>
>> Keep track of which vcpu is being tun in kvm_arch_vcpu_ioctl_run(),
>
> run
>
>> and allow the data to be retrived using either:
>
> retrieved
>
>> - kvm_arm_get_running_vcpu(): returns the vcpu running at this point
>>   on the current CPU. Can only be used in a non-preemptable context.
>
> preemptible
>
>> - kvm_arm_get_running_vcpus(): returns the per-CPU variable holding
>>   the the running vcpus, useable for per-CPU interrupts.
>
> -the
> usable
>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>> ---
>>  arch/arm/include/asm/kvm_host.h |   10 ++++++++++
>>  arch/arm/kvm/arm.c              |   30 ++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index e7fc249..e66cd56 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -154,4 +154,14 @@ static inline int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
>>  {
>>       return 0;
>>  }
>> +
>> +struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
>> +struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
>
> DECLARE_PER_CPU?
>

for a function prototype, how does that work?

>> +int kvm_arm_copy_coproc_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
>> +unsigned long kvm_arm_num_coproc_regs(struct kvm_vcpu *vcpu);
>> +struct kvm_one_reg;
>> +int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>> +int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>> +
>>  #endif /* __ARM_KVM_HOST_H__ */
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 2cdc07b..60b119a 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -53,11 +53,38 @@ static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>>  static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>>  static unsigned long hyp_default_vectors;
>>
>> +/* Per-CPU variable containing the currently running vcpu. */
>> +static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
>> +
>>  /* The VMID used in the VTTBR */
>>  static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
>>  static u8 kvm_next_vmid;
>>  static DEFINE_SPINLOCK(kvm_vmid_lock);
>>
>> +static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>> +{
>> +     BUG_ON(preemptible());
>> +     __get_cpu_var(kvm_arm_running_vcpu) = vcpu;
>> +}
>> +
>> +/**
>> + * kvm_arm_get_running_vcpu - get the vcpu running on the current CPU.
>> + * Must be called from non-preemptible context
>> + */
>> +struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
>> +{
>> +     BUG_ON(preemptible());
>> +     return __get_cpu_var(kvm_arm_running_vcpu);
>> +}
>> +
>> +/**
>> + * kvm_arm_get_running_vcpus - get the per-CPU array on currently running vcpus.
>> + */
>
> s/on/of/ ?
>

typos fixed.

Thanks,
-Christoffer
