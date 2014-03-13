From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 13 Mar 2014 19:11:28 +0900
Subject: [PATCH v4 0/3] arm64: prerequisites for audit and ftrace
In-Reply-To: <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains some patches commonly applied for audit and ftrace.

Patch [1/3] defines syscall trace related TIF_* flags in order to add hooks,
including ftrace, audit and seccomp, later on.  Those features will be
implemented in separate patchsets, but it's safe to check for all TIF_*
now because they can not be turned on anyway.

Patch [2/3] doesn't change a behavior but make it easy and manageable to
confirm we invoke those hooks in correct order by splitting syscall_trace().

Patch [3/3] adds a commonly used function, which returns a return value of
system call.

Changes v3 -> v4:
* added "arm64: split syscall_trace() into separate functions for enter/
  exit", which is just a preparation for adding syscall trace hooks later.

Changes v2 -> v3:
* reverted a change in syscall_trace() in v1 [1/2]
* added "arm64: Add regs_return_value() in syscall.h" patch which was
  previously included in audit patch [2/2]

Changes v1 -> v2:
* added a guard against TIF_SYSCALL_TRACE at tracehook_report_syscall_*()
* renamed _TIF_WORK_SYSCALL to _TIF_SYSCALL_WORK

AKASHI Takahiro (3):
  arm64: make a single hook to syscall_trace() for all syscall features
  arm64: split syscall_trace() into separate functions for enter/exit
  arm64: Add regs_return_value() in syscall.h

 arch/arm64/include/asm/ptrace.h      |    5 ++++
 arch/arm64/include/asm/thread_info.h |   13 +++++++++
 arch/arm64/kernel/entry.S            |   15 +++++------
 arch/arm64/kernel/ptrace.c           |   48 ++++++++++++++++++++++++++--------
 4 files changed, 62 insertions(+), 19 deletions(-)

-- 
1.7.9.5
