From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 10 Aug 2015 10:43:00 +0200
Subject: [PATCH v4 4/5] KVM: introduce kvm_arch functions for IRQ bypass
In-Reply-To: <1438978154.4023.262.camel@redhat.com>
References: <1438622444-25444-1-git-send-email-eric.auger@linaro.org>	
 <1438622444-25444-5-git-send-email-eric.auger@linaro.org>
 <1438978154.4023.262.camel@redhat.com>
Message-ID: <55C86414.5070203@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2015 10:09 PM, Alex Williamson wrote:
> On Mon, 2015-08-03 at 19:20 +0200, Eric Auger wrote:
>> This patch introduces
>> - kvm_arch_irq_bypass_add_producer
>> - kvm_arch_irq_bypass_del_producer
>> - kvm_arch_irq_bypass_stop
>> - kvm_arch_irq_bypass_start
>>
>> They make possible to specialize the KVM IRQ bypass consumer in
>> case CONFIG_KVM_HAVE_IRQ_BYPASS is set.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>> Signed-off-by: Feng Wu <feng.wu@intel.com>
>>
>> ---
>>
>> v2 -> v3 (Feng Wu):
>> - use 'kvm_arch_irq_bypass_start' instead of 'kvm_arch_irq_bypass_resume'
>> - Remove 'kvm_arch_irq_bypass_update', which is not needed to be
>>   a irqbypass callback per Alex's comments.
>> - Make kvm_arch_irq_bypass_add_producer return 'int'
>>
>> v1 -> v2:
>> - use CONFIG_KVM_HAVE_IRQ_BYPASS instead CONFIG_IRQ_BYPASS_MANAGER
>> - rename all functions according to Paolo's proposal
>> - add kvm_arch_irq_bypass_update according to Feng's need
>> ---
>>  include/linux/kvm_host.h | 33 +++++++++++++++++++++++++++++++++
>>  virt/kvm/Kconfig         |  3 +++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 05e99b8..84b5feb 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -24,6 +24,7 @@
>>  #include <linux/err.h>
>>  #include <linux/irqflags.h>
>>  #include <linux/context_tracking.h>
>> +#include <linux/irqbypass.h>
>>  #include <asm/signal.h>
>>  
>>  #include <linux/kvm.h>
>> @@ -1151,5 +1152,37 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
>>  {
>>  }
>>  #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
>> +
>> +#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
>> +
>> +int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
>> +			   struct irq_bypass_producer *);
>> +void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
>> +			   struct irq_bypass_producer *);
>> +void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *);
>> +void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
>> +
>> +#else
> 
> Do we really need static inline stubs?  When would they get used?
This addresses the case where another arch would use an irq bypass
producer (such as vfio platform driver ) and irqfd without
implementing/needing forwarding/posting stuff.

I see 2 solutions: either we have those stubs or in eventfd.c we guard
	irq_bypass_unregister_consumer(&irqfd->consumer);
and
	ret = irq_bypass_register_consumer(&irqfd->consumer);
by

#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
#endif

This latter solution maybe is better.

  How
> would they work since we call them via function pointers?
Just tested that without the ARM forwarding implementation of kvm_arch
functions and that runs fine.
> 
>> +
>> +static inline int kvm_arch_irq_bypass_add_producer(
>> +			struct irq_bypass_consumer *cons,
>> +			struct irq_bypass_producer *prod)
>> +{
>> +	return -1;
> 
> No reason not to stick with standard errno values, is there?  -EINVAL
> Thanks,
sure

Thanks

Eric
> 
> Alex
> 
>> +}
>> +static inline void kvm_arch_irq_bypass_del_producer(
>> +			struct irq_bypass_consumer *cons,
>> +			struct irq_bypass_producer *prod)
>> +{
>> +}
>> +static inline void kvm_arch_irq_bypass_stop(
>> +			struct irq_bypass_consumer *cons)
>> +{
>> +}
>> +static inline void kvm_arch_irq_bypass_start(
>> +			struct irq_bypass_consumer *cons)
>> +{
>> +}
>> +#endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>>  #endif
>>  
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index e2c876d..9f8014d 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -47,3 +47,6 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>>  config KVM_COMPAT
>>         def_bool y
>>         depends on COMPAT && !S390
>> +
>> +config HAVE_KVM_IRQ_BYPASS
>> +       bool
> 
> 
> 
