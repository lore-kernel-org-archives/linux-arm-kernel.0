From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 10:29:47 -0500
Subject: [PATCH v5 07/12] ARM: KVM: VGIC virtual CPU interface management
In-Reply-To: <50F536DC.2060702@arm.com>
References: <20130108184116.46558.3558.stgit@ubuntu>
 <20130108184211.46558.74646.stgit@ubuntu>
 <20130114154231.GG18935@mudshark.cambridge.arm.com>
 <CANM98qJ_Pb5bT0k7bAhv6i1YTj6GxvNE6vvY49OZrqsKpF3xOA@mail.gmail.com>
 <50F536DC.2060702@arm.com>
Message-ID: <CANM98qJ0YRNA5R+qnRF9i0a7BRoL817Mq9D1SFPcxsSWgd2x0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
>> index 1ace491..f9d1977 100644
>> --- a/arch/arm/include/asm/kvm_vgic.h
>> +++ b/arch/arm/include/asm/kvm_vgic.h
>> @@ -33,6 +33,7 @@
>>  #define VGIC_NR_PRIVATE_IRQS (VGIC_NR_SGIS + VGIC_NR_PPIS)
>>  #define VGIC_NR_SHARED_IRQS  (VGIC_NR_IRQS - VGIC_NR_PRIVATE_IRQS)
>>  #define VGIC_MAX_CPUS                KVM_MAX_VCPUS
>> +#define VGIC_MAX_LRS         64
>
> Consider this instead (for the reason below)
> #define VGIC_MAX_LRS    (1 << 7)
>

so here you mean (1 << 6), right?

>>  /* Sanity checks... */
>>  #if (VGIC_MAX_CPUS > 8)
>> @@ -120,7 +121,7 @@ struct vgic_cpu {
>>       DECLARE_BITMAP( pending_shared, VGIC_NR_SHARED_IRQS);
>>
>>       /* Bitmap of used/free list registers */
>> -     DECLARE_BITMAP( lr_used, 64);
>> +     DECLARE_BITMAP( lr_used, VGIC_MAX_LRS);
>>
>>       /* Number of list registers on this CPU */
>>       int             nr_lr;
>> @@ -132,7 +133,7 @@ struct vgic_cpu {
>>       u32             vgic_eisr[2];   /* Saved only */
>>       u32             vgic_elrsr[2];  /* Saved only */
>>       u32             vgic_apr;
>> -     u32             vgic_lr[64];    /* A15 has only 4... */
>> +     u32             vgic_lr[VGIC_MAX_LRS];
>>  #endif
>>  };
>>
>> diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
>> index a0d283c..90a99fd 100644
>> --- a/arch/arm/kvm/vgic.c
>> +++ b/arch/arm/kvm/vgic.c
>> @@ -1345,6 +1345,8 @@ int kvm_vgic_hyp_init(void)
>>
>>       vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
>>       vgic_nr_lr = (vgic_nr_lr & 0x1f) + 1;
>
> There is a bug here. It should be:
>         vgic_nr_lr = (vgic_nr_lr & 0x2f) + 1;
>

and here you mean (vgic_nr_lr & 0x3f) + 1
right?


>> +     if (vgic_nr_lr > VGIC_MAX_LRS)
>> +             vgic_nr_lr = VGIC_MAX_LRS; /* TODO: Clear remaining LRs */
>
> Why? VGIC_MAX_LRS isn't a configurable value, but a maximum value
> defined by the specification. This is the maximum you can fit in a 6 bit
> field, plus one (1 << 7, exactly).
>
>>       ret = create_hyp_io_mappings(vgic_vctrl_base,
>>                                    vgic_vctrl_base + resource_size(&vctrl_res),
>> --
>>
>> Thanks,
>> -Christoffer
>>
>
>
> --
> Jazz is not dead. It just smells funny...
>
