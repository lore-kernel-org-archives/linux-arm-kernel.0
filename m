From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun,  6 Apr 2014 23:19:03 +0100
Subject: [PATCH 0/3] arm64: Provide ESR_EL1 information to user signal handlers
Message-ID: <1396822746-26241-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 port omitted the fault status information in sigcontext.
However, there are emulators like Qemu that rely on such information to
distinguish between a read or a write fault without decoding the
faulting instruction.

The first patch fixes the compat case. The second patch is a clean-up
and the third introduces the esr_context structure with its own magic to
be stored on the signal handler stack when applicable (SIGSEGV and
SIGBUS). Given that this hardware register is meant for EL1 consumption,
if significant changes are made in future architecture versions a new
magic number will be introduced.

Catalin Marinas (3):
  arm64: Provide read/write fault information in compat signal handlers
  arm64: Remove the aux_context structure
  arm64: Expose ESR_EL1 information to user when SIGSEGV/SIGBUS

 arch/arm64/include/asm/processor.h       |  1 +
 arch/arm64/include/asm/sigcontext.h      | 31 --------------------------
 arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++++
 arch/arm64/kernel/signal.c               | 37 +++++++++++++++++++++++---------
 arch/arm64/kernel/signal32.c             |  4 +++-
 arch/arm64/kernel/traps.c                |  7 ++++--
 arch/arm64/mm/fault.c                    |  3 ++-
 7 files changed, 45 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm64/include/asm/sigcontext.h
