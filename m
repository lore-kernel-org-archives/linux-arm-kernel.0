From: andre.przywara@linaro.org (Andre Przywara)
Date: Tue, 14 May 2013 00:23:15 +0200
Subject: [PATCH v2] ARM: KVM: prevent NULL pointer dereferences with KVM
 VCPU ioctl
In-Reply-To: <20130513055253.GC64337@ubuntu>
References: <1368052086-25059-1-git-send-email-andre.przywara@linaro.org>
 <20130513055253.GC64337@ubuntu>
Message-ID: <519167D3.4030600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 07:52 AM, Christoffer Dall wrote:
> On Thu, May 09, 2013 at 12:28:06AM +0200, Andre Przywara wrote:
>> Some ARM KVM VCPU ioctls require the vCPU to be properly initialized
>> with the KVM_ARM_VCPU_INIT ioctl before being used with further
>> requests. KVM_RUN checks whether this initialization has been
>> done, but other ioctls do not.
>> Namely KVM_GET_REG_LIST will dereference an array with index -1
>> without initialization and thus leads to a kernel oops.
>> Fix this by adding checks before executing the ioctl handlers.
>>
>> Changes from v1:
>>   * moved check into a static function with a meaningful name
>>
>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>> ---
>>   arch/arm/kvm/arm.c | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index c1fe498..b73b587 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -676,6 +676,15 @@ static void vcpu_pause(struct kvm_vcpu *vcpu)
>>   	wait_event_interruptible(*wq, !vcpu->arch.pause);
>>   }
>>
>> +/*
>> + * Some ioctls require initialization by KVM_ARM_VCPU_INIT first, check
>> + * this with this function
>> + */
>> +static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.target >= 0;
>> +}
>> +
>
> this should probably be a static inline in a header file instead, it's
> likely that it could be called from another file.

kvm_host.h looks like a natural candidate, but unfortunately struct 
kvm_vcpu is opaque here, so dereferencing it does not work without 
further changes which I do not deem to be justified. I used kvm_coproc.h 
instead, which is loosely related (KVM_[SG]ET_ONE_REG) and just simply 
works. If you don't think that's appropriate, just drop me a note. Patch 
follows in a separate mail.

Regards,
Andre.
