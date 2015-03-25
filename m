From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 25 Mar 2015 15:22:13 +0000
Subject: [PATCH 5/5] ARM64: kernel: acpi: honour acpi=force command line
 parameter
In-Reply-To: <5512BE9F.8070305@huawei.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-6-git-send-email-lorenzo.pieralisi@arm.com>
 <5512BE9F.8070305@huawei.com>
Message-ID: <20150325152213.GB21478@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Wed, Mar 25, 2015 at 01:56:47PM +0000, Hanjun Guo wrote:
> On 2015/3/25 1:58, Lorenzo Pieralisi wrote:
> > If acpi=force is passed on the command line, it forces ACPI to be
> > the only available boot method, hence it must be left enabled even
> > if the initialization and sanity checks on ACPI tables fails.
> >
> > This patch refactors ACPI initialization to prevent disabling ACPI
> > if acpi=force is passed on the command line.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > ---

As mentioned, here is the update version for this patch:

-- >8 --
Subject: [PATCH] ARM64: kernel: acpi: honour acpi=force command line parameter

If acpi=force is passed on the command line, it forces ACPI to be
the only available boot method, hence it must be left enabled even
if the initialization and sanity checks on ACPI tables fails.

This patch refactors ACPI initialization to prevent disabling ACPI
if acpi=force is passed on the command line.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ---
 arch/arm64/kernel/acpi.c      | 16 ++++++++++++----
 arch/arm64/kernel/setup.c     |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index e1a8965..59c05d8 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -38,7 +38,6 @@ typedef u64 phys_cpuid_t;
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
-extern bool param_acpi_force;
 
 /* 1 to indicate PSCI 0.2+ is implemented */
 static inline bool acpi_psci_present(void)
@@ -92,8 +91,6 @@ void __init acpi_init_cpus(void);
 static inline bool acpi_psci_present(void) { return false; }
 static inline bool acpi_psci_use_hvc(void) { return false; }
 static inline void acpi_init_cpus(void) { }
-
-#define param_acpi_force false
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 172b7c9..cd60329 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -43,7 +43,7 @@ static int enabled_cpus;
 static bool bootcpu_valid  __initdata;
 
 static bool param_acpi_off __initdata;
-bool param_acpi_force __initdata;
+static bool param_acpi_force __initdata;
 
 static int __init parse_acpi(char *arg)
 {
@@ -284,8 +284,13 @@ out:
  * We can parse ACPI boot-time tables such as MADT after
  * this function is called.
  *
- * ACPI is enabled on return if ACPI tables initialized and sanity checks
- * passed, disabled otherwise
+ * On return ACPI is enabled if either:
+ *
+ * - ACPI tables are initialized and sanity checks passed
+ * - acpi=force was passed in the command line and ACPI was not disabled
+ *   explicitly through acpi=off command line parameter
+ *
+ * ACPI is disabled on function return otherwise
  */
 void __init acpi_boot_table_init(void)
 {
@@ -309,10 +314,13 @@ void __init acpi_boot_table_init(void)
 	 * If ACPI tables are initialized and FADT sanity checks passed,
 	 * leave ACPI enabled and carry on booting; otherwise disable ACPI
 	 * on initialization error.
+	 * If acpi=force was passed on the command line it forces ACPI
+	 * to be enabled even if its initialization failed.
 	 */
 	if (acpi_table_init() || acpi_fadt_sanity_check()) {
 		pr_err("Failed to init ACPI tables\n");
-		disable_acpi();
+		if (!param_acpi_force)
+			disable_acpi();
 	}
 }
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index d60b1ad..b278311 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,7 +390,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	if (acpi_disabled  && !param_acpi_force) {
+	if (acpi_disabled) {
 		unflatten_device_tree();
 		psci_dt_init();
 		cpu_read_bootcpu_ops();
-- 
2.2.1
