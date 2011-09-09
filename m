From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 9 Sep 2011 14:31:25 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110908162452.GA20292@n2100.arm.linux.org.uk>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
	<20110908062301.GK8148@S2100-06.ap.freescale.net>
	<20110908074718.GA14953@n2100.arm.linux.org.uk>
	<20110908152222.GA31581@S2100-06.ap.freescale.net>
	<20110908162452.GA20292@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4w66kyS+JGB01b4EyPtBhyVEpNjEOMO_CgnaxaXXkZu1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Sep 08, 2011 at 11:22:23PM +0800, Shawn Guo wrote:
>> On Thu, Sep 08, 2011 at 08:47:18AM +0100, Russell King - ARM Linux wrote:
>> > On Thu, Sep 08, 2011 at 02:23:02PM +0800, Shawn Guo wrote:
>> > > Yes, if you lose L2 power in suspend, it's the easiest way for you to
>> > > resume L2.
>> > >
>> > > For my case which retains L2, I actually do not want to call this
>> > > function which will invalidate L2. ?But since we still have problem
>> > > to use rmk's generic suspend/resume updates (ARM: pm: add L2 cache
>> > > cleaning for suspend), we have to flush the entire L2 on imx6q for now.
>> >
>> > OMAP44xx has the same problem but they re-initialize L2 on resume in
>> > their pre-cpu_resume() assembly code.
>> >
>> Are you suggesting that this might be the reason why imx6q has problem
>> with your patch?
>
> Consider the mechanics of what is happening.
>
> On suspend, when we enter cpu_suspend(), we assume the L2 cache is
> still enabled.
>
> We _always_ assume that L1 cache state is lost, so we always flush the
> entire L1 cache.
>
> As SoCs can (and do) preserve the L2 contents over suspend/resume cycles,
> we leave it to the platform's finisher to decide whether it needs to
> flush the entire L2 cache to RAM or not.
>
> If L2 is preserved, then we want to ensure that as much data as possible
> is retained in the L2 cache (if the hardware preserves its contents, we
> don't want waste time flushing data out of the cache needlessly -
> especially if we're using these paths for cpuidle.) ?However, we need
> access to a certain amount of data to bring the system back up, and as
> the L2 cache typically will not be searched before the MMU is enabled,
> we have to flush out a certain minimal amount of data (the location
> of the stacked restore information and the stacked restore information
> itself.)
>
> However, we don't flush out anything else from the L2 cache.
>
> Now, upon resume, the resume code will be able to read the data it needs
> to restore the system as we ensured that was flushed out to memory - as
> I mentioned above, the L2 cache won't be searched for this irrespective
> of whether the control registers have enabled it or not.
>
> We will continue to the point where we hit the first bit of information
> stored in L2, which will probably be the stacked SVC register set. ?If
> at this point we're not able to search the L2 cache, then we'll read
> stale data from the backing memory instead, and the system will crash.
>
> Consider what generic code could do about this - if we flushed out that
> register set to memory, then we could get past that point - but we then
> would need to call a function to enable the L2 cache. ?What if that
> function needs data which is sitting in the L2 cache to function (eg,
> it may need values from the device tree). ?We would need to ensure
> that that data were also flushed out of the L2 cache. ?What about
> spinlocks? ?Maybe some other CPU has dragged the spinlock data into
> the L2 cache. ?That gets _much_ harder to solve.
>
> Now to the physical act of enabling the L2 cache. ?The L2 cache control
> registers are subject to security restrictions when running in non-secure
> mode, needing platform specific SMC calls to reprogram the cache. ?Generic
> code is unable to do this.
>
> Hence why it's left up to the platform to figure out how to enable the
> L2 cache before calling cpu_resume(). ?The platform is best placed to
> work out what it needs to do to setup the L2 cache so that the L2 cache
> is available by the time the system control register is written, enabling
> the MMU and caches.

Thanks for your great document to explain what happen. it is really
clear and good.

but in case l2 is not preserved and it is lost in suspend cycles,  we
will flush all data out of l2 before suspending. and we don't need to
re-enable l2
before calling cpu_resume() too since nobody will hit data in l2 not in memory.
after resuming, we just re-init the l2 like cold boot. then
l2x0_of_init() and moving l2x0_init out of init section might be
suitable?

>
>> Are we supposed to re-initialize L2 before calling
>> into generic cpu_resume()?
>
> So, the above is the long way of saying "yes" to this question. ?I hope
> it gives the full picture about why this is so.
>

thanks
barry
