From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat, 25 Nov 2017 12:41:27 +0300
Subject: [PATCH] arm64: fix missing 'const' qualifiers
Message-ID: <20171125094127.7536-1-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was discovered during LTO-enabled compilation with gcc/ld.bfd.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/cpu_ops.c             | 7 ++++---
 drivers/clk/hisilicon/crg-hi3516cv300.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index d16978213c5b..36178002f0c3 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -31,13 +31,14 @@ extern const struct cpu_operations cpu_psci_ops;
 
 const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
 
-static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
+static const struct cpu_operations *const dt_supported_cpu_ops[] __initconst = {
 	&smp_spin_table_ops,
 	&cpu_psci_ops,
 	NULL,
 };
 
-static const struct cpu_operations *acpi_supported_cpu_ops[] __initconst = {
+static const struct cpu_operations
+	*const acpi_supported_cpu_ops[] __initconst = {
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 	&acpi_parking_protocol_ops,
 #endif
@@ -47,7 +48,7 @@ static const struct cpu_operations *acpi_supported_cpu_ops[] __initconst = {
 
 static const struct cpu_operations * __init cpu_get_ops(const char *name)
 {
-	const struct cpu_operations **ops;
+	const struct cpu_operations *const *ops;
 
 	ops = acpi_disabled ? dt_supported_cpu_ops : acpi_supported_cpu_ops;
 
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 2007123832bb..53450b651e4c 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -204,7 +204,7 @@ static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
 /* hi3516CV300 sysctrl CRG */
 #define HI3516CV300_SYSCTRL_NR_CLKS 16
 
-static const char *wdt_mux_p[] __initconst = { "3m", "apb" };
+static const char *const wdt_mux_p[] __initconst = { "3m", "apb" };
 static u32 wdt_mux_table[] = {0, 1};
 
 static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
-- 
2.11.0
