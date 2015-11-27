From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Nov 2015 10:36:35 +0100
Subject: [PATCH v3b] regulator: core: avoid unused variable warning
In-Reply-To: <CAMuHMdWAR7D0LhehsH_cFi7pWM2awX+O8bD_aTboZymD6rreSA@mail.gmail.com>
References: <4083086.03MkICpY7S@wuerfel>
 <CAMuHMdWAR7D0LhehsH_cFi7pWM2awX+O8bD_aTboZymD6rreSA@mail.gmail.com>
Message-ID: <6486349.NfasOOYIHJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 November 2015 10:25:11 Geert Uytterhoeven wrote:
> Hi Arnd, Mark,
> 
> I saw this BUG a few times lately, but it doesn't trigger on every boot:
> 
> =====================================
> [ BUG: bad unlock balance detected! ]
> 4.4.0-rc2-koelsch-02027-g82cc3c313143199b-dirty #2084 Tainted: G        W
> -------------------------------------
> kworker/u4:0/6 is trying to release lock (&rdev->mutex) at:
> [<c0247b84>] regulator_set_voltage+0x38/0x50
> but there are no more locks to release!
> 
> other info that might help us debug this:
> 4 locks held by kworker/u4:0/6:
>  #0:  ("%s""deferwq"){++++.+}, at: [<c0042934>] process_one_work+0x1c0/0x3dc
>  #1:  (deferred_probe_work){+.+.+.}, at: [<c0042934>]
> process_one_work+0x1c0/0x3dc
>  #2:  (&dev->mutex){......}, at: [<c02a1464>] __device_attach+0x1c/0x104
>  #3:  (&_host->ios_lock){+.+...}, at: [<c038798c>] tmio_mmc_set_ios+0x34/0x1d8
> 
> stack backtrace:
> CPU: 0 PID: 6 Comm: kworker/u4:0 Tainted: G        W
> 4.4.0-rc2-koelsch-02027-g82cc3c313143199b-dirty #2084
> Hardware name: Generic R8A7791 (Flattened Device Tree)
> Workqueue: deferwq deferred_probe_work_func
> [<c00173a0>] (unwind_backtrace) from [<c0013094>] (show_stack+0x10/0x14)
> [<c0013094>] (show_stack) from [<c01f2338>] (dump_stack+0x70/0x8c)
> [<c01f2338>] (dump_stack) from [<c0067c70>]
> (print_unlock_imbalance_bug+0xa4/0xd8)
> [<c0067c70>] (print_unlock_imbalance_bug) from [<c006d0e0>]
> (lock_release+0x1c0/0x38c)
> [<c006d0e0>] (lock_release) from [<c04ab954>]
> (__mutex_unlock_slowpath+0x110/0x190)
> [<c04ab954>] (__mutex_unlock_slowpath) from [<c0247b84>]
> (regulator_set_voltage+0x38/0x50)
> [<c0247b84>] (regulator_set_voltage) from [<c03767a0>]
> (mmc_regulator_set_ocr+0x40/0xc4)
> [<c03767a0>] (mmc_regulator_set_ocr) from [<c0387a98>]
> (tmio_mmc_set_ios+0x140/0x1d8)
> [<c0387a98>] (tmio_mmc_set_ios) from [<c0377a6c>] (mmc_power_up+0x3c/0xb0)
> [<c0377a6c>] (mmc_power_up) from [<c037878c>] (mmc_start_host+0x50/0x7c)
> [<c037878c>] (mmc_start_host) from [<c0379754>] (mmc_add_host+0x5c/0x80)
> [<c0379754>] (mmc_add_host) from [<c0388438>] (tmio_mmc_host_probe+0x3dc/0x48c)
> [<c0388438>] (tmio_mmc_host_probe) from [<c0389bc8>]
> (sh_mobile_sdhi_probe+0x1c4/0x3e8)
> [<c0389bc8>] (sh_mobile_sdhi_probe) from [<c02a2e30>]
> (platform_drv_probe+0x50/0xa0)
> [<c02a2e30>] (platform_drv_probe) from [<c02a1684>]
> (driver_probe_device+0x110/0x28c)
> [<c02a1684>] (driver_probe_device) from [<c029ff74>]
> (bus_for_each_drv+0x84/0x94)
> [<c029ff74>] (bus_for_each_drv) from [<c02a14d8>] (__device_attach+0x90/0x104)
> [<c02a14d8>] (__device_attach) from [<c02a0c28>] (bus_probe_device+0x28/0x84)
> [<c02a0c28>] (bus_probe_device) from [<c02a1040>]
> (deferred_probe_work_func+0x60/0x88)
> [<c02a1040>] (deferred_probe_work_func) from [<c00429ac>]
> (process_one_work+0x238/0x3dc)
> [<c00429ac>] (process_one_work) from [<c00430ac>] (worker_thread+0x2a8/0x3e8)
> [<c00430ac>] (worker_thread) from [<c0047874>] (kthread+0xd8/0xec)
> [<c0047874>] (kthread) from [<c000fb48>] (ret_from_fork+0x14/0x2c)
> 
> On Fri, Nov 20, 2015 at 3:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The second argument of the mutex_lock_nested() helper is only
> > evaluated if CONFIG_DEBUG_LOCK_ALLOC is set. Otherwise we
> > get this build warning for the new regulator_lock_supply
> > function:
> >
> > drivers/regulator/core.c: In function 'regulator_lock_supply':
> > drivers/regulator/core.c:142:6: warning: unused variable 'i' [-Wunused-variable]
> >
> > To avoid the warning, this restructures the code to make it
> > both simpler and to move the 'i++' outside of the mutex_lock_nested
> > call, where it is now always used and the variable is not
> > flagged as unused.
> >
> > We had some discussion about changing mutex_lock_nested to an
> > inline function, which would make the code do the right thing here,
> > but in the end decided against it, in order to guarantee that
> > mutex_lock_nested() does not introduced overhead without
> > CONFIG_DEBUG_LOCK_ALLOC.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 9f01cd4a915 ("regulator: core: introduce function to lock regulators and its supplies")
> > Link: http://permalink.gmane.org/gmane.linux.kernel/2068900
> > ---
> > This is a different approach I came up with now, feel free to
> > pick either v3a or v3b of the patch, whichever seems more appropriate
> > to you.
> >
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index 4cf1390784e5..c9bdca5f3b9b 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -138,18 +138,10 @@ static bool have_full_constraints(void)
> >   */
> >  static void regulator_lock_supply(struct regulator_dev *rdev)
> >  {
> > -       struct regulator *supply;
> > -       int i = 0;
> > -
> > -       while (1) {
> > -               mutex_lock_nested(&rdev->mutex, i++);
> 
> The above line was always executed at least once...
> 
> > -               supply = rdev->supply;
> > -
> > -               if (!rdev->supply)
> > -                       return;
> > +       int i;
> >
> > -               rdev = supply->rdev;
> > -       }
> > +       for (i = 0; rdev->supply; rdev = rdev->supply->rdev, i++)
> > +               mutex_lock_nested(&rdev->mutex, i);
> 
> ... but not anymore.
> 

Damn, I was trying to be too smart. I tried to come up with the perfect
line that did the same thing as before, but clearly failed.

We could scrap that patch and take the other alternative that I sent
(which is more obvious than this one), or add do it like this:

8<---
Subject: regulator: core: fix regulator_lock_supply regression

As noticed by Geert Uytterhoeven, my patch to avoid a harmless build warning
in regulator_lock_supply() was total crap and introduced a real bug:

> [ BUG: bad unlock balance detected! ]
> kworker/u4:0/6 is trying to release lock (&rdev->mutex) at:
> [<c0247b84>] regulator_set_voltage+0x38/0x50

we still lock the regulator supplies, but not the actual regulators,
so we are missing a lock, and the unlock is unbalanced.

This rectifies it by first locking the regulator device itself before
using the same loop as before to lock its supplies.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 716fec9d1965 ("[SUBMITTED] regulator: core: avoid unused variable warning")

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c9bdca5f3b9b..89e4dcb84758 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -140,7 +140,8 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
 {
 	int i;
 
-	for (i = 0; rdev->supply; rdev = rdev->supply->rdev, i++)
+	mutex_lock(&rdev->mutex);
+	for (i = 1; rdev->supply; rdev = rdev->supply->rdev, i++)
 		mutex_lock_nested(&rdev->mutex, i);
 }
 
