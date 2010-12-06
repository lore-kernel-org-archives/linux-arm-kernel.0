From: per.fransson.ml@gmail.com (Per Fransson)
Date: Mon, 6 Dec 2010 10:34:31 +0100
Subject: mpcore watchdogs questions
In-Reply-To: <20101203145803.GQ18100@redhat.com>
References: <4CF8F702.1070502@stericsson.com>
	<20101203145803.GQ18100@redhat.com>
Message-ID: <AANLkTikRbF9yVUMLo2rRfM0zC2GRRhA7MD7dyCMR2+Sm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I am not entirely sure what you are looking for, but the

Well, the basic premise of the question is this:

We have these per-CPU watchdogs,
what's the best fit for them in a linux kernel setting?

Now, there's already a driver for these WDs, but even so the existing watchdog
framework seems more suited to non-local watchdogs which can be counted on
to stay awake all the time.

> kernel/{softlockup,watchdog}.c takes a different approach to a normal
> watchdog. ?Normal watchdogs have somebody kick them so they stay asleep,
> with the intention that if they wake up bad things happened.
>
> The hard/soft lockup detector will always wake up at a periodic rate and
> check to see if they system has progressed since the last check.
> Unfortunately, because of its periodic rate, it will cause wakeup events
> (though every 60 seconds isn't that bad is it? :-) ), except for the
> hardlockup case which uses the NMI. ?That is tied to cpu activity and
> won't fire an NMI if the cpu is sleeping.
>
> There have been talks about trying to tie the hrtimer and the kthread to
> the power management layer with the idea that if the system is sleeping
> there is no need to increment interrupt stats (using hrtimer) or check
> process usage (using the kthread). ?That would cut down the number of
> wakeups.
>

The way I see it, the idea behind the lockup detection code, and please correct
me if I'm wrong, is to cover the following case on a per-CPU basis:

* Assuming the CPU in question is actually chugging along, is it
getting real work
done, where "real work" is defined as being able to schedule a high-prio kernel
thread and have it perform the actions expected of it (kicking the watchdog).
In the hardlockup case "real work" is instead defined as being able to
respond to
hrtimers going off.

So, this is precisely why the Cortex-A9 mpcore WDs might work better
as a part of
the lockup detection code, they can only watch a CPU which is awake (enough) and
they do so on a per-CPU basis.

Regards,
Per
