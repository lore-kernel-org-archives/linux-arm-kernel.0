From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jan 2017 15:12:36 +0000
Subject: [PATCH] arm64: Don't trace __switch_to if function graph tracer
 is enabled
In-Reply-To: <1482360288-124624-1-git-send-email-joelaf@google.com>
References: <1482360288-124624-1-git-send-email-joelaf@google.com>
Message-ID: <20170104151235.GI18193@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 02:44:46PM -0800, Joel Fernandes wrote:
> Function graph tracer shows negative time (wrap around) when tracing
> __switch_to if the nosleep-time trace option is enabled.
> 
> Time compensation for nosleep-time is done by an ftrace probe on
> sched_switch. This doesn't work well for the following events (with
> letters representing timestamps):
> A - sched switch probe called for task T switch out
> B - __switch_to calltime is recorded
> C - sched_switch probe called for task T switch in
> D - __switch_to rettime is recorded
> 
> If C - A > D - B, then we end up over compensating for the time spent in
> __switch_to giving rise to negative times in the trace output.
> 
> On x86, __switch_to is not traced if function graph tracer is enabled.
> Do the same for arm64 as well.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued for 4.11.

Will
