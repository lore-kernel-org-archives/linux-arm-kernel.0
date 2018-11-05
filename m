From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Mon, 5 Nov 2018 10:16:03 +0100
Subject: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
In-Reply-To: <20181030.112511.957438343014682098.davem@davemloft.net>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-2-kurt@linutronix.de>
 <20181030.112511.957438343014682098.davem@davemloft.net>
Message-ID: <20181105091601.5dgwkcd4wcsw2cvp@breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-10-30 11:25:11 [-0700], David Miller wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> Date: Tue, 30 Oct 2018 10:31:38 +0100
> 
> > The function could report a false positive if it gets preempted between reading
> > the XAE_MDIO_MCR_OFFSET register and checking for the timeout.  In such a case,
> > the condition has to be rechecked to avoid false positives.
> > 
> > Therefore, check for expected condition even after the timeout occurred.
> > 
> > Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>  ...
> >  		if (time_before_eq(end, jiffies)) {
> > -			WARN_ON(1);
> > -			return -ETIMEDOUT;
> > +			val = axienet_ior(lp, XAE_MDIO_MCR_OFFSET);
> > +			break;
> >  		}
> > +
> >  		udelay(1);
> >  	}
> > -	return 0;
> > +	if (val & XAE_MDIO_MCR_READY_MASK)
> > +		return 0;
> > +
> > +	WARN_ON(1);
> > +	return -ETIMEDOUT;
> 
> You are not fundamentally changing the situation at all.

> The condtion could change right after your last read of
> XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
> modifications to this code.
> 
> It sounds more like the timeout is slightly too short, and that's the
> real problem that causes whatever behavior you think you are fixing
> here.

There is a timeout of two jiffies. If the condition is not true within
those two jiffies it will attempt to check condition one last time after
the timeout occured.
If the task got preempted after the reading from the register but before
the timeout it is possible that the task gets back on the CPU after the
timeout occured. And since the timeout occured it won't check if the
condition changed:
Time
 0   +---+
     | c | Check for condition (false)
     | c |
     | c |
     | c |
     | c |
     | P | Task gets preempted
     |   |
     | O | Condition is true, task still preempted, no check
     |   |
 2   | T | The timeout is true
     |   |
     |   |
     |   |
     | p | Task gets back on the CPU, no re-check of condition

In the last step, there is no checking of the condition after the
timeout occured and it wrongly assumes that the condition is not true.
Increasing the timeout would help as long as the task gets not preempted
past the new timeout.
The same pattern (check condition after timeout) is also used in
wait_event_timeout() or readx_poll_timeout().  Would you prefer to
refactor this with readx_poll_timeout() instead?

> I'm not applying this.
Please reconsider.

Sebastian
