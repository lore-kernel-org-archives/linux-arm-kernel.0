From: m.smarduch@samsung.com (Mario Smarduch)
Date: Tue, 10 Jun 2014 11:08:24 -0700
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <20140610092240.GF1388@lvm>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
 <20140608120522.GG3279@lvm> <539663A0.9080507@samsung.com>
 <20140610092240.GF1388@lvm>
Message-ID: <53974998.70001@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2014 02:22 AM, Christoffer Dall wrote:
> On Mon, Jun 09, 2014 at 06:47:12PM -0700, Mario Smarduch wrote:
>> On 06/08/2014 05:05 AM, Christoffer Dall wrote:
>>> On Fri, Jun 06, 2014 at 10:33:41AM -0700, Mario Smarduch wrote:
>>>> kvm_vm_ioctl_get_dirty_log() is generic used by x86, ARM. x86 recent patch 
>>>> changed this function, this patch picks up those changes, re-tested everything
>>>> works. Applies cleanly with other patches.
>>>>
>>>> This patch adds support for keeping track of VM dirty pages. As dirty page log
>>>> is retrieved, the pages that have been written are write protected again for
>>>> next write and log read.
>>>>
>>>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>>>> ---
>>>>  arch/arm/include/asm/kvm_host.h |    3 ++
>>>>  arch/arm/kvm/arm.c              |    5 ---
>>>>  arch/arm/kvm/mmu.c              |   79 +++++++++++++++++++++++++++++++++++
>>>>  arch/x86/kvm/x86.c              |   86 ---------------------------------------
>>>>  virt/kvm/kvm_main.c             |   86 +++++++++++++++++++++++++++++++++++++++
>>>>  5 files changed, 168 insertions(+), 91 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>>> index 59565f5..b760f9c 100644
>>>> --- a/arch/arm/include/asm/kvm_host.h
>>>> +++ b/arch/arm/include/asm/kvm_host.h
>>>> @@ -232,5 +232,8 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *, u64 regid);
>>>>  int kvm_arm_timer_set_reg(struct kvm_vcpu *, u64 regid, u64 value);
>>>>  
>>>>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>>>> +void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>>>> +	struct kvm_memory_slot *slot,
>>>> +	gfn_t gfn_offset, unsigned long mask);
>>>
>>> Do all other architectures implement this function?  arm64?
>>
>> Besides arm, x86 but the function is not generic.
>>>
> 
> you're now calling this from generic code, so all architecture must
> implement it, and the prototype should proably be in
> include/linux/kvm_host.h, not in the arch-specific headers.
Ah ok.
> 
>>>>  
>>>>  #endif /* __ARM_KVM_HOST_H__ */
>>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>>> index dfd63ac..f06fb21 100644
>>>> --- a/arch/arm/kvm/arm.c
>>>> +++ b/arch/arm/kvm/arm.c
>>>> @@ -780,11 +780,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>>  	}
>>>>  }
>>>>  
>>>> -int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
>>>> -{
>>>> -	return -EINVAL;
>>>> -}
>>>> -
>>>
>>> What about the other architectures implementing this function?
>>
>> Six architectures define this function. With this patch this
>> function is generic in kvm_main.c used by x86.
> 
> But you're not defining it as a weak symbol (and I don't suspect that
> you should unless other archs do this in a *very* different way), so you
> need to either remove it from the other archs, make it a weak symbol (I
> hope this is not the case) or do something else.
Mistake on my part I just cut and paste Xiaos x86's recent upstream patch and 
didn't add weak definition.

I looked at IA64, MIPS (two of them ), S390 somewhat similar but quite 
different implementations. They use a sync version, where the dirty bitmaps 
are maintained at arch level and then copied to memslot->dirty_bitmap. There 
is only commonality between x86 and ARM right now, x86 uses
memslot->dirty_bitmap directly.

Maybe this function should go back to architecture layer, it's
unlikely it can become generic across all architectures.

There is also the issue of kvm_flush_remote_tlbs(), that's also weak,
the generic one is using IPIs. Since it's only used in mmu.c maybe make 
this one static.


> 
> -Christoffer
> 
