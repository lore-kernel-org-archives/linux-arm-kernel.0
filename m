From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:44 +0800
Subject: [PATCH v10 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if
 ACPI is enabled on ARM64
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-19-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Al Stone <al.stone@linaro.org>

ACPI reduced hardware mode is disabled by default, but ARM64
can only run properly in ACPI hardware reduced mode, so select
ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.

If the firmware is not using hardware reduced ACPI mode, we
will disable ACPI to avoid nightmare such as accessing some
registers which are not available on ARM64.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Reviewed-by: Grant Likely <grant.likely@linaro.org>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig       | 1 +
 arch/arm64/kernel/acpi.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..d00ab9a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,5 +1,6 @@
 config ARM64
 	def_bool y
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 6468f88..5819ef7 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -303,6 +303,11 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 	 */
 	if (table->revision > 5 ||
 	    (table->revision == 5 && fadt->minor_revision >= 1)) {
+		if (!acpi_gbl_reduced_hardware) {
+			pr_err("Not hardware reduced ACPI mode, will not be supported\n");
+			goto disable_acpi;
+		}
+
 		/*
 		 * ACPI 5.1 only has two explicit methods to boot up SMP,
 		 * PSCI and Parking protocol, but the Parking protocol is
@@ -319,8 +324,9 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 
 	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
 		table->revision, fadt->minor_revision);
-	disable_acpi();
 
+disable_acpi:
+	disable_acpi();
 	return -EINVAL;
 }
 
-- 
1.9.1
