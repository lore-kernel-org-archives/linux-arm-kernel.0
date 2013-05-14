From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 14:04:36 +0100
Subject: [PATCH 0/8] ARM: MPU Support for PMSAv7 processors
Message-ID: <1368536684-13608-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds basic support for the PMSAv7-compliant MPU, which is
present on R-class cores.

The initial support implemented here lacks the ability to deal with setting
different region configurations for the I and D-side. No hardware is available
at the moment that supports this capability. It sets out a staic MPU mapping,
keeping one region for probing, one for the whole of memory and one for RAM.

The final patch in the series also creates a region protecting the vectors
from being accessed at PL0, reducing the possibility of programming errors
in userspace causing the kernel to panic as it is entered from user mode.

This series is the final step in enabling SMP with Cortex-R7 (and hence NOMMU)
by configuring the memory as shared.

In order to test these patches, you will need:
i) My nommu fixes series, which incorporates Will's NOMMU and SMP fixes
   - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168106.html
ii) The Cortex-R7 support patches posted earlier to this list.
   - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168128.html
iii) The multiplatform patches posted earlier to this list.
   - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/168106.html

Jonathan Austin (8):
  ARM: mpu: add PMSA related registers and bitfields to existing
    headers
  ARM: mpu: add header for MPU register layouts and region data
  ARM: mpu: add early bring-up code for the ARMv7 PMSA-compliant MPU
  ARM: mpu: add MPU probe and initialisation functions in C
  ARM: mpu: Complete initialisation of the MPU after reaching the
    C-world
  ARM: mpu: add MPU initialisation for secondary cores
  ARM: mpu: Allow enabling of the MPU via kconfig
  ARM: mpu: protect the vectors page with an MPU region

 arch/arm/Kconfig               |    4 +-
 arch/arm/Kconfig-nommu         |   11 ++
 arch/arm/include/asm/cp15.h    |    5 +
 arch/arm/include/asm/cputype.h |    1 +
 arch/arm/include/asm/mpu.h     |   76 ++++++++++++
 arch/arm/include/asm/smp.h     |    5 +-
 arch/arm/kernel/head-nommu.S   |  110 +++++++++++++++++
 arch/arm/kernel/signal.c       |    9 +-
 arch/arm/kernel/smp.c          |    8 +-
 arch/arm/mm/nommu.c            |  257 +++++++++++++++++++++++++++++++++++++++-
 10 files changed, 478 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/include/asm/mpu.h

-- 
1.7.9.5
