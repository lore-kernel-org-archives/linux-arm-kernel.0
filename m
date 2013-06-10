From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 10 Jun 2013 14:52:08 -0400
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
Message-ID: <1370890328.9844.111.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-06-10 at 13:36 -0400, Alan Stern wrote:

> > I don't think so, and obviously softirq allows IRQs to be served quickly,
> > otherwise why is softirq and tasklet introduced?

Because of history. In the old days there were top halves (hard irq) and
bottom halves (like a softirq). The thing about a bottom half was, no
two could run at the same time. That is, if one CPU was running a bottom
half, another CPU would have to wait for that one to complete before it
could run any bottom half. The killer here is that it didn't matter if
it was the same bottom half or not! Microsoft/Mindcraft was kind enough
to point out this inefficiency with some benchmarks showing how horrible
Linux ran on a 4 way box. Thanks to them, softirqs and tasklets were
born :-)

A softirq does the rest of the interrupt work with interrupts enabled.

A tasklet is run from softirq context, but the difference between a
softirq and tasklet is that the same tasklet can not run on two
different CPUs at the same time. It acts similar to a task, as a task
can not run on two different CPUs at the same time either, hence the
name "tasklet". But tasklets are better than bottom halves because it
allows for different tasklets to run on different CPUs.



>  and why so many drivers
> > are using tasklet/softirq?

Because it's easy to set up and device driver authors don't know any
better ;-). Note, a lot of drivers are now using work queues today,
which run as a task.

Yes, there's a little more overhead with a task than for a softirq, but
the problem with softirqs and tasklets is that they can't be preempted,
and they are more important than all tasks on the system. If you have a
task that is critical, it must yield for your softirq. Almost!

That is, even if you have a softirq, it may not run in irq context at
all. If you get too many softirqs at a time (one comes while another one
is running), it will defer the processing to the ksoftirq thread. This
not only runs as a task, but also runs as SCHED_OTHER, and must yield to
other tasks like everyone else too.

Thus, adding it as a softirq does not guarantee that it will be
processed quickly. It just means that most of the time it will prevent
anything else from happening while your "most important handler in the
world" is running.

-- Steve
