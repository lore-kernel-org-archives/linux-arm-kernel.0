From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Feb 2015 20:09:36 +0000
Subject: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <20150203141749.GA32536@leverpostej>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
 <20150203141749.GA32536@leverpostej>
Message-ID: <20150203200936.GA21731@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 02:17:49PM +0000, Mark Rutland wrote:
> On Mon, Feb 02, 2015 at 12:45:42PM +0000, Hanjun Guo wrote:
> > Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> > from the GICC Structure introduced by ACPI 5.1.
> > 
> > MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we use
> > MPIDR not the GIC CPU interface ID to identify CPUs.
> > 
> > Further steps would typedef a phys_id_t for in arch code(with
> > appropriate size and a corresponding invalid value, say ~0) and use that
> > instead of an int in drivers/acpi/processor_core.c to store phys_id, then
> > no need for mpidr packing.
> 
> I don't understand why we don't fix this now, and I'm very worried that
> this patch leaves much potential for FW bugs due to potential Linux
> bugs.
> 
> Having a function called cpu_physical_id which _does not_ return a
> physical ID makes no sense to me. Any time we really need a physical
> ID, we're still going to have to unpack it (in an architecture-specific
> manner).

Do you mean something like this? Only briefly tested on Juno and I may
have missed other calls:

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index ea4d2b35c57b..4fafd62b1b86 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -49,33 +49,12 @@ static inline void enable_acpi(void)
 	acpi_noirq = 0;
 }
 
-/* MPIDR value provided in GICC structure is 64 bits, but the
- * existing phys_id (CPU hardware ID) using in acpi processor
- * driver is 32-bit, to conform to the same datatype we need
- * to repack the GICC structure MPIDR.
- *
- * bits other than following 32 bits are defined as 0, so it
- * will be no information lost after repacked.
- *
- * Bits [0:7] Aff0;
- * Bits [8:15] Aff1;
- * Bits [16:23] Aff2;
- * Bits [32:39] Aff3;
- */
-static inline u32 pack_mpidr(u64 mpidr)
-{
-	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
-}
-
 /*
  * The ACPI processor driver for ACPI core code needs this macro
  * to find out this cpu was already mapped (mapping from CPU hardware
  * ID to CPU logical ID) or not.
- *
- * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu,
- * and MPIDR is the cpu hardware ID we needed to pack.
  */
-#define cpu_physical_id(cpu) pack_mpidr(cpu_logical_map(cpu))
+#define cpu_physical_id(cpu) cpu_logical_map(cpu)
 
 /*
  * It's used from ACPI core in kdump to boot UP system with SMP kernel,
diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 59e282311b58..a492276e008d 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -40,4 +40,6 @@ static inline u32 mpidr_hash_size(void)
 extern u64 __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
+typedef u64 cpuid_t;
+
 #endif /* __ASM_SMP_PLAT_H */
diff --git a/arch/ia64/include/asm/smp.h b/arch/ia64/include/asm/smp.h
index fea21e986022..251c6af899d6 100644
--- a/arch/ia64/include/asm/smp.h
+++ b/arch/ia64/include/asm/smp.h
@@ -41,6 +41,8 @@ ia64_get_lid (void)
 
 #define hard_smp_processor_id()		ia64_get_lid()
 
