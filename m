From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 17 Apr 2012 15:53:05 +0530
Subject: [PATCH 0/3] OMAP4: CPUidle: Add coupled idle support
In-Reply-To: <4F8287BA.2090602@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <87obr9s8wk.fsf@ti.com> <4F7B11EE.6030904@ti.com> <4F8287BA.2090602@ti.com>
Message-ID: <CAMQu2gxusZFn2ifOTqvC6WG+TzW0FhBw8bhJkfXcBPPyUib5Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 12:24 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Tuesday 03 April 2012 08:36 PM, Santosh Shilimkar wrote:
>> On Tuesday 03 April 2012 10:34 AM, Kevin Hilman wrote:
>>> Hi Santosh,
>>>
>>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>>
>>>> The series adds the coupled cpuidle support for OMAP4 based on the v2
>>>> series posted [1]. This makes OMAP4 to support SMP cpuidle and also
>>>> removes the hard dependency of off-lining CPU1 to trigger deeper
>>>> C-states.
>>>>
>>>> I have put together a branch which is based on 3.3 kernel with
>>>> Len Browns next branch [2] which has time keeping and other cpuidle
>>>> patches which will mostly get merged by 3.4-rc1 and rebased coupled
>>>> idle series from [1].
>>>
>>> Thanks for rebasing this.
>>>
>>>> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
>>>> for_3.5/omap4_coupled_cpuidle-rebase
>>>
>>> This branch by itself seems to work fine. ?However, when combining with
>>> other stuff that has merged for v3.4, it hangs during boot. ?I haven't
>>> yet isolated the problem, but it's easy to reproduce by combining your
>>> branch with v3.4-rc1:
>>>
>>> ? git checkout -b test/coupled-v3.4 v3.4-rc1
>>> ? git merge -s recursive -X ours santosh/for_3.5/omap4_coupled_cpuidle-rebase [1]
>>>
>>> This hangs on boot, and it seems like a coupled state deadlock because
>>> commenting out the coupled states in the C-state creation of
>>> cpuidle44xx.c makes it boot just fine.
>>>
>> I managed to reproduce the issue. Just to ensure that any OMAP changes
>> have not introduced the regression I merged all Tony's pull request on
>> my branch and tried it out. OMAP changes are fine and coupled idle
>> continue to work.
>>
>> Started bisecting the commits. For bisect I have to create a series
>> which is not dependent on Len's cpuidle updates. First round of bisect
>> was not successful so tried one more time. Was very close to narrowing
>> down on commit but then encountered set of commits where either CPUIDLE
>> itself is broken(deeper C-states are not getting attempted) or I get
>> softIRQ 08 pending error.
>>
>> The last bad commit in bisect was ...
>> [8682df25ca9afd3aac30f2c72d00bd98de2118e8] Merge branch
>> 'fortglx/3.4/rtc' of git://git.linaro.org/people/jstultz/linux into
>> timers/core
>>
>> So far looks like, one of below series has introduced a race which is
>> getting highlighted with coupled cpuidle patchset.
>>
>> 9b612fa Merge branch 'fortglx/3.4/clocksource' of
>> git://git.linaro.org/people/jstultz/linux into timers/core
>> 8682df2 Merge branch 'fortglx/3.4/rtc' of
>> git://git.linaro.org/people/jstultz/linux into timers/core
>> 97ac984 Merge branch 'fortglx/3.4/time' of
>> git://git.linaro.org/people/jstultz/linux into timers/core
>>
> Finally managed to crack down the issue.
> The broad-cast clock-event was remaining in shut-down mode and
> hence we were loosing the OS tick after entering to low power
> states. The cases where it use to work was mainly because of
> external interrupts like NFS etc.
>
> Have posted a patch [1] on LKML which fixes the issue. Waiting
> for feedback from Thomas on it.
>
Based on the discussion on patch [1], I ended up creating another
patch(end of the email) for OMAP4 idle driver. Git tree is
updated accordingly and available here [2]

Regards,
Santosh

[1] https://lkml.org/lkml/2012/4/9/13

[2] git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
 for_3.5/coupled_cpuidle-rebase

>From d36a31b21e3d839ff0ae440186874bfeb6e7edc1 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Tue, 17 Apr 2012 15:09:20 +0530
Subject: [PATCH] ARM: OMAP4: CPUidle: Open broadcast clock-event device.

OMAP4 idle driver uses CLOCK_EVT_NOTIFY_BROADCAST_[ENTER/EXIT]
for broadcast clock events. But _ENTER/_EXIT doesn't really open
broadcast clock events and to explicitly setup the broadcast device,
CLOCK_EVT_NOTIFY_BROADCAST_ON should be used.

So far the broadcast device was opened up by generic code and hence
OMAP4 idle was working without explicit CLOCK_EVT_NOTIFY_BROADCAST_ON.
>From commit 77b0d60 {clockevents: Leave the broadcast device in shutdown
mode}, the default setup is skipped so driver needs to open up the
broadcast device.

Without this patch, boot might hang since CPU enters deeper idle state in
which local timer stalls and broad cast timer is not armed.

Discussion thread :
	https://lkml.org/lkml/2012/4/9/13

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c
b/arch/arm/mach-omap2/cpuidle44xx.c
index ccc8e82..cf804e9 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -259,6 +259,7 @@ int __init omap4_idle_init(void)
 		dev->state_count++;
 		drv->state_count++;

+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu_id);
 		cpuidle_register_driver(&omap4_idle_driver);

 		if (cpuidle_register_device(dev)) {
-- 
1.7.5.4
