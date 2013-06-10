From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Jun 2013 16:47:09 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1370890328.9844.111.camel@gandalf.local.home>
Message-ID: <Pine.LNX.4.44L0.1306101642400.1133-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Steven Rostedt wrote:

> >  and why so many drivers
> > > are using tasklet/softirq?
> 
> Because it's easy to set up and device driver authors don't know any
> better ;-). Note, a lot of drivers are now using work queues today,
> which run as a task.
> 
> Yes, there's a little more overhead with a task than for a softirq, but
> the problem with softirqs and tasklets is that they can't be preempted,
> and they are more important than all tasks on the system. If you have a
> task that is critical, it must yield for your softirq. Almost!
> 
> That is, even if you have a softirq, it may not run in irq context at
> all. If you get too many softirqs at a time (one comes while another one
> is running), it will defer the processing to the ksoftirq thread. This
> not only runs as a task, but also runs as SCHED_OTHER, and must yield to
> other tasks like everyone else too.
> 
> Thus, adding it as a softirq does not guarantee that it will be
> processed quickly. It just means that most of the time it will prevent
> anything else from happening while your "most important handler in the
> world" is running.

>From this, it sounds like you generally advise using threaded interrupt 
handlers rather than tasklets/softirqs.

Alan Stern
