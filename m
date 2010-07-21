From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 21 Jul 2010 01:33:14 +0100
Subject: [PATCH 0/4] ARM: S5PV210: Clock Framework: powerdomain,
	block-gating, flags
In-Reply-To: <AANLkTinUO548kSoDSII3ry8KZQFpUtXvgTooz40d6o7D@mail.gmail.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>	<006401cb27a7$90122100$b0366300$%kim@samsung.com>
	<AANLkTinUO548kSoDSII3ry8KZQFpUtXvgTooz40d6o7D@mail.gmail.com>
Message-ID: <4C46404A.4030500@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/10 04:05, MyungJoo Ham wrote:
> On Tue, Jul 20, 2010 at 10:04 AM, Kukjin Kim<kgene.kim@samsung.com>  wrote:
>> MyungJoo Ham wrote:
>>>
>>> This patches add support for powerdomain, block-gating, and flags in
>> struct clk.
>>>
>>> Blockgating re-uses powerdomain support scheme and depends on powerdomain
>>> support.
>>>
>>> Flags support is independent from powerdomain; however, powerdomain
>> support
>>> is NOT stable without flags support. Without flags support, powerdomain
>> may lock
>>> up the system with some conditions although they are rare. Thus, when
>>> powerdomain or block-gating is used, flags support should be turned on for
>> the
>>> system stability. (and that's why I'm sending flags support with
>>> powerdomain/block-gating support).
>>>
>>> Although powerdomain support is requred for blockgating, blockgating is
>> NOT
>>> required for powerdomain. Besides, powerdomain support is observed to
>> reduce
>>> power consumption significantly (with 2.6.29 kernel); however, blockgating
>> support
>>> didn't show any significant improvement.
>>>
>>>
>>> MyungJoo Ham (4):
>>>    ARM: SAMSUNG SoC: Powerdomain/Block-gating Support
>>>    ARM: S5PV210: Powerdomain/Clock-gating Support
>>>    ARM: SAMSUNG SoC: Clock Framework: Flag Support for struct clk.
>>>    ARM: S5PV210: Clock Framework: Flag Support for struct clk.
>>>
>>>   arch/arm/mach-s5pv210/Kconfig              |   17 +
>>>   arch/arm/mach-s5pv210/clock.c              |  906
>>> ++++++++++++++++++++++------
>>>   arch/arm/plat-samsung/Kconfig              |   19 +
>>>   arch/arm/plat-samsung/clock.c              |  146 +++++-
>>>   arch/arm/plat-samsung/include/plat/clock.h |   44 ++
>>>   5 files changed, 935 insertions(+), 197 deletions(-)
>>
>> Already we discussed about power domain...
>> And actually your code is similar with my member's 2.6.29 powerdomain
>> scheme.
>> So Ben's code review about that is available to your this patch.
>>
>> Following is from Ben Dooks note.
>>
>> ===

My powers of psychic prediction are legendary now :0)

>> Powerdomain control notes
>> =========================
>>
>> Copyright 2010 Simtec Electronics
>> Ben Dooks<ben@simtec.co.uk>
>>
>> Code Review
>> -----------
>>
>> The current implementation makes a number of #ifdef based additions to
>> the clock.c which currently lies in plat-s3c/clock.c (but to be moved
>> to plat-samsung/clock.c). The following are the observations from reviewing
>> the code as presented:
>>
>> 1) The use of #ifdef is not recommended, as noted before in reviews it
>>    makes the code hard to read, allows bugs to creep in due to code
>>    either being skipped, and problems when we get to the stage several
>>    conflicting configurations could live in the kernel.
>
> I've been using #ifdef's for enabling/disabling powerdomain and
> blockgating control (especially for machines that do not have support
> for powerdomain/blockgating). However, it seems to be reasonable that
> the #ifdef's are not needed and to be removed.
>
>>
>> 2) The code is changing the functionality of the clk_enable() and the
>>    clk_disable() calls, which is bad for the following reasons:
>>
>>    A) Anyone reading or modifying a driver using this API may not see
>>       what is going on underneath.
>>
>>    B) It ties the clock to the powerdomain, if any of the current drivers
>>       wish to temporarily stop the clock to reduce the dynamic power
>>       consumption they cannot (see part A, if all drivers are resting
>>       in the power domain the whole domain may shutdown with a resulting
>>       cost to the work resumption).
>>
>>    C) It ties the drivers to the specific clock implementation and thus
>>       restricts future use of standard drivers on future devices.
>>
>>    D) It ties policy into the kernel, as it forces the power domains to
>>       shut down if the driver is not in use. The developer or end user
>>       may want to change this depending on either a device wide or usage
>>       case. Policy decisions are best left out of the kernel.
>>
>
> Um... yes, putting powerdomain/blockgating code at clk_* code is too
> invasive to the clk_* code. And it'd be more problematic if we move on
> to the common struct clk.

As a note, you could add virtual clocks, one per power domain which
have their enable function point into the power domain code. This
should be called each time the clock is enabled/disabled and thus
allows easier integration that the current method. It should also
avoid a pile of #ifdefs.

> I'll implement powerdomain/blockgating control code
>   at arch/arm/mach-s5pv210/clock.c:s5pv210_clk_*_ctrl.
>
> For B) and D), we may need to leave an option not to control
> powerdomain. How about leaving an option at sysfs if not using
> #ifdef's?

I'd like to see something more generic, however this approach has
its own merits. The plus side is it'll save power, the down sides
are as follows:

1) Drivers are now losing their clock _and_ power, really the driver
    should be quiesced by runtime-pm otherwise we end up relying on
    the lower level behaviour of the clock system (undocumented) and
    having drivers have to restore settings when they do clk_enable()

    This is fine for Samsung specific drivers, but is going to be really
    bad for everyone else.

2) Some devices, such as the SDHCI need clocks after the operation has
    finished to allow cards to complete

3) How much time is spent taking the power domains up/down? Is this time
    we could be usefully using to actually do work for the user?

The big one here is #1.

I would much prefer to see some framework which controls when devices
are going to be scheduled so that they can be put to sleep when it is
unlikely they're going to be used, and the system's performance can be
controlled (ie, if the device is in hard-use, such as decoding video
it is probably unlikely we'll want to shutdown the data source at-all)
another example would be if the device is idling, it would be very
permissible to shut things down when they are not in use as the system
does not need a lot of performance at that point.

I've suggested hooking power-domain support into the regulator framework
but Mark's pointed out some problems there. it may be worth using the
regulator framework as a low-level system so that regulators can be
chained off (ie, control external ldos/switches/etc).

I'd be happier to see something where the device drivers use runtime pm
(possibly with the regulator framework) to allow the user to stop the
system. We could also look at device in-use doing auto runtime-pm to
say open => resume, and close => suspend.

>> Part (1) is a definite barrier to merging, the code whilst functional is
>> both ugly and the use of #ifdefs like that are contrary to a number of
>> developers beliefs.
>>
>> The second part is also a stumbling block, as it is likely to be commented
>> upon by a number of interested parties if it did come up for review. I am
>> certainly not happy to see this sort of invasive change to the clock system
>> merged. I expect others would also raise objections.
>>
>> ...
>>
>> ===
>>
>> So need to another approach for it.

It certainly needs a pile of work before we can think about it.

>> Thanks.
>>
>> Best regards,
>> Kgene.
>> --
>> Kukjin Kim<kgene.kim@samsung.com>, Senior Engineer,
>> SW Solution Development Team, Samsung Electronics Co., Ltd.


-- 
Ben Dooks, Design & Software Engineer, Simtec Electronics

http://www.simtec.co.uk/
