From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  8 Sep 2016 13:55:33 +0100
Subject: [PATCH 0/6] arm64: replace open-coded {msr, mrs} with {read,
 write}_sysreg()
Message-ID: <1473339339-32334-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A while back we added {read,write}_sysreg accessors to handle accesses
to system registers, without the usual boilerplate asm volatile,
temporary variable, etc.

These patches replace asm blocks that perform mrs/msr with
{read,write}_sysreg(), and remove code and comments that this change makes
unnecessary. Where {read,write}_sysreg() are not appropriate, comments are
added to explain why.
 
This gets rid of a reasonable amount of code, and makes what
remains easier to follow. 

Thanks,
Mark.

Mark Rutland (6):
  arm64: sysreg: allow write_sysreg to use XZR
  arm64: arch_timer: simplify accessors
  arm64: dcc: simplify accessors
  arm64/kvm: use {read,write}_sysreg()
  arm64: simplify sysreg manipulation
  arm64: simplify contextidr_thread_switch

 arch/arm64/include/asm/arch_timer.h    | 41 ++++++++++++----------------------
 arch/arm64/include/asm/dcc.h           | 14 ++++--------
 arch/arm64/include/asm/hw_breakpoint.h | 13 ++++++-----
 arch/arm64/include/asm/mmu_context.h   | 36 +++++++++++------------------
 arch/arm64/include/asm/pgtable-hwdef.h |  1 +
 arch/arm64/include/asm/sysreg.h        | 28 +++++++++++++----------
 arch/arm64/include/asm/thread_info.h   |  3 +++
 arch/arm64/include/asm/virt.h          |  6 ++---
 arch/arm64/kernel/cacheinfo.c          |  8 +++----
 arch/arm64/kernel/debug-monitors.c     |  8 +++----
 arch/arm64/kernel/process.c            | 14 +++++-------
 arch/arm64/kernel/sys_compat.c         |  2 +-
 arch/arm64/kvm/sys_regs.c              | 31 +++++++++----------------
 arch/arm64/kvm/sys_regs_generic_v8.c   |  6 ++---
 14 files changed, 86 insertions(+), 125 deletions(-)

-- 
1.9.1
