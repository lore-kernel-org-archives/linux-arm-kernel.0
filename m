From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 6 Jul 2015 11:05:26 +0100
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <20150706093026.GA11590@cbox>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com> <5596503E.6040902@arm.com>
 <00fd01d0b7b6$f6cf3550$e46d9ff0$@samsung.com> <559A3C9C.6050302@arm.com>
 <20150706093026.GA11590@cbox>
Message-ID: <559A52E6.5050402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/07/15 10:30, Christoffer Dall wrote:
> On Mon, Jul 06, 2015 at 09:30:20AM +0100, Andre Przywara wrote:
>> Hi Pavel,
>>
>> On 06/07/15 07:42, Pavel Fedin wrote:
>>>  Hello!
>>>
>>>> I like this approach, but it runs into problems:
>>>> As you read above the current documentation says that the flags field
>>>> must be zero and the current KVM_SET_GSI_ROUTING handler bails out if it
>>>> isn't. So userland would need to know whether it's safe to set that
>>>> field.
>>>
>>>  This problem does not exist because:
>>> a) Older platforms do not need this flag, so they expect to get zero.
>>> b) ARM64 + GICv3 platform cannot work without this flag.
>>>
>>>  This is perfectly OK combination IMO. Userland just knows, whether it needs to supply device ID or
>>> not. For example, my modified qemu now has kvm_msi_flags global variable which defaults to 0. ITS
>>> code, then, if activated, changes it to KVM_MSI_VALID_DEVID, and qemu starts supplying device IDs to
>>> the related calls.
>>
>> Well, I had this solution before in kvmtool: If ARM && ITS then set the
>> flag. But I wasn't really happy with this, as the IRQ routing, setup and
>> injection code is rather architecture agnostic (implementing the generic
>> KVM interface), so spraying in some architecture hacks sounded not very
>> elegant.
>> Also as the flag describes a rather generic feature (provide an unique
>> device ID), I'd rather avoid to make this an ARM hack.
>>
>> That being said this is not a show stopper for me, so if the others are
>> happy with this, I will go down your road.
>>
> There must be some way for userspace to discover if it's valid to set
> the flag or not; either through a well-defined error-code probing
> mechanism for KVM_SET_GSI_ROUTING or through advertising a capability.

Right, makes sense, I was wondering about this requirement earlier, but
couldn't find really good prior art in the code (KVM_GET_VCPU_EVENTS
seems to be bad example).
So I think we get along with a new VM specific capability like
KVM_CAP_MSIS_REQUIRE_DEVID. This isn't strictly a "capability" (as it's
more a requirement), but I guess it fits here anyway. It has to be
per-VM, as a GICv2M guest does not need it, but an ITS guest does.
We can use this very flag for both the KVM_SIGNAL_MSI and the
KVM_SET_GSI_ROUTING ioctl, so interface churn is kept minimal.

Does that make sense?

Actually I have implemented this already last week, I will send it out
along with a v2 of the ITS emulation later this week.

Cheers,
Andre.
