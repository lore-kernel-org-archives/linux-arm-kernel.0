From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 16 Apr 2018 18:05:44 +0800
Subject: [PATCH] KVM: arm/arm64: Close VMID generation race
In-Reply-To: <5ACD6521.5090500@huawei.com>
References: <20180409170706.23541-1-marc.zyngier@arm.com>
 <20180409205139.GH10904@cbox>
 <20180410105119.yzzzd4lyvlsvtbfy@lakrids.cambridge.arm.com>
 <20180410150540.GK10904@cbox>
 <20180410152419.inzprhuqhx26keuq@lakrids.cambridge.arm.com>
 <f90f8486-10c7-ce42-94a8-abaabd80ebb7@arm.com> <5ACD6521.5090500@huawei.com>
Message-ID: <5AD47578.7010103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/4/11 9:30, Shannon Zhao wrote:
> 
> On 2018/4/10 23:37, Marc Zyngier wrote:
>> > On 10/04/18 16:24, Mark Rutland wrote:
>>> >> On Tue, Apr 10, 2018 at 05:05:40PM +0200, Christoffer Dall wrote:
>>>> >>> On Tue, Apr 10, 2018 at 11:51:19AM +0100, Mark Rutland wrote:
>>>>> >>>> I think we also need to update kvm->arch.vttbr before updating
>>>>> >>>> kvm->arch.vmid_gen, otherwise another CPU can come in, see that the
>>>>> >>>> vmid_gen is up-to-date, jump to hyp, and program a stale VTTBR (with the
>>>>> >>>> old VMID).
>>>>> >>>>
>>>>> >>>> With the smp_wmb() and update of kvm->arch.vmid_gen moved to the end of
>>>>> >>>> the critical section, I think that works, modulo using READ_ONCE() and
>>>>> >>>> WRITE_ONCE() to ensure single-copy-atomicity of the fields we access
>>>>> >>>> locklessly.
>>>> >>>
>>>> >>> Indeed, you're right.  I would look something like this, then:
>>>> >>>
>>>> >>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>>>> >>> index 2e43f9d42bd5..6cb08995e7ff 100644
>>>> >>> --- a/virt/kvm/arm/arm.c
>>>> >>> +++ b/virt/kvm/arm/arm.c
>>>> >>> @@ -450,7 +450,9 @@ void force_vm_exit(const cpumask_t *mask)
>>>> >>>   */
>>>> >>>  static bool need_new_vmid_gen(struct kvm *kvm)
>>>> >>>  {
>>>> >>> -	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
>>>> >>> +	u64 current_vmid_gen = atomic64_read(&kvm_vmid_gen);
>>>> >>> +	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
>>>> >>> +	return unlikely(READ_ONCE(kvm->arch.vmid_gen) != current_vmid_gen);
>>>> >>>  }
>>>> >>>  
>>>> >>>  /**
>>>> >>> @@ -500,7 +502,6 @@ static void update_vttbr(struct kvm *kvm)
>>>> >>>  		kvm_call_hyp(__kvm_flush_vm_context);
>>>> >>>  	}
>>>> >>>  
>>>> >>> -	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
>>>> >>>  	kvm->arch.vmid = kvm_next_vmid;
>>>> >>>  	kvm_next_vmid++;
>>>> >>>  	kvm_next_vmid &= (1 << kvm_vmid_bits) - 1;
>>>> >>> @@ -509,7 +510,10 @@ static void update_vttbr(struct kvm *kvm)
>>>> >>>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
>>>> >>>  	BUG_ON(pgd_phys & ~VTTBR_BADDR_MASK);
>>>> >>>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK(kvm_vmid_bits);
>>>> >>> -	kvm->arch.vttbr = pgd_phys | vmid;
>>>> >>> +	WRITE_ONCE(kvm->arch.vttbr, pgd_phys | vmid);
>>>> >>> +
>>>> >>> +	smp_wmb(); /* Ensure vttbr update is observed before vmid_gen update */
>>>> >>> +	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
>>>> >>>  
>>>> >>>  	spin_unlock(&kvm_vmid_lock);
>>>> >>>  }
>>> >>
>>> >> I think that's right, yes.
>>> >>
>>> >> We could replace the smp_{r,w}mb() barriers with an acquire of the
>>> >> kvm_vmid_gen and a release of kvm->arch.vmid_gen, but if we're really
>>> >> trying to optimize things there are larger algorithmic changes necessary
>>> >> anyhow.
>>> >>
>>>> >>> It's probably easier to convince ourselves about the correctness of
>>>> >>> Marc's code using a rwlock instead, though.  Thoughts?
>>> >>
>>> >> I believe that Marc's preference was the rwlock; I have no preference
>>> >> either way.
>> > 
>> > I don't mind either way. If you can be bothered to write a proper commit
>> > log for this, I'll take it. What I'd really want is Shannon to indicate
>> > whether or not this solves the issue he was seeing.
>> > 
> I'll test Marc's patch. This will take about 3 days since it's not 100%
> reproducible.
Hi Marc,

I've run the test for about 4 days. The issue doesn't appear.
So Tested-by: Shannon Zhao <zhaoshenglong@huawei.com>

Thanks,
-- 
Shannon
