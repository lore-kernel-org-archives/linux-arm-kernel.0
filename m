From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Apr 2013 14:19:52 +0100
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <20130415114307.GC29528@arm.com>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
 <1365510814-21343-1-git-send-email-cov@codeaurora.org>
 <20130415101159.GA25095@localhost.cambridge.arm.com>
 <20130415104542.GE9827@mudshark.cambridge.arm.com>
 <20130415105840.GB29528@arm.com> <20130415114307.GC29528@arm.com>
Message-ID: <20130415131952.GH9827@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 12:43:07PM +0100, Catalin Marinas wrote:
> On Mon, Apr 15, 2013 at 11:58:40AM +0100, Catalin Marinas wrote:
> > On Mon, Apr 15, 2013 at 11:45:42AM +0100, Will Deacon wrote:
> > > Really? If prev is NULL in context_switch(...), the scheduler will implode,
> > > and I can't see where else switch_to is called from.
> > > 
> > > Which code path are you thinking of?
> > 
> > copy_thread() zeros cpu_context which is used by cpu_switch_to() to load
> > the next saved registers. The switch_to() function sets prev to last as
> > returned by __switch_to(), so this is valid but in __switch_to() we
> > don't have a valid prev (nor next) after cpu_switch_to() for newly
> > created threads.
> 
> Correction - newly created threads return to ret_from_fork rather than
> __switch_to(), which means that we miss the first
> contextidr_thread_switch() call for a new thread. I would vote for
> Christopher's original patch moving the call before cpu_switch_to(). The
> alternative is to define finish_arch_switch() and add the call there. If
> you are primarily tracing user space, it doesn't really matter whether
> the stack was switched or not when we set the contextidr. For kernel
> tracking, it could be a problem as we have the next task with the old
> stack. But the same could be said about the prev task with the new
> stack.

The sp defines the current task, which is what the debugger will be
interested in and will likely try to correlate with the PID reported in
the contextidr, so I still maintain that it's important for these to be
in sync.

Will
