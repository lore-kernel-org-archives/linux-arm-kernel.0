From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  8 Jul 2013 23:11:56 +0100
Subject: [PATCH v3 0/5] kernel mode NEON support
Message-ID: <1373321521-15485-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 3 of the kernel mode NEON patch set.

Changes since v2:
- revert to using plain preempt_disable()/preempt_enable() rather than fiddling
  with the preempt count directly; we will keep the ability to spot violations
  of the no sleep rule even on non-PREEMPT builds with CONFIG_DEBUG_ATOMIC_SLEEP
  disabled, as sleeping disables the VFP, causing subsequent VFP instructions to
  hit the kernel mode VFP exception handler;
- modified the kernel mode VFP exception handler:
  * improved the error messages and comments to help identify the condition
    above
  * dropped the BUG() as we are already on a code path that will result in an
    oops anyway

Changes since v1:
- changed the order of the patches, so kernel_neon_begin() does not
  appear before the required fixes are in place
- don't use might_sleep() to enforce that kernel_neon_begin() should
  not be called from interrupt context, as it also prevents it from
  being called with preemption disabled, which is perfectly acceptable
- prefer inc_preempt_count() over preempt_disable() so sleeping after
  calling kernel_neon_begin() gets flagged even with kernel preemption
  disabled in Kconfig
- made the RAID6 patch suitable for both arm and arm64

Ard Biesheuvel (5):
  ARM: move VFP init to an earlier boot stage
  ARM: be strict about FP exceptions in kernel mode
  ARM: add support for kernel mode NEON
  ARM: crypto: add NEON accelerated XOR implementation
  lib/raid6: add ARM-NEON accelerated syndrome calculation

 arch/arm/Kconfig            |  7 ++++
 arch/arm/include/asm/neon.h | 36 ++++++++++++++++++++
 arch/arm/include/asm/xor.h  | 73 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile       |  6 ++++
 arch/arm/lib/xor-neon.c     | 42 ++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S        |  5 +++
 arch/arm/vfp/vfpmodule.c    | 69 +++++++++++++++++++++++++++++++++++++-
 include/linux/raid/pq.h     |  5 +++
 lib/raid6/.gitignore        |  1 +
 lib/raid6/Makefile          | 40 +++++++++++++++++++++++
 lib/raid6/algos.c           |  6 ++++
 lib/raid6/neon.c            | 58 ++++++++++++++++++++++++++++++++
 lib/raid6/neon.uc           | 80 +++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/test/Makefile     | 26 ++++++++++++++-
 14 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/neon.h
 create mode 100644 arch/arm/lib/xor-neon.c
 create mode 100644 lib/raid6/neon.c
 create mode 100644 lib/raid6/neon.uc

-- 
1.8.1.2
