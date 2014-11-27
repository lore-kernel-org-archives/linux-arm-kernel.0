From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Nov 2014 13:07:32 +0800
Subject: [PATCH v2 2/3] ACPI / processor: Convert apic_id to phys_id to make
 it arch agnostic
In-Reply-To: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
References: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Message-ID: <1417064853-27905-3-git-send-email-hanjun.guo@linaro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

apic_id in MADT table is the CPU hardware id which identify
it self in the system for x86 and ia64, OSPM will use it for
SMP init to map APIC ID to logical cpu number in the early
boot, when the DSDT/SSDT (ACPI namespace) is scanned later, the
ACPI processor driver is probed and the driver will use acpi_id
in DSDT to get the apic_id, then map to the logical cpu number
which is needed by the processor driver.

Before ACPI 5.0, only x86 and ia64 were supported in ACPI spec,
so apic_id is used both in arch code and ACPI core which is
pretty fine. Since ACPI 5.0, ARM is supported by ACPI and
APIC is not available on ARM, this will confuse people when
apic_id is both used by x86 and ARM in one function.

So convert apic_id to phys_id (which is the original meaning)
in ACPI processor dirver to make it arch agnostic, but leave the
arch dependent code unchanged, no functional change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.com>
---
 drivers/acpi/acpi_processor.c | 21 +++++++++-------
 drivers/acpi/processor_core.c | 56 +++++++++++++++++++++----------------------
 include/acpi/processor.h      |  8 +++----
 3 files changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 1fdf5e0..f02b29e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -170,7 +170,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	acpi_status status;
 	int ret;
 
-	if (pr->apic_id == -1)
+	if (pr->phys_id == -1)
 		return -ENODEV;
 
 	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
@@ -180,7 +180,7 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	cpu_maps_update_begin();
 	cpu_hotplug_begin();
 
-	ret = acpi_map_lsapic(pr->handle, pr->apic_id, &pr->id);
+	ret = acpi_map_lsapic(pr->handle, pr->phys_id, &pr->id);
 	if (ret)
 		goto out;
 
@@ -215,7 +215,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
-	int apic_id, cpu_index, device_declaration = 0;
+	int phys_id, cpu_index, device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
 	unsigned long long value;
@@ -262,15 +262,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		pr->acpi_id = value;
 	}
 
-	apic_id = acpi_get_apicid(pr->handle, device_declaration, pr->acpi_id);
-	if (apic_id < 0)
-		acpi_handle_debug(pr->handle, "failed to get CPU APIC ID.\n");
-	pr->apic_id = apic_id;
+	phys_id = acpi_get_phys_id(pr->handle, device_declaration, pr->acpi_id);
+	if (phys_id < 0)
+		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
+	pr->phys_id = phys_id;
 
-	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
+	cpu_index = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
 	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
 		cpu0_initialized = 1;
