From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jul 2013 20:07:17 +0100
Subject: [PATCH v4 03/17] sched_clock: Use an hrtimer instead of timer
In-Reply-To: <51ED80E7.4050606@codeaurora.org>
References: <1374189690-10810-1-git-send-email-sboyd@codeaurora.org>
 <1374189690-10810-4-git-send-email-sboyd@codeaurora.org>
 <51ED781F.6060300@linaro.org> <51ED7DD5.8010000@codeaurora.org>
 <51ED80E7.4050606@codeaurora.org>
Message-ID: <20130722190717.GO24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 11:58:47AM -0700, Stephen Boyd wrote:
> On 07/22/13 11:45, Stephen Boyd wrote:
> > Hmm. Is it too early to use hrtimers? Moving the hrtimer_start() into
> > sched_clock_register() also causes the same crash.
> 
> Yes that seems to be the problem. The vexpress board is setting up the
> sched_clock in setup_arch() (via v2m_init_early) which runs before
> hrtimers_init(). I've only tested this on boards that setup the timer in
> the time_init() callback which runs after hrtimers_init(). Your patch
> should be fine, although it would be nice if we didn't have callers
> setting up the sched_clock so early.

However, it _is_ the correct place to do it, as I've repeatedly stated.
The reason for this is that the scheduler will have already read from
sched_clock() by the time you get to timer_init() to seed its idea of
the start time for PID0 - again, as I've explained multiple times.
