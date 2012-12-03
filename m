From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 3 Dec 2012 09:58:09 -0500
Subject: [PATCH v4 09/13] ARM: KVM: VGIC interrupt injection
In-Reply-To: <50BCB55B.3070000@arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154518.3061.69353.stgit@chazy-air>
 <20121203132543.GE20074@mudshark.cambridge.arm.com>
 <50BCB55B.3070000@arm.com>
Message-ID: <CANM98qLkcGB7+MvzLg-Z8z+ejm8WjdOVirp3r7mt+KR3q_b6=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> +
>>> +static bool vgic_update_irq_state(struct kvm *kvm, int cpuid,
>>> +                              unsigned int irq_num, bool level)
>>> +{
>>> +    struct vgic_dist *dist = &kvm->arch.vgic;
>>> +    struct kvm_vcpu *vcpu;
>>> +    int is_edge, is_level, state;
>>> +    int enabled;
>>> +    bool ret = true;
>>> +
>>> +    spin_lock(&dist->lock);
>>> +
>>> +    is_edge = vgic_irq_is_edge(dist, irq_num);
>>> +    is_level = !is_edge;
>>> +    state = vgic_bitmap_get_irq_val(&dist->irq_state, cpuid, irq_num);
>>> +
>>> +    /*
>>> +     * Only inject an interrupt if:
>>> +     * - level triggered and we change level
>>> +     * - edge triggered and we have a rising edge
>>> +     */
>>> +    if ((is_level && !(state ^ level)) || (is_edge && (state || !level))) {
>>> +            ret = false;
>>> +            goto out;
>>> +    }
>>
>> Eek, more of the edge/level combo. Can this be be restructured so that we
>> have vgic_update_{edge,level}_irq_state, which are called from here
>> appropriately?
>
> I'll have a look.
>
oh, you're no fun anymore. That if statement is one of the funniest
pieces of this code.

-Christoffer
