From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 30 Oct 2015 14:25:35 +0900
Subject: [PATCH v4 0/6] arm64: ftrace: fix incorrect output from stack tracer
Message-ID: <1446182741-31019-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth patch series for fixing stack tracer on arm64.
The original issue was reported by Jungseok[1], and then I found more
issues[2].
(Steven, Jungseok, sorry for not replying to your comments directly.)

I address here all the issues and implement fixes described in [2] except
for interrupt-triggered problems(II-3) and leaf function(II-5).  Recent
discussions[3] about introducing a dedicated interrupt stack suggests that
we may avoid walking through from an interrupt stack to a process stack.
(So interrupt-stack patch is a prerequisite.)

Basically,
patch1 corresponds to the original issue.
patch2 is a proactive improvement of function_graph tracer. 
patch3 corresponds to II-4(functions under function_graph tracer).
patch4, 5 and 6 correspond to II-1(slurping stack) and II-2(differences
between x86 and arm64).

Each fix can be applied independently, but if patch4, 5 and 6 are
acceptable, patch1 is not necessary because patch7 replaces a default
stack tracer.

I tested the code with v4.3-rc7 + Jungseok's patch v5[4].

Changes from v3:
- fixed build errors/warnings reported by kbuild test robot
- addressed Steven's comments around check_stack()
- removed a patch ("arm64: ftrace: allow for tracing leaf functions")
  I don't remember why I thought this was necessary, but anyhow "-pg" seems
  to disable omit-leaf-stack-frame.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html 
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368003.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378699.html

AKASHI Takahiro (6):
  arm64: ftrace: adjust callsite addresses examined by stack tracer
  arm64: ftrace: modify a stack frame in a safe way
  arm64: ftrace: fix a stack tracer's output under function graph
    tracer
  ftrace: allow arch-specific stack tracer
  arm64: insn: add instruction decoders for ldp/stp and add/sub
  arm64: ftrace: add arch-specific stack tracer

 arch/arm64/include/asm/ftrace.h     |    7 +-
 arch/arm64/include/asm/insn.h       |   18 +++
 arch/arm64/include/asm/stacktrace.h |    4 +
 arch/arm64/kernel/ftrace.c          |   79 +++++++++++--
 arch/arm64/kernel/insn.c            |  102 +++++++++++++++++
 arch/arm64/kernel/stacktrace.c      |  213 ++++++++++++++++++++++++++++++++++-
 include/linux/ftrace.h              |   17 +++
 kernel/trace/trace_stack.c          |   88 ++++++++-------
 8 files changed, 473 insertions(+), 55 deletions(-)

-- 
1.7.9.5
