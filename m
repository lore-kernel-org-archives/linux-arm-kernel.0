From: peng.hao2@zte.com.cn (peng.hao2 at zte.com.cn)
Date: Sat, 24 Mar 2018 10:08:54 +0800 (CST)
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2M10gS1ZNOiBhcm0vYXJtNjQgOiBhZGQgbHBpIGluZm8gaW4gdmdpYy1kZWJ1Zw==?=
Message-ID: <201803241008543904320@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>On 24/03/18 00:42, Peng Hao wrote:
>> Add lpi debug info to vgic-stat.
>> The printed info like this:
>>     SPI  287      0 000001        0        0   0 160      -1
>>     LPI 8192      2 000100        0        0   0 160      -1
>> 
>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>> ---
>>  virt/kvm/arm/vgic/vgic-debug.c | 59 ++++++++++++++++++++++++++++++++++++++----
>>  virt/kvm/arm/vgic/vgic-its.c   | 16 ++++++------
>>  virt/kvm/arm/vgic/vgic.h       |  1 +
>>  3 files changed, 63 insertions(+), 13 deletions(-)
>> 
.....
>> +    for (i = 0; i < irq_count; i++) {
>> +        irq = vgic_get_irq(kvm, NULL, intids[i]);
>> +        if (!irq)
>> +            continue;
>> +        lpi_irqs[iter->nr_lpis++] = irq;
>> +    }
>> +    iter->lpi_irqs = lpi_irqs;
>> +    kfree(intids);

>You are still completely missing the point. Why are you allocating this
>array of pointers while you have a perfectly sensible array of intids,
>allowing you do treat all the irqs uniformly?

>>  }
>>  
>>  static void iter_init(struct kvm *kvm, struct vgic_state_iter *iter,
>> @@ -64,6 +100,8 @@ static void iter_init(struct kvm *kvm, struct vgic_state_iter *iter,
>>      iter->nr_cpus = nr_cpus;
>>      iter->nr_spis = kvm->arch.vgic.nr_spis;
>>  
> +    if (vgic_supports_direct_msis(kvm) && !pos)
>> +        vgic_debug_get_lpis(kvm, iter);

>Again: What is the point of this?

>>      /* Fast forward to the right position if needed */
>>      while (pos--)
>>          iter_next(iter);
>> @@ -73,7 +111,9 @@ static bool end_of_vgic(struct vgic_state_iter *iter)
>>  {
>>      return iter->dist_id > 0 &&
>>          iter->vcpu_id == iter->nr_cpus &&
>> -        (iter->intid - VGIC_NR_PRIVATE_IRQS) == iter->nr_spis;
>> +        (iter->intid - VGIC_NR_PRIVATE_IRQS) >= iter->nr_spis &&
>> +        ((iter->nr_lpis == 0) ||
>> +        (iter->lpi_print_count == iter->nr_lpis + 1));
>>  }
>>  
>>  static void *vgic_debug_start(struct seq_file *s, loff_t *pos)
>> @@ -130,6 +170,7 @@ static void vgic_debug_stop(struct seq_file *s, void *v)
>>  
>>      mutex_lock(&kvm->lock);
>>      iter = kvm->arch.vgic.iter;
>> +    kfree(iter->lpi_irqs);
>>      kfree(iter);
>>      kvm->arch.vgic.iter = NULL;
>>      mutex_unlock(&kvm->lock);
>> @@ -154,7 +195,7 @@ static void print_header(struct seq_file *s, struct vgic_irq *irq,
>>               struct kvm_vcpu *vcpu)
>>  {
>>      int id = 0;
>> -    char *hdr = "SPI ";
>> +    char *hdr = "Global";
>>  
>>      if (vcpu) {
>>          hdr = "VCPU";
>> @@ -162,7 +203,10 @@ static void print_header(struct seq_file *s, struct vgic_irq *irq,
>>      }
>>  
>>      seq_printf(s, "\n");
....
>>      print_irq_state(s, irq, vcpu);
>>      spin_unlock(&irq->irq_lock);
>> +    vgic_put_irq(kvm, irq);

>Doesn't it shock you that you're doing a "put" on something you haven't
>done a "get" on?

>[...]

>Here's what I mean[1]. No double allocation, uniform access to the irq
>pointer, no imbalance in reference management.
Thanks for your help.
By the way, I want to know which device you use for testing vgic-v4 function.
I passthrough one VF to VM,but it just says "timeout".
>[1]
>https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=kvm-arm64/vgic-debug&id=7ab86b67167698d30a93b9f5079eb9f48f885bf6
