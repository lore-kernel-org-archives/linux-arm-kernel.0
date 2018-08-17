From: duwe@lst.de (Torsten Duwe)
Date: Fri, 17 Aug 2018 12:25:44 +0200 (CEST)
Subject: [PATCH v2 0/3] arm64 live patching
Message-ID: <20180817102544.C628D68EF4@newverein.lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all!

Here's v2; I hope I have incorporated all feedback properly.
Julien: #S_X28 + 8 is in, but ftrace_modify_call() is referenced
from generic code: kernel/trace/ftrace.c __ftrace_replace_code()

And I'd *really* like some feedback from ARM/Linaro/... on the stack
unwinder!

[Changes from v1]:

* Missing compiler support is now a Makefile error, instead
  of a warning. This will keep the compile log shorter and
  it will thus be easier to spot the problem.

* A separate ftrace_regs_caller. Only that one will write out
  a complete pt_regs, for efficiency.

* Replace the use of X19 with X28 to remember the old PC during
  live patch detection, as only that is saved&restored now for
  non-regs ftrace.

* CONFIG_DYNAMIC_FTRACE_WITH_REGS and CC_USING_PATCHABLE_FUNCTION_ENTRY
  are currently synonymous on arm64, but differentiate better for
  the future when this is no longer the case.

* Clean up "old"/"new" insn value setting vs. #ifdefs.

* #define a INSN_MOV_X9_X30 with suggested aarch64_insn_gen call
  and use that instead of an immediate hex value.

	Torsten
