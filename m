From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Jun 2018 12:40:05 +0100
Subject: [PATCH 1/2] KVM: Enforce error in ioctl for compat tasks when
 !KVM_COMPAT
In-Reply-To: <22acc63b-8737-39b4-d4d4-87927a49fa8c@de.ibm.com>
References: <20180619094251.8586-1-marc.zyngier@arm.com>
 <20180619094251.8586-2-marc.zyngier@arm.com>
 <20180619100134.4loab4jtnfdzrpxu@lakrids.cambridge.arm.com>
 <8e4d21bf-d30f-ac66-3017-2badf6a29ec5@arm.com>
 <22acc63b-8737-39b4-d4d4-87927a49fa8c@de.ibm.com>
Message-ID: <f4f2dcd6-9ef7-f7fa-8ec4-f320d4a649ac@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/06/18 12:24, Christian Borntraeger wrote:
> 
> 
> On 06/19/2018 12:10 PM, Marc Zyngier wrote:
>> On 19/06/18 11:01, Mark Rutland wrote:
>>> On Tue, Jun 19, 2018 at 10:42:50AM +0100, Marc Zyngier wrote:
>>>> The current behaviour of the compat ioctls is a bit odd.
>>>> We provide a compat_ioctl method when KVM_COMPAT is set, and NULL
>>>> otherwise. But NULL means that the normal, non-compat ioctl should
>>>> be used directly for compat tasks, and there is no way to actually
>>>> prevent a compat task from issueing KVM ioctls.
>>>>
>>>> This patch changes this behaviour, by always registering a compat_ioctl
>>>> method, even if KVM_COMPAT is not selected. In that case, the callback
>>>> will always return -EINVAL.
>>>>
>>>> Reported-by: Mark Rutland <mark.rutland@arm.com>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> I virt/kvm/Kconfig we have:
>>>
>>> config KVM_COMPAT
>>>        def_bool y
>>>        depends on KVM && COMPAT && !S390
>>>
>>> ... and in arch/s390 we have COMPAT support, so does this potentially break
>>> anything there?
>>
>> It doesn't seem to (COMPAT seems to support the 31 bit stuff, which I
>> don't think ever had KVM support), but my s390-foo is quite basic.
>>
>> Christian, could you help here?
> 
> We do not support KVM for 31 bit. So the original goal of the KVM_COMPAT stuff
> was to actually disable the compat thing for the KVM device driver. 
> 
> See
> 
> commit de8e5d744051568c8aad ("KVM: Disable compat ioctl for s390").
> 
> Now looking back, this patch actually only disabled the compat wrappers and
> still allows an 31bit process to run the 64bit ioctls. In theory this should
> cause no issues as the 64bit ioctl must fence off all invalid input anyway
> but actually forbidding KVM for compat processes is even better.
> 
> 
> 
> So I think this patch actually is a good thing.
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> if you want you could even add a
> Fixes: tag.

Added, thanks.

Radim, Paolo: are you happy with me taking this through the kvmarm tree?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
