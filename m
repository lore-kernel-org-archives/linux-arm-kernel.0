From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 15 Dec 2014 20:24:05 +0530
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <20141215134636.GI11285@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
 <002f01d0186b$2700b730$75022590$%brar@samsung.com>
 <20141215134636.GI11285@n2100.arm.linux.org.uk>
Message-ID: <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, December 15, 2014 7:17 PM
> To: Yadwinder Singh Brar
> Cc: 'Viresh Kumar'; 'Rafael J. Wysocki'; linux-arm-
> kernel at lists.infradead.org; linux-pm at vger.kernel.org; 'Eduardo
> Valentin'
> Subject: Re: 3.18: lockdep problems in cpufreq
> 
> On Mon, Dec 15, 2014 at 06:58:41PM +0530, Yadwinder Singh Brar wrote:
> > Unfortunately, I didn?t get any such warning though I tested patch
> > enabling CONFIG_PROVE_LOCKING before posting. It seems Russell is
> > trying to load imx_thermal as module and parallely Changing cpufreq
> > governor from userspace, which was not my test case.
> 
> No.  Yes, imx_thermal is a module, which is loaded by udev very early
> in the userspace boot.  Later on, in the rc.local, I poke the governor
> from userspace.
> 
> This is evidenced by the bluetooth modules being loaded after
> imx_thermal:
> 
> Module                  Size  Used by
> bnep                   10574  2
> rfcomm                 33720  0
> bluetooth             293598  10 bnep,rfcomm
> nfsd                   90264  0
> exportfs                3988  1 nfsd
> hid_cypress             1763  0
> snd_soc_fsl_spdif       9753  2
> imx_pcm_dma             1137  1 snd_soc_fsl_spdif
> imx_sdma               12885  2
> imx2_wdt                3248  0
> imx_thermal             5386  0
> snd_soc_imx_spdif       1877  0
> 
> and the timestamp on the bluetooth message:
> 
> [   25.503739] Bluetooth: Core ver 2.19
> 
> vs the timestamp on the lockdep message:
> 
> [   29.499195] [ INFO: possible circular locking dependency detected ]
> 
> My rc.local does this:
> 
>     # Configure cpufreq
>     echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
>     echo performance >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> 
> > Anyways, after analyzing log and code,I think problem is not in
> > cpufreq_thermal_notifier which was modified in patch as stated above.
> > Actual problem is in __cpufreq_cooling_register which is
> unnecessarily
> > calling cpufreq_register_notifier() inside section protected by
> > cooling_cpufreq_lock.
> > Because cpufreq_policy_notifier_list).rwsem is already held by
> > store_scaling_governor when __cpufreq_cooling_register is trying to
> > cpufreq_policy_notifier_list while holding cooling_cpufreq_lock.
> >
> > So I think following can fix the problem:
> >
> > diff --git a/drivers/thermal/cpu_cooling.c
> > b/drivers/thermal/cpu_cooling.c index ad09e51..622ea40 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -484,15 +484,15 @@ __cpufreq_cooling_register(struct device_node
> *np,
> >         cpufreq_dev->cpufreq_state = 0;
> >         mutex_lock(&cooling_cpufreq_lock);
> >
> > -       /* Register the notifier for first cpufreq cooling device */
> > -       if (cpufreq_dev_count == 0)
> > -
> cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > -                                         CPUFREQ_POLICY_NOTIFIER);
> >         cpufreq_dev_count++;
> >         list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> >
> >         mutex_unlock(&cooling_cpufreq_lock);
> >
> > +       /* Register the notifier for first cpufreq cooling device */
> > +       if (cpufreq_dev_count == 0)
> > +
> cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > +                                         CPUFREQ_POLICY_NOTIFIER);
> 
> No, sorry, this patch is worse.
> 

Actually it was not patch :P , just moved cpufreq_register_notifier()
out of locking, as it is(C&P) to explain my point.

> 1. cpufreq_register_notifier() will never be called, even on the first
>    caller to this code: at the point where it's tested for zero, it
> will
>    be incremented to one by the previous code.
> 
> 2. What happens if two threads come here?
> 
>    The first thread succeeds in grabbing cooling_cpufreq_lock.  The
> second
>    thread stalls waiting for cooling_cpufreq_lock to be released.
> 
>    The first thread increments cpufreq_dev_count, adds to the list, and
> then
>    releases the lock.  At this point, control may be passed to the
> second
>    thread (since mutex_unlock() will wake it up.)  The second thread
> gets
>    into the critical region, and increments cpufreq_dev_count again.
> 
>    By the time the first thread runs, cpufreq_dev_count may be two at
> this
>    point.

Yes, may be.

> 
> Unfortunately, you do need some kind of synchronisation here.  If it's
> not important when cpufreq_register_notifier() gets called, maybe this
> can work:
> 
> 	bool register;
> 
> 	mutex_lock(&cooling_cpufreq_lock);
> 	register = cpufreq_dev_count++ == 0;
> 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> 	mutex_unlock(&cooling_cpufreq_lock);
> 
> 	if (register)

register may be 0 in scenario you stated above in second point.
So this approach will not work.
 
> 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> 					  CPUFREQ_POLICY_NOTIFIER);
> 
> However, I suspect that may well be buggy if we have a cleanup path
> which unregisters the notifier when cpufreq_dev_count is decremented to
> zero...
> which we seem to have in cpufreq_cooling_unregister().
> 
> The answer may well be to have finer grained locking here:
> 
> - one lock to protect cpufreq_dev_list, which is only ever taken when
>   adding or removing entries from it
> 
> - a second lock to protect cpufreq_dev_count and the calls to
>   cpufreq_register_notifier() and cpufreq_unregister_notifier()
> 
> and you would /never/ take either of those two locks inside each other.
> In other words:
> 
> 	mutex_lock(&cooling_list_lock);
> 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> 	mutex_unlock(&cooling_list_lock);
> 
> 	mutex_lock(&cooling_cpufreq_lock);
> 	if (cpufreq_dev_count++ == 0)
> 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> 					  CPUFREQ_POLICY_NOTIFIER);
> 	mutex_unlock(&cooling_cpufreq_lock);
> 
> and similar in the cleanup path.  The notifier itself would only ever
> take the cooling_list_lock.
> 

I agree with this approach, if its fine for others also, I can implement
and post patch.

Thanks,
Yadwinder

> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