+typedef int cpuid_t;
+
 #ifdef CONFIG_SMP
 
 #define XTP_OFFSET		0x1e0008
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 8cd1cc3bc835..638f7562ba99 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -83,6 +83,8 @@ struct smp_ops {
 /* Globals due to paravirt */
 extern void set_cpu_sibling_map(int cpu);
 
+typedef int cpuid_t;
+
 #ifdef CONFIG_SMP
 #ifndef CONFIG_PARAVIRT
 #define startup_ipi_hook(phys_apicid, start_eip, start_esp) do { } while (0)
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 1020b1b53a17..3e1a6b3ee3b8 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -215,7 +215,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
-	int phys_id, cpu_index, device_declaration = 0;
+	cpuid_t phys_id;
+	int cpu_index, device_declaration = 0;
 	acpi_status status = AE_OK;
 	static int cpu0_initialized;
 	unsigned long long value;
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 5ac12e40fedd..a2735c315ef7 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -13,7 +13,7 @@
 ACPI_MODULE_NAME("processor_core");
 
 static int map_lapic_id(struct acpi_subtable_header *entry,
-		 u32 acpi_id, int *apic_id)
+		 u32 acpi_id, cpuid_t *apic_id)
 {
 	struct acpi_madt_local_apic *lapic =
 		container_of(entry, struct acpi_madt_local_apic, header);
@@ -29,7 +29,7 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,
-			 int device_declaration, u32 acpi_id, int *apic_id)
+			 int device_declaration, u32 acpi_id, cpuid_t *apic_id)
 {
 	struct acpi_madt_local_x2apic *apic =
 		container_of(entry, struct acpi_madt_local_x2apic, header);
@@ -46,7 +46,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_lsapic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, int *apic_id)
+		int device_declaration, u32 acpi_id, cpuid_t *apic_id)
 {
 	struct acpi_madt_local_sapic *lsapic =
 		container_of(entry, struct acpi_madt_local_sapic, header);
@@ -69,7 +69,7 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
  * on Intel platforms
  */
 static int map_gicc_mpidr(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, int *mpidr)
+		int device_declaration, u32 acpi_id, cpuid_t *mpidr)
 {
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
@@ -84,24 +84,21 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	if (device_declaration && (gicc->uid == acpi_id)) {
 		/*
 		 * bits other than [0:7] Aff0, [8:15] Aff1, [16:23] Aff2 and
-		 * [32:39] Aff3 must be 0 which is defined in ACPI 5.1, so pack
-		 * the Affx fields into a single 32 bit identifier to accommodate
-		 * the acpi processor drivers.
+		 * [32:39] Aff3 must be 0 which is defined in ACPI 5.1
 		 */
-		*mpidr = ((gicc->arm_mpidr & 0xff00000000) >> 8)
-			 | gicc->arm_mpidr;
+		*mpidr = gicc->arm_mpidr & 0xff00ffffffUL;
 		return 0;
 	}
 
 	return -EINVAL;
 }
 
-static int map_madt_entry(int type, u32 acpi_id)
+static cpuid_t map_madt_entry(int type, u32 acpi_id)
 {
 	unsigned long madt_end, entry;
 	static struct acpi_table_madt *madt;
 	static int read_madt;
-	int phys_id = -1;	/* CPU hardware ID */
+	cpuid_t phys_id = -1;	/* CPU hardware ID */
 
 	if (!read_madt) {
 		if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_MADT, 0,
@@ -145,7 +142,7 @@ static int map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	struct acpi_subtable_header *header;
-	int phys_id = -1;
+	cpuid_t phys_id = -1;
 
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
 		goto exit;
@@ -174,7 +171,7 @@ exit:
 	return phys_id;
 }
 
-int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
+cpuid_t acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
 {
 	int phys_id;
 
@@ -185,7 +182,7 @@ int acpi_get_phys_id(acpi_handle handle, int type, u32 acpi_id)
 	return phys_id;
 }
 
-int acpi_map_cpuid(int phys_id, u32 acpi_id)
+int acpi_map_cpuid(cpuid_t phys_id, u32 acpi_id)
 {
 #ifdef CONFIG_SMP
 	int i;
@@ -213,9 +210,9 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
 		 * Return -1 for other CPU's handle.
 		 */
 		if (nr_cpu_ids <= 1 && acpi_id == 0)
-			return acpi_id;
+			return 0;
 		else
-			return phys_id;
+			return -1;
 	}
 
 #ifdef CONFIG_SMP
@@ -233,7 +230,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
 
 int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
 {
-	int phys_id;
+	cpuid_t phys_id;
 
 	phys_id = acpi_get_phys_id(handle, type, acpi_id);
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index b95dc32a6e6b..30ebdbf0d961 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -196,7 +196,7 @@ struct acpi_processor_flags {
 struct acpi_processor {
 	acpi_handle handle;
 	u32 acpi_id;
-	u32 phys_id;	/* CPU hardware ID such as APIC ID for x86 */
+	cpuid_t phys_id;	/* CPU hardware ID such as APIC ID for x86 */
 	u32 id;		/* CPU logical ID allocated by OS */
 	u32 pblk;
 	int performance_platform_limit;
@@ -310,8 +310,8 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_core.c */
-int acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
-int acpi_map_cpuid(int phys_id, u32 acpi_id);
+cpuid_t acpi_get_phys_id(acpi_handle, int type, u32 acpi_id);
+int acpi_map_cpuid(cpuid_t phys_id, u32 acpi_id);
 int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
 
 /* in processor_pdc.c */
