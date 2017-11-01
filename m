From: james.morse@arm.com (James Morse)
Date: Wed, 01 Nov 2017 15:23:50 +0000
Subject: [PATCH v4 00/21] SError rework + RAS&IESB for firmware first
 support
In-Reply-To: <20171031100829.GC5584@arm.com>
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171031063535.GA2166@lvm> <20171031100829.GC5584@arm.com>
Message-ID: <59F9E706.40503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 31/10/17 10:08, Will Deacon wrote:
> On Tue, Oct 31, 2017 at 07:35:35AM +0100, Christoffer Dall wrote:
>> On Thu, Oct 19, 2017 at 03:57:46PM +0100, James Morse wrote:
>>> The aim of this series is to enable IESB and add ESB-instructions to let us
>>> kick any pending RAS errors into firmware to be handled by firmware-first.
>>>
>>> Not all systems will have this firmware, so these RAS errors will become
>>> pending SErrors. We should take these as quickly as possible and avoid
>>> panic()ing for errors where we could have continued.
>>>
>>> This first part of this series reworks the DAIF masking so that SError is
>>> unmasked unless we are handling a debug exception.
>>>
>>> The last part provides the same minimal handling for SError that interrupt
>>> KVM. KVM is currently unable to handle SErrors during world-switch, unless
>>> they occur during a magic single-instruction window, it hyp-panics. I suspect
>>> this will be easier to fix once the VHE world-switch is further optimised.
>>>
>>> KVMs kvm_inject_vabt() needs updating for v8.2 as now we can specify an ESR,
>>> and all-zeros has a RAS meaning.
>>>
>>> KVM's existing 'impdef SError to the guest' behaviour probably needs revisiting.
>>> These are errors where we don't know what they mean, they may not be
>>> synchronised by ESB. Today we blame the guest.
>>> My half-baked suggestion would be to make a virtual SError pending, but then
>>> exit to user-space to give Qemu the change to quit (for virtual machines that
>>> don't generate SError), pend an SError with a new Qemu-specific ESR, or blindly
>>> continue and take KVMs default all-zeros impdef ESR.
>>
>> The KVM side of this series is looking pretty good.
>>
>> What are the merge plans for this?  I am fine if you will take this via
>> the arm64 tree with our acks from the KVM side.  Alternatively, I
>> suppose you can apply all the arm64 patches and provide us with a stable
>> branch for that?
> 
> I'll take a look this afternoon, but we haven't had a linux next release
> since the 18th so I'm starting to get nervous about conflicts if I end up
> pulling in new trees now.

Will's 'what about mixed RAS support' comment will take me a while to get to
fix, and I don't think I can test that before the end of the week.

Unless there is an rc8+linux-next I think this is too late, but I will split off
and repost the SError_rework bits as that seems uncontentious...


Thanks,

James
