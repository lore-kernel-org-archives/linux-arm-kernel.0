From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Sep 2011 13:51:46 -0700
Subject: [PATCH v2 2/5] cpu_pm: call notifiers during suspend
In-Reply-To: <CAMbhsRQvft4dqhAc4j_bXDR8018zeoSRXuWC6bS-d8rA0PgOyA@mail.gmail.com>
	(Colin Cross's message of "Thu, 8 Sep 2011 11:04:26 -0700")
References: <1315060755-4613-1-git-send-email-santosh.shilimkar@ti.com>
	<1315060755-4613-3-git-send-email-santosh.shilimkar@ti.com>
	<87k49knmrw.fsf@ti.com> <4E684F90.7010809@ti.com>
	<87wrdjku9h.fsf@ti.com>
	<CAMbhsRQvft4dqhAc4j_bXDR8018zeoSRXuWC6bS-d8rA0PgOyA@mail.gmail.com>
Message-ID: <87ehzqbvvh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross <ccross@android.com> writes:

> On Thu, Sep 8, 2011 at 7:01 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Santosh <santosh.shilimkar@ti.com> writes:
>>
>>> On Thursday 08 September 2011 01:32 AM, Kevin Hilman wrote:
>>>> Santosh Shilimkar<santosh.shilimkar@ti.com> ?writes:
>>>>
>>>>> From: Colin Cross<ccross@android.com>
>>>>>
>>>>> Implements syscore_ops in cpu_pm to call the cpu and
>>>>> cpu cluster notifiers during suspend and resume,
>>>>> allowing drivers receiving the notifications to
>>>>> avoid implementing syscore_ops.
>>>>>
>>>>> Signed-off-by: Colin Cross<ccross@android.com>
>>>>> [santosh.shilimkar at ti.com: Rebased against 3.1-rc4]
>>>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>>>
>>>> I don't think using syscore_ops is right here. ?The platform code should
>>>> decide where in its own suspend path the notifiers should be triggered.
>>>>
>>>> The reason is because while the syscore_ops run late in the suspend
>>>> path, they still run before some platform-specific decisions about the
>>>> low-power states are made. ?That means that any notifiers that need to
>>>> use information about the target low-power state (e.g. whether context
>>>> will be lost or not) cannot do so since that information has not yet
>>>> been decided until the platform_suspend_ops->enter() runs.
>>>>
>>> Initially I thought the same but in general S2R, platform doesn't
>>> support multiple states like CPUIDLE. On OMAP, we do have a debug
>>> option to choose the state but on real product, it's always the
>>> deepest supported state is used. So the driver saving the
>>> full context for S2R, should be fine.
>>>
>>> Ofcourse for CPUIDLE, the notifier call chain decisions are left
>>> with platform CPUIDLE drivers since there can be multiple low
>>> power states and the context save/restore has to be done based
>>> on low power states.
>>>
>>> The advantage with this is, the platform code is clean from the
>>> notfiers calls. CPUIDLE driver needs to call the different notifier
>>> events based on C-states and that perfectly works.
>>>
>>> I liked this simplification for the S2R. Down side is in S2R if you
>>> don't plan to hit deepest state, drivers end up saving full context
>>> which is fine I guess.
>>
>> That's not the downside I'm worried about.
>>
>> If you have a driver that has a notifier, presumably it has something it
>> wants to do to prepare for suspend *and* for idle, and you'd only want a
>> single notifier callback in the driver to be used for both. ?That
>> callback would look something like:
>>
>> ? start_preparing_for_suspend();
>>
>> ? if (next_state == OFF)
>> ? ? ?save_context();
>>
>> ? finish_preparing_for_suspend();
>>
>>
>> The problem with the current cpu_*_pm_enter() calls in syscore_ops is
>> that they happen before the next states are programmed, so during
>> suspend the 'if (next_state == off)' above would never be true, but
>> during idle it might be.
>
> These notifiers are designed for drivers that are tightly coupled to
> the cpu, and shared across multiple architectures (mostly GIC and
> VFP).  

That is certainly the initial intended usage, and I understand that
design, but they are useful for much more.

Specifically, consider devices whose power transitions need to be
tightly coupled with the CPU, but are in different power domains.
Notifiers for these devices may need to be coordinated with
platform-specific events.

Also, it's not only about context save for off-mode.  Some of these
tightly-coupled devices have other work to do besides context
save/restore, and CPU PM notifiers are useful there.  A dumb example off
the top of my head: pins (e.g. GPIOs), that need to be mux'd into safe
mode to avoid glitches when coming back from off.  (admittedly, this is
broken HW, but we all know broken HW is part of life.)

> In practice, all of these devices are off in every suspend
> state, because nobody leaves the CPU on in suspend.

Sure, but you might leave other power domains on (or in retention)
during suspend, and these domains might contain some of the devices
whose power transitions are coupled with CPU transitions and thus using
CPU PM notifiers.

Also, so far we've only talked about suspend, but the CPU (and other
power domains) might also go off during idle.  The approach in $SUBJECT
patch addresses suspend but not idle, which means it's up to
platform-specific code to trigger the notifiers for idle.  I think it
should be the same for suspend.

> The (next_state == OFF) api you refer to would have to be something
> architecture specific, since the power state handling is very
> different on every platform, so it's not something that would ever be
> included in drivers that I imagined would be using these notifiers.

Sure, but you created something so useful that it can be used in other
areas than you initially imagined. :)   Thanks!

I wouldn't imagine arch-specific being used in those generic drivers
either, but in addition to the drivers you imagined, I'm already trying
to the notifiers in drivers that are platform-specific.  I only imagine
using the "next state" type of checking in platform-specific code, not
in generic ones.

Note however that I'm certainly not arguing that the notifiers should
not be called in suspend.  I'm only arguing that it should be up to
platform-specific code when to call them because of possible
platform-specific pre-requisites in platform-specific notifier
callbacks.

IMO, there are 2 options.

1) leave it up to platform-specific code when to trigger the notifiers
   for *both* suspend and idle PM transitions

2) trigger the notifiers in arch-independent code for both suspend and
   idle *but* provide a way that platform-specific code can disable
   them in favor of using platform-specific trigger points.

If most platforms really don't care, then maybe (2) would be the
better approach.  That's fine with me as long as there's a way to
disable them so platform-specific ones can be used.

Kevin
