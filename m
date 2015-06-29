From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Jun 2015 12:23:35 +0100
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi
 tracepoints
In-Reply-To: <20150629100251.GZ7557@n2100.arm.linux.org.uk>
References: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
 <20150629100251.GZ7557@n2100.arm.linux.org.uk>
Message-ID: <20150629112335.GE29907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 11:02:51AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 24, 2015 at 01:14:18PM -0700, Stephen Boyd wrote:
> > John Stultz reported an RCU splat on ARM with ipi trace events
> > enabled. It looks like the same problem exists on ARM64.
> > 
> > At this point in the IPI handling path we haven't called
> > irq_enter() yet, so RCU doesn't know that we're about to exit
> > idle and properly warns that we're using RCU from an idle CPU.
> > Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
> > that RCU is informed about our exit from idle.
> > 
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Fixes: 45ed695ac10a "ARM64: add IPI tracepoints"
[...]
> The Fixes: line has a standard format, which is not the formatting above.
> Please see Documentation/SubmittingPatches section 2.  Thanks.

I re-wrote it in this instance. What's not clear to me is whether cc:
stable is still necessary with a Fixes: tag (I add it just in case).

Anyway, to simplify the process, I came up with a .gitconfig alias:

[alias]
        show-fixes = !git show --pretty=format:\"Fixes: %h (\\\"%s\\\")\nCc: <stable@vger.kernel.org> "#" $(git describe --match="v*" --contains $1 | cut -d - -f -1)+\n\n%b\" $1 "#"

And another for .vimrc (to replace a Fixes: line):

command! GitFixes
	\ :.!read tagname commit; git show-fixes $commit 2> /dev/null | head -n 2

-- 
Catalin
