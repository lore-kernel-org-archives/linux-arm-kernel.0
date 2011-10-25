From: rabin@rab.in (Rabin Vincent)
Date: Tue, 25 Oct 2011 21:06:52 +0530
Subject: [PATCH] ARM: kprobes: only patch instructions on one CPU
In-Reply-To: <1318496852.2213.39.camel@computer2>
References: <1318435944-21855-1-git-send-email-rabin@rab.in>
	<1318492515.2265.51.camel@computer2>
	<1318496852.2213.39.camel@computer2>
Message-ID: <20111025153652.GA11649@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 10:07:32AM +0100, Tixy wrote:
> As I said in my reply to the other mail, I had missed the fact that it
> is stop_machine_cpu_stop() which is used to call our function, and this
> synchronises all cores. Therefore, this patch is correct, assuming that
> a flush_icache_range executed on one core also flushes I-caches on other
> cores. (I'm a bit doubtfull of this as I beleive that at least
> ARM11MPCore requires this to be managed in software and I can't find any
> code that handles this.)

If we want kprobes to work correctly on ARM11MPCore, shouldn't we need
to broadcast the invalidate in arch_prepare_kprobe() and the
non-stop-machine-using parts of arch_arm_kprobe() too?

Also, it seems odd to perform the instruction write and
flush_icache_range() on every CPU from stop_machine().  Perhaps it would
be better if there were a way in stop_machine() to call an I-cache
invalidation function on all CPUs, after the arm/disarm function is
called on only one of them.
