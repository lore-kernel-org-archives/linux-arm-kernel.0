From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 24 Mar 2015 22:02:56 +0800
Subject: [patch v11 23/23] ARM64 / ACPI: Don't unflatten device tree if
 acpi=force is passed
In-Reply-To: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1427205776-5060-24-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the policy is that once we pass acpi=force in the early
param, we will not unflatten device tree even if ACPI is disabled
in ACPI table init fails, so fix the code by comparinging both
acpi_disabled and param_acpi_force before the device tree is
unflattened.

CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h | 3 +++
 arch/arm64/kernel/acpi.c      | 2 +-
 arch/arm64/kernel/setup.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59c05d8..e1a8965 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -38,6 +38,7 @@ typedef u64 phys_cpuid_t;
 extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
+extern bool param_acpi_force;
 
 /* 1 to indicate PSCI 0.2+ is implemented */
 static inline bool acpi_psci_present(void)
@@ -91,6 +92,8 @@ void __init acpi_init_cpus(void);
 static inline bool acpi_psci_present(void) { return false; }
 static inline bool acpi_psci_use_hvc(void) { return false; }
 static inline void acpi_init_cpus(void) { }
+
+#define param_acpi_force false
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 5819ef7..fe9d8f0 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -43,7 +43,7 @@ static int enabled_cpus;
 static bool bootcpu_valid  __initdata;
 
 static bool param_acpi_off __initdata;
-static bool param_acpi_force __initdata;
+bool param_acpi_force __initdata;
 
 static int __init parse_acpi(char *arg)
 {
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index b278311..d60b1ad 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,7 +390,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	if (acpi_disabled) {
+	if (acpi_disabled  && !param_acpi_force) {
 		unflatten_device_tree();
 		psci_dt_init();
 		cpu_read_bootcpu_ops();
-- 
1.9.1
