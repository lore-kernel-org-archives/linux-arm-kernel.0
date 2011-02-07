From: John.Linn@xilinx.com (John Linn)
Date: Mon, 7 Feb 2011 08:01:37 -0700
Subject: [PATCH 3/4] ARM: Xilinx: Adding timer support to the platform
In-Reply-To: <20110207145858.GC24893@pulham.picochip.com>
References: <1296922637-24662-1-git-send-email-john.linn@xilinx.com>
	<1296922637-24662-2-git-send-email-john.linn@xilinx.com>
	<1296922637-24662-3-git-send-email-john.linn@xilinx.com>
	<66f1ca90-76f5-4571-b10e-8b79f62e5275@VA3EHSMHS020.ehs.local>
	<20110206010343.GB5563@pulham.picochip.com>
	<a58cfb3f-31d6-4120-a961-694aed8b7486@VA3EHSMHS006.ehs.local>
	<20110207145858.GC24893@pulham.picochip.com>
Message-ID: <74e0d395-ca75-4ac0-8dcc-fdb55d3deeb3@VA3EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jamie Iles [mailto:jamie at jamieiles.com]
> Sent: Monday, February 07, 2011 7:59 AM
> To: John Linn
> Cc: Jamie Iles; linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
Kiran Sutariya
> Subject: Re: [PATCH 3/4] ARM: Xilinx: Adding timer support to the
platform
> 
> On Mon, Feb 07, 2011 at 07:16:01AM -0700, John Linn wrote:
> > > -----Original Message-----
> > > From: Jamie Iles [mailto:jamie at jamieiles.com]
> > > Sent: Saturday, February 05, 2011 6:04 PM
> > > To: John Linn
> > > Cc: linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org; linux at arm.linux.org.uk;
> > > catalin.marinas at arm.com; glikely at secretlab.ca; Kiran Sutariya
> > > Subject: Re: [PATCH 3/4] ARM: Xilinx: Adding timer support to the
> > platform
> > >
> > > Hi John,
> > >
> > > A couple more nitpicks.
> > >
> > > Jamie
> > >
> > > On Sat, Feb 05, 2011 at 09:17:16AM -0700, John Linn wrote:
> > > > +static irqreturn_t xttcpss_clock_event_interrupt(int irq, void
> > *dev_id)
> > > > +{
> > > > +	struct clock_event_device *evt = &xttcpss_clockevent;
> > > > +	struct xttcpss_timer *timer = dev_id;
> > > > +	u32 ctrl_reg;
> > > > +
> > > > +	/* Acknowledge the interrupt and call event handler */
> > > > +	xttcpss_write(timer->base_addr + XTTCPSS_ISR_OFFSET,
> > > > +		xttcpss_read(timer->base_addr +
XTTCPSS_ISR_OFFSET));
> > > > +
> > > > +	if (timer->mode == CLOCK_EVT_MODE_ONESHOT) {
> > > > +
> > > > +		/* Disable the counter as it would keep running.
*/
> > > > +		ctrl_reg = xttcpss_read(timer->base_addr +
> > > > +
XTTCPSS_CNT_CNTRL_OFFSET);
> > > > +		ctrl_reg |= ~(XTTCPSS_CNT_CNTRL_ENABLE_MASK);
> > >
> > > The clock events framework should reprogram the next event so you
> > don't
> > > actually need to disable the timer here.  Once the event handler
has
> > > been called the timer will be reenabled with a new period, and as
> > we're
> > > running with interrupts disabled here we don't need to stop the
timer.
> > >
> >
> > What about if there's not another event to be started?
> 
> Then the clockevents code can set the mode to CLOCK_EVT_MODE_SHUTDOWN
> and this should disable the timer.  For NOHZ, AFAICT the
> clockevents/tick code will make sure that the next tick always falls
> within your max_delta_ns.
> 
> Jamie

Thanks, appreciate that help as I'm still learning more on the clock
mgmt.

Sounds good, I can stop it and test that.

-- John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
