From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Jul 2014 09:47:45 +0100
Subject: [PATCH v15 11/12] virt: arm: support hip04 gic
In-Reply-To: <CAD6h2NTGTxmcyZC1upx4nC7HXpARJ_w02wGbadSHspAt2mUngQ@mail.gmail.com>
 (Haojian Zhuang's message of "Tue, 29 Jul 2014 03:31:52 +0100")
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-12-git-send-email-haojian.zhuang@linaro.org>
 <8761ihnz1l.fsf@approximate.cambridge.arm.com>
 <CAD6h2NTGTxmcyZC1upx4nC7HXpARJ_w02wGbadSHspAt2mUngQ@mail.gmail.com>
Message-ID: <87ppgomtzi.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29 2014 at  3:31:52 am BST, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
> On 29 July 2014 02:00, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Mon, Jul 28 2014 at 2:57:55 pm BST, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>> In ARM standard GIC, GICH_APR offset is 0xf0 & GICH_LR0 offset is 0x100.
>>> In HiP04 GIC, GICH_APR offset is 0x70 & GICH_LR0 offset is 0x80.
>>>
>>> Now reuse the nr_lr field in struct vgic_cpu. Bit[31:16] is used to store
>>> GICH_APR offset in HiP04, and bit[15:0] is used to store real nr_lr
>>> variable. In ARM standard GIC, don't set bit[31:16]. So we could avoid
>>> to change the VGIC implementation in arm64.
>>>
>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>> ---
>>>  arch/arm/kernel/asm-offsets.c   |  2 +-
>>>  arch/arm/kvm/interrupts_head.S  | 29 +++++++++++++++++++++++------
>>>  arch/arm64/kernel/asm-offsets.c |  2 +-
>>>  arch/arm64/kvm/hyp.S            |  4 ++--
>>>  include/kvm/arm_vgic.h          |  7 +++++--
>>>  include/linux/irqchip/arm-gic.h |  6 ++++++
>>>  virt/kvm/arm/vgic.c             | 37 ++++++++++++++++++++++++++-----------
>>>  7 files changed, 64 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
>>> index 85598b5..166cc98 100644
>>> --- a/arch/arm/kernel/asm-offsets.c
>>> +++ b/arch/arm/kernel/asm-offsets.c
>>> @@ -189,7 +189,7 @@ int main(void)
>>>    DEFINE(VGIC_CPU_ELRSR,     offsetof(struct vgic_cpu, vgic_elrsr));
>>>    DEFINE(VGIC_CPU_APR,               offsetof(struct vgic_cpu, vgic_apr));
>>>    DEFINE(VGIC_CPU_LR,                offsetof(struct vgic_cpu, vgic_lr));
>>> -  DEFINE(VGIC_CPU_NR_LR,     offsetof(struct vgic_cpu, nr_lr));
>>> +  DEFINE(VGIC_CPU_HW_CFG,    offsetof(struct vgic_cpu, hw_cfg));
>>>  #ifdef CONFIG_KVM_ARM_TIMER
>>>    DEFINE(VCPU_TIMER_CNTV_CTL,        offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
>>>    DEFINE(VCPU_TIMER_CNTV_CVAL,       offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval));
>>> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
>>> index 76af9302..9fbbf99 100644
>>> --- a/arch/arm/kvm/interrupts_head.S
>>> +++ b/arch/arm/kvm/interrupts_head.S
>>> @@ -419,7 +419,9 @@ vcpu      .req    r0              @ vcpu pointer always in r0
>>>       ldr     r7, [r2, #GICH_EISR1]
>>>       ldr     r8, [r2, #GICH_ELRSR0]
>>>       ldr     r9, [r2, #GICH_ELRSR1]
>>> -     ldr     r10, [r2, #GICH_APR]
>>> +     ldr     r10, [r11, #VGIC_CPU_HW_CFG]
>>> +     mov     r10, r10, lsr #HWCFG_APR_SHIFT
>>> +     ldr     r10, [r2, r10]
>>>
>>>       str     r3, [r11, #VGIC_CPU_HCR]
>>>       str     r4, [r11, #VGIC_CPU_VMCR]
>>> @@ -435,9 +437,15 @@ vcpu     .req    r0              @ vcpu pointer always in r0
>>>       str     r5, [r2, #GICH_HCR]
>>>
>>>       /* Save list registers */
>>> -     add     r2, r2, #GICH_LR0
>>> +     ldr     r4, [r11, #VGIC_CPU_HW_CFG]
>>> +     mov     r10, r4, lsr #HWCFG_APR_SHIFT
>>> +     /* the offset between GICH_APR & GICH_LR0 is 0x10 */
>>> +     add     r10, r10, #0x10
>>> +     add     r2, r2, r10
>>>       add     r3, r11, #VGIC_CPU_LR
>>> -     ldr     r4, [r11, #VGIC_CPU_NR_LR]
>>> +     /* Get NR_LR from VGIC_CPU_HW_CFG */
>>> +     ldr     r6, =HWCFG_NR_LR_MASK
>>> +     and     r4, r4, r6
>>
>> Use "ubfx r4, r4, #0, #16" instead (with the proper symbolic constants,
>> of course). It will save loading this mask from the constant pool. For
>> consistency, you can also replace the above mov+lsr with the same
>> mechanism.
>>
> OK
>
>>>  1:   ldr     r6, [r2], #4
>>>       str     r6, [r3], #4
>>>       subs    r4, r4, #1
>>> @@ -469,12 +477,21 @@ vcpu    .req    r0              @ vcpu pointer always in r0
>>>
>>>       str     r3, [r2, #GICH_HCR]
>>>       str     r4, [r2, #GICH_VMCR]
>>> -     str     r8, [r2, #GICH_APR]
>>> +     ldr     r6, [r11, #VGIC_CPU_HW_CFG]
>>> +     mov     r6, r6, lsr #HWCFG_APR_SHIFT
>>> +     str     r8, [r2, r6]
>>>
>>>       /* Restore list registers */
>>> -     add     r2, r2, #GICH_LR0
>>> +     ldr     r4, [r11, #VGIC_CPU_HW_CFG]
>>> +     mov     r6, r4, lsr #HWCFG_APR_SHIFT
>>> +     /* the offset between GICH_APR & GICH_LR0 is 0x10 */
>>> +     add     r6, r6, #0x10
>>> +     /* get offset of GICH_LR0 */
>>> +     add     r2, r2, r6
>>> +     /* Get NR_LR from VGIC_CPU_HW_CFG */
>>>       add     r3, r11, #VGIC_CPU_LR
>>> -     ldr     r4, [r11, #VGIC_CPU_NR_LR]
>>> +     ldr     r6, =HWCFG_NR_LR_MASK
>>> +     and     r4, r4, r6
>>
>> Same here.
>>
>
> OK
>>>  1:   ldr     r6, [r3], #4
>>>       str     r6, [r2], #4
>>>       subs    r4, r4, #1
>>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>>> index 646f888..2422358 100644
>>> --- a/arch/arm64/kernel/asm-offsets.c
>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>> @@ -136,7 +136,7 @@ int main(void)
>>>    DEFINE(VGIC_CPU_ELRSR,     offsetof(struct vgic_cpu, vgic_elrsr));
>>>    DEFINE(VGIC_CPU_APR,               offsetof(struct vgic_cpu, vgic_apr));
>>>    DEFINE(VGIC_CPU_LR,                offsetof(struct vgic_cpu, vgic_lr));
>>> -  DEFINE(VGIC_CPU_NR_LR,     offsetof(struct vgic_cpu, nr_lr));
>>> +  DEFINE(VGIC_CPU_HW_CFG,    offsetof(struct vgic_cpu, hw_cfg));
>>>    DEFINE(KVM_VTTBR,          offsetof(struct kvm, arch.vttbr));
>>>    DEFINE(KVM_VGIC_VCTRL,     offsetof(struct kvm, arch.vgic.vctrl_base));
>>>  #endif
>>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>>> index b0d1512..2dbe337 100644
>>> --- a/arch/arm64/kvm/hyp.S
>>> +++ b/arch/arm64/kvm/hyp.S
>>> @@ -426,7 +426,7 @@ CPU_BE(   rev     w11, w11 )
>>>
>>>       /* Save list registers */
>>>       add     x2, x2, #GICH_LR0
>>> -     ldr     w4, [x3, #VGIC_CPU_NR_LR]
>>> +     ldr     w4, [x3, #VGIC_CPU_HW_CFG]
>>
>> Have you tested this? It looks to me that you're not dropping the top
>> bits, so you're going to end-up with 0x1000004 list registers instead of
>> the expected 4 with GIC-400...
>>
>
> As you mentioned, GICv2 isn't used in arm64. And the HIP04 GIC isn't
> used in arm64 also. I renamed to VGIC_CPU_NR_LR to VGIC_CPU_HW_CFG. It
> seems that I needn't drop it as APR offset isn't recorded in
> VGIC_CPU_HW_CFG.

If you understood that arm64 didn't use GICv2, I must have expressed
myself extremely badly. What do you think this code does? The only
saving grace is that the is no FrankenGIC involved here, and we just
have to trim the offset.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
