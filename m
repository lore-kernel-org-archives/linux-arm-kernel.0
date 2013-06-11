From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Jun 2013 16:40:03 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1370897680.9844.118.camel@gandalf.local.home>
References: <Pine.LNX.4.44L0.1306101642400.1133-100000@iolanthe.rowland.org>
 <1370897680.9844.118.camel@gandalf.local.home>
Message-ID: <CACVXFVMVrHC6YmJL905CaB7BRMM3T2D6rrR1UxKv3_i+gH22Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 4:54 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2013-06-10 at 16:47 -0400, Alan Stern wrote:
>> On Mon, 10 Jun 2013, Steven Rostedt wrote:
>>
>> > >  and why so many drivers
>> > > > are using tasklet/softirq?
>> >
>> > Because it's easy to set up and device driver authors don't know any
>> > better ;-). Note, a lot of drivers are now using work queues today,
>> > which run as a task.
>> >
>> > Yes, there's a little more overhead with a task than for a softirq, but
>> > the problem with softirqs and tasklets is that they can't be preempted,
>> > and they are more important than all tasks on the system. If you have a
>> > task that is critical, it must yield for your softirq. Almost!
>> >
>> > That is, even if you have a softirq, it may not run in irq context at
>> > all. If you get too many softirqs at a time (one comes while another one
>> > is running), it will defer the processing to the ksoftirq thread. This
>> > not only runs as a task, but also runs as SCHED_OTHER, and must yield to
>> > other tasks like everyone else too.
>> >
>> > Thus, adding it as a softirq does not guarantee that it will be
>> > processed quickly. It just means that most of the time it will prevent
>> > anything else from happening while your "most important handler in the
>> > world" is running.
>>
>> >From this, it sounds like you generally advise using threaded interrupt
>> handlers rather than tasklets/softirqs.
>
> Yes, there's plenty of benefits for them, and I highly doubt that any
> USB device would even notice the difference between a softirq and a
> thread for response time latencies.

Steven, thanks for your input.

IMO, about the problem, the most important point between threaded interrupt
handler and tasklet is the latency.

For USB video/audio application, the data need to be handled very quickly.
Also new transfer need to be scheduled without much latency. I am wondering
if interrupt thread handler can respond quickly enough if there is high load on
CPUs.

For USB mass storage driver, it still need to be handled quickly.

If tasklet is taken, tasklet_schedule() is always called from hard interrupt
context, so most of time the latency should be better than interrupt thread
handler latency since tasklet handler is called just after irq handler exits in
the situation.  Also we can avoid to do tasklet_schedule when the tasklet
is being handled.

I will compare, collect and post out some latency data later for the sake of
choosing which one to handle URB giveback.

Thanks,
--
Ming Lei
