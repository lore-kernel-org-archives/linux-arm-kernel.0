From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 13:23:32 +0100
Subject: [PATCH v9 05/12] ARM/ARM64: KVM: Make kvm_psci_call() return
 convention more flexible
In-Reply-To: <CAAhSdy0hna8NifXXb6icgUEVA_T0Seu99xf6JtGGbsEWYH2+fQ@mail.gmail.com>
 (Anup Patel's message of "Tue, 15 Apr 2014 12:13:30 +0100")
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
 <1397542455-354-6-git-send-email-anup.patel@linaro.org>
 <87y4z6zydm.fsf@approximate.cambridge.arm.com>
 <CAAhSdy0hna8NifXXb6icgUEVA_T0Seu99xf6JtGGbsEWYH2+fQ@mail.gmail.com>
Message-ID: <87vbuaye63.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15 2014 at 12:13:30 pm BST, Anup Patel <anup@brainfault.org> wrote:
> On Tue, Apr 15, 2014 at 3:51 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Tue, Apr 15 2014 at  7:14:08 am BST, Anup Patel <anup.patel@linaro.org> wrote:
>>> Currently, the kvm_psci_call() returns 'true' or 'false' based on whether
>>> the PSCI function call was handled successfully or not. This does not help
>>> us emulate system-level PSCI functions where the actual emulation work will
>>> be done by user space (QEMU or KVMTOOL). Examples of such system-level PSCI
>>> functions are: PSCI v0.2 SYSTEM_OFF and SYSTEM_RESET.
>>>
>>> This patch updates kvm_psci_call() to return three types of values:
>>> 1) > 0 (success)
>>> 2) = 0 (success but exit to user space)
>>> 3) < 0 (errors)
>>>
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>>  arch/arm/include/asm/kvm_psci.h   |    2 +-
>>>  arch/arm/kvm/handle_exit.c        |   10 +++++++---
>>>  arch/arm/kvm/psci.c               |   28 ++++++++++++++++------------
>>>  arch/arm64/include/asm/kvm_psci.h |    2 +-
>>>  arch/arm64/kvm/handle_exit.c      |   10 +++++++---
>>>  5 files changed, 32 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
>>> index 4c0e3e1..6bda945 100644
>>> --- a/arch/arm/include/asm/kvm_psci.h
>>> +++ b/arch/arm/include/asm/kvm_psci.h
>>> @@ -22,6 +22,6 @@
>>>  #define KVM_ARM_PSCI_0_2     2
>>>
>>>  int kvm_psci_version(struct kvm_vcpu *vcpu);
>>> -bool kvm_psci_call(struct kvm_vcpu *vcpu);
>>> +int kvm_psci_call(struct kvm_vcpu *vcpu);
>>>
>>>  #endif /* __ARM_KVM_PSCI_H__ */
>>> diff --git a/arch/arm/kvm/handle_exit.c b/arch/arm/kvm/handle_exit.c
>>> index 0de91fc..1270095 100644
>>> --- a/arch/arm/kvm/handle_exit.c
>>> +++ b/arch/arm/kvm/handle_exit.c
>>> @@ -38,14 +38,18 @@ static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>
>>>  static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>>  {
>>> +     int ret;
>>> +
>>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>>                     kvm_vcpu_hvc_get_imm(vcpu));
>>>
>>> -     if (kvm_psci_call(vcpu))
>>> +     ret = kvm_psci_call(vcpu);
>>> +     if (ret == -EINVAL) {
>>
>> Please check for (ret < 0), so it actually matches with the comment (and
>> will same some debugging when we introduce another error code).
>
> Should we be injecting undefined exception for all types errors?

What would be the alternative? If we end-up being unable to provide the
expected service because of an internal error, I'd rather let the guest
know about it.

> The intention here was to only inject undefined exception when
> PSCI function number is invalid.

I understand that, and this is the only case at the moment. What I'm
foreseeing is a situation where we've been unable to perform the
expected service, and PSCI doesn't specify any "internal error". So an
error injection looks like a valid solution to me.

	M.
-- 
Jazz is not dead. It just smells funny.
