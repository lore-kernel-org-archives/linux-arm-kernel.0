From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Fri, 06 Jul 2018 10:20:04 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <20180706090534.GD26019@e103592.cambridge.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <87h8lc93jc.fsf@linaro.org>
 <20180706090534.GD26019@e103592.cambridge.arm.com>
Message-ID: <87d0w090vv.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> On Fri, Jul 06, 2018 at 09:22:47AM +0100, Alex Benn?e wrote:
>>
>> Dave Martin <Dave.Martin@arm.com> writes:
>>
>> <snip>
>> >
>> > This series is somewhat tested on Arm Juno r0 and the Arm Fast Model
>> > (with/without SVE support).  arch/arm builds, but I've not booted
>> > it -- only some trivial refactoring in this series affects arch/arm.
>>
>> Now that QEMU linux-user SVE support is pretty much complete we've also
>> got preliminary patches for system emulation mode. However we currently
>> don't have VHE implemented so I guess we need to do that first before we
>> can test under QEMU.
>
> Qemu can use this as a KVM client without invasive changes, right?

Yeah for KVM use there aren't really any changes.

> For kvmtool, it's just a question of checking/setting a feature flag
> in KVM_ARM_PREFERRED_TARGET and KVM_ARM_VCPU_INIT, and (eventually)
> doing at ioctl() to set the set of permitted vector lengths (not yet,
> this will come in a follow-up series).

For the most part in QEMU with KVM we just treat the list of registers
we get from the OS as an opaque blob of things we save to memory and
pass back.

The CPU features code will probably need a bit of tweaking but it will
be minor. I'm not sure what the current status of cross-host CPU
migration is at the moment - that was mostly Christopher's headache to
track ;-)

For things like gdbstub we need to add additional handling. I suspect as
we currently don't explicitly handle the SVE registers they won't show
up - I believe there are protocol updates for better handling these
registers coming.

I think migration should work out of the box but I'd need to double
check. Certainly its a strong argument for getting VHE done in TCG mode
as we can exercise a lot of the common code.

>
> Cheers
> ---Dave


--
Alex Benn?e
