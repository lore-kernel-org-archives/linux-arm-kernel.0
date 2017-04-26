From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 26 Apr 2017 10:26:24 +0200
Subject: [PATCH v5 02/22] KVM: arm/arm64: Add GICV3 pending table save API
 documentation
In-Reply-To: <CAFEAcA_0N9Jx5ym+=jjmxAzSaXPjt-m+gW1cq90of8Qhw3LOzg@mail.gmail.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-3-git-send-email-eric.auger@redhat.com>
 <CAFEAcA_0N9Jx5ym+=jjmxAzSaXPjt-m+gW1cq90of8Qhw3LOzg@mail.gmail.com>
Message-ID: <a5ab9181-8398-f62b-12f1-032961b12c28@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 25/04/2017 12:43, Peter Maydell wrote:
> On 14 April 2017 at 11:15, Eric Auger <eric.auger@redhat.com> wrote:
>> Add description for how to save GICV3 LPI pending bit into
>> guest RAM pending tables.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v5: creation
>> ---
>>  Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> index c1a2461..9293b45 100644
>> --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
>> @@ -167,11 +167,17 @@ Groups:
>>      KVM_DEV_ARM_VGIC_CTRL_INIT
>>        request the initialization of the VGIC, no additional parameter in
>>        kvm_device_attr.addr.
>> +    KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES
>> +      save all LPI pending bits into guest RAM pending tables.
>> +
>> +      The first kB of the pending table is not altered by this operation.
>>    Errors:
>>      -ENXIO: VGIC not properly configured as required prior to calling
>>       this attribute
>>      -ENODEV: no online VCPU
>>      -ENOMEM: memory shortage when allocating vgic internal data
>> +    -EFAULT: Invalid guest ram access
>> +    -EBUSY:  One or more VCPUS are running
>>
>>
>>    KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO
>> --
>> 2.5.5
> 
> When does the -EFAULT return happen? (if the guest points GITS_BASER<n>
> etc at invalid memory, presumably?)
Yes that's correct, when GICR_PENDBASER contains a bad GPA.
 How does the QEMU migration code
> handle this case? Failing migration because the guest has done something
> silly doesn't seem too palatable, but trying to avoid that could be
> more effort than an obscure corner case really merits.
The kvm_device_access will cause an abort() as for other errors returned
by kvm_device_ioctl().

Thanks

Eric
> 
> thanks
> -- PMM
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
