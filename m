From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 10 Jul 2018 08:42:25 +0900
Subject: [PATCH v3.1 0/4] arm64: kexec,
 kdump: fix boot failures on acpi-only system
Message-ID: <20180709234229.20181-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series is a set of bug fixes to address kexec/kdump
failures which are sometimes observed on ACPI-only system and reported
in LAK-ML before.

In short, the phenomena are:
1. kexec'ed kernel can fail to boot because some ACPI table is corrupted
   by a new kernel (or other data) being loaded into System RAM. Currently
   kexec may possibly allocate space ignoring such "reserved" regions.
   We will see no messages after "Bye!"

2. crash dump (kdump) kernel can fail to boot and get into panic due to
   an alignment fault when accessing ACPI tables. This can happen because
   those tables are not always properly aligned while they are mapped
   non-cacheable (ioremap'ed) as they are not recognized as part of System
   RAM under the current implementation.

After discussing several possibilities to address those issues,
the agreed approach, in my understanding, is
* to add resource entries for every "reserved", i.e. memblock_reserve(),
  regions to /proc/iomem.
  (NOMAP regions, also marked as "reserved," remains at top-level for
  backward compatibility. User-space can tell the difference between
  reserved-system-ram and reserved-address-space.)
* For case (1), user space (kexec-tools) should rule out such regions
  in searching for free space for loaded data.
* For case (2), the kernel should access ACPI tables by mapping
  them with appropriate memory attributes described in UEFI memory map.
  (This means that it doesn't require any changes in /proc/iomem, and
  hence user space.)

Please find past discussions about /proc/iomem in [1].
--- more words from James ---
Our attempts to fix this just in the kernel reached a dead end, because Kdump
needs to include reserved-system-ram, whereas kexec has to avoid it. User-space
needs to be able to tell reserved-system-ram and reserved-address-space apart.
Hence we need to expose that information, and pick it up in user-space.

Patched-kernel and unpatch-user-space will work the same way it does today, as
the additional reserved regions are ignored by user-space.

Unpatched-kernel and patched-user-space will also work the same way it does
today as the additional reserved regions are missing.
--->8---

Patch#1 addresses kexec case, for which you are also required to update
user space. See necessary patches in [2]. If you want to review Patch#1,
please also take a look at and review [2].

Patch#2, #3 and #4 address the kdump case above.


Changes in v3.1 (2018, July 10, 2018)
* add Ard's patch[4] to this patch set

Changes in v3 (2018, July 9, 2018)
* drop the v2's patch#3, preferring [4]

Changes in v2 (2018, June 19, 2018)
* re-organise v1's patch#2 and #3 into v2's #2, #3 and #4
  not to break bisect

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/565980.html
[2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/resv_mem
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/573655.html
[4] https://marc.info/?l=linux-efi&m=152930773507524&w=2

AKASHI Takahiro (2):
  efi/arm: map UEFI memory map even w/o runtime services enabled
  arm64: acpi: fix alignment fault in accessing ACPI

Ard Biesheuvel (1):
  efi/arm: preserve early mapping of UEFI memory map longer for BGRT

James Morse (1):
  arm64: export memblock_reserve()d regions via /proc/iomem

 arch/arm64/include/asm/acpi.h      | 23 ++++++++++++------
 arch/arm64/kernel/acpi.c           | 11 +++------
 arch/arm64/kernel/setup.c          | 38 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/arm-init.c    |  1 -
 drivers/firmware/efi/arm-runtime.c | 16 +++++++------
 5 files changed, 66 insertions(+), 23 deletions(-)

-- 
2.17.0
