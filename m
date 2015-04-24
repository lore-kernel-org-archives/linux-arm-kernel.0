From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 11:44:05 +0900
Subject: [RFC 0/4] arm64: add livepatch support
Message-ID: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables livepatch support on arm64.

Livepatch was merged in v4.0, and allows replacying a function dynamically
based on ftrace framework, but it also requires -mfentry option of gcc.
Currently arm64 gcc doesn't support it, but by adding a helper function to
ftrace, we will be able to support livepatch on arch's which don't support
this option.

I submit this patchset as RFC since I'm not quite sure that I'm doing
in the right way, or we should definitely support -fentry instead.

Please note that I tested the feature only with livepatch-sample, and
the code for DYNAMIC_TRACE_WITH_REGS is still rough-edged.

To: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
To: Seth Jennings <sjenning@redhat.com>
To: Jiri Kosina <jkosina@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will.deacon@arm.com>

AKASHI Takahiro (4):
  ftrace: add a helper function for livepatch
  livepatch: adjust a patched function's address
  arm64: ftrace: add DYNAMIC_TRACE_WITH_REGS version
  arm64: add livepatch support

 arch/arm64/Kconfig                 |    4 ++
 arch/arm64/include/asm/ftrace.h    |    4 ++
 arch/arm64/include/asm/livepatch.h |   38 +++++++++++
 arch/arm64/kernel/Makefile         |    1 +
 arch/arm64/kernel/entry-ftrace.S   |  124 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c         |   24 ++++++-
 arch/arm64/kernel/livepatch.c      |   68 ++++++++++++++++++++
 arch/x86/include/asm/livepatch.h   |    5 ++
 include/linux/ftrace.h             |    2 +
 include/linux/livepatch.h          |    2 +
 kernel/livepatch/core.c            |   16 +++--
 kernel/trace/ftrace.c              |   26 ++++++++
 12 files changed, 309 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/livepatch.h
 create mode 100644 arch/arm64/kernel/livepatch.c

-- 
1.7.9.5
