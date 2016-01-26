From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 27 Jan 2016 00:37:24 +0100
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160126232212.GE19432@atomide.com>
References: <20160126224804.GB19432@atomide.com>
 <CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
 <20160126232212.GE19432@atomide.com>
Message-ID: <CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 12:22 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Rafael J. Wysocki <rafael@kernel.org> [160126 15:15]:
>> On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > Hi,
>> >
>> > Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
>> > PM states at probe error and driver unbind") broke PM on at least
>> > omap3. It seems we now need to additionally also call
>> > pm_runtime_dont_use_autosuspend() to get things working again?
>> >
>> > The following fixes idling on omap3, but I'm wondering if we
>> > should do something in pm_runtime_reinit() instead?
>>
>> Well, does it actually help if you add
>> pm_runtime_dont_use_autosuspend(dev) to pm_runtime_reinit()?
>
> No adding it to pm_runtime_reinit() does not help.

Yes, I realized that it wouldn't help only after sending the previous
message, sorry about that.

The reason why it helps in the driver code seems to be that
autosuspend_delay happens to be negative, so update_autosuspend()
decrements the usage counter that would have stayed incremented
otherwise.  Or at least that's the only way it can help I see ATM.

> Looks like we have RPM_ACTIVE set in pm_runtime_reinit() if that
> gives any clues.

It looks like pm_runtime_reinit() should clear the usage counter too.

Thanks,
Rafael
