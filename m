From: al.stone@linaro.org (Al Stone)
Date: Thu, 18 Jun 2015 16:36:05 -0600
Subject: [PATCH v2 0/3] Correct for ACPI 5.1->6.0 spec changes in MADT GICC
 entries
Message-ID: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the ACPI 5.1 version of the spec, the struct for the GICC subtable
(struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
BAD_MADT_ENTRY() compares the struct size to the length in the GICC
subtable, it fails if 5.1 structs are in use, and there are systems in
the wild that have them.

Note that this was found in linux-next and these patches apply against
that tree and the arm64 kernel tree; 4.1-rc8 does not appear to have this
problem since it still has the 5.1 struct definition.

Even though there is precendent in ia64 code for ignoring the changes in
size, this patch set instead tries to verify correctness.  The first patch
in the set adds macros for easily using the ACPI spec version.  The second
patch adds the BAD_MADT_GICC_ENTRY() macro that uses the version macros to
check the GICC subtable only, accounting for the difference in specification
versions that are possible.  The final patch replaces BAD_MADT_ENTRY usage
with the BAD_MADT_GICC_ENTRY macro in arm64 code, which is currently the
only architecture affected.  The BAD_MADT_ENTRY() will continue to work as
is for all other MADT subtables.

I have tested these patches on an APM Mustang with version 1.15 firmware,
where the problem was found, and they fix the problem.

Changes for v2:
  -- Replace magic constants with proper defines (Lorenzo)
  -- Minor syntax clean-up noted by checkpatch
  -- Send out CCs properly this time
  -- Minor clean-up of the paragraphs in this cover letter


Al Stone (3):
  ACPI : introduce macros for using the ACPI specification version
  ACPI: add BAD_MADT_GICC_ENTRY() macro
  ACPI / ARM64 : use the new BAD_MADT_GICC_ENTRY macro

 arch/arm64/kernel/smp.c   |  2 +-
 drivers/irqchip/irq-gic.c |  2 +-
 include/linux/acpi.h      | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.4.0
