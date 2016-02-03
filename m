From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Feb 2016 09:22:22 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAJZ5v0hdDdFDiieDnsjummg6F+nV7fi=gFa=oFweyP7-ApsHrQ@mail.gmail.com>
References: <20160202210345.GZ19432@atomide.com>
 <Pine.LNX.4.44L0.1602021626540.1653-100000@iolanthe.rowland.org>
 <20160202234626.GD19432@atomide.com>
 <CAJZ5v0hdDdFDiieDnsjummg6F+nV7fi=gFa=oFweyP7-ApsHrQ@mail.gmail.com>
Message-ID: <20160203172222.GL19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rafael J. Wysocki <rafael@kernel.org> [160203 09:19]:
> On Wed, Feb 3, 2016 at 12:46 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Alan Stern <stern@rowland.harvard.edu> [160202 13:46]:
> >> On Tue, 2 Feb 2016, Tony Lindgren wrote:
> >>
> >> > > Also, what is autosuspend_delay set to for your device?  And is
> >> > > runtime_auto set?
> >> >
> >> > It's 100 at that point, see the commented snippet below from
> >> > omap_hsmmc_probe():
> >> >
> >> >     pm_runtime_enable(host->dev);
> >> >     pm_runtime_get_sync(host->dev);
> >> >     pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
> >> >     /* NOTE: pm_runtime_dont_use_autosuspend(host->dev) needed here? */
> >> >     pm_runtime_use_autosuspend(host->dev);
> >> >     ...
> >> >     /* gets -EPROBE_DEFER */
> >> > err_irq:
> >> >     ...
> >> >     pm_runtime_put_sync(host->dev);
> >>
> >> You could try changing this to pm_runtime_put_sync_suspend().  But
> >> putting pm_runtime_dont_use_autosuspend() before the put_sync seems
> >> like a perfectly reasonable thing to do, especially if you feel you
> >> should reverse all the changes you made at the start.
> 
> FWIW, I'd call pm_runtime_dont_use_autosuspend() before put_sync().
> 
> After all, the driver doesn't want to use autosuspend going forward,
> so stating that explicitly looks like the right thing to do.

Yeah agreed. FYI, this is what I typed up here into a commit message:

1. For sections of code that needs the device disabled, use
   pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
   been set.

2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
   pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
   set.

Regards,

Tony
