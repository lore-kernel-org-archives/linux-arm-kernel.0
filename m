From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 21 Nov 2017 12:12:58 +0000
Subject: [PATCH v3 0/3] KVM: arm64: single step emulation instructions
In-Reply-To: <20171120154131.GO28855@cbox>
References: <20171116153921.21991-1-alex.bennee@linaro.org>
 <20171120154131.GO28855@cbox>
Message-ID: <874lpnygmt.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Christoffer Dall <cdall@linaro.org> writes:

> Hi Alex,
>
> On Thu, Nov 16, 2017 at 03:39:18PM +0000, Alex Benn?e wrote:
>> Hi,
>>
>> This is rev 3 of the series, practically the same than rev 2 but fixed
>> a return 1->0 in the kvm_run loop that Julien caught. I've added his
>> r-b tags to the other patches.
>>
>> As usual revision details bellow the --- in each patch.
>
> Thanks for taking care of this.
>
> I have applied the series and slightly tweaked the commit messages and
> commentary.
>
> Did we simply decide to not worry about exiting to userspace if we do
> fast-path emulation, such as for the errata workaround and GIC
> mashaling in switch.c ?

Hmm I'd forgotten about that - I figured it was all in handle_exit or
passed to userspace. So I guess in-hyp emulation is a 3rd class of
instruction emulation?

Which particular interface cases are we covering here?

I suspect if these are regions that are only accessed once the system is
up and running we are going to run into problems due to single stepping
while IRQs are enabled. But conceptually we just need to do the same
flag check after __skip_instr has done before deciding to fall out the
loop or goto again;

We would have to fake up HSR so handle_exit did the right thing on the
way out though. That seems a little icky....

>
> Thanks,
> -Christoffer
>
>>
>> Alex Benn?e (3):
>>   kvm: arm debug: introduce helper for single-step
>>   kvm: arm64: handle single-stepping trapped instructions
>>   kvm: arm64: handle single-step of userspace mmio instructions
>>
>>  arch/arm/include/asm/kvm_host.h   |  5 +++++
>>  arch/arm64/include/asm/kvm_host.h |  1 +
>>  arch/arm64/kvm/debug.c            | 22 ++++++++++++++++++
>>  arch/arm64/kvm/handle_exit.c      | 47 +++++++++++++++++++++++++++------------
>>  virt/kvm/arm/arm.c                |  3 +++
>>  5 files changed, 64 insertions(+), 14 deletions(-)
>>
>> --
>> 2.15.0
>>


--
Alex Benn?e
