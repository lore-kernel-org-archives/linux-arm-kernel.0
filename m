From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 15:19:17 +0000
Subject: [PATCH 0/4] arm64: correctly and consistently handle Xt == XZR
Message-ID: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I spotted that we inconsistently handle the use of Xt when we trap
instructions, and in some cases we may erroneously access SP.

These patches add new helpers to handle this for us, and moves code over to
using them, fixing the erroneous SP usage in the process.

Patch 2 (correcting the trapped CTR_EL0 handling) will need backporting to
stable, and is dependent on patch 1.

Patch 3 is also a fix, but shouldn't need backporting as the patch hasn't made
it into a release yet. Patch 4 is a cleanup for consistency.

Thanks,
Mark.

Mark Rutland (4):
  arm64: ptrace: add XZR-safe regs accessors
  arm64: traps: correctly handle MRS/MSR with XZR
  arm64: cpufeature: correctly handle MRS to XZR
  arm64/kprobes: consistently handle MRS/MSR with XZR

 arch/arm64/include/asm/ptrace.h          | 20 ++++++++++++++++++++
 arch/arm64/kernel/cpufeature.c           |  2 +-
 arch/arm64/kernel/probes/simulate-insn.c | 18 ++++++------------
 arch/arm64/kernel/traps.c                |  6 ++++--
 4 files changed, 31 insertions(+), 15 deletions(-)

-- 
1.9.1
