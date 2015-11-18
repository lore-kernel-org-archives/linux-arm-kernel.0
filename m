From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 18 Nov 2015 15:43:03 +0900
Subject: [PATCH v6 0/6] arm64: ftrace: fix incorrect output from stack tracer
Message-ID: <1447828989-4980-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the sixth patch series for fixing stack tracer on arm64.
The original issue was reported by Jungseok[1], and then I found more
issues[2].

patch1 is a proactive improvement of function_graph tracer. 
patch2 and 3 correspond to II-4(functions under function_graph tracer).
patch4, 5 and 6 correspond to II-1(slurping stack) and II-2(differences
between x86 and arm64).
patch6 is a function prologue analyzer test. This won't attest
the correctness of the functionality, but it can suggest that all
the traced functions are treated properly by this function.

We don't have to care about the original issue because the root cause
(patch "ARM64: unwind: Fix PC calculation") has been reverted in v4.3.

Among the issues in [2], this patchset doesn't address
- II-3(interrupted frame):
  Recent discussions[3] about introducing a dedicated interrupt stack
  suggests that we can avoid walking through from interrupt stack to
  process stack.
  (Please note that, even on x86, interrupt stack is not supported by
  stack tracer.)

  So recent interrupt-stack patch[4] is a prerequisite here.

- II-5(leaf function):
  I don't remember why I thought this was a problem, but anyhow "-pg"
  seems to disable omit-leaf-stack-frame.

I tested the code with v4.4-rc1 + Jungseok's/James' patch v7[4].


Changes from v5:
- removed a patch ("ftrace: allow arch-specific stack tracer")
  which is already in v4.4-rc1
- handle a "return_to_handler" entry in call stack lists in more commonr
  way by fixing such entries in unwind_frame(). This will cover all
  the cases, a) stack tracer, b) perf call graph and c) dump_backtrace.
  (patch 2, 3)
- fixed aarch64_insn_is_eret(). Thanks to Jungseok. (patch 4)
- removed some hunks (offseting AARCH64_INSN_SIZE) due to having reverted
  a patch ("ARM64: unwind: Fix PC calculation") (patch 3)
- fixed function prologue analyzer on big-endian kernel. Thanks to Yalin.
  (patch 5)
- fixed a stack size of the top function in stack tracer's output
  (its size was reported 16 bytes bigger than actual size due to
   mishandled ftrace_caller.) (patch 3)

Changes from v4:
- removed a patch("arm64: ftrace: adjust callsite addresses examined
		by stack tracer")
- added a function prologue analyzer test(patch 6)

Changes from v3:
- fixed build errors/warnings reported by kbuild test robot
- addressed Steven's comments around check_stack()
- removed a patch ("arm64: ftrace: allow for tracing leaf functions")
  I don't remember why I thought this was necessary, but anyhow "-pg" seems
  to disable omit-leaf-stack-frame.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/369316.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368003.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385337.html

AKASHI Takahiro (6):
  arm64: ftrace: modify a stack frame in a safe way
  arm64: pass a task parameter to unwind_frame()
  arm64: ftrace: fix a stack tracer's output under function graph
    tracer
  arm64: insn: add instruction decoders for ldp/stp and add/sub
  arm64: ftrace: add arch-specific stack tracer
  arm64: ftrace: add a test of function prologue analyzer

 arch/arm64/include/asm/ftrace.h     |    4 +-
 arch/arm64/include/asm/insn.h       |   18 +++
 arch/arm64/include/asm/stacktrace.h |   13 +-
 arch/arm64/kernel/ftrace.c          |   75 +++++++++-
 arch/arm64/kernel/insn.c            |  102 +++++++++++++
 arch/arm64/kernel/perf_callchain.c  |    5 +-
 arch/arm64/kernel/process.c         |    5 +-
 arch/arm64/kernel/return_address.c  |    5 +-
 arch/arm64/kernel/stacktrace.c      |  267 ++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/time.c            |    5 +-
 arch/arm64/kernel/traps.c           |    5 +-
 11 files changed, 482 insertions(+), 22 deletions(-)

-- 
1.7.9.5
