From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 May 2014 14:26:27 +0100
Subject: [PATCH v6 15/15] virt: arm: support hip04 gic
In-Reply-To: <CAD6h2NTDh3uzvB0UVBsviTWTF9_wpdY6KY0ocv5qwc9Z=3i4hg@mail.gmail.com>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-16-git-send-email-haojian.zhuang@linaro.org>
 <53748BE8.8060203@arm.com>
 <CAD6h2NTDh3uzvB0UVBsviTWTF9_wpdY6KY0ocv5qwc9Z=3i4hg@mail.gmail.com>
Message-ID: <5374C083.60806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/14 14:09, Haojian Zhuang wrote:
> On 15 May 2014 17:42, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 11/05/14 09:06, Haojian Zhuang wrote:
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
>>>  arch/arm/kvm/interrupts_head.S  | 32 ++++++++++++++++++++++------
>>>  include/kvm/arm_vgic.h          |  5 ++++-
>>>  include/linux/irqchip/arm-gic.h |  6 ++++++
>>>  virt/kvm/arm/vgic.c             | 47 +++++++++++++++++++++++++++++------------
>>>  4 files changed, 69 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
>>> index 76af9302..7aacaff 100644
>>> --- a/arch/arm/kvm/interrupts_head.S
>>> +++ b/arch/arm/kvm/interrupts_head.S
>>> @@ -419,7 +419,10 @@ vcpu     .req    r0              @ vcpu pointer always in r0
>>>       ldr     r7, [r2, #GICH_EISR1]
>>>       ldr     r8, [r2, #GICH_ELRSR0]
>>>       ldr     r9, [r2, #GICH_ELRSR1]
>>> -     ldr     r10, [r2, #GICH_APR]
>>> +     ldr     r10, [r11, #VGIC_CPU_NR_LR]
>>
>> Please rename this field to something else, now that it contains more
>> than the number of LRs.
> 
> Since vgic driver is shared between arm & arm64, I only use high word
> in VGIC_CPU_NR_LR register if SoC is HiP04. Then I could avoid to
> change the vgic implementation in arm64.
> 
> Do you want to me change arm64 implementation at the same time?

Is there anything that guarantees we'll never see the same GIC connected
to an arm64 CPU? Probably not. So you might as well do it completely. At
the minimum, mask out the top bits of the nr_lr word.

Also, there is a number of things that are not quite clear about this
GICH implementation. Given how extensive the changes are in GICD, do the
LRs have the exact same format as GICv2 (i.e. supporting only 8 vcpus,
1020 interrupts)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
