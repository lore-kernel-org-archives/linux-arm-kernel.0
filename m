From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jan 2015 12:04:13 +0000
Subject: [PATCH 0/7] arm64/kvm: common ESR_ELx definitions and decoding
Message-ID: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we have two sets of macros used for ESR_ELx handling, one used
by core arm64 code and the other used by KVM. These differ slightly in
naming convention and style of definition.

This patch series introduces and migrates all users to a common set of
macros for ESR_ELx handling, preventing further drift.

Additionally this series adds exception class decoding when reporting
exceptions, saving deveopers from having to perform tedious mental
arithmetic to figure out what the likely cause of an unexpected
exception was.

Thanks,
Mark.

Mark Rutland (7):
  arm64: introduce common ESR_ELx_* definitions
  arm64: move to ESR_ELx macros
  arm64: remove ESR_EL1_* macros
  arm64: decode ESR_ELx.EC when reporting exceptions
  arm64: kvm: move to ESR_ELx macros
  arm64: kvm: remove ESR_EL2_* macros
  arm64: kvm: decode ESR_ELx.EC when reporting exceptions

 arch/arm64/include/asm/esr.h         | 116 +++++++++++++++++++++++++----------
 arch/arm64/include/asm/kvm_arm.h     |  73 ++--------------------
 arch/arm64/include/asm/kvm_emulate.h |  28 +++++----
 arch/arm64/kernel/entry.S            |  64 +++++++++----------
 arch/arm64/kernel/signal32.c         |   2 +-
 arch/arm64/kernel/traps.c            |  50 ++++++++++++++-
 arch/arm64/kvm/emulate.c             |   5 +-
 arch/arm64/kvm/handle_exit.c         |  39 ++++++------
 arch/arm64/kvm/hyp.S                 |  17 ++---
 arch/arm64/kvm/inject_fault.c        |  14 ++---
 arch/arm64/kvm/sys_regs.c            |  23 ++++---
 arch/arm64/mm/fault.c                |   2 +-
 12 files changed, 236 insertions(+), 197 deletions(-)

-- 
1.9.1
