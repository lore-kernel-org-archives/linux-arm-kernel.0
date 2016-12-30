From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Dec 2016 11:15:30 -0800
Subject: [PATCH] trace: extend trace_clock to support arch_arm clock
 counter
In-Reply-To: <20161220170458.GM10132@arm.com>
References: <1480666495-26536-1-git-send-email-sramana@codeaurora.org>
 <20161202110845.GC8266@arm.com> <5843D587.5010407@codeaurora.org>
 <20161206121346.GF2498@arm.com> <584E2F40.10904@codeaurora.org>
 <20161212104243.GA21248@arm.com> <58529799.9060206@codeaurora.org>
 <20161220170458.GM10132@arm.com>
Message-ID: <20161230191530.GI17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20, Will Deacon wrote:
> On Thu, Dec 15, 2016 at 06:46:09PM +0530, Srinivas Ramana wrote:
> > On 12/12/2016 04:12 PM, Will Deacon wrote:
> > >On Mon, Dec 12, 2016 at 10:31:52AM +0530, Srinivas Ramana wrote:
> > >>On 12/06/2016 05:43 PM, Will Deacon wrote:
> > >>>Does this mean we need a way to expose the frequency to userspace, too?
> > >>
> > >>Not really. The CNTFRQ_EL0 of timer subsystem holds the clock frequency of
> > >>system timer and is available to EL0.
> > >
> > >Experience shows that CNTFRQ_EL0 is often unreliable, and the frequency
> > >can be overridden by the device-tree. There are also systems where the
> > >counter stops ticking across suspend. Whilst both of these can be considered
> > >"broken", I suspect we want runtime buy-in from the arch-timer driver
> > >before registering this trace_clock.
> > 
> > Agree. It doesnt seem like architecture mandates initializing this.
> > For those systems where tick would stop, if not arch counter, i assume there
> > is some counter which falls in 'always ON' domain without which they cant
> > keep track of time.
> 
> We just need to avoid exposing this trace clock if the frequency was
> provided by firmware.
> 

We would need to know the frequency if we wanted to convert the
counter values into seconds. In our case, we don't really care to
do that. All we want to do is compare events in the ftrace log
with events in other hw subsystem logs. If we have the raw
counter value there then it makes it simple to compare the two
and debug problems. Now that isn't to say that it would be useful
to convert the counter value into seconds, but it doesn't look to
be a prerequisite of registering the trace clock.

If we want to expose the counter frequency to userspace we could
make a sysfs attribute for that and have userspace rely on it
instead of CNTFRQ_EL0. Or if we can make CNTFRQ_EL0 accesses trap
(forgive me for not looking at the ARM ARM right now) we can
emulate it based on the DT property.

And for systems where the counter stops during suspend, I imagine
the only problem would be tracing across suspend would show a
clock that doesn't keep counting while suspended. sched_clock()
already exhibits that behavior, so I'm not sure we've lost
anything here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
