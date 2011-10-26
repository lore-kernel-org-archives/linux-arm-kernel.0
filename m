From: tixy@yxit.co.uk (Tixy)
Date: Wed, 26 Oct 2011 07:28:47 +0100
Subject: [PATCH] ARM: kprobes: only patch instructions on one CPU
In-Reply-To: <20111025153652.GA11649@debian>
References: <1318435944-21855-1-git-send-email-rabin@rab.in>
	<1318492515.2265.51.camel@computer2>
	<1318496852.2213.39.camel@computer2>
	<20111025153652.GA11649@debian>
Message-ID: <1319610527.2246.17.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-25 at 21:06 +0530, Rabin Vincent wrote:
> On Thu, Oct 13, 2011 at 10:07:32AM +0100, Tixy wrote:
> > As I said in my reply to the other mail, I had missed the fact that it
> > is stop_machine_cpu_stop() which is used to call our function, and this
> > synchronises all cores. Therefore, this patch is correct, assuming that
> > a flush_icache_range executed on one core also flushes I-caches on other
> > cores. (I'm a bit doubtfull of this as I beleive that at least
> > ARM11MPCore requires this to be managed in software and I can't find any
> > code that handles this.)
> 
> If we want kprobes to work correctly on ARM11MPCore, shouldn't we need
> to broadcast the invalidate in arch_prepare_kprobe() and the
> non-stop-machine-using parts of arch_arm_kprobe() too?

We would, though the effect of not doing so would be safer. I.e. we
would just miss triggering kprobes, whereas when removing probes the
effect could be a processes faulting when it executes the 'breakpoint'
instruction still in the I cache.

> Also, it seems odd to perform the instruction write and
> flush_icache_range() on every CPU from stop_machine().  Perhaps it would
> be better if there were a way in stop_machine() to call an I-cache
> invalidation function on all CPUs, after the arm/disarm function is
> called on only one of them.

The arm/disarm functions only writes an instruction to RAM and flushes
the I-cache for it. It doesn't seem worth the effort of adding code to
avoid the couple of instruction required to write the instruction,
especially as stop_machine() is already causing all CPUs to reschedule,
sync with each other, and reschedule again.

As you say though, it should be possible and looks nicer if the disarm
code was only called on one CPU. I'm just trying to point out that there
may be risks and there is little performance benefit.

-- 
Tixy
