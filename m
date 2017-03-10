From: mawilcox@microsoft.com (Matthew Wilcox)
Date: Fri, 10 Mar 2017 18:33:28 +0000
Subject: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
In-Reply-To: <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
References: <20170310150218.GW21222@n2100.armlinux.org.uk>
 <CAJZ5v0jGRH_hwvvm9OLsaYgbghqWKOke9PyGNnkvP_ZiMqAxSw@mail.gmail.com>
 <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
Message-ID: <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(compile tested only ... obviously)

>From cd5401d81633d5e48e39d67d4e65156e6759537e Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <mawilcox@microsoft.com>
Date: Fri, 10 Mar 2017 13:22:53 -0500
Subject: [PATCH] thermal: Fix potential deadlock in cpu_cooling

I expanded the scope of cooling_list_lock a little too far; it was
not just covering cpufreq_dev_count, it was also covering the calls
to cpufreq_register_notifier() and cpufreq_unregister_notifier().
Since cooling_list_lock is also used within cpufreq_thermal_notifier(),
lockdep reports a potential deadlock.  I don't think that's actually
possible, but it's easy enough to make it impossible by testing the
condition under cooling_list_lock and dropping the lock before calling
cpufreq_register_notifier().

As a bonus, I noticed that cpufreq_dev_count is only used for the purpose
of knowing whether this is the first or last cooling device registered,
and we know that anyway because we know whether the list transitioned
between empty and not-empty.  So we can delete that variable too.

Fixes: ae606089621ef0349402cfcbeca33a82abbd0fd0
Reported-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/thermal/cpu_cooling.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 91048eeca28b..11b5ea685518 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -107,8 +107,6 @@ struct cpufreq_cooling_device {
 };
 static DEFINE_IDA(cpufreq_ida);
 
-static unsigned int cpufreq_dev_count;
-
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_dev_list);
 
@@ -771,6 +769,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	unsigned int freq, i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
+	bool first;
 
 	if (!alloc_cpumask_var(&temp_mask, GFP_KERNEL))
 		return ERR_PTR(-ENOMEM);
@@ -874,13 +873,14 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_dev->cool_dev = cool_dev;
 
 	mutex_lock(&cooling_list_lock);
+	/* Register the notifier for first cpufreq cooling device */
+	first = list_empty(&cpufreq_dev_list);
 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
+	mutex_unlock(&cooling_list_lock);
 
-	/* Register the notifier for first cpufreq cooling device */
-	if (!cpufreq_dev_count++)
+	if (first)
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
-	mutex_unlock(&cooling_list_lock);
 
 	goto put_policy;
 
@@ -1021,6 +1021,7 @@ EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	struct cpufreq_cooling_device *cpufreq_dev;
+	bool last;
 
 	if (!cdev)
 		return;
@@ -1028,14 +1029,15 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	cpufreq_dev = cdev->devdata;
 
 	mutex_lock(&cooling_list_lock);
+	list_del(&cpufreq_dev->node);
 	/* Unregister the notifier for the last cpufreq cooling device */
-	if (!--cpufreq_dev_count)
+	last = list_empty(&cpufreq_dev_list);
+	mutex_unlock(&cooling_list_lock);
+
+	if (last)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	list_del(&cpufreq_dev->node);
-	mutex_unlock(&cooling_list_lock);
-
 	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
 	kfree(cpufreq_dev->dyn_power_table);
-- 
2.11.0


