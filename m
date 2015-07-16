From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jul 2015 17:01:54 +0100
Subject: [PATCH 0/5] arm64: kernel: Add support for Privileged Access Never
Message-ID: <1437062519-18883-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Privileged Access Never (PAN; part of the ARMv8.1
Extensions). When enabled, this feature causes a permission fault if the kernel
attempts to access memory that is also accessible by userspace - instead the
PAN bit must be cleared when accessing userspace memory. (or use the
ldt*/stt* instructions).

This series detects and enables this feature, and uses alternatives to change
{get,put}_user() et al to clear the PAN bit while they do their work.


James Morse (5):
  arm64: kernel: preparatory: Move config_sctlr_el1
  arm64: kernel: Add cpufeature 'enable' callback.
  arm64: kernel: Add min/max values in feature-detection register
    values.
  arm64: kernel: Add optional CONFIG_ parameter to ALTERNATIVE().
  arm64: kernel: Add support for Privileged Access Never

 arch/arm64/Kconfig                   | 14 ++++++++++++++
 arch/arm64/include/asm/alternative.h | 28 +++++++++++++++++++++++++---
 arch/arm64/include/asm/cpufeature.h  |  7 +++++--
 arch/arm64/include/asm/futex.h       |  8 ++++++++
 arch/arm64/include/asm/processor.h   |  2 ++
 arch/arm64/include/asm/sysreg.h      | 18 ++++++++++++++++++
 arch/arm64/include/asm/uaccess.h     | 11 +++++++++++
 arch/arm64/kernel/armv8_deprecated.c | 11 +----------
 arch/arm64/kernel/cpufeature.c       | 34 ++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/process.c          |  3 +++
 arch/arm64/lib/clear_user.S          |  8 ++++++++
 arch/arm64/lib/copy_from_user.S      |  8 ++++++++
 arch/arm64/lib/copy_in_user.S        |  8 ++++++++
 arch/arm64/lib/copy_to_user.S        |  8 ++++++++
 arch/arm64/mm/fault.c                | 23 +++++++++++++++++++++++
 15 files changed, 174 insertions(+), 17 deletions(-)

-- 
2.1.4
