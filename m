From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 20 Jun 2016 13:56:08 +0300
Subject: [PATCH v4 0/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Message-ID: <20160620105615.15538-1-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

You said you are ok with the ACPI part of the patches [4].
The patchset has received ACK from Will [5].  Can you consider pulling it please?

Thank you
Aleksey Makarov

This patchset adds support for ACPI_TABLE_UPGRADE for ARM64

These patches help with:

1). During development of a platform, it is much easier to debug
problems with tables if you can test replacement ones without having to
respin the firmware. In the server world, you usually don't have the
firmware source code, so to get it respun could be days-weeks even if
you are working with the authors closely. We have practically used this
feature on a number of platforms already and it will continue.

2). They empower (advanced) users and developers to work around problems
that they find on platforms. Sure, we want firmware to always be fixed
and working well, but it is better if folks have the tools.

It's also required for parity with x86 functionality on servers as Redhat
use that method in their tooling.

The patchset refactors the code introduced by the patches by Lv Zheng [1],
fixes access to the destination of new ACPI tables as suggested
by Mark Rutland [2] and enables the feature for ARM64

It was first sent by Jon Masters [3] to linaro-acpi in December 2015

Tested on QEMU (arm64 and x86) and ThunderX
Should be applied to next-20160620

v4:
- rebase to next-20160620
- add Acked-by: Will Deacon <will.deacon@arm.com>
- add Acked-by: Lv Zheng <lv.zheng@intel.com> for [2/5]

v3:
https://lkml.kernel.org/g/20160602174910.30428-1-aleksey.makarov at linaro.org -- only [5/5]
- change PFN_PHYS(max_pfn) to MEMBLOCK_ALLOC_ACCESSIBLE. (Catalin Marinas)

v2:
https://lkml.kernel.org/g/1463674518-22477-1-git-send-email-aleksey.makarov at linaro.org
- add Acked-by: Lv Zheng <lv.zheng@intel.com>
- replace the original patch "ACPI: table upgrade: move early_initrd_acpi_init()
  to header file" with the patch "ACPI: table upgrade: refactor function
  definitions".  This new patch is just the original one rewritten following the
  suggestion by Lv Zheng to use initrd_start, inird_end directly in
  acpi_table_initrd_init().  It simplifies things noticeably.
- add Jon's explanations to the cover of the patchset and my explanations
  to "ACPI: ARM64: support for ACPI_TABLE_UPGRADE"
- introduce ARCH_HAS_ACPI_TABLE_UPGRADE in a separate patch (Mark Rutland)
- move arch-specific definition to an arch-specific header in a separate patch
  (Mark Rutland)

v1:
https://lkml.kernel.org/g/1463486765-31827-1-git-send-email-aleksey.makarov at linaro.org

[1]: https://lkml.kernel.org/g/cover.1460340514.git.lv.zheng at intel.com
[2]: https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006101.html
[3]: https://lists.linaro.org/pipermail/linaro-acpi/2015-December/006099.html
[4]: https://lkml.kernel.org/g/CAJZ5v0is7c833aQkRm-D+TwLM+eUYeKEAdLOOdrEdT-hrC_M1A at mail.gmail.com
[5]: https://lkml.kernel.org/g/20160614164116.GF16531 at arm.com

Aleksey Makarov (4):
  ACPI: table upgrade: use cacheable map for tables
  ACPI: table upgrade: refactor function definitions
  ACPI: table upgrade: move arch-specific symbol to asm/acpi.h
  ACPI: table upgrade: introduce ARCH_HAS_ACPI_TABLE_UPGRADE

Jon Masters (1):
  ACPI: ARM64: support for ACPI_TABLE_UPGRADE

 arch/arm64/Kconfig            |  1 +
 arch/arm64/include/asm/acpi.h |  2 ++
 arch/arm64/kernel/setup.c     |  6 ++++--
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/acpi.h   |  2 ++
 arch/x86/kernel/setup.c       |  9 +--------
 drivers/acpi/Kconfig          |  5 ++++-
 drivers/acpi/tables.c         | 23 +++++++++--------------
 include/linux/acpi.h          |  8 ++++++--
 9 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.8.3
