From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 3 Feb 2016 17:24:55 +0100
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160203160951.GF19432@atomide.com>
References: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
 <20160203160951.GF19432@atomide.com>
Message-ID: <CAPDyKFoNY8xP11n6mFVicYwdy49sB4=H0fTm53754HukFX4HBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 17:09, Tony Lindgren <tony@atomide.com> wrote:
> * Alan Stern <stern@rowland.harvard.edu> [160203 07:46]:
>> On Wed, 3 Feb 2016, Ulf Hansson wrote:
>>
>> > > Let me summarize my understanding of this thread so far.
>> > >
>> > > It looks like the omap3 code initializes hardware in ->probe() and
>> > > then it may return -EPROBE_DEFER due to some unmet dependencies.  In
>> > > that case the hardware is not reset to the previous state and the
>> > > runtime PM framework is left in the state that corresponds to the
>> > > current hardware state.  Before we had pm_runtime_reinit(), everything
>> > > worked as expected on the second ->probe() call, because things were
>> > > in sync then.
>> >
>> > Correct!
>
> Well not quite correct. After failed probe PM runtime is set to reset
> state while hardware is still enabled.

Yes, but that's *after* pm_runtime_reinit() was added.

I think Rafael was thinking about how it worked *before*.

>
>> > Before pm_runtime_reinit(), the failing probe case (-EPROBE_DEFER)
>> > worked fine because the HW state and the runtime PM status was in
>> > sync. The device was powered and the runtime PM status was RPM_ACTIVE.
>> >
>> > >
>> > > The introduction of pm_runtime_reinit() changed the situation and now
>> > > effectively the hardware is required to be reset to the initial state
>> > > if -EPROBE_DEFER is to be returned too.
>> >
>> > Not correct. The hardware doesn't need a reset as it stays powered
>> > after a failed probe.
>
> It is really best to disable the hardware after a failed probe
> like we do with pm_runtime_put_sync_(suspend)() and pm_runtime_disable().
>
> This is because there may never be another probe attempt and we want
> to have unclaimed devices shut off (or idled) for PM.

I totally agree!

>
>> > Instead, only the runtime PM status needs to be synchronized with the
>> > HW state the next probe attempt.
>>
>> In other words, the probe routine assumes the actual state is the same
>> as the PM status.  This may have been true before pm_runtime_reinit()
>> came along, but it's not true now.
>>
>> > In other words, when the PM domain's ->runtime_resume() callbacks gets
>> > called due to a pm_runtime_get_sync() in the second probe attempt, it
>> > may find that the HW is already powered and can return zero instead of
>> > resetting it.
>
> Certainly that should at least produce a warning in the hardware
> specific implementation. It's a state mismatch between PM runtime
> and the hardware specific implementation.
>
> And as discussed, the problem does not exist as long as we understand
> that we need to use pm_runtime_put_sync_suspend() if the driver has
> set pm_runtime_use_autoidle(). Or else use the combination of
> pm_runtime_dont_use_autoidle() and pm_runtime_put_sync().

Okay, so I understand that you decided to not pick up the omap hwmod
patch I posted.

If you want some further help in fixing the omap drivers, please just
tell me I am at your service. :-)

Also, we must not forget to also update their runtime PM calls in
their ->remove() callbacks, as those seems to suffer from the same
problem as in the -EPROBE_DEFER case.

>
>> What's wrong with going ahead and resetting the hardware anyway?
>
> Nothing, unless a state needs to be maintained for things like GPIO
> pins power memory :)
>
> Regards,
>
> Tony

Kind regards
Uffe
