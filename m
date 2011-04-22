From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 21 Apr 2011 20:13:13 -0700
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
References: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
Message-ID: <4DB0F249.6000307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikram Narayanan wrote:
> And also, are clocksoure and clockevents dependent on each other? I
> see in some platforms, that they have used 2 different timers for the
> above. Can a same clock be used for both clocksource and clockevents?
> Please throw some light on this. If it can be used so, what ties up
> the clocksource and clockevent?

You can look at msm for an example of a single timer being used both as
a clocksource and a clockevent. We end up shutting off the clocksource
whenever we shut down the clockevent. This does cause some issues.
Switching clocksources at runtime does not work. It will also cause
problems if you implement your own sched_clock function, as it will have
little choice but to return a stale cached value whenever the clockevent
is disabled, such as in the suspend path.

Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
