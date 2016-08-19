From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Aug 2016 14:05:49 +0100
Subject: [PATCH 5/5] arm64: KVM: vgic-v2: Enable GICV access from HYP if
 access from guest is unsafe
In-Reply-To: <CAFEAcA99RScdr+E39Q+03L5DyDLiQgQo9x1DeP1gE2-nJ1yUig@mail.gmail.com>
References: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
 <1471610295-1456-6-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA99RScdr+E39Q+03L5DyDLiQgQo9x1DeP1gE2-nJ1yUig@mail.gmail.com>
Message-ID: <57B7042D.1020702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 19/08/16 13:53, Peter Maydell wrote:
> On 19 August 2016 at 13:38, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> So far, we've been disabling KVM on systems where the GICV region couldn't
>> be safely given to a guest. Now that we're able to handle this access
>> safely by emulating it in HYP, we can enable this feature when we detect
>> an unsafe configuration.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  virt/kvm/arm/vgic/vgic-v2.c | 69 +++++++++++++++++++++++++++------------------
>>  1 file changed, 42 insertions(+), 27 deletions(-)
>>
>> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
>> index b8da901..d1dcfc76 100644
>> --- a/virt/kvm/arm/vgic/vgic-v2.c
>> +++ b/virt/kvm/arm/vgic/vgic-v2.c
>> @@ -278,12 +278,14 @@ int vgic_v2_map_resources(struct kvm *kvm)
>>                 goto out;
>>         }
>>
>> -       ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
>> -                                   kvm_vgic_global_state.vcpu_base,
>> -                                   KVM_VGIC_V2_CPU_SIZE, true);
>> -       if (ret) {
>> -               kvm_err("Unable to remap VGIC CPU to VCPU\n");
>> -               goto out;
>> +       if (!static_branch_unlikely(&vgic_v2_cpuif_trap)) {
>> +               ret = kvm_phys_addr_ioremap(kvm, dist->vgic_cpu_base,
>> +                                           kvm_vgic_global_state.vcpu_base,
>> +                                           KVM_VGIC_V2_CPU_SIZE, true);
>> +               if (ret) {
>> +                       kvm_err("Unable to remap VGIC CPU to VCPU\n");
>> +                       goto out;
>> +               }
>>         }
>>
>>         dist->ready = true;
>> @@ -312,45 +314,51 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
>>                 return -ENXIO;
>>         }
>>
>> -       if (!PAGE_ALIGNED(info->vcpu.start)) {
>> -               kvm_err("GICV physical address 0x%llx not page aligned\n",
>> -                       (unsigned long long)info->vcpu.start);
>> -               return -ENXIO;
>> -       }
>> +       if (!PAGE_ALIGNED(info->vcpu.start) ||
>> +           !PAGE_ALIGNED(resource_size(&info->vcpu))) {
>> +               kvm_info("GICV region size/alignement is unsafe, using trapping\n");
> 
> "alignment".

Ah, thanks. There's always a bit of French being stuck somewhere... ;-)

> 
> Is it worth specifically saying "performance will be worse", or do we
> expect this to only happen on systems where the h/w can't permit direct
> access (as opposed to those with bad dt info) ?

We cannot distinguish between the two, unfortunately. Even worse, ACPI
only gives us a base address, and not the size of the region. So even if
the HW was perfectly compliant with SBSA, we have to assume the worse case.

I guess that a slightly more alarming message is in order indeed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
