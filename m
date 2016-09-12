From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Sep 2016 09:51:43 +0100
Subject: [PATCH v4 1/5] arm/arm64: vgic-new: Implement support for
 userspace access
In-Reply-To: <CALicx6sHYqwGdW_zwE9d8BWO2BucQM6gEoLZAtJ6XG0AjAuGGw@mail.gmail.com>
References: <1473510138-4719-1-git-send-email-vijay.kilari@gmail.com>
 <1473510138-4719-2-git-send-email-vijay.kilari@gmail.com>
 <57D66679.3020804@arm.com>
 <CALicx6sHYqwGdW_zwE9d8BWO2BucQM6gEoLZAtJ6XG0AjAuGGw@mail.gmail.com>
Message-ID: <57D66C9F.8070003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 09:46, Vijay Kilari wrote:
> On Mon, Sep 12, 2016 at 1:55 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 10/09/16 13:22, vijay.kilari at gmail.com wrote:
>>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>>
>>> +
>>> +void vgic_uaccess_write_pending(struct kvm_vcpu *vcpu,
>>> +                             gpa_t addr, unsigned int len,
>>> +                             unsigned long val)
>>> +{
>>> +     u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
>>> +     int i;
>>> +
>>> +     for (i = 0; i < len * 8; i++) {
>>> +             struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
>>> +
>>> +             spin_lock(&irq->irq_lock);
>>> +             if (test_bit(i, &val)) {
>>> +                     irq->pending = true;
>>> +                     irq->soft_pending = true;
>>> +                     vgic_queue_irq_unlock(vcpu->kvm, irq);
>>> +             } else {
>>> +                     irq->soft_pending = false;
>>> +                     if (irq->config == VGIC_CONFIG_EDGE ||
>>> +                         (irq->config == VGIC_CONFIG_LEVEL &&
>>> +                         !irq->line_level))
>>> +                             irq->pending = false;
>>> +                     spin_unlock(&irq->irq_lock);
>>> +             }
>>> +
>>> +             vgic_put_irq(vcpu->kvm, irq);
>>> +     }
>>> +}
>>> +
>>
>> These two functions only seems to be called from the GICv3 code. What is
>> the rational for making them globally accessible? Or should they also be
>> wired into the GICv2 code?
> 
> Yes, probably this might be required for V2. But I don't have GICv2 platform
> to implement and verify it. Also not aware if someone is looking at
> migration with GICv2
> platform with this new vgic code.

Migration is already supported, and we can always verify it once you've
made the change.

> 
> Can be kept here for later to wire into GICv2 code.

I don't think so. You are implementing this code, so please wire it into
the potential users.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
