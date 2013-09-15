From: acourbot@nvidia.com (Alexandre Courbot)
Date: Sun, 15 Sep 2013 18:40:23 +0900
Subject: [PATCH v6 0/5] ARM: support for Trusted Foundations secure monitor
Message-ID: <1379238028-7960-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sixth attempt at the support for Trusted Foundations, which allows many
Tegra-based (and quite possibly other) devices sold on the market to boot and
be used with an upstream kernel.

v5 did not receive many comments on the code itself, so I hope this means
the patch set is converging well. Most remarks were about the lack of clarity
about what Trusted Foundations is and how it fits with respect to SMC calling
conventions and the PSCI standard (spoiler: it does not fit).

Change against v5:
- added a no-op of_register_trusted_foundations() for the case where neither
  Trusted Foundations nor device tree support are enabled
- made it clear in the commit message and source file that TF does not follow
  the SMC calling convention, is totally independant of PSIC and only matters
  to devices that come with a bootloader that enables it.

Alexandre Courbot (5):
  ARM: add basic support for Trusted Foundations
  ARM: tegra: add support for Trusted Foundations
  ARM: tegra: split setting of CPU reset handler
  ARM: tegra: set CPU reset handler with firmware op
  ARM: tegra: support Trusted Foundations by default

 .../arm/firmware/tl,trusted-foundations.txt        | 17 +++++
 Documentation/devicetree/bindings/arm/tegra.txt    |  5 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/Kconfig                                   |  2 +
 arch/arm/Makefile                                  |  1 +
 arch/arm/configs/tegra_defconfig                   |  1 +
 arch/arm/firmware/Kconfig                          | 28 ++++++++
 arch/arm/firmware/Makefile                         |  1 +
 arch/arm/firmware/trusted_foundations.c            | 79 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h         | 70 +++++++++++++++++++
 arch/arm/mach-tegra/Kconfig                        |  1 +
 arch/arm/mach-tegra/common.c                       |  2 +
 arch/arm/mach-tegra/reset.c                        | 40 ++++++++---
 13 files changed, 237 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
 create mode 100644 arch/arm/firmware/Kconfig
 create mode 100644 arch/arm/firmware/Makefile
 create mode 100644 arch/arm/firmware/trusted_foundations.c
 create mode 100644 arch/arm/include/asm/trusted_foundations.h

-- 
1.8.4
