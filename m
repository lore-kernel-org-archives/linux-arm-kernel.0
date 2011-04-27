From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Wed, 27 Apr 2011 15:36:25 +0900
Subject: [RFC PATCH v2 1/3] PM / Core: suspend_again callback for device
	PM.
In-Reply-To: <201104270032.42046.rjw@sisk.pl>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426210627.GA28033@elf.ucw.cz>
	<201104262346.58046.rjw@sisk.pl> <201104270032.42046.rjw@sisk.pl>
Message-ID: <BANLkTi=QDjBtY2WypXjYzyAOUGYjf_oRvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 7:32 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 26, 2011, Rafael J. Wysocki wrote:
>> On Tuesday, April 26, 2011, Pavel Machek wrote:
> ...
>> > Ok, see the spitz_should_wakeup() function in arch/arm/mach-pxa/* and
>> > should_wakeup() usage.
>>
>> OK, I will.
>
> Well, as far as I can tell, on Zaurus this is all done within the platform
> ->enter() callback, so it doesn't carry out the device resume, while the
> proposed $subject patch does. ?For this reason, I'm not even sure if the
> proposed approach is really suitable for Zaurus (the resuming and suspending
> of all devices every once a while will cost quite some enery I guess).

In fact, the kernel "hacks" of mine have been looping at
sysdev-suspend/resume implemented with platform_suspend_ops; thus it
does not carry device resume either.
I've moved the looping point to general device-suspend/resume because
I thought that other systems may require active devices.
However, if others can be satisfied without resumed devices, it is
perfect with me to move that inside device resume as well.

>
> Still, in the unlikely case it is suitable, here's my opinion.
>
> I don't think syscore_ops is the right place to put the new "suspend
> again" callback for reasons stated previously.
>
> I also don't think dev_pm_ops is the right place to put such a callback,
> because it will only be necessary on very few platforms and there's no
> reason why every driver, subsystem or power domain in the kernel should care.
>
> Moreover, the usage cases appear to be suspend-specific.
>
> For the above reasons, the only place the "suspend again" callback may be
> put into is struct platform_suspend_ops. ?Then, suspend_devices_and_enter()
> may be modified so that it loops between dpm_suspend_start() and
> dpm_suspend_end() until that callback returns "false" and there are no
> wakeup events (as indicated by pm_wakeup_pending(); but please note that
> this would require suspend_enter() to indicate that pm_wakeup_pending()
> returned "true" and events_check_enabled should not be reset until
> we're sure that we _really_ want to resume).
>
> Alternatively, if that's sufficient, suspend_enter() may be called in a
> loop until the "suspend again" callback returns "false" and there are no
> wakeup events (in the above sense).
>
> The callback can be called "repeat" and return bool as far as I'm concerned,
> but I'm not insisting on that.
>
> MyungJoo, would that be suitable to you?

As long as sysdevs are resumed and some devices/subsystems (I2C-PMIC,
ADC, and RTC in my cases) can be selectively resumed and suspended, it
is fine.
Thus, your "alternative" suggestion is perfect with me. Actually, this
is almost going back to the original hack. =)

I'll submit next revision with platform_suspend_ops later.

Thank you!

>
> Rafael
>

Cheers!
- MyungJoo
-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
