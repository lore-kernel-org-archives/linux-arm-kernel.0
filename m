From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Thu, 7 Sep 2017 15:45:13 +0800
Subject: [PATCH v3 0/3] arm64/ras: support sea error recovery
Message-ID: <1504770316-4327-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM v8.2 RAS Extension, SEA are usually triggered when memory errors
are consumed. In some cases, if the error address is in a clean page or a
read-only page, there is a chance to recover. Such as error occurs in a
instruction page, we can reread this page from disk instead of killing
process.

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
v3 - v2:
  - fix patch style issue

v2 - v1:
  - wrap arm_proc_error_check and log_arm_hw_error in a single arm_process_error()
  - fix sea_save_info return value issue
  - fix link error if this CONFIG_ARM64_ERR_RECOV is not selected
  - use a notify chain instead of call arch_apei_report_mem_error directly

  https://lkml.org/lkml/2017/9/1/189

Xie XiuQi (3):
  arm64/ras: support sea error recovery
  GHES: add a notify chain for process memory section
  arm64/ras: save error address from memory section for recovery

 arch/arm64/Kconfig                   |  11 +++
 arch/arm64/include/asm/ras.h         |  36 ++++++++
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/ras.c              | 172 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c           |   8 ++
 arch/arm64/mm/fault.c                |  27 ++++--
 drivers/acpi/apei/ghes.c             |  14 ++-
 include/acpi/ghes.h                  |   8 ++
 9 files changed, 270 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 arch/arm64/kernel/ras.c

-- 
1.8.3.1
