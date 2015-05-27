From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 May 2015 14:29:27 +0900
Subject: [v4 2/4] arm64: kvm: add kvm cpu hotplug
In-Reply-To: <55643E4F.2000806@arm.com>
References: <1431047884-5637-1-git-send-email-takahiro.akashi@linaro.org>
 <1431047884-5637-3-git-send-email-takahiro.akashi@linaro.org>
 <55643E4F.2000806@arm.com>
Message-ID: <55655637.30505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2015 06:35 PM, Marc Zyngier wrote:
> On 08/05/15 02:18, AKASHI Takahiro wrote:
>> This patch allows cpu cores to be up and down by adding
>> kvm_arch_hardware_enable/isable(). This way, especially in kexec case,
>> cores are reset to initial states and kexec can gracefully shutdown the
>> system and reboot a new kernel from EL2.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>   arch/arm/include/asm/kvm_host.h   |    1 -
>>   arch/arm/kvm/arm.c                |   29 +++++++++++++++++++----------
>>   arch/arm64/include/asm/kvm_host.h |    1 -
>>   3 files changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index 41008cd..ca97764 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -237,7 +237,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>>
>>   struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>>
>> -static inline void kvm_arch_hardware_disable(void) {}
>>   static inline void kvm_arch_hardware_unsetup(void) {}
>>   static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>>   static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 251ab9e..e989925 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -87,11 +87,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
>>   	return &kvm_arm_running_vcpu;
>>   }
>>
>> -int kvm_arch_hardware_enable(void)
>> -{
>> -	return 0;
>> -}
>> -
>>   int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>>   {
>>   	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
>> @@ -885,6 +880,9 @@ static void cpu_init_hyp_mode(void *dummy)
>
> Since you removed the IPI, why do you keep the dummy argument?

Yeah, will remove it.

>>   	unsigned long stack_page;
>>   	unsigned long vector_ptr;
>>
>> +	if (__hyp_get_vectors() != hyp_default_vectors)
>> +		return;
>> +
>>   	/* Switch from the HYP stub to our own HYP init vector */
>>   	__hyp_set_vectors(kvm_get_idmap_vector());
>>
>> @@ -921,6 +919,10 @@ static int hyp_init_cpu_notify(struct notifier_block *self,
>>   		if (__hyp_get_vectors() == hyp_default_vectors)
>>   			cpu_init_hyp_mode(NULL);
>>   		break;
>> +	case CPU_DYING:
>> +	case CPU_DYING_FROZEN:
>> +		kvm_cpu_reset(NULL);
>> +		break;
>>   	}
>>
>>   	return NOTIFY_OK;
>> @@ -936,6 +938,7 @@ static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
>>   				    void *v)
>>   {
>>   	if (cmd == CPU_PM_EXIT &&
>> +	    kvm_arm_get_running_vcpu() &&
>>   	    __hyp_get_vectors() == hyp_default_vectors) {
>>   		cpu_init_hyp_mode(NULL);
>>   		return NOTIFY_OK;
>> @@ -1039,11 +1042,6 @@ static int init_hyp_mode(void)
>>   	}
>>
>>   	/*
>> -	 * Execute the init code on each CPU.
>> -	 */
>> -	on_each_cpu(cpu_init_hyp_mode, NULL, 1);
>> -
>> -	/*
>>   	 * Init HYP view of VGIC
>>   	 */
>>   	err = kvm_vgic_hyp_init();
>> @@ -1144,6 +1142,17 @@ out_err:
>>   	return err;
>>   }
>>
>> +int kvm_arch_hardware_enable(void)
>> +{
>> +	cpu_init_hyp_mode(NULL);
>> +	return 0;
>> +}
>> +
>> +void kvm_arch_hardware_disable(void)
>> +{
>> +	kvm_cpu_reset(NULL);
>> +}
>> +
>
> Bahhh... Just rename cpu_init_hyp_mode to kvm_arch_hardware_enable, and
> kvM_cpu_reset to kvm_arch_hardware_disable. I don't see the point of
> keeping this indirection.

Historical reason ...
Anyway, if we don't have to add anything else here, yes, I will rename them.

-Takahiro AKASHI

>>   /* NOP: Compiling as a module not supported */
>>   void kvm_arch_exit(void)
>>   {
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 6a8da9c..831e6a4 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -262,7 +262,6 @@ static inline void vgic_arch_setup(const struct vgic_params *vgic)
>>   	}
>>   }
>>
>> -static inline void kvm_arch_hardware_disable(void) {}
>>   static inline void kvm_arch_hardware_unsetup(void) {}
>>   static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>>   static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>>
>
>
