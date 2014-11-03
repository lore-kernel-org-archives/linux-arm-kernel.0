From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Mon, 3 Nov 2014 21:14:56 +0100
Subject: [RFC Patch 2/4] mfd: AXP20x: Add power supply sub-driver
In-Reply-To: <20141023201235.3b94cc82@smutje.local>
References: <20141020215954.7f1d5502@neptune.home>
 <20141020223320.2b4ecba9@neptune.home>
 <20141023201235.3b94cc82@smutje.local>
Message-ID: <20141103211456.2eb13a6e@neptune.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 October 2014 Edgar Toernig <froese@gmx.de> wrote:
> > +	getnstimeofday(&ts);
> > +	/* only query hardware if our data is stale */
> > +	spin_lock(&devdata->lock);
> > +	if (!init && !(ts.tv_sec > devdata->next_check.tv_sec ||
> > +	               ts.tv_nsec > devdata->next_check.tv_sec)) {
> > +		spin_unlock(&devdata->lock);
> > +		return 0;
> > +	}
> > +	spin_unlock(&devdata->lock);
> 
> That time comparison is broken - it compares nsec with sec and
> doesn't check that secs are equal before comparing the nsecs.
> There's timespec_compare which gets it right.

Oops, yeah, going to switch to timespec_compare().
Thanks for spotting!

> Btw, you are aware that the timeofday is a user adjustable
> value?  If I ever turn back system time I won't get power
> data any more until the old (future) time is reached.

Huh, no, I didn't consider that.

> Wouldn't it be easier to simply use jiffies and limit the
> poll rate to one second or so?

I considered limiting to some arbitrary polling rate though think
it's better to give users the option to query values more often,
up to the rate at which the value are measured by AXP.
As the AXP's measurement rate is configurable (not exposed by
driver) it's better to base on that setting instead of having
to care at the time of exposing the configuration knob.

Thus jiffies seem to be a bit at their limit. Is using ktime better?


Bruno
