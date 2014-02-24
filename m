From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Feb 2014 15:26:26 +0100
Subject: [PATCH v3 0/4] kernel mode NEON optimizations
Message-ID: <1393251990-19614-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main purpose of this series is to allow Crypto Extensions instructions to be
used in interrupt context. For instance, the WPA2 CCMP handling (i.e., AES-128
in CCM mode) in the mac80211 layer runs entirely in softirq context.

Patch #1 does some preparatory work so all code external to kernel/fpsimd.c uses
accessor functions to manipulate both the on-CPU and preserved FPSIMD states
rather than poking them directly.

Patch #2 implements an optimization that reduces the number of times the
userland FPSIMD state is needlessly preserved and restored.

Patch #3 modifies kernel_neon_begin() and kernel_neon_end() so they may be
called from interrupt context.

Patch #4 contains the core AES cipher implementation

Changes since v2:
- incorporated feedback from Catalin Marinas on the FPSIMD state handling
- updated the AES inline asm to use the Q constraint for in/output data,
  allowing the memory clobber to be dropped.

Changes since v1:
- added preparatory patch #1
- based on feedback from Will Deacon, make sure ptrace() and return from signal
  handler cases are covered.

Mildly but not yet thoroughly tested.
All feedback highly appreciated.

Ard Biesheuvel (4):
  arm64: add abstractions for FPSIMD state manipulation
  arm64: defer reloading a task's FPSIMD state to userland resume
  arm64: add support for kernel mode NEON in interrupt context
  arm64: add Crypto Extensions based synchronous core AES cipher

 arch/arm64/Makefile                   |   1 +
 arch/arm64/crypto/Makefile            |  13 +++
 arch/arm64/crypto/aes-ce-cipher.c     | 149 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/fpsimd.h       |  23 +++++
 arch/arm64/include/asm/fpsimdmacros.h |  37 +++++++
 arch/arm64/include/asm/neon.h         |   6 +-
 arch/arm64/include/asm/thread_info.h  |   4 +-
 arch/arm64/kernel/entry-fpsimd.S      |  24 +++++
 arch/arm64/kernel/entry.S             |   2 +-
 arch/arm64/kernel/fpsimd.c            | 180 ++++++++++++++++++++++++++++++----
 arch/arm64/kernel/process.c           |   2 +-
 arch/arm64/kernel/ptrace.c            |   2 +
 arch/arm64/kernel/signal.c            |   8 +-
 arch/arm64/kernel/signal32.c          |   4 +-
 crypto/Kconfig                        |   6 ++
 15 files changed, 433 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-ce-cipher.c

-- 
1.8.3.2
