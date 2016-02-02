From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Feb 2016 10:05:56 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160202164910.GV19432@atomide.com>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
 <20160202164910.GV19432@atomide.com>
Message-ID: <20160202180555.GW19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160202 08:50]:
> * Alan Stern <stern@rowland.harvard.edu> [160202 08:17]:
> 
> > ?  pm_runtime_put_sync() _already_ does not respect the autosuspend 
> > mode.  If you want to respect it, you have to call 
> > pm_runtime_put_sync_autosuspend() instead.
> 
> I think you found the real bug there. So the right fix is to
> call pm_runtime_put_sync_autosuspend() at the end of failed
> probe in omap_hsmmc. Let me give that a try here.

Nope that's not it but getting closer.

The following seems to make things behave for me. Now the
question is.. Does it have some undesired side effects?

> Can we add some warning to pm_runtime_put_sync() about that?

Probably no need for that, I misunderstood the meaning of
pm_runtime_put_sync_autosuspend().

Regards,

Tony

8< --------------
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -435,7 +435,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 		goto out;
 
 	/* If the autosuspend_delay time hasn't expired yet, reschedule. */
-	if ((rpmflags & RPM_AUTO)
+	if (((rpmflags & (RPM_ASYNC | RPM_AUTO)) == ((RPM_ASYNC | RPM_AUTO)))
 	    && dev->power.runtime_status != RPM_SUSPENDING) {
 		unsigned long expires = pm_runtime_autosuspend_expiration(dev);
 
