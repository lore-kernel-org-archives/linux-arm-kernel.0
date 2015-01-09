From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 9 Jan 2015 13:38:04 +0800
Subject: [RFC] mmc:change mmc_init workqueue into a freezable workqueue
In-Reply-To: <20150108114225.GR12302@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D103EDAF89E192@CNBJMBX05.corpusers.net>
 <20150108114225.GR12302@n2100.arm.linux.org.uk>
Message-ID: <35FD53F367049845BC99AC72306C23D103EDAF89E197@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, January 08, 2015 7:42 PM
> To: Wang, Yalin
> Cc: 'chris at printf.net'; 'ulf.hansson at linaro.org'; 'tim.kryger at gmail.com';
> 'tgih.jun at samsung.com'; 'johan.rudholm at axis.com'; 'linux-
> mmc at vger.kernel.org'; 'linux-kernel at vger.kernel.org'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: [RFC] mmc:change mmc_init workqueue into a freezable workqueue
> 
> On Thu, Jan 08, 2015 at 06:06:32PM +0800, Wang, Yalin wrote:
> > This patch fix the mmc driver suspend/resume conflict problems, mmc
> > workqueue will queue mmc_rescan(), and it will call some
> > pm_runtime_* functions, this will conflict with suspend path
> > sometimes, and will result in some strange behavior:
> >
> > Suspend path:
> > 	-000 |context_switch(inline)
> > 	-000 |__schedule()
> > 	-001 |schedule_preempt_disabled()
> > 	-002 |spin_lock(inline)
> > 	-002 |__mutex_lock_common(inline)
> > 	-002 |__mutex_lock_slowpath(lock_count = 0xEDCD0F48)
> > 	-003 |__mutex_fastpath_lock(inline)
> > 	-003 |mutex_lock(lock = 0xEDCD0F48)
> > 	-004 |sdhci_do_set_ios(host = 0xEDCD0CC0, ios = 0xEDCD0A70)
> > 	-005 |sdhci_set_ios(?, ios = 0xEDCD0A70)
> > 	-006 |mmc_set_ios(host = 0xEDCD0800)
> > 	-007 |mmc_delay(inline)
> > 	-007 |mmc_power_off(host = 0xEDCD0800)
> > 	-008 |mmc_suspend_host(inline)
> > 	-008 |mmc_suspend_host(host = 0xEDCD0800)
> > 	-009 |mmc_host_suspend(dev = 0xEDCD0808)
> > 	-010 |dpm_run_callback(cb = 0xC0627A88, dev = 0xEDCD0808, state =
> (event = 2), info = 0xC0B6EF9B)
> > 	-011 |__device_suspend(dev = 0xEDCD0808, state = (event = 2), ?)
> > 	-012 |device_suspend(inline)
> 
> Suspend can't complete until device_suspend() returns.  Hence,
> mmc_power_off() must finish.
> 
> > mmc_rescan() resume path:
> > 	 -000 |context_switch(inline)
> > 	 -000 |__schedule()
> > 	 -001 |do_undefinstr(regs = 0xD12242F0)
> > 	 -002 |__und_svc(asm)
> > 	  --> |exception
> 
> I assume this is what you mean by "strange behaviour" ?  If so, please give
> the full oops.  Have you fully diagnosed the failure?
> 
> > most mmc power callback function don't check this special case, and
> > will cause problems, make sure the workqueue is stopped during suspend
> > is more safe.
> 
> I think there's a bad side effect of this: if you have swap on a SD card,
> and you ask the system to hibernate, you don't want this thread to freeze.
> 
> What you do need to do is to ensure that new requests can't be processed
> while the host is suspended.
> 
> A hibernate works (approximately) as:
> 
> - freeze all tasks
> - push as much out to swap as possible
> - suspend devices
> - create system snapshot
> - resume devices
> - write system snapshot to swap
> - power down
> 
> If the MMC thread is frozen, and you have swap on SD, then it can't write
> the image to swap.
> 
I see your concerns, thanks for your comment.
I will think about some other solutions for this problems.


Thank you
