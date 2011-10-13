From: tixy@yxit.co.uk (Tixy)
Date: Thu, 13 Oct 2011 08:40:42 +0100
Subject: [PATCH] [RFC PATCH] ARM: kprobes: Make breakpoint
	setting/clearing SMP safe
In-Reply-To: <CAH+eYFDSG=npBEjEgObqg+vPk8QuJBnnnGyULk9s-C9Bq3iH8Q@mail.gmail.com>
References: <1310474402-5398-1-git-send-email-tixy@yxit.co.uk>
	<CAH+eYFDSG=npBEjEgObqg+vPk8QuJBnnnGyULk9s-C9Bq3iH8Q@mail.gmail.com>
Message-ID: <1318491642.2265.36.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-12 at 22:03 +0530, Rabin Vincent wrote:
> On Tue, Jul 12, 2011 at 18:10, Tixy <tixy@yxit.co.uk> wrote:
> > Both these issues are known and the kprobe implementation uses
> > stop_machine() to avoid them, however, this is not sufficient.
> > stop_machine() does not perform any kind on synchronisation between CPUs
> > so it it still possible for one CPU to call the breakpoint changing
> > function before another CPU has been interrupted to do likewise.
> >
> > To fix this problem, this patch creates a new function
> > sync_stop_machine() which ensures that all online CPUs execute the
> > specified function at the same time.
> 
> AFAICS stop_machine() already does what you want.  When you use
> stop_machine(), the actual call to your function is done (on each
> CPU's stopper thread) using the stop_machine_cpu_stop() function,
> which already has the synchronization between CPUs which you're
> trying to do here.

The only serialisation I can see is the wait_for_completion() in
__stop_cpus() which waits for the all CPUs to have executed the
requested function. I don't see anything which prevents one CPU from
starting (and finishing) the requested function before other CPU's are
ready for it. If this synchronisation existed it would have to be in
cpu_stopper_thread() as it pulls tasks off the work list.

In queue_stop_cpus_work() we have

	for_each_cpu(cpu, cpumask)
		cpu_stop_queue_work(&per_cpu(cpu_stopper, cpu),
				    &per_cpu(stop_cpus_work, cpu));

If the CPU executing this gets delayed by an ISR on each iteration of
the for_each_cpu loop then the work it queues for one CPU could have
completed before it gets around to queuing it for the next CPU.

-- 
Tixy