-		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
+		/*
+		 * Handle UP system running SMP kernel, with no CPU
+		 * entry in MADT
+		 */
 		if ((cpu_index == -1) && (num_online_cpus() == 1))
 			cpu_index = 0;
 	}
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index f124cbb..7962651 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -86,12 +86,12 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
 static int map_madt_entry(int type, u32 acpi_id)
 {
 	unsigned long madt_end, entry;
-	int apic_id = -1;
+	int phys_id = -1;	/* CPU hardware ID */
 	struct acpi_table_madt *madt;
 
 	madt = get_madt_table();
 	if (!madt)
-		return apic_id;
+		return phys_id;
 
 	entry = (unsigned long)madt;
 	madt_end = entry + madt->header.length;
@@ -103,18 +103,18 @@ static int map_madt_entry(int type, u32 acpi_id)
 		struct acpi_subtable_header *header =
 			(struct acpi_subtable_header *)entry;
 		if (header->type == ACPI_MADT_TYPE_LOCAL_APIC) {
-			if (!map_lapic_id(header, acpi_id, &apic_id))
+			if (!map_lapic_id(header, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
-			if (!map_x2apic_id(header, type, acpi_id, &apic_id))
+			if (!map_x2apic_id(header, type, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
-			if (!map_lsapic_id(header, type, acpi_id, &apic_id))
+			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
 				break;
 		}
 		entry += header->length;
 	}
-	return apic_id;
+	return phys_id;
 }
 
 static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
@@ -122,7 +122,7 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	struct acpi_subtable_header *header;
-	int apic_id = -1;
+	int phys_id = -1;
 
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
 		goto exit;
@@ -138,38 +138,38 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 
 	header = (struct acpi_subtable_header *)obj->buffer.pointer;
 	if (header->type == ACPI_MADT_TYPE_LOCAL_APIC)
-		map_lapic_id(header, acpi_id, &apic_id);
+		map_lapic_id(header, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
-		map_lsapic_id(header, type, acpi_id, &apic_id);
+		map_lsapic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
-		map_x2apic_id(header, type, acpi_id, &apic_id);
+		map_x2apic_id(header, type, acpi_id, &phys_id);
 
 exit:
 	kfree(buffer.pointer);
-	return apic_id;
+	return phys_id;
 }
 
-int acpi_get_apicid(acpi_handle handle, int type, u32 acpi_id)
+int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
 {
-	int apic_id;
+	int phys_id;
 
-	apic_id = map_mat_entry(handle, type, acpi_id);
-	if (apic_id == -1)
-		apic_id = map_madt_entry(type, acpi_id);
+	phys_id = map_mat_entry(handle, type, acpi_id);
+	if (phys_id == -1)
+		phys_id = map_madt_entry(type, acpi_id);
 
-	return apic_id;
+	return phys_id;
 }
 
-int acpi_map_cpuid(int apic_id, u32 acpi_id)
+int acpi_map_cpuid(int phys_id, u32 acpi_id)
 {
 #ifdef CONFIG_SMP
 	int i;
 #endif
 
-	if (apic_id == -1) {
+	if (phys_id == -1) {
 		/*
 		 * On UP processor, there is no _MAT or MADT table.
-		 * So above apic_id is always set to -1.
+		 * So above phys_id is always set to -1.
 		 *
 		 * BIOS may define multiple CPU handles even for UP processor.
 		 * For example,
@@ -182,7 +182,7 @@ int acpi_map_cpuid(int apic_id, u32 acpi_id)
 		 *     Processor (CPU3, 0x03, 0x00000410, 0x06) {}
 		 * }
 		 *
-		 * Ignores apic_id and always returns 0 for the processor
+		 * Ignores phys_id and always returns 0 for the processor
 		 * handle with acpi id 0 if nr_cpu_ids is 1.
 		 * This should be the case if SMP tables are not found.
 		 * Return -1 for other CPU's handle.
@@ -190,29 +190,29 @@ int acpi_map_cpuid(int apic_id, u32 acpi_id)
 		if (nr_cpu_ids <= 1 && acpi_id == 0)
 			return acpi_id;
 		else
-			return apic_id;
+			return phys_id;
 	}
 
 #ifdef CONFIG_SMP
 	for_each_possible_cpu(i) {
-		if (cpu_physical_id(i) == apic_id)
+		if (cpu_physical_id(i) == phys_id)
 			return i;
 	}
 #else
 	/* In UP kernel, only processor 0 is valid */
-	if (apic_id == 0)
-		return apic_id;
+	if (phys_id == 0)
+		return phys_id;
 #endif
 	return -1;
 }
 
 int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 {
-	int apic_id;
+	int phys_id;
 
-	apic_id = acpi_get_apicid(handle, type, acpi_id);
+	phys_id = acpi_get_phys_id(handle, type, acpi_id);
 
-	return acpi_map_cpuid(apic_id, acpi_id);
+	return acpi_map_cpuid(phys_id, acpi_id);
 }
 EXPORT_SYMBOL_GPL(acpi_get_cpuid);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index cbb6cd3..8e34af9 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -199,8 +199,8 @@ struct acpi_processor_flags {
 struct acpi_processor {
 	acpi_handle handle;
 	u32 acpi_id;
-	u32 apic_id;
-	u32 id;
+	u32 phys_id;	/* CPU hardware ID such as APIC ID for x86 */
+	u32 id;		/* CPU logical ID allocated by OS */
 	u32 pblk;
 	int performance_platform_limit;
 	int throttling_platform_limit;
@@ -313,8 +313,8 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_core.c */
-int acpi_get_apicid(acpi_handle, int type, u32 acpi_id);
-int acpi_map_cpuid(int apic_id, u32 acpi_id);
+int acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
+int acpi_map_cpuid(int phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
 /* in processor_pdc.c */
-- 
1.9.1
