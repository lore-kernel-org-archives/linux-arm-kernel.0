From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri,  3 Jul 2015 15:29:06 +0800
Subject: [PATCH v2] ARM64 / SMP: Switch pr_err() to pr_debug() for disabled
 GICC entry
Message-ID: <1435908546-11457-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is normal that firmware presents GICC entry or entries (processors)
with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
ACPI firmware may present 8 ebabled first with another 8 cpus disabled
in MADT, the disabled cpus can be hot-added later.

Firmware may also present more cpus than the hardware actually has, but
disabled the unused ones, and easily enable it when the hardware has such
cpus to make the firmware code scalable.

So that's not an error for disabled cpus in MADT, we can switch pr_err()
to pr_debug() to make the boot a little quieter by default.

Since hwid for disabled cpus often are invalid, and we check invalid hwid
fisrt in the code, for use case that hot add cpus later will be filtered
out and will not be counted in possible cups, so move this check before
the hwid one to prepare the code to count for disabeld cpus when cpu
hot-plug is introduced.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4b2121b..49d00da 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -396,13 +396,13 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
-	if (hwid & ~MPIDR_HWID_BITMASK || hwid == INVALID_HWID) {
-		pr_err("skipping CPU entry with invalid MPIDR 0x%llx\n", hwid);
+	if (!(processor->flags & ACPI_MADT_ENABLED)) {
+		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
 
-	if (!(processor->flags & ACPI_MADT_ENABLED)) {
-		pr_err("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
+	if (hwid & ~MPIDR_HWID_BITMASK || hwid == INVALID_HWID) {
+		pr_err("skipping CPU entry with invalid MPIDR 0x%llx\n", hwid);
 		return;
 	}
 
-- 
1.9.1
