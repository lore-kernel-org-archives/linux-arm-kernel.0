From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Fri, 1 Sep 2017 18:31:58 +0800
Subject: [RFC PATCH v1 0/3] arm64/ras: support sea error recovery
Message-ID: <1504261921-39308-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
are consumed. In some cases, if the error address is in a clean page or a
read-only page, there is a chance to recover. Such as error occurs in a
instruction page, we can reread this page from disk instead of killing process.

Because memory_failure() may sleep, we can not call it directly in SEA exception
context. So we saved faulting physical address associated with a process in the
ghes handler and set __TIF_SEA_NOTIFY. When we return from SEA exception context
and get into do_notify_resume() before the process running, we could check it
and call memory_failure() to do recovery. It's safe, because we are in process
context.

In some platform, when SEA triggerred, physical address could be
reported by memory section or by processor section, so we save 
address at this two place.

Xie XiuQi (3):
  arm64/ras: support sea error recovery
  apei: add ghes param for arch_apei_report_mem_error
  arm64/apei: get error address from memory section for recovery

 arch/arm64/Kconfig                   |  11 +++
 arch/arm64/include/asm/ras.h         |  27 ++++++
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/ras.c              | 155 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c           |   8 ++
 arch/arm64/mm/fault.c                |  27 ++++--
 arch/x86/kernel/acpi/apei.c          |   2 +-
 drivers/acpi/apei/apei-base.c        |   4 +-
 drivers/acpi/apei/ghes.c             |   4 +-
 include/acpi/apei.h                  |   4 +-
 include/acpi/ghes.h                  |   3 +-
 12 files changed, 236 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c

-- 
1.8.3.1
