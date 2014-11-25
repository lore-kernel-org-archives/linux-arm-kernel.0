From: Elliott@hp.com (Elliott, Robert (Server Storage))
Date: Tue, 25 Nov 2014 03:02:30 +0000
Subject: [PATCH RESEND v8] iopoll: Introduce memory-mapped IO polling
 macros
In-Reply-To: <vnkwy4r0gjne.fsf@mitchelh-linux.qualcomm.com>
References: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
 <94D0CD8314A33A4D9D801C0FE68B4029593C5E1F@G9W0745.americas.hpqcorp.net>
 <vnkwy4r0gjne.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <94D0CD8314A33A4D9D801C0FE68B4029593C61A3@G9W0745.americas.hpqcorp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mitchel Humpherys [mailto:mitchelh at codeaurora.org]
> Sent: Monday, November 24, 2014 7:21 PM
> To: Elliott, Robert (Server Storage)
...
> > The hpsa SCSI driver used to use usleep_range in a loop like
> > that, but we found that it caused scheduler problems during
> > boots because it uses TASK_UNINTERRUPTIBLE:
> > [    9.260668] [sched_delayed] sched: RT throttling activated
> >
> > msleep() worked much better.

Sorry, that might have been msleep_interruptible() - the fixes
are still not upstream, so I'll have to doublecheck tomorrow.

> Hmm, maybe you were just sleeping for too long?  According to
> Documentation/timers/timers-howto.txt, usleep_range is what should be
> used for non-atomic sleeps in the range [10us, 20ms].  Plus we need
> microsecond granularity anyways, so msleep wouldn't cut it.

The intervals and the overall number of loops were indeed long.  I 
think the corrected code waits a total of 1 second; before the fix,
600 seconds.

> If there are any potential users of these macros that would want to
> sleep for more than 20ms I guess we could add a special case here to use
> msleep when sleep_us exceeds 20,000 or so.
...

Maybe just a comment in the documentation for the macro would suffice,
possibly with a separate macro for longer interval sleeps.  I don't
want to force an extra msleep() call to be compiled into a bunch
of places where it's not needed.


---
Rob Elliott    HP Server Storage
