From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Nov 2017 17:34:08 +0000
Subject: [PATCH v2 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
In-Reply-To: <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
 <20171129164116.16167-16-christoffer.dall@linaro.org>
 <12137903-6f11-6350-6344-30e3bc6542e3@redhat.com>
Message-ID: <CAMJs5B-JWrHrCyO6zNC8z34uiMrhNk6RaQCTKRB27Mki+XhpFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 5:30 PM, David Hildenbrand <david@redhat.com> wrote:
>
>> +++ b/virt/kvm/arm/arm.c
>> @@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
>>  int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
>>                                   struct kvm_mp_state *mp_state)
>>  {
>> -     vcpu_load(vcpu);
>> -
>>       if (vcpu->arch.power_off)
>>               mp_state->mp_state = KVM_MP_STATE_STOPPED;
>>       else
>>               mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
>>
>> -     vcpu_put(vcpu);
>>       return 0;
>>  }
>
> Okay, this also makes sense on other architectures. The important thing
> is only that we hold the vcpu mutex.
>
Yes, but as Paolo said, it's better if architecture maintainers do
that themselves.  The risk of me messing things up is way too high
otherwise.

Thanks,
-Christoffer
