From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 24 Apr 2013 10:09:44 -0700
Subject: [PATCH v3 24/32] arm64: KVM: 32bit GP register access
In-Reply-To: <5177D8E1.6010903@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-25-git-send-email-marc.zyngier@arm.com>
 <20130423230039.GI20569@gmail.com> <5177D8E1.6010903@arm.com>
Message-ID: <CAEDV+gLcNQozXrX+9N_Qomjnhs1huKnXxToFTFFPAZkyobOppA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 6:06 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 24/04/13 00:00, Christoffer Dall wrote:
>> On Mon, Apr 08, 2013 at 05:17:26PM +0100, Marc Zyngier wrote:
>>> Allow access to the 32bit register file through the usual API.
>>>
>>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  arch/arm64/include/asm/kvm_emulate.h |  17 +++-
>>>  arch/arm64/kvm/Makefile              |   2 +-
>>>  arch/arm64/kvm/regmap.c              | 168 +++++++++++++++++++++++++++++++++++
>>>  3 files changed, 184 insertions(+), 3 deletions(-)
>>>  create mode 100644 arch/arm64/kvm/regmap.c
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>>> index 2dcfa74..37a6567 100644
>>> --- a/arch/arm64/include/asm/kvm_emulate.h
>>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>>> @@ -28,6 +28,9 @@
>>>  #include <asm/kvm_mmio.h>
>>>  #include <asm/ptrace.h>
>>>
>>> +unsigned long *vcpu_reg32(const struct kvm_vcpu *vcpu, u8 reg_num);
>>> +unsigned long *vcpu_spsr32(const struct kvm_vcpu *vcpu);
>>> +
>>>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>>>  void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>>  void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>> @@ -49,7 +52,7 @@ static inline unsigned long *vcpu_cpsr(const struct kvm_vcpu *vcpu)
>>>
>>>  static inline bool vcpu_mode_is_32bit(const struct kvm_vcpu *vcpu)
>>>  {
>>> -    return false;   /* 32bit? Bahhh... */
>>> +    return !!(*vcpu_cpsr(vcpu) & PSR_MODE32_BIT);
>>
>> nit: you don't need the '!!': it's a bool
>
> No it is not. It is a bitwise and, turned into a bool.
>
yeah and the result of the bitwise and will be cast to a bool as per
the function's return value without the use of '!!' or did I read the
C spec wrong?
