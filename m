From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Fri, 30 Dec 2011 14:07:11 +0100
Subject: ftrace performance impact with different configuration
In-Reply-To: <1325175685.24045.5.camel@gandalf.stny.rr.com>
References: <CALZhoSRVNp=Sj2u2GHiQhuHOEdrfiM58KzG+RutvJV=8CoCpTQ@mail.gmail.com>
 <CAH+eYFDb4r235jAGjr7j5R5C+9YK9WeXXjVZGWQUB=330sOi0Q@mail.gmail.com>
 <1325175685.24045.5.camel@gandalf.stny.rr.com>
Message-ID: <23257775.9kkYY4quUh@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 29 d?cembre 2011 11:21:25 Steven Rostedt a ?crit :
> On Thu, 2011-12-29 at 21:12 +0530, Rabin Vincent wrote:
> > On Thu, Dec 29, 2011 at 14:08, Lei Wen <adrian.wenl@gmail.com> wrote:
> > > 2. Seem dynamic ftrace also could involve some penalty for the
> > > running
> > > system, although it patching the running kernel with nop stub...
> > > 
> > > For the second item, is there anyone done some research before that
> > > could zero the cost for the running system when the tracing is not
> > > enabled yet?
> > 
> > One thing that needs to be fixed (for ARM) is that for the new-style
> > mcounts, the nop that's currently being done is not really a nop -- it
> > removes the function call, but there is still an unnecessary push/pop
> > sequence.  This should be modified to have the push {lr} removed too.
> > (Two instructions replaced instead of one.)
> 
> Unfortunately you can't do this, at least not when the kernel is
> preemptible.
> 
> Say we have:
> 
> 	push lr
> 	call mcount
> 
> then we convert it to:
> 
> 	nop
> 	nop
> 
> The conversion to nop should not be an issue, and this is what would be
> done when the system boots up. But then we enable tracing, some low
> priority task could have been preempted after executing the first nop,
> and we call stop machine to do the conversions (if no stop machine, then
> lets just say a higher prio task is running while we do the
> conversions). Then we add both the push lr and call back. But when that
> lower priority task gets scheduled in again, it would have looked like
> it ran:
> 
> 	nop
> 	call mcount
> 
> Since the call to mcount requires that the lr was pushed, this process
> will crash when the return is done and we never saved the lr.
> 
> If you don't like the push. the best thing you can do is convert to:
> 
> 	jmp 1f
> 	call mcount
> 1:
> 
> This may not be as cheap as two nops, but it may be better than a push.

Sorry about being a bit naive, but why it is not possible to do it in two 
steps ?
call stop_machine to put the jmp which skip the call to mcount
Then wait until all tasks hits schedule() (synchronize_sched() ?)
Then modify both instructions to put in place the two nops since we know that 
nobody is calling mcount.

Thanks,

Philippe
