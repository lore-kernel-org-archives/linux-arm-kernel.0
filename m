From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 22 Feb 2017 15:24:01 +0000
Subject: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
In-Reply-To: <CAJZ5v0iheYM-qj8=bO3NZhoM5=8+TikYhm23EZV72HxNxUXDsg@mail.gmail.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <94167d3a-e005-3af0-d290-a1086684d570@arm.com>
 <3c8b3f2d-8604-f999-4208-a82f171b64f2@arm.com>
 <1975396.x0czmkNPOW@aspire.rjw.lan>
 <35840771-e16f-d6fe-3a89-1b3f51f4a8f3@arm.com>
 <CAMuHMdXpKrJn9NrkAarvMtytk9gHEFcRoZLCsWBFgriUCeWo=Q@mail.gmail.com>
 <f649d707-8b0a-5ca9-b021-93ae8cf66b33@arm.com>
 <CAJZ5v0iheYM-qj8=bO3NZhoM5=8+TikYhm23EZV72HxNxUXDsg@mail.gmail.com>
Message-ID: <ecc87d46-6a77-3c8f-d67e-974d20b8a603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/02/17 14:50, Rafael J. Wysocki wrote:
> On Wed, Feb 22, 2017 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>
>> OK, I thought I had told this before. What do you mean by PSCI system
>> suspend can't wakeup from the configured wakeup source. You just said
>> above that you can wake up from the switch.
>>
>> Just enabling the wakeup sources in Linux doesn't mean you can enter
>> system suspend anytime. You must enter only the state from which you can
>> resume. And in your case if you can't wakeup from WLAN or wakeup source
>> you have configured then simply don't enter system suspend.
> 
> Well, not quite.
> 
> The sysfs wakeup setting for devices only means whether or not to
> enable the generation of wakeup signals for them while suspending.  It
> allows to *prevent* devices from waking up the system, but it doesn't
> guarantee that they will actually wake up if enabled.
> 
> Now, the platform doesn't decide on the sleep state it will go to on
> the basis of what devices have been enabled to wake up the system.
> The states ("shallow", "deep") have to be defined upfront, including
> what devices can wake up from the "shallow" and what devices can wake
> up from the "deep" states (these lists need not be the same).  [As I
> said before, the assumption is that all of them will be able to wake
> up the system from suspend-to-idle.]
> 
> So, if user space triggers a transition to the "shallow" state, say,
> it will be possible to wake up the system from it by devices that (a)
> can wake it up from the "shallow" state as defined for the given
> platform and (b) have been enabled to wake up the system via sysfs.
> 
> Conversely, if you have a system power state such that only a subset
> of devices can wake up from it, it needs to be defined as either
> "shallow" or "deep" and the list of possible wakeup sources is part of
> that definition.

Completely agreed.

And yes the current assumption is that the set of wake-up source in DT
applies to the suspend-to-idle case and may/may not from the deeper
s2ram state.

Sorry if I conveyed something else in my emails. I was mostly referring
to the patch set and the way it's hacking up. I still fail to understand
what Geert is doing different in his "shallow" state that "s2idle" can't
achieve that state. So my comments were more aligned to that when I made
the above comment.

-- 
Regards,
Sudeep
