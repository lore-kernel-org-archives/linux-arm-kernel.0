From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Sep 2012 11:44:29 -0700
Subject: [PATCH] perf: Use raw_smp_processor_id insted of smp_processor_id
In-Reply-To: <20120912120511.GD28448@n2100.arm.linux.org.uk>
References: <1347450610-4342-1-git-send-email-rogerq@ti.com>
 <20120912120511.GD28448@n2100.arm.linux.org.uk>
Message-ID: <5050D80D.90002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/12 05:05, Russell King - ARM Linux wrote:
> NAK.  Using a different function which doesn't have the warning isn't a
> subsitute for fixing the problem properly.  What you're doing is papering
> over the bug, making the warning go away without properly understanding
> the problem.
>
> The warning is there because something is being done wrong.  What that is
> is exactly what is being said in the warning message.  You're getting a
> CPU number in a context where preemptions can occur - and therefore the
> CPU that you're running on can change.
>
> Think about this sequence:
>
> 	- cpu = smp_processor_id(); /* returns 0 */
> 	- you are preempted
> 	- you resume on CPU 1
> 	- trace_clock_disable(clk->name, 0, 0);
>
> If trace_clock_disable() uses the CPU number to access per-CPU data
> without locking, that's going to cause corruption.
>
> Please, if you're going to fix a warning, analyse it properly first and
> don't just search for a function which appears to give you the same
> functionality but without the warning message.

Is anyone actually using the CPU field in this tracepoint? I don't see
any usecase for it except for the case where you have a percpu clock,
but even then I imagine the name of the clock would be different
depending on which CPU it corresponds to. So why can't we just remove
the CPU field from the tracepoint?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
