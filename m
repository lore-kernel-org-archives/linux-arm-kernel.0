From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu,  8 Oct 2015 19:01:37 +0900
Subject: [PATCH v3 0/7] arm64: ftrace: fix incorrect output from stack tracer
Message-ID: <1444298504-10392-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third patch series for fixing stack tracer on arm64.
The original issue was reported by Jungseok[1], and then I found more
issues[2].
(Steven, Jungseok, sorry for not replying to your comments directly.)

I address here all the issues and implement fixes described in [2] except
for interrupt-triggered problems, ie. II-3). Recent discussions[3] about
introducing a dedicated interrupt stack suggests that we may avoid walking
through from an interrupt stack to a process stack.
(So interrupt-stack patch is a prerequisite.)

Basically,
patch1 corresponds to the original issue.
patch2 is a proactive improvement of function_graph tracer. 
patch3 corresponds to II-4(functions under function_graph tracer).
patch4 corresponds to II-5(leaf function).
patch5, 6 and 7 correspond to II-1(slurping stack) and II-2(differences
between x86 and arm64).

Each fix can be applied independently, but if patch5, 6 and 7 are
acceptable, patch1 is not necessary because patch7 replaces a default
stack tracer.

I tested the code with v4.3-rc3 + Jungseok's patch v3[4].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/355920.html 
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/368003.html
[4] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371451.html

AKASHI Takahiro (7):
  arm64: ftrace: adjust callsite addresses examined by stack tracer
  arm64: ftrace: modify a stack frame in a safe way
  arm64: ftrace: fix a stack tracer's output under function graph
    tracer
  arm64: ftrace: allow for tracing leaf functions
  ftrace: allow arch-specific stack tracer
  arm64: insn: add instruction decoders for ldp/stp and add/sub
  arm64: ftrace: add arch-specific stack tracer

 arch/arm64/Makefile                 |    5 +
 arch/arm64/include/asm/ftrace.h     |    7 +-
 arch/arm64/include/asm/insn.h       |   18 +++
 arch/arm64/include/asm/stacktrace.h |    1 +
 arch/arm64/kernel/ftrace.c          |   77 +++++++++++--
 arch/arm64/kernel/insn.c            |  102 +++++++++++++++++
 arch/arm64/kernel/stacktrace.c      |  213 ++++++++++++++++++++++++++++++++++-
 include/linux/ftrace.h              |   17 +++
 kernel/trace/trace_stack.c          |   27 +++--
 9 files changed, 442 insertions(+), 25 deletions(-)

-- 
1.7.9.5
