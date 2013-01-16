From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 11:17:06 -0500
Subject: [PATCH v5 07/14] KVM: ARM: World-switch implementation
In-Reply-To: <20130116155212.GX11529@redhat.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183924.46302.65998.stgit@ubuntu>
 <20130115094312.GI11529@redhat.com>
 <CANM98q+qScaXniyYjrd9QEZzWKzj3PkCE0YNFUp2ijnCfS_v4w@mail.gmail.com>
 <20130116121238.GS11529@redhat.com>
 <CANM98q+jpzVWfg8drE+azcbDF1Q1suphZyJrij04b+OB4ZX4Dw@mail.gmail.com>
 <20130116155212.GX11529@redhat.com>
Message-ID: <CANM98qLtf0i1LA3KT3xT0ivS3U9ioA_HkKQHwe6ZzXHNuYOONw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 10:52 AM, Gleb Natapov <gleb@redhat.com> wrote:
> On Wed, Jan 16, 2013 at 10:42:02AM -0500, Christoffer Dall wrote:
>> [...]
>>
>> >
>> >> read side RCU protects against is the memslots data structure as far
>> >> as I can see, so the second patch pasted below fixes this for the code
>> >> that actually accesses this data structure.
>> > Many memory related functions that you call access memslots under the
>> > hood and assume that locking is done by the caller. From the quick look
>> > I found those that you've missed:
>> > kvm_is_visible_gfn()
>> > kvm_read_guest()
>> > gfn_to_hva()
>> > gfn_to_pfn_prot()
>> > kvm_memslots()
>> >
>> > May be there are more. Can you enable RCU debugging in your kernel config
>> > and check? This does not guaranty that it will catch all of the places,
>> > but better than nothing.
>> >
>>
>> yeah, I missed the call to is_visible_gfn and friends, this fixes it:
>>
> Thank you. One more kvm_read_guest() in emulate.c.
>

this one is going out for now (see the i/o discussion).

>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index c806080..f30e131 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -591,7 +591,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu,
>> struct kvm_run *run)
>>       struct kvm_memory_slot *memslot;
>>       bool is_iabt;
>>       gfn_t gfn;
>> -     int ret;
>> +     int ret, idx;
>>
>>       hsr_ec = vcpu->arch.hsr >> HSR_EC_SHIFT;
>>       is_iabt = (hsr_ec == HSR_EC_IABT);
>> @@ -608,33 +608,43 @@ int kvm_handle_guest_abort(struct kvm_vcpu
>> *vcpu, struct kvm_run *run)
>>               return -EFAULT;
>>       }
>>
>> +     idx = srcu_read_lock(&vcpu->kvm->srcu);
>> +
>>       gfn = fault_ipa >> PAGE_SHIFT;
>>       if (!kvm_is_visible_gfn(vcpu->kvm, gfn)) {
>>               if (is_iabt) {
>>                       /* Prefetch Abort on I/O address */
>>                       kvm_inject_pabt(vcpu, vcpu->arch.hxfar);
>> -                     return 1;
>> +                     ret = 1;
>> +                     goto out_unlock;
>>               }
>>
>>               if (fault_status != FSC_FAULT) {
>>                       kvm_err("Unsupported fault status on io memory: %#lx\n",
>>                               fault_status);
>> -                     return -EFAULT;
>> +                     ret = -EFAULT;
>> +                     goto out_unlock;
>>               }
>>
>>               /* Adjust page offset */
>>               fault_ipa |= vcpu->arch.hxfar & ~PAGE_MASK;
>> -             return io_mem_abort(vcpu, run, fault_ipa);
>> +             ret = io_mem_abort(vcpu, run, fault_ipa);
>> +             goto out_unlock;
>>       }
>>
>>       memslot = gfn_to_memslot(vcpu->kvm, gfn);
>>       if (!memslot->user_alloc) {
>>               kvm_err("non user-alloc memslots not supported\n");
>> -             return -EINVAL;
>> +             ret = -EINVAL;
>> +             goto out_unlock;
>>       }
>>
>>       ret = user_mem_abort(vcpu, fault_ipa, gfn, memslot, fault_status);
>> -     return ret ? ret : 1;
>> +     if (ret == 0)
>> +             ret = 1;
>> +out_unlock:
>> +     srcu_read_unlock(&vcpu->kvm->srcu, idx);
>> +     return ret;
>>  }
>>
>>  static void handle_hva_to_gpa(struct kvm *kvm,
>> --
>>
>> Thanks,
>> -Christoffer
>
> --
>                         Gleb.
