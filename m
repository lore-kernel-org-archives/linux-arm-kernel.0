From: james.morse@arm.com (James Morse)
Date: Tue, 21 Jul 2015 13:23:25 +0100
Subject: [PATCH v3 0/6] arm64: kernel: Add support for Privileged Access Never
Message-ID: <1437481411-1595-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Privileged Access Never (PAN; part of the ARMv8.1
Extensions). When enabled, this feature causes a permission fault if the kernel
attempts to access memory that is also accessible by userspace - instead the
PAN bit must be cleared when accessing userspace memory. (or use the
ldt*/stt* instructions).

This series detects and enables this feature, and uses alternatives to change
{get,put}_user() et al to clear the PAN bit while they do their work.

Changes since v 2:
* Added missing PAN-swivel around  swp emulation. (Thanks to Vladimir Murzin for
  spotting this!).
* Use bit shifts in cpuid_feature_extract_field(), to produce better asm.
* Changed the enable() patch field names, and switched to ints.
* Removed PSTATE_PAN define and use PSR_PAN_BIT instead.

Changes since v1:
* Copied cpuid_feature_extract_field() from arch/arm as a new patch, suggested
  by Russell King [1].
* Changed feature-detection patch to use cpuid_feature_extract_field() for sign
  extension, and '>='.
* Moved SCTLR_EL1_* from asm/cputype.h to asm/sysreg.h
* Added PSR_PAN_BIT in uapi/asm/ptrace.h
* Removed the setting of PSTATE_PAN in kernel/process.c

[1] http://www.spinics.net/lists/arm-kernel/msg432518.html


James Morse (6):
  arm64: kernel: Add cpuid_feature_extract_field() for 4bit sign
    extension
  arm64: kernel: preparatory: Move config_sctlr_el1
  arm64: kernel: Add cpufeature 'enable' callback
  arm64: kernel: Add min_field_value and use '>=' for feature detection
  arm64: kernel: Add optional CONFIG_ parameter to ALTERNATIVE()
  arm64: kernel: Add support for Privileged Access Never

 arch/arm64/Kconfig                   | 14 +++++++++++++
 arch/arm64/include/asm/alternative.h | 28 ++++++++++++++++++++++---
 arch/arm64/include/asm/cpufeature.h  | 15 +++++++++++---
 arch/arm64/include/asm/cputype.h     |  3 ---
 arch/arm64/include/asm/futex.h       |  8 ++++++++
 arch/arm64/include/asm/processor.h   |  2 ++
 arch/arm64/include/asm/sysreg.h      | 20 ++++++++++++++++++
 arch/arm64/include/asm/uaccess.h     | 11 ++++++++++
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/armv8_deprecated.c | 19 ++++++++---------
 arch/arm64/kernel/cpufeature.c       | 40 +++++++++++++++++++++++++++++++++---
 arch/arm64/lib/clear_user.S          |  8 ++++++++
 arch/arm64/lib/copy_from_user.S      |  8 ++++++++
 arch/arm64/lib/copy_in_user.S        |  8 ++++++++
 arch/arm64/lib/copy_to_user.S        |  8 ++++++++
 arch/arm64/mm/fault.c                | 23 +++++++++++++++++++++
 16 files changed, 193 insertions(+), 23 deletions(-)

-- 
2.1.4
