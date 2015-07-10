From: hidehiro.kawai.ez@hitachi.com (Hidehiro Kawai)
Date: Fri, 10 Jul 2015 20:33:31 +0900
Subject: [PATCH 0/3] kexec: crash_kexec_post_notifiers boot option related
 fixes
Message-ID: <20150710113331.4368.10495.stgit@softrs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a bugfix patch set for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.

The main patch is PATCH 3/3, and it fixes two problems reported by
Daniel Walker (https://lkml.org/lkml/2015/6/24/44). 

 Problem 1:
 If crash_kexec_post_notifiers boot option is specified, some
 shutting down process which assume other cpus are still alive
 don't work properly.

 Problem 2:
 If crash_kexec_post_notifiers boot option is specified, register
 information of other cpus are not saved to crash dumps.

PATCH 3/3 is also another solution for a bug reported by Daisuke
Hatayama (https://lkml.org/lkml/2015/5/15/284).  So, this patch
replace commits 5375b70 and f45d85f which fix the bug.

---

Hidehiro Kawai (3):
      panic: Disable crash_kexec_post_notifiers if kdump is not available
      kexec: Pass panic message to crash_kexec()
      kexec: Change the timing of callbacks related to "crash_kexec_post_notifiers" boot option


 Documentation/kernel-parameters.txt |    4 ++
 arch/arm/kernel/traps.c             |    2 +
 arch/arm64/kernel/traps.c           |    2 +
 arch/metag/kernel/traps.c           |    2 +
 arch/mips/kernel/traps.c            |    2 +
 arch/powerpc/kernel/traps.c         |    2 +
 arch/s390/kernel/ipl.c              |    2 +
 arch/sh/kernel/traps.c              |    2 +
 arch/x86/kernel/dumpstack.c         |    2 +
 arch/x86/platform/uv/uv_nmi.c       |    2 +
 include/linux/kernel.h              |    1 +
 include/linux/kexec.h               |    7 +++-
 kernel/kexec.c                      |   62 ++++++++++++++++++++++++++++++-----
 kernel/panic.c                      |   23 ++++---------
 14 files changed, 80 insertions(+), 35 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
