From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 25 Jan 2011 17:33:14 +0000
Subject: [PATCH 03/14] ARM: v6k: remove CPU_32v6K dependencies in
	asm/spinlock.h
In-Reply-To: <20110125165919.GD17286@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 4:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 25, 2011 at 04:43:52PM +0000, Dave Martin wrote:
>> A couple of questions on this:
>>
>> 1) I notice these spinlock functions are generally marked inline.
>>
>> Is that likely to happen in modules? ?If so, there would be a need to
>> do SMP_ON_UP fixups at module load time -- I don't think that's
>> currently implemented.
>
> No one should be using the arch_* spinlocks directly. ?The spinlocks
> are implemented in out of line code in kernel/spinlock.c

OK--- do think this is something we need a sanity-check for, or does
this fall into to a category of bad driver implementation which will
get thrown out during peer review?

>
>> 2) When building with this patch and CONFIG_SMP_ON_UP=y, I've seen
>> vmlinux link errors like this:
>>
>> ? LD ? ? ?.tmp_vmlinux1
>> `.exit.text' referenced in section `.alt.smp.init' of
>> drivers/built-in.o: defined in discarded section `.exit.text' of
>> drivers/built-in.o
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> I don't know whether this is caused by the patch directly or as a
>> side-effect -- I've only noticed it in the linaro-2.6.37 tree so far.
>> git bisect indentified this above patch as the first one with the
>> error in that case.
>>
>> I don't understand the section discarding logic too well, so I'm not
>> sure how to fix it for now...
>
> Hmm. ?I don't see how that could happen, unless some driver is going
> behind the spinlock APIs, or using our dsb_sev() directly.
>
> I think you need to first track down what's responsible for inserting
> architecture spinlock code into drivers.
>

OK, I'll try and do a bit more digging.  I think I have a better idea
of what to look for now, anyhow.

Cheers
---Dave
