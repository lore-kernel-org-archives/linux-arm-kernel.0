From: kurt.kanzenbach@linutronix.de (Kurt Kanzenbach)
Date: Wed, 31 Oct 2018 14:06:51 +0100
Subject: [PATCH 1/2] net: axienet: recheck condition after timeout in
 mdio_wait()
In-Reply-To: <20181030.112511.957438343014682098.davem@davemloft.net>
References: <20181030093139.10226-1-kurt@linutronix.de>
 <20181030093139.10226-2-kurt@linutronix.de>
 <20181030.112511.957438343014682098.davem@davemloft.net>
Message-ID: <20181031130651.l4toezvyg4etevnh@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2018 at 11:25:11AM -0700, David Miller wrote:
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
>
> The condtion could change right after your last read of
> XAR_MDIO_MCR_OFFSET, which is the same thing that happens before your
> modifications to this code.

That's true. The problem is different: If the current task gets
preempted by a higher priority task between checking the condition and
the timeout code, then a timeout might be falsely detected. Consider the
following events:

loop:
 check mdio condition
 ------------------------
 task with real time priority may run for a long time
 ------------------------
 check for timeout
 wait

That's why I've added the recheck of the condition in the timeout case.

>
> It sounds more like the timeout is slightly too short, and that's the
> real problem that causes whatever behavior you think you are fixing
> here.

The timeout value is not the problem here.

Thanks,
Kurt
