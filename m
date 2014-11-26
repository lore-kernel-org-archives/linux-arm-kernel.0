From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 26 Nov 2014 15:03:14 +0000
Subject: [PATCH 3/7] KVM: arm: guest debug,
 add stub KVM_SET_GUEST_DEBUG ioctl
In-Reply-To: <20141126143855.GC3245@hawk.usersys.redhat.com>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-4-git-send-email-alex.bennee@linaro.org>
 <20141126143855.GC3245@hawk.usersys.redhat.com>
Message-ID: <87r3wqknrh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Andrew Jones <drjones@redhat.com> writes:

> On Tue, Nov 25, 2014 at 04:10:01PM +0000, Alex Benn?e wrote:
>> This commit adds a stub function to support the KVM_SET_GUEST_DEBUG
>> ioctl. Currently any operation flag will return EINVAL. Actual
>> functionality will be added with further patches.
>
> Technically the stub is already there, and you're extending it to
> start looking at control flags, but still not doing anything yet.

Sure we do:

>>  int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>  					struct kvm_guest_debug *dbg)
>>  {
>> -	return -EINVAL;
>> +	/* If it's not enabled clear all flags */
>> +	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
>> +		vcpu->guest_debug = 0;
>> +		return 0;
>> +	}

That's some class non-functionality right there ;-)

>> +	vcpu->guest_debug = dbg->control;
>> +	kvm_info("%s: guest_debug is 0x%lx\n", __func__, vcpu->guest_debug);
>> +
>> +	/* Single Step */
>> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
>> +		kvm_info("SS requested, not yet implemented\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Software Break Points */
>> +	if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP) {
>> +		kvm_info("SW BP support requested, not yet implemented\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Hardware assisted Break and Watch points */
>> +	if (vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP) {
>> +		kvm_info("HW BP support requested, not yet implemented\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>>  }
>
> I guess all the kvm_info's were useful for developing this patch series,
> but do we still need them?

They also served the very useful roll of stopping checkpatch.pl bitching
about my reluctance to remove braces from the if () { } clauses. However
I take your point. I can certainly remove the kvm_info() statements as
each bit of functionality is added while leaving this one to help when
someone is bisecting and confused.

-- 
Alex Benn?e
