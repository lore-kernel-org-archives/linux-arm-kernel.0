From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Wed, 27 Sep 2017 20:50:16 +0800
Subject: [PATCH v4 0/4] arm64/ras: support sea error recovery
Message-ID: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
are consumed. According to the existing process, errors occurred in the
kernel, leading to direct panic, if it occurred the user-space, we should
just kill process.

But there is a class of error, in fact, is not necessary to kill
process, you can recover and continue to run the process. Such as
the instruction data corrupted, where the memory page might be
read-only, which is has not been modified, the disk might have the
correct data, so you can directly drop the page, ant reload it when
necessary.

So this patchset is just try to solve such problem: if the error is
consumed in user-space and the error occurs on a clean page, you can
directly drop the memory page without killing process.

If the corrupted page is clean, just dropped it and return to user-space
without side effects. And if corrupted page is dirty, memory_failure()
will send SIGBUS with code=BUS_MCEERR_AR. While without this patchset,
do_sea() will just send SIGBUS, so the process was killed in the same place.

Because memory_failure() may sleep, we can not call it directly in SEA
exception context. So we saved faulting physical address associated with
a process in the ghes handler and set __TIF_SEA_NOTIFY. When we return
from SEA exception context and get into do_notify_resume() before the
process running, we could check it and call memory_failure() to do
recovery. It's safe, because we are in process context.

In some platform, when SEA triggerred, physical address could be reported
by memory section or by processor section, so we save address at this two
place.

---
v4 - v3:
  - rebase on top of the latest mainline
  - make ghes_arm_process_error as a weak function
  - only pick cache error from arm processor section for error recovery
  - fix s-o-b issue

  https://lkml.org/lkml/2017/9/7/98

v3 - v2:
  - fix patch style issue

v2 - v1:
  - wrap arm_proc_error_check and log_arm_hw_error in a single arm_process_error()
  - fix sea_save_info return value issue
  - fix link error if this CONFIG_ARM64_ERR_RECOV is not selected
  - use a notify chain instead of call arch_apei_report_mem_error directly

  https://lkml.org/lkml/2017/9/1/189

Xie XiuQi (4):
  ACPI, CPER: add arm error info type definition
  arm64/ras: support sea error recovery
  GHES: add a notify chain for process memory section
  arm64/ras: save error address from memory section for recovery

 arch/arm64/Kconfig                   |  11 +++
 arch/arm64/include/asm/ras.h         |  23 +++++
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/ras.c              | 173 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c           |   7 ++
 arch/arm64/mm/fault.c                |  27 ++++--
 drivers/acpi/apei/ghes.c             |  18 +++-
 include/acpi/ghes.h                  |  11 +++
 include/linux/cper.h                 |   5 +
 10 files changed, 270 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c

-- 
1.8.3.1
