From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Tue, 13 Nov 2012 08:35:01 -0500
Subject: [PATCH v4 05/13] ARM: KVM: VGIC accept vcpu and dist base
 addresses from user space
In-Reply-To: <20121112085650.GB29502@b29396-Latitude-E6410>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154451.3061.74235.stgit@chazy-air>
 <20121112085650.GB29502@b29396-Latitude-E6410>
Message-ID: <CANM98qJ++rbV6ui6_a94GxZY5sbCnziKHO6DTFkk3cr+P+=Pjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 3:56 AM, Dong Aisheng <b29396@freescale.com> wrote:
> On Sat, Nov 10, 2012 at 04:44:51PM +0100, Christoffer Dall wrote:
> [...]
>> +int kvm_vgic_set_addr(struct kvm *kvm, unsigned long type, u64 addr)
>> +{
>> +     int r = 0;
>> +     struct vgic_dist *vgic = &kvm->arch.vgic;
>> +
>> +     if (addr & ~KVM_PHYS_MASK)
>> +             return -E2BIG;
>> +
>> +     if (addr & ~PAGE_MASK)
>> +             return -EINVAL;
>> +
>> +     mutex_lock(&kvm->lock);
>> +     switch (type) {
>> +     case KVM_VGIC_V2_ADDR_TYPE_DIST:
>> +             if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_dist_base))
>> +                     return -EEXIST;
>> +             if (addr + VGIC_DIST_SIZE < addr)
>> +                     return -EINVAL;
>> +             kvm->arch.vgic.vgic_dist_base = addr;
>> +             break;
>> +     case KVM_VGIC_V2_ADDR_TYPE_CPU:
>> +             if (!IS_VGIC_ADDR_UNDEF(vgic->vgic_cpu_base))
>> +                     return -EEXIST;
>> +             if (addr + VGIC_CPU_SIZE < addr)
>> +                     return -EINVAL;
>> +             kvm->arch.vgic.vgic_cpu_base = addr;
>> +             break;
>> +     default:
>> +             r = -ENODEV;
>> +     }
>> +
>> +     if (vgic_ioaddr_overlap(kvm)) {
>> +             kvm->arch.vgic.vgic_dist_base = VGIC_ADDR_UNDEF;
>> +             kvm->arch.vgic.vgic_cpu_base = VGIC_ADDR_UNDEF;
>
> Missing mutex_unlock?

indeed, should be r = -EINVAL.

nice catch!
