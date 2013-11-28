From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 28 Nov 2013 10:36:16 -0800
Subject: [PATCH v2 4/9] clocksource/cadence_ttc: Use enable/disable_irq
In-Reply-To: <alpine.DEB.2.02.1311281507280.30673@ionos.tec.linutronix.de>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-5-git-send-email-soren.brinkmann@xilinx.com>
 <52972F3A.9090103@linaro.org>
 <alpine.DEB.2.02.1311281507280.30673@ionos.tec.linutronix.de>
Message-ID: <b2ed3cbc-c9df-4235-8137-93514c05bffa@DB8EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Nov 28, 2013 at 03:18:50PM +0100, Thomas Gleixner wrote:
> On Thu, 28 Nov 2013, Daniel Lezcano wrote:
> 
> > On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
> > > To ensure that the timer interrupt is properly enabled/disabled across
> > > the whole CPU cluster use enable/disable_irq() instead of
> > > local_irq_disable().
> > > 
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > >   drivers/clocksource/cadence_ttc_timer.c | 6 ++----
> > >   1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/clocksource/cadence_ttc_timer.c
> > > b/drivers/clocksource/cadence_ttc_timer.c
> > > index a92350b55d32..246d018d1e63 100644
> > > --- a/drivers/clocksource/cadence_ttc_timer.c
> > > +++ b/drivers/clocksource/cadence_ttc_timer.c
> > > @@ -322,18 +322,16 @@ static int ttc_rate_change_clockevent_cb(struct
> > > notifier_block *nb,
> > >   	switch (event) {
> > >   	case POST_RATE_CHANGE:
> > >   	{
> > > -		unsigned long flags;
> > > -
> > >   		/*
> > >   		 * clockevents_update_freq should be called with IRQ disabled
> > > on
> > >   		 * the CPU the timer provides events for. The timer we use is
> > >   		 * common to both CPUs, not sure if we need to run on both
> > >   		 * cores.
> 
> Can we adjust that bogus comment as well, please?
I can remove that comment. I'll see if including it in one of the
existing patches or adding another patch for it makes sense.

> 
> > >   		 */
> > > -		local_irq_save(flags);
> > > +		disable_irq(ttcce->ce.irq);
> > >   		clockevents_update_freq(&ttcce->ce,
> > >   				ndata->new_rate / PRESCALE);
> > > -		local_irq_restore(flags);
> > > +		enable_irq(ttcce->ce.irq);
> > > 
> > >   		/* update cached frequency */
> > >   		ttc->freq = ndata->new_rate;
> > > 
> > 
> > I am worried about the 'disable_irq' function calling 'synchronize_irq'. Isn't
> > possible to deadlock with the ondemand cpufreq governor ? I added Viresh in
> > Cc, he knows better than me the code path.
> 
> disable_irq() will only deadlock if called from the interrupt handler
> of the device interrupt itself or when the calling code is holding
> locks which prevent the function to proceed.
> 
> But what's more important is, that the patch violates the calling
> convention of clockevents_update_freq(). It must be called with
> interrupts disabled. 
> 
> Now the problem with this device is that it is not a per cpu
> device. It's a global device, so this update can conflict with a
> parallel access on the other CPU. Now the disable_irq() only prevents
> that the other CPU can handle a device interrupt from that timer. But
> it does not prevent any parallel access from e.g. the idle code path
> which will try to reprogram it.
Does that mean interrupts need to be disabled globally? Also, does the
cpuidle path depend on interrupts or can it interfere no matter what?

> 
> Soren, is that timer used as the broadcast device ?
Yes, this is the only broadcast capable timer on Zynq, AFAIK. Other than
the TTC we only have the arm_global_timer and smp_twd timers, which both
are per_cpu devices and thus not broadcast capable.

	S?ren
