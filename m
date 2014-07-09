From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  9 Jul 2014 17:39:05 +0800
Subject: [PATCH v2 2/3] ACPI: Don't use acpi_lapic in ACPI core code
In-Reply-To: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1404898746-6685-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Now ARM64 support is being added to ACPI so architecture specific
values can not be used in core ACPI code.

Following on the patch "ACPI / processor: Check if LAPIC is present
during initialization" which uses acpi_lapic in acpi_processor.c,
on ARM64 platform, GIC is used instead of local APIC, so acpi_lapic
is not a suitable value for ARM64.

What is actually important at this point is if there is/are CPU
entry/entries (Local APIC/SAPIC, GICC) in MADT, so introduce
acpi_has_cpu_in_madt() to be arch specific and generic.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/ia64/include/asm/acpi.h  |    5 +++++
 arch/x86/include/asm/acpi.h   |    5 +++++
 drivers/acpi/acpi_processor.c |    2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 75dc59a..a1d91ab 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -40,6 +40,11 @@ extern int acpi_lapic;
 #define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
+
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return !!acpi_lapic;
+}
 #endif
 #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
 static inline void disable_acpi(void) { }
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index e06225e..0ab4f9f 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -121,6 +121,11 @@ static inline void arch_acpi_set_pdc_bits(u32 *buf)
 		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
 }
 
+static inline bool acpi_has_cpu_in_madt(void)
+{
+	return !!acpi_lapic;
+}
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 1c08574..1fdf5e0 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -268,7 +268,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	pr->apic_id = apic_id;
 
 	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
-	if (!cpu0_initialized && !acpi_lapic) {
+	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
 		cpu0_initialized = 1;
 		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
 		if ((cpu_index == -1) && (num_online_cpus() == 1))
-- 
1.7.9.5
