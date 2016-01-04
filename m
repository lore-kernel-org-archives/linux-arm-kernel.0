From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jan 2016 16:55:35 +0000
Subject: [PATCH v2] arm64: Store breakpoint single step state into pstate
In-Reply-To: <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
References: <1450860731-194418-1-git-send-email-wangnan0@huawei.com>
 <1450921362-198371-1-git-send-email-wangnan0@huawei.com>
Message-ID: <20160104165535.GI1616@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 24, 2015 at 01:42:42AM +0000, Wang Nan wrote:
> Two 'perf test' fail on arm64:
> 
>  # perf test overflow
>  17: Test breakpoint overflow signal handler                  : FAILED!
>  18: Test breakpoint overflow sampling                        : FAILED!
> 
> When breakpoint raises, after perf_bp_event, breakpoint_handler()
> temporary disables breakpoint and enables single step. Then in
> single_step_handler(), reenable breakpoint. Without doing this
> the breakpoint would be triggered again.
> 
> However, if there's a pending signal and it have signal handler,
> control would be transfer to signal handler, so single step handler
> would be applied to the first instruction of signal handler. After
> the handler return, the instruction triggered the breakpoint would be
> executed again. At this time the breakpoint is enabled, so the
> breakpoint is triggered again.

Whilst I appreciate that you're just trying to get those tests passing
on arm64, I really don't think its a good idea for us to try and emulate
the x86 debug semantics here. This doesn't happen for ptrace, and I think
we're likely to break more than we fix if we try to do it for perf too.

The problem seems to be that we take the debug exception before the
breakpointed instruction has been executed and call perf_bp_event at
that moment, so when we single-step the faulting instruction we actually
step into the SIGIO handler and end up getting stuck.

Your fix doesn't really address this afaict, in that you don't (can't?)
handle:

  * A longjmp out of a signal handler
  * A watchpoint and a breakpoint that fire on the same instruction
  * User-controlled single-step from a signal handler that enables a
    breakpoint explicitly
  * Nested signals

so I'd really rather leave the code as-is.

Will
