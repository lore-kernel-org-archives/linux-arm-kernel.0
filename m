From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 17 Jan 2014 10:23:06 +0100
Subject: [PATCH v2 resend 0/5] arm64: advertise availability of CRC and crypto
 instructions
Message-ID: <1389950591-4212-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a followup to the patch that was recently merged by Catalin that
allocates hwcaps bits for CRC and Crypto Extensions instructions so userland can
discover whether the current CPU has any of those capabilities.

Patch #1 enables ARM support for the ELF_HWCAP2/AT_HWCAP2 ELF auxv entry that
was recently added to the kernel and glibc (2.18). It extends the feature bit
space to 64 bits (on 32-bit architectures)

Patch #2 adds generic support for ELF_HWCAP2/AT_HWCAP2 to the 32-bit ELF compat
mode for 64-bit architectures.

Patch #3 adds support for ELF_HWCAP2/AT_HWCAP2 to arm64's 32-bit ELF compat mode

Patch #4 allocates the HWCAP2 bits in the arch/arm tree. This is necessary
because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
so there should be agreement about the meaning of feature bits, even if the ARM
kernel has no support yet for ARMv8 32-bit only hardware (such as ARMv8-R)

Patch #5 advertises the CRC and Crypto Extensions to 32-bit ELF binaries running
under an arm64 kernel.

v2 changes:
- omitted 2 arm64 specific patches that have already been merged by Catalin
- move ARM feature bits to HWCAP2

Ard Biesheuvel (5):
  ARM: add support for AT_HWCAP2 ELF auxv entry
  binfmt_elf: add ELF_HWCAP2 to compat auxv entries
  arm64: add AT_HWCAP2 support for 32-bit compat
  ARM: introduce HWCAP2 feature bits for ARMv8 Crypto Extensions
  arm64: advertise ARMv8 extensions to 32-bit compat ELF binaries

 arch/arm/include/asm/hwcap.h      |  3 ++-
 arch/arm/include/uapi/asm/hwcap.h |  9 +++++++++
 arch/arm/kernel/setup.c           | 16 ++++++++++++++++
 arch/arm64/include/asm/hwcap.h    |  9 ++++++++-
 arch/arm64/kernel/setup.c         | 33 +++++++++++++++++++++++++++++++++
 fs/compat_binfmt_elf.c            |  5 +++++
 6 files changed, 73 insertions(+), 2 deletions(-)

-- 
1.8.3.2
