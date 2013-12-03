From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:36:47 +0800
Subject: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC related
 stuff to make it more arch-independent
In-Reply-To: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_PDC related stuff in processor_core.c is little bit X86/IA64 dependent,
rework the code to make it more arch-independent.

The return value of acpi_processor_eval_pdc() should be 'acpi_status' but
defined as 'int', fix it too.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
---
 drivers/acpi/processor_core.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 34e7b3c..9931435 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -273,8 +273,19 @@ static void acpi_set_pdc_bits(u32 *buf)
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
 
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
 	/* Enable coordination with firmware's _TSD info */
 	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
+	if (boot_option_idle_override == IDLE_NOMWAIT) {
+		/*
+		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
+		 * mode will be disabled in the parameter of _PDC object.
+		 * Of course C1_FFH access mode will also be disabled.
+		 */
+		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
+
+	}
+#endif
 
 	/* Twiddle arch-specific bits needed for _PDC */
 	arch_acpi_set_pdc_bits(buf);
@@ -323,25 +334,11 @@ static struct acpi_object_list *acpi_processor_alloc_pdc(void)
  * _PDC is required for a BIOS-OS handshake for most of the newer
  * ACPI processor features.
  */
-static int
+static acpi_status
 acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
 
-	if (boot_option_idle_override == IDLE_NOMWAIT) {
-		/*
-		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
-		 * mode will be disabled in the parameter of _PDC object.
-		 * Of course C1_FFH access mode will also be disabled.
-		 */
-		union acpi_object *obj;
-		u32 *buffer = NULL;
-
-		obj = pdc_in->pointer;
-		buffer = (u32 *)(obj->buffer.pointer);
-		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
-
-	}
 	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
-- 
1.7.9.5
