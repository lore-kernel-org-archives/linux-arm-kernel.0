From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 11:13:08 -0500
Subject: [PATCH v5 07/12] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <50F6D0A0.5010707@arm.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184211.46558.74646.stgit@ubuntu>
 <20130114154231.GG18935@mudshark.cambridge.arm.com>
 <CANM98qJ_Pb5bT0k7bAhv6i1YTj6GxvNE6vvY49OZrqsKpF3xOA@mail.gmail.com>
 <50F536DC.2060702@arm.com>
 <CANM98qJ0YRNA5R+qnRF9i0a7BRoL817Mq9D1SFPcxsSWgd2x0w@mail.gmail.com>
 <50F6D0A0.5010707@arm.com>
Message-ID: <CANM98qL1Ln2GYhC-prLR3VHgb=b1YR608dW6o7CS4s3L6Xy84Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:09 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/01/13 15:29, Christoffer Dall wrote:
>> [...]
>>
>>>> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
>>>> index 1ace491..f9d1977 100644
>>>> --- a/arch/arm/include/asm/kvm_vgic.h
>>>> +++ b/arch/arm/include/asm/kvm_vgic.h
>>>> @@ -33,6 +33,7 @@
>>>>  #define VGIC_NR_PRIVATE_IRQS (VGIC_NR_SGIS + VGIC_NR_PPIS)
>>>>  #define VGIC_NR_SHARED_IRQS  (VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
>>>>  #define VGIC_MAX_CPUS                KVM_MAX_VCPUS
>>>> +#define VGIC_MAX_LRS         64
>>>
>>> Consider this instead (for the reason below)
>>> #define VGIC_MAX_LRS    (1 << 7)
>>>
>>
>> so here you mean (1 << 6), right?
>
> No. We have a 6 bit field that contains (NR_LRS - 1). So the maximum
> value is (0b111111 + 1), which is (1 << 7).
>

eh, (1 << 7) is 128, and we have a maximum value of 63 (which plus the
one is 64). You can verify this by thinking about having four bits, is
a halfword, which we use hex numbers to deal with, so the number of
values you can decode there is 16, then you have two more bits, which
each doubles the number of values, so this becomes 64 values total,
ie. from 0 through 63.  :)




>>
>>>>  /* Sanity checks... */
>>>>  #if (VGIC_MAX_CPUS > 8)
>>>> @@ -120,7 +121,7 @@ struct vgic_cpu {
>>>>       DECLARE_BITMAP( pending_shared, VGIC_NR_SHARED_IRQS);
>>>>
>>>>       /* Bitmap of used/free list registers */
>>>> -     DECLARE_BITMAP( lr_used, 64);
>>>> +     DECLARE_BITMAP( lr_used, VGIC_MAX_LRS);
>>>>
>>>>       /* Number of list registers on this CPU */
>>>>       int             nr_lr;
>>>> @@ -132,7 +133,7 @@ struct vgic_cpu {
>>>>       u32             vgic_eisr[2];   /* Saved only */
>>>>       u32             vgic_elrsr[2];  /* Saved only */
>>>>       u32             vgic_apr;
>>>> -     u32             vgic_lr[64];    /* A15 has only 4... */
>>>> +     u32             vgic_lr[VGIC_MAX_LRS];
>>>>  #endif
>>>>  };
>>>>
>>>> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>>>> index a0d283c..90a99fd 100644
>>>> --- a/arch/arm/kvm/vgic.c
>>>> +++ b/arch/arm/kvm/vgic.c
>>>> @@ -1345,6 +1345,8 @@ int kvm_vgic_hyp_init(void)
>>>>
>>>>       vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
>>>>       vgic_nr_lr = (vgic_nr_lr & 0x1f) + 1;
>>>
>>> There is a bug here. It should be:
>>>         vgic_nr_lr = (vgic_nr_lr & 0x2f) + 1;
>>>
>>
>> and here you mean (vgic_nr_lr & 0x3f) + 1
>> right?
>
> Neither. 0x2f is the right value. See the GIC spec, 5.3.2, GICH_VTR
> register.
>
I'm looking at it, and I don't understand why you don't want to
consider bit[4] ?

-Christoffer
