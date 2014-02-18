From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 19 Feb 2014 00:23:53 +0800
Subject: [PATCH v5 0/5] Prepare for running ACPI on !x86 and !ia64
Message-ID: <1392740638-2479-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the ACPI code is arch-dependent and make the code can't be
compiled on !x86 or !ia64, the first two patches just do some rework
on the idle_boot_override and _PDC related stuff to make the ACPI
code more arch-independent.

The third patch just introduce map_gic_id() for ACPI processor core
followed the ACPI 5.0 spec. Last two patches are just some cleanups.

I have compiled the kernel successfully after appling this patch set
on x86 and ia64.

Changs for v5:
Realign the additional lines to the open parenthesis
pr_info(xxxx);
	xxxx;

Changes for v4:
a) remove preprocessor directives in function bodies;
b) add another two patches for cleanups.

Changes for v3:
Fix the issues pointed out by Lan Tianyu and add the Reviewed-by for
first patch.

Changes for v2:
a) add #if defined(CONFIG_X86) || defined(CONFIG_IA64) for
   idle_boot_override related code;
b) Rebased on 3.14-rc1.

Changes since the RFC version:
a) Remove the RFC tag;
b) Move idle_boot_override out of the arch directory suggested
   by Alan;
c) Make these 3 patches as a separate patch set since there are
   not not related to the ARM/ARM64 platform.

Hanjun Guo (5):
  ACPI / idle: Make idle_boot_override depend on x86 and ia64
  ACPI / processor_core: Rework _PDC related stuff to make it more
    arch-independent
  ACPI / processor: Introduce map_gic_id() to get apic id from MADT or
    _MAT method
  ACPI: Move BAD_MADT_ENTRY() to linux/acpi.h
  ACPI: Replace printk with pr_* in tables.c

 arch/ia64/include/asm/acpi.h  |    5 +-
 arch/ia64/kernel/acpi.c       |   18 ++++--
 arch/x86/include/asm/acpi.h   |   19 +------
 arch/x86/kernel/acpi/boot.c   |    4 --
 arch/x86/kernel/acpi/cstate.c |   29 ++++++++++
 drivers/acpi/processor_core.c |   92 ++++++++++++++++++------------
 drivers/acpi/tables.c         |  124 ++++++++++++++++++-----------------------
 include/linux/acpi.h          |    4 ++
 8 files changed, 158 insertions(+), 137 deletions(-)

-- 
1.7.9.5