> -----Original Message-----
> From: Matthew Wilcox
> Sent: Friday, March 10, 2017 1:06 PM
> To: 'Rafael J. Wysocki' <rafael@kernel.org>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; Zhang, Rui <rui.zhang@intel.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Viresh Kumar
> <viresh.kumar@linaro.org>; Linux PM <linux-pm@vger.kernel.org>; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
> 
> Oh, I see.  With my changes, we now call cpufreq_register_notifier() and
> cpufreq_unregister_notifier() with the cooling_list_lock held, and we take the
> cooling_list_lock inside cpufreq_thermal_notifier().  Yeah, that's bad but
> shouldn't lead to any actual lockups.  I'll have a patch in a few minutes (just
> waiting on a build).
> 
> > -----Original Message-----
> > From: rjwysocki at gmail.com [mailto:rjwysocki at gmail.com] On Behalf Of
> Rafael
> > J. Wysocki
> > Sent: Friday, March 10, 2017 12:43 PM
> > To: Russell King - ARM Linux <linux@armlinux.org.uk>; Zhang, Rui
> > <rui.zhang@intel.com>; Matthew Wilcox <mawilcox@microsoft.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Linux PM <linux-pm@vger.kernel.org>; linux-
> arm-
> > kernel at lists.infradead.org
> > Subject: Re: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
> >
> > On Fri, Mar 10, 2017 at 4:02 PM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > ======================================================
> > > [ INFO: possible circular locking dependency detected ]
> > > 4.11.0-rc1+ #2121 Not tainted
> > > -------------------------------------------------------
> > > ondemand/1005 is trying to acquire lock:
> > >  (cooling_list_lock){+.+...}, at: [<c052d074>]
> > cpufreq_thermal_notifier+0x2c/0xcc
> > >                but task is already holding lock:
> > >  ((cpufreq_policy_notifier_list).rwsem){++++..}, at: [<c0058ff8>]
> > __blocking_notifier_call_chain+0x34/0x68
> > >                which lock already depends on the new lock.
> > >
> > >                the existing dependency chain (in reverse order) is:
> > > -> #1 ((cpufreq_policy_notifier_list).rwsem){++++..}:
> > >        down_write+0x44/0x98
> > >        blocking_notifier_chain_register+0x28/0xd8
> > >        cpufreq_register_notifier+0xa4/0xe4
> > >        __cpufreq_cooling_register+0x4cc/0x578
> > >        cpufreq_cooling_register+0x20/0x24
> > >        imx_thermal_probe+0x1c4/0x5f4 [imx_thermal]
> > >        platform_drv_probe+0x58/0xb8
> > >        driver_probe_device+0x204/0x2c8
> > >        __driver_attach+0xbc/0xc0
> > >        bus_for_each_dev+0x5c/0x90
> > >        driver_attach+0x24/0x28
> > >        bus_add_driver+0xf4/0x200
> > >        driver_register+0x80/0xfc
> > >        __platform_driver_register+0x48/0x4c
> > >        0xbf04d018
> > >        do_one_initcall+0x44/0x170
> > >        do_init_module+0x68/0x1d8
> > >        load_module+0x1968/0x208c
> > >        SyS_finit_module+0x94/0xa0
> > >        ret_fast_syscall+0x0/0x1c
> > > -> #0 (cooling_list_lock){+.+...}:
> > >        lock_acquire+0xd8/0x250
> > >        __mutex_lock+0x58/0x930
> > >        mutex_lock_nested+0x24/0x2c
> > >        cpufreq_thermal_notifier+0x2c/0xcc
> > >        notifier_call_chain+0x4c/0x8c
> > >        __blocking_notifier_call_chain+0x50/0x68
> > >        blocking_notifier_call_chain+0x20/0x28
> > >        cpufreq_set_policy+0x74/0x1a4
> > >        store_scaling_governor+0x68/0x84
> > >        store+0x70/0x94
> > >        sysfs_kf_write+0x54/0x58
> > >        kernfs_fop_write+0x138/0x204
> > >        __vfs_write+0x34/0x11c
> > >        vfs_write+0xac/0x16c
> > >        SyS_write+0x44/0x90
> > >        ret_fast_syscall+0x0/0x1c
> > >
> > > other info that might help us debug this:
> > >
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock((cpufreq_policy_notifier_list).rwsem);
> > >                                lock(cooling_list_lock);
> > >                                lock((cpufreq_policy_notifier_list).rwsem);
> > >   lock(cooling_list_lock);
> > >
> > >       *** DEADLOCK ***
> >
> > This broke it:
> >
> > commit ae606089621ef0349402cfcbeca33a82abbd0fd0
> > Author: Matthew Wilcox <mawilcox@microsoft.com>
> > Date:   Wed Dec 21 09:47:05 2016 -0800
> >
> >     thermal: convert cpu_cooling to use an IDA
> >
> >     thermal cpu cooling does not use the ability to look up pointers by ID,
> >     so convert it from using an IDR to the more space-efficient IDA.
> >
> >     The cooling_cpufreq_lock was being used to protect cpufreq_dev_count as
> >     well as the IDR.  Rather than keep the mutex to protect a single integer,
> >     I expanded the scope of cooling_list_lock to also cover cpufreq_dev_count.
> >     We could also convert cpufreq_dev_count into an atomic.
> >
> >     Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> >     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >
> >
> > Matthew? Rui?
> >
> > Thanks,
> > Rafael
> >
> >
> > > 6 locks held by ondemand/1005:
> > >  #0:  (sb_writers#6){.+.+.+}, at: [<c017cf38>] vfs_write+0x150/0x16c
> > >  #1:  (&of->mutex){+.+.+.}, at: [<c01fbd7c>] kernfs_fop_write+0xf8/0x204
> > >  #2:  (s_active#135){.+.+.+}, at: [<c01fbd84>]
> kernfs_fop_write+0x100/0x204
> > >  #3:  (cpu_hotplug.dep_map){++++++}, at: [<c0034028>]
> > get_online_cpus+0x34/0xa8
> > >  #4:  (&policy->rwsem){+++++.}, at: [<c052edd8>] store+0x5c/0x94
> > >  #5:  ((cpufreq_policy_notifier_list).rwsem){++++..}, at: [<c0058ff8>]
> > __blocking_notifier_call_chain+0x34/0x68
> > >
> > > stack backtrace:
> > > CPU: 1 PID: 1005 Comm: ondemand Not tainted 4.11.0-rc1+ #2121
> > > Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > > Backtrace:
> > > [<c0013ba4>] (dump_backtrace) from [<c0013de4>]
> (show_stack+0x18/0x1c)
> > >  r6:600e0093 r5:ffffffff r4:00000000 r3:00000000
> > > [<c0013dcc>] (show_stack) from [<c033ea48>] (dump_stack+0xa4/0xdc)
> > > [<c033e9a4>] (dump_stack) from [<c011db2c>]
> > (print_circular_bug+0x28c/0x2e0)
> > >  r6:c0bf2d84 r5:c0bf2e94 r4:c0bf2d84 r3:c09e84a8
> > > [<c011d8a0>] (print_circular_bug) from [<c008b08c>]
> > (__lock_acquire+0x16c8/0x17b0)
> > >  r10:ee75aa48 r8:00000006 r7:c0a531c8 r6:ee75aa28 r5:ee75a4c0
> > r4:c141aa58
> > > [<c00899c4>] (__lock_acquire) from [<c008b6d8>]
> > (lock_acquire+0xd8/0x250)
> > >  r10:00000000 r9:c0a8a8a4 r8:00000000 r7:00000000 r6:c0a74fe4
> > r5:600e0013
> > >  r4:00000000
> > > [<c008b600>] (lock_acquire) from [<c070ce18>]
> (__mutex_lock+0x58/0x930)
> > >  r10:00000002 r9:00000000 r8:c141aa58 r7:edc8bca0 r6:00000000
> > r5:00000000
> > >  r4:c0a74fb0
> > > [<c070cdc0>] (__mutex_lock) from [<c070d798>]
> > (mutex_lock_nested+0x24/0x2c)
> > >  r10:00000008 r9:00000000 r8:00000000 r7:edc8bca0 r6:00000000
> > r5:c0a74fb0
> > >  r4:edc8bca0
> > > [<c070d774>] (mutex_lock_nested) from [<c052d074>]
> > (cpufreq_thermal_notifier+0x2c/0xcc)
> > > [<c052d048>] (cpufreq_thermal_notifier) from [<c0058c54>]
> > (notifier_call_chain+0x4c/0x8c)
> > >  r5:00000000 r4:ffffffff
> > > [<c0058c08>] (notifier_call_chain) from [<c0059014>]
> > (__blocking_notifier_call_chain+0x50/0x68)
> > >  r8:d014e400 r7:00000000 r6:edc8bca0 r5:ffffffff r4:c0a7521c r3:ffffffff
> > > [<c0058fc4>] (__blocking_notifier_call_chain) from [<c005904c>]
> > (blocking_notifier_call_chain+0x20/0x28)
> > >  r7:c1437a4c r6:00000000 r5:d014e400 r4:edc8bca0
> > > [<c005902c>] (blocking_notifier_call_chain) from [<c05318d0>]
> > (cpufreq_set_policy+0x74/0x1a4)
> > > [<c053185c>] (cpufreq_set_policy) from [<c0531a68>]
> > (store_scaling_governor+0x68/0x84)
> > >  r8:d014e400 r7:c0a75410 r6:00000008 r5:d8f83480 r4:d014e400
> > r3:00000000
> > > [<c0531a00>] (store_scaling_governor) from [<c052edec>]
> (store+0x70/0x94)
> > >  r6:d8f83480 r5:00000008 r4:d014e4e0
> > > [<c052ed7c>] (store) from [<c01fcc54>] (sysfs_kf_write+0x54/0x58)
> > >  r8:00000000 r7:d8f83480 r6:d8f83480 r5:00000008 r4:d01c1240
> > r3:00000008
> > > [<c01fcc00>] (sysfs_kf_write) from [<c01fbdbc>]
> > (kernfs_fop_write+0x138/0x204)
> > >  r6:d01c1240 r5:d01c1250 r4:00000000 r3:ee75a4c0
> > > [<c01fbc84>] (kernfs_fop_write) from [<c017b6f0>]
> > (__vfs_write+0x34/0x11c)
> > >  r10:809f5d08 r9:edc8a000 r8:00000008 r7:edc8bf78 r6:d5af4b40
> > r5:809f5d08
> > >  r4:c071eebc
> > > [<c017b6bc>] (__vfs_write) from [<c017ce94>] (vfs_write+0xac/0x16c)
> > >  r8:edc8bf78 r7:00000000 r6:809f5d08 r5:00000008 r4:d5af4b40
> > > [<c017cde8>] (vfs_write) from [<c017d144>] (SyS_write+0x44/0x90)
> > >  r10:809f5d08 r8:00000008 r7:d5af4b40 r6:d5af4b40 r5:00000000
> > r4:00000000
> > > [<c017d100>] (SyS_write) from [<c000fd60>] (ret_fast_syscall+0x0/0x1c)
> > >  r10:00000000 r8:c000ff04 r7:00000004 r6:7f8a8d08 r5:809f5d08
> > r4:00000008
> > >
> > > --
> > > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> > > according to speedtest.net.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-thermal-Fix-potential-deadlock-in-cpu_cooling.patch
Type: application/octet-stream
Size: 3479 bytes
Desc: 0001-thermal-Fix-potential-deadlock-in-cpu_cooling.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170310/d9288531/attachment-0001.obj>
