From: james.morse@arm.com (James Morse)
Date: Thu, 19 Jul 2018 15:15:20 +0100
Subject: [PATCH v8 1/4] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
In-Reply-To: <49bb119c-ec31-34ee-f4e5-9f3e90d7c181@huawei.com>
References: <20180713154751.18131-1-james.morse@arm.com>
 <20180713154751.18131-2-james.morse@arm.com>
 <CAFEAcA-t8U-GmkCtAcAN8tj4UAaynCZhgTi1Cg1RhaarGUOJfg@mail.gmail.com>
 <49bb119c-ec31-34ee-f4e5-9f3e90d7c181@huawei.com>
Message-ID: <a840714a-16b3-2da8-c6e2-5be85c73bda2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 19/07/18 08:39, gengdongjiu wrote:
> On 2018/7/18 0:33, Peter Maydell wrote:
>> On 13 July 2018 at 16:47, James Morse <james.morse@arm.com> wrote:
>>> From: Dongjiu Geng <gengdongjiu@huawei.com>
>>>
>>> For the migrating VMs, user space may need to know the exception
>>> state. For example, in the machine A, KVM make an SError pending,
>>> when migrate to B, KVM also needs to pend an SError.
>>>
>>> This new IOCTL exports user-invisible states related to SError.
>>> Together with appropriate user space changes, user space can get/set
>>> the SError exception state to do migrate/snapshot/suspend.

>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>>> index d10944e619d3..e3940f8715a5 100644
>>> --- a/Documentation/virtual/kvm/api.txt
>>> +++ b/Documentation/virtual/kvm/api.txt


>>> +Gets currently pending SError exceptions as well as related states of the vcpu.
>>
>> Any chance of expanding this to explain what this state actually is?
>> (ie something you could use to implement or review the userspace
>> code which has to manipulate it)
> sure, can expand it.
> 
> serror_pending means whether KVM is pending Serror for guest.
> serror_has_esr means whether KVM or user space can set the SError syndrome for guest.
> serror_esr means the value of SError syndrome.

I've had a go at something more verbose for this section:
------------------%<------------------
If the guest accesses a device that is being emulated by the host kernel in such
a way that a real device would generate a physical SError, KVM may make a
virtual SError pending for that VCPU. This system error interrupt remains
pending until the guest takes the exception by unmasking PSTATE.A.

Running the VCPU may cause it to take a pending SError, or make an access that
causes an SError to become pending. The event's description is only valid while
the VPCU is not running.

This API provides a way to read and write the pending 'event' state that is not
visible to the guest. To save, restore or migrate a VCPU the struct representing
the state can be read then written using this GET/SET API, along with the other
guest-visible registers. It is not possible to 'cancel' an SError that has been
made pending.

A device being emulated in user-space may also wish to generate an SError. To do
this the events structure can be populated by user-space. The current state
should be read first, to ensure no existing SError is pending. If an existing
SError is pending, the architectures 'Multiple SError interrupts' rules should
be followed. (2.5.3 of DDI0587.a "ARM Reliability, Availability, and
Serviceability (RAS) Specification").
------------------%<------------------


Thanks,

James
