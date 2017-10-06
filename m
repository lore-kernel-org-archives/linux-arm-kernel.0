From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 6 Oct 2017 15:27:51 +0100
Subject: [PATCH v1 2/2] kvm: arm64: handle single-step of userspace mmio
 instructions
In-Reply-To: <878tgoxudc.fsf@linaro.org>
References: <20171006113921.24880-1-alex.bennee@linaro.org>
 <20171006113921.24880-3-alex.bennee@linaro.org>
 <a9f8905e-18e9-267a-2479-f498c248e2f4@arm.com> <878tgoxudc.fsf@linaro.org>
Message-ID: <e7dafd0d-80b0-8a53-049e-9d4ecf431359@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/10/17 14:45, Alex Benn?e wrote:
> 
> Julien Thierry <julien.thierry@arm.com> writes:
> 
>> On 06/10/17 12:39, Alex Benn?e wrote:
>>> The system state of KVM when using userspace emulation is not complete
>>> until we return into KVM_RUN. To handle mmio related updates we wait
>>> until they have been committed and then schedule our KVM_EXIT_DEBUG.
>>>
>>> I've introduced a new function kvm_arm_maybe_return_debug() to wrap up
>>> the differences between arm/arm64 which is currently null for arm.
>>>
>>> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>>> ---
>>>    arch/arm/include/asm/kvm_host.h   |  2 ++
>>>    arch/arm64/include/asm/kvm_host.h |  1 +
>>>    arch/arm64/kvm/debug.c            | 21 +++++++++++++++++++++
>>>    arch/arm64/kvm/handle_exit.c      |  9 +++------
>>>    virt/kvm/arm/arm.c                |  2 +-
>>>    virt/kvm/arm/mmio.c               |  3 ++-
>>>    6 files changed, 30 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>> index 4a879f6ff13b..aec943f6d123 100644
>>> --- a/arch/arm/include/asm/kvm_host.h
>>> +++ b/arch/arm/include/asm/kvm_host.h
>>> @@ -285,6 +285,8 @@ static inline void kvm_arm_init_debug(void) {}
>>>    static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
>>>    static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
>>>    static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
>>> +static inline int  kvm_arm_maybe_return_debug(struct kvm_vcpu *vcpu,
>>> +						struct kvm_run *run) {}
>>>
>>
>> This function should return 1.
> 
> So I did ponder making this a bool, returning true if we need to exit
> and testing in v/k/a/arm.c exit leg rather than in the mmio handler.
> 
> At the moment it mirrors the existing exit logic which follows -1 err, 0
> return, >0 handled. But as I mentioned in the cover letter this fell
> down a bit when dealing with the mmio case.
> 

Hmmm, my main issue is that this version doesn't have a return 
statement, which probably triggers a gcc warning with ARCH=arm and also 
might cause arm (32bit) kvm to exit upon handling mmio return when we 
don't want to.

Otherwise, I also wondered about using a bool here. But following the 
pre-existing logic makes sense to me (but I have no strong feeling about 
it).

>>
>>>    int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
>>>    			       struct kvm_device_attr *attr);
>>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>>> index e923b58606e2..fa67d21662f6 100644
>>> --- a/arch/arm64/include/asm/kvm_host.h
>>> +++ b/arch/arm64/include/asm/kvm_host.h
>>> @@ -369,6 +369,7 @@ void kvm_arm_init_debug(void);
>>>    void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>>>    void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>>>    void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
>>> +int  kvm_arm_maybe_return_debug(struct kvm_vcpu *vcpu, struct kvm_run *run);
>>
>> I feel the name could be a little bit more explicit:
>>
>> kvm_arm_trap_need_step_debug, kvm_arm_trap_step_return_debug,
>> kvm_arm_trap_need_return_debug.
> 
> I wanted to keep the debug suffix so that's fine although I'm not so
> sure trap is correct because on the tail end of mmio emulation are we
> still trapping?
> 
> Maybe kvm_arm_step_emulated_debug?
> 

Yes, sounds good.

Thanks,

>> At least, I think it would be nice that the name reflect that this
>> check is meant for emulated instructions.
>>
>> Otherwise:
>>
>> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
>>
>> Thanks,
> 
> 
> --
> Alex Benn?e
> 

-- 
Julien Thierry
