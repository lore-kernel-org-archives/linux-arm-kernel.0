From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Dec 2013 22:04:34 +0100
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
Message-ID: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an expansion of the patch posted by Steve Capper about 6 weeks
ago that allocates hwcaps bits for CRC and Crypto Extensions instructions so
userland can discover whether the current CPU has any of those capabilities.

Patch #1 is a cleanup patch for read_cpuid(), which allowed me to skip adding
yet another #define to asm/cputype.h (for ID_ISAR5_EL1)

Patch #2 is Steve's original patch, but slightly tweaked because hwcaps bit 2
has been allocated for something else in the mean time.

Patch #3 allocates the capability bits in the arch/arm tree. This is necessary
because 32-bit ARM binaries can execute both under ARM and under arm64 kernels,
so there should be agreement about the meaning of feature bits, even if those
features don't actually exist on systems covered by the arch/arm tree.

@Russell: if this looks ok to you, could you please indicate whether you prefer
to take this patch separately, or ack it and let it be merged as part of the
series.

Patch #4 advertises the CRC and Crypto Extensions to 32-bit binaries running
under an arm64 kernel.

Ard Biesheuvel (3):
  arm64: drop redundant macros from read_cpuid()
  ARM: allocate hwcaps bits for v8 crypto extensions
  arm64: add 32-bit compat hwcaps for v8 crypto extensions

Steve Capper (1):
  arm64: Add hwcaps for crypto and CRC32 extensions.

 arch/arm/include/uapi/asm/hwcap.h   |  5 +++
 arch/arm/kernel/setup.c             |  5 +++
 arch/arm64/include/asm/cputype.h    | 18 +++-------
 arch/arm64/include/asm/hwcap.h      |  6 ++++
 arch/arm64/include/uapi/asm/hwcap.h |  6 +++-
 arch/arm64/kernel/setup.c           | 69 +++++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 15 deletions(-)

-- 
1.8.3.2
