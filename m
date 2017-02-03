From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 3 Feb 2017 14:51:48 +0000
Subject: [RFC 01/13] KVM: arm/arm64: Add vITS save/restore API
 documentation
In-Reply-To: <CAFEAcA98mFM=iNs2n=F9d4suV7+mjPJRjZfiYagX5y7HiPgMnw@mail.gmail.com>
References: <1484236613-24633-1-git-send-email-eric.auger@redhat.com>
 <1484236613-24633-2-git-send-email-eric.auger@redhat.com>
 <CAFEAcA98mFM=iNs2n=F9d4suV7+mjPJRjZfiYagX5y7HiPgMnw@mail.gmail.com>
Message-ID: <a1517c30-bad7-c587-167b-534ef15ab658@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/17 14:00, Peter Maydell wrote:
> On 12 January 2017 at 15:56, Eric Auger <eric.auger@redhat.com> wrote:
>> Add description for how to access vITS registers and how to flush/restore
>> vITS tables into/from memory
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  Documentation/virtual/kvm/devices/arm-vgic-its.txt | 70 ++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> index 6081a5b..bd74613 100644
>> --- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> +++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
>> @@ -36,3 +36,73 @@ Groups:
>>      -ENXIO:  ITS not properly configured as required prior to setting
>>               this attribute
>>      -ENOMEM: Memory shortage when allocating ITS internal data
>> +
>> +  KVM_DEV_ARM_VGIC_GRP_ITS_REGS
>> +  Attributes:
>> +      The attr field of kvm_device_attr encodes the offset of the
>> +      ITS register, relative to the ITS control frame base address
>> +      (ITS_base).
>> +
>> +      kvm_device_attr.addr points to a __u64 value whatever the width
>> +      of the addressed register (32/64 bits).
>> +
>> +      Writes to read-only registers are ignored by the kernel except
>> +      for a single register, GITS_READR. Normally this register is RO
>> +      but it needs to be restored otherwise commands in the queue will
>> +      be re-executed after CWRITER setting.
> 
> Dumb question -- is it possible/sensible to process the command
> queue rather than migrating a list of outstanding commands?

It is not always possible, specially if the ITS implements the "stall"
mechanism, where it waits for SW acknowledgement in case of a command error.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
