From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 11 Nov 2014 12:05:46 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <545D0074.7060205@ti.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
 <CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
 <17707586.6KbjDf5Kep@vostro.rjw.lan>
 <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
 <545D0074.7060205@ti.com>
Message-ID: <CAPDyKFpgYiRuW0cbpW_ZnZU-bRqvuqzfW+QfkbUTiYVEpE1ZLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> 2) There are no requirements for arch/platforms/drivers to work in both cases
> CONFIG_PM_RUNTIME=y/n. But they must be built without errors/warning for both
> cases.

For cross SoC drivers this statement is not correct! Driver _must_
support the various combinations of CONFIG_PM*.

Therefore, I think it's better to strive towards a common solution and
to get the building blocks in place.

>
> For example, for Keystone 2 only CONFIG_PM_RUNTIME=y is going to be supported
> and if some one decided to disable it - it can be perfectly done from sys_fs/
> user space.

I can't see why the sysfs option to disable runtime PM should affect
this discussion. That's done at runtime and after the device has been
probed.

>
> 3) pm_runtime_get_sync()(or similar) is good not only because i's waking up device, but also
> because:
> - it can wake up chain of devices (dev->parent->parent->...)

That's right. But that's not what this patchset aims to do.

I realize that the header of the cover letter isn't describing the
problem I am trying to solve very well. I guess the below header would
have been better:

"PM / Domains: Power up PM domains prior drivers starts to probe their devices"

> - it can wake up power domain

Yes, but it requires CONFIG_PM_RUNTIME to be set.

Thus, to solve the problem during driver ->probe() we need another
solution which don't require CONFIG_PM_RUNTIME to be set. As this
patchset proposes.

> - it connects device to domain/class/type/bus and so allow to add additional PM layer on top
>   of Platform bus (for example arch/arm/mach-omap2/omap_device.c).
>
> So, it will do all needed things, and if it doesn't that problem is in platfrom/bus/driver
> code and not in Runtime PM.
> if pm_runtime_get_sync() will be dropped - than all above will need to be implemented
> around the ->probe().

I am not sure what you mean about dropping pm_runtime_get_sync()? All
I am saying is that we can't use it to power on PM domains during the
probe sequence.

Of course, you may still use pm_runtime_get_sync() from anywhere it's
needed, to for example handle device's parent/child relationships.

>
> 4) I've copied here comment from Rafael:
>  >>>> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
>  >>>> it must take the fact that the driver's own ->runtime_resume() may be called
>  >>>> as a result of this into account.
>  Agree, that's a little bit annoying, but we are living with that for more then
>  5 years already (I'm 3 years) - so, I am, as driver developer, expecting above behavior
>  (just walk through the drivers and you will see how many drivers expecting the same).
>
> So, any volunteers to check and fix ~500 drivers.

We don't have to change these drivers. An certainly they are not 500. :-)

They will still work as is!

Though we need this fix to comply with them, which is supposed to go
in for 3.18 rc[n].
"PM / Domains: Fix initial default state of the need_restore flag"

[...]

Kind regards
Uffe
