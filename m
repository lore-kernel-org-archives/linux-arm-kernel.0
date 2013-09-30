From: anup@brainfault.org (Anup Patel)
Date: Mon, 30 Sep 2013 09:43:38 +0530
Subject: [PATCH v4 4/4] KVM: Add documentation for KVM_ARM_PREFERRED_TARGET
 ioctl
In-Reply-To: <20130925201059.GE32311@cbox>
References: <1380101163-20028-1-git-send-email-anup.patel@linaro.org>
 <1380101163-20028-5-git-send-email-anup.patel@linaro.org>
 <20130925201059.GE32311@cbox>
Message-ID: <CAAhSdy3nFRQWWbsxrPH6NOgBWx-naAx2GoBbSHCO=NSkWYf2Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 1:40 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Wed, Sep 25, 2013 at 02:56:03PM +0530, Anup Patel wrote:
>> To implement CPU=Host we have added KVM_ARM_PREFERRED_TARGET
>> vm ioctl which provides information to user space required for
>> creating VCPU matching underlying Host.
>>
>> This patch adds info related to this new KVM_ARM_PREFERRED_TARGET
>> vm ioctl in the KVM API documentation.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  Documentation/virtual/kvm/api.txt |   27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 858aecf..f31e6e8 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2303,8 +2303,28 @@ Possible features:
>>       - KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>>         Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
>>
>> +4.83 KVM_ARM_PREFERRED_TARGET
>>
>> -4.83 KVM_GET_REG_LIST
>
> I think the convention here is to keep two new lines after a Section.

Well this is not be consistenly followed by everyone.
Please look at the api.txt again.

Anyways, I will change and keep two new lines after a Section.

>
>> +Capability: basic
>> +Architectures: arm, arm64
>> +Type: vm ioctl
>> +Parameters: struct struct kvm_vcpu_init (out)
>> +Returns: 0 on success; -1 on error
>> +Errors:
>> +  ENODEV:    no preferred target available for the host
>> +
>> +This queries KVM for preferred CPU target type which can be emulated
>> +by KVM on underlying host.
>> +
>> +The ioctl returns struct kvm_vcpu_init instance containing information
>> +about preferred CPU target type and target specific features available
>> +for it.
>> +
>> +The information returned by this ioctl can be used to prepare instance
>
> an instance

Ok.

>
>> +of struct kvm_vcpu_init for KVM_ARM_VCPU_INIT ioctl which will result
>
> the KVM_ARM_VCPU_INIT ioctl.
> (the last part is not necessarily true is it?  It's only a best bet,
> think for example about Big.Little...)
>
>> +in VCPU matching underlying host.
>
> You also need to add something about the features here:
>
> The kvm_vcpu_init->features bitmap will have feature bits set if the
> preferred target recommends setting these features, but this is not
> required.

Ok.

>
>> +
>> +4.84 KVM_GET_REG_LIST
>>
>>  Capability: basic
>>  Architectures: arm, arm64
>> @@ -2323,8 +2343,7 @@ struct kvm_reg_list {
>>  This ioctl returns the guest registers that are supported for the
>>  KVM_GET_ONE_REG/KVM_SET_ONE_REG calls.
>>
>> -
>> -4.84 KVM_ARM_SET_DEVICE_ADDR
>> +4.85 KVM_ARM_SET_DEVICE_ADDR
>>
>>  Capability: KVM_CAP_ARM_SET_DEVICE_ADDR
>>  Architectures: arm, arm64
>> @@ -2362,7 +2381,7 @@ must be called after calling KVM_CREATE_IRQCHIP, but before calling
>>  KVM_RUN on any of the VCPUs.  Calling this ioctl twice for any of the
>>  base addresses will return -EEXIST.
>>
>> -4.85 KVM_PPC_RTAS_DEFINE_TOKEN
>> +4.86 KVM_PPC_RTAS_DEFINE_TOKEN
>>
>>  Capability: KVM_CAP_PPC_RTAS
>>  Architectures: ppc
>> --
>> 1.7.9.5
>>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--Anup
