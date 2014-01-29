From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jan 2014 17:50:41 +0100
Subject: [PATCH 0/5] generic CPU feature based udev module autoprobing
Message-ID: <1391014246-9715-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a slightly expanded version of the series that I have proposed
before. It implements a generic way to wire up udev module autoprobing to
optional CPU features.

Patch #1 moves some code around to prevent duplication later.

Patch #2 implements the actual generic part. It relies on the include file
<asm/cpufeature.h> to be supplied by the architecture to map CPU features to
the number based scheme used by modalias.

Patch #3 aligns x86 with the generic code. As x86 allows matching on CPU vendor,
family and model IDs, it still retains most of the original code for creating
and matching the module metadata.

Patch #4 enables the generic implementation of patch #2 for arm64 by supplying
an 'asm/cpufeatures.h' that maps CPU feature numbers to bit offsets in
elf_hwcap, and by setting CONFIG_GENERIC_CPU_AUTOPROBE for the architecture.

Patch #5 is an example that maps an AES crypto module to the optional AES
feature found on arm64.

Ard Biesheuvel (5):
  cpu: move arch_cpu_uevent() to generic code
  cpu: add generic support for CPU feature based module autoloading
  x86: align x86 arch with generic CPU modalias handling
  arm64: enable generic CPU feature modalias matching for this
    architecture
  arm64: add Crypto Extensions based synchronous core AES cipher

 arch/arm64/Kconfig                  |   1 +
 arch/arm64/Makefile                 |   1 +
 arch/arm64/crypto/Makefile          |  13 +++++
 arch/arm64/crypto/aes-ce-cipher.c   | 103 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cpufeature.h |  30 +++++++++++
 arch/x86/Kconfig                    |   4 +-
 arch/x86/include/asm/cpufeature.h   |   7 +++
 arch/x86/kernel/cpu/match.c         |  42 ---------------
 crypto/Kconfig                      |   6 +++
 drivers/base/Kconfig                |   3 ++
 drivers/base/cpu.c                  |  46 ++++++++++++++--
 include/linux/cpu.h                 |   7 ---
 include/linux/cpufeature.h          |  60 +++++++++++++++++++++
 include/linux/mod_devicetable.h     |   9 ++++
 scripts/mod/devicetable-offsets.c   |   3 ++
 scripts/mod/file2alias.c            |  20 +++++--
 16 files changed, 293 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-ce-cipher.c
 create mode 100644 arch/arm64/include/asm/cpufeature.h
 create mode 100644 include/linux/cpufeature.h

-- 
1.8.3.2
