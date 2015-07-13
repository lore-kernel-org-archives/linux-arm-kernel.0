From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 13 Jul 2015 14:29:32 +0900
Subject: [RFC 0/3] arm64: ftrace: fix incorrect output from stack tracer
Message-ID: <1436765375-7119-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported in the thread below[1], the output from stack tracer using
ftrace on arm64 seems to be incorrect due to different reasons. Each
problem is described and fixed repsectively in the following patches.
Please see the commit messages for the details.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html

If the patch[1/3], which adds "#ifdef CONFIG_ARM64" to generic ftrace code,
is not acceptable, we will have to introduce an arch-dependent function,
ie. arch_check_stack().

Even with those patches, we see another issue that the values in 'Size'
field are *inaccurate*. This is simply because we have no way to estimate
the value of stack pointer at each function from the content of stack.
Thus the function's reported stack size does not include its own local
variables, but includes *its child's* ones.
See more details below.

In my opinion, we cannot fix this issue unless analyzing the function's
first instruction, ie. "stp x29, x30, [sp, #xx]!".

* How does stack tracer identify each function's stack size?

Take an example, func-0 calls func-1 and func-1 calls func-2.
The stack layout looks like the below:
("p" is a temp variable in check_stack().)

sp2     +-------+ <--------- func-2's stackframe
        |       |
        |       |
fp2     +-------+
        |  fp1  |
        +-------+ <-- p1 (*p1 == stack_dump_trace[i] == lr1)
        |  lr1  |
        +-------+
        |       |
        |  func-2's local variables
        |       |
sp1     +-------+ <--------- func-1(lr1)'s stackframe
        |       |             (stack_dump_index[i] = top - p1)
        |  func-1's dynamic local variables
        |       |
fp1     +-------+
        |  fp0  |
        +-------+ <-- p0 (*p0 == stack_dump_trace[i+1] == lr0)
        |  lr0  |
        +-------+
        |       |
        |  func-1's local variables
        |       |
sp0     +-------+ <--------- func-0(lr0)'s stackframe
        |       |             (stack_dump_index[i+1] = top - p0)
        |       |
        *-------+ top

Stack tracer records the stack height of func-1 (== stack_dump_trace[i]):
	stack_dump_index[i] = <stack top> - <estimated stack pointer>
in check_stack() by searching for func-1's return address (lr1)
and eventually calculates func-1's stack size by:
	stack_dump_index[i] - stack_dump_index[i+1]
		=> (top - p1) - (top - p0)
		=> p1 - p0

On x86, this calculation is correct because x86's call instruction pushes
the return address to the stack and jump into the child(func-2) function,
thus the func-1's stack pointer is "p1" where *p1 is equal to
stack_dump_trace[i]. But this is not true on arm64.

AKASHI Takahiro (3):
  ftrace: adjust a function's pc to search for in check_stack() for
    arm64
  arm64: refactor save_stack_trace()
  arm64: ftrace: mcount() should not create a stack frame

 arch/arm64/kernel/entry-ftrace.S |   15 ++++++++-------
 arch/arm64/kernel/stacktrace.c   |   31 +++++++++++++++++++++++--------
 kernel/trace/trace_stack.c       |    4 ++++
 3 files changed, 35 insertions(+), 15 deletions(-)

-- 
1.7.9.5
