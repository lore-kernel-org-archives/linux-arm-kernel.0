From: nhillery@codeaurora.org (Nathan Hillery)
Date: Tue, 21 Aug 2018 17:44:59 -0400
Subject: [RFC, V5,
 2/4] arm_pmu: acpi: Add support for CPU PMU variant detection
In-Reply-To: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
References: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
Message-ID: <1534887901-24734-3-git-send-email-nhillery@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device Tree allows CPU PMU variant detection via the PMU device compatible
property. ACPI does not have an equivalent mechanism, so we introduce
a probe table to support detection via a device nested inside the CPU
device in the DSDT:

Device (CPU0)
{
    Name (_HID, "ACPI0007" /* Processor Device */)
    ...
    Device (PMU0)
    {
        Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */

        /*
         * The device might also contain _DSD properties to indicate other
         * IMPLEMENTATION DEFINED PMU features.
         */
        Name (_DSD, Package ()
        {
            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
            Package ()
            {
                ...
            }
        })
    }
}

With this in place, we can declare the variant:

    ACPI_DECLARE_PMU_VARIANT(qcom_falkor, "QCOM8150", falkor_pmu_init);

The init function is called after the default PMU initialization and is
passed a pointer to the arm_pmu structure and a pointer to the PMU device.
The init function can then override arm_pmu callbacks & attributes and
query more properties from the PMU device.

Signed-off-by: Nathan Hillery <nhillery@codeaurora.org>
---
 drivers/perf/arm_pmu_acpi.c       | 27 +++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  1 +
 include/linux/acpi.h              | 11 +++++++++++
 include/linux/perf/arm_pmu.h      |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f19751..6b0ca71 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -220,6 +220,26 @@ static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
 	return 0;
 }
 
+/*
+ * Check if the given child device of the CPU device matches a PMU variant
+ * device declared with ACPI_DECLARE_PMU_VARIANT, if so, pass the arm_pmu
+ * structure and the matching device for further initialization.
+ */
+static int arm_pmu_variant_init(struct device *dev, void *data)
+{
+	extern struct acpi_device_id ACPI_PROBE_TABLE(pmu);
+	unsigned int cpu = *((unsigned int *)data);
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(&ACPI_PROBE_TABLE(pmu), dev);
+	if (id) {
+		armpmu_acpi_init_fn fn = (armpmu_acpi_init_fn)id->driver_data;
+
+		return fn(per_cpu(probed_pmus, cpu), dev);
+	}
+	return 0;
+}
+
 int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 {
 	int pmu_idx = 0;
@@ -240,6 +260,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct arm_pmu *pmu = per_cpu(probed_pmus, cpu);
+		struct device *dev = get_cpu_device(cpu);
 		char *base_name;
 
 		if (!pmu || pmu->name)
@@ -254,6 +275,10 @@ int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 			return ret;
 		}
 
+		ret = device_for_each_child(dev, &cpu, arm_pmu_variant_init);
+		if (ret == -ENODEV)
+			pr_warn("Failed PMU re-init, fallback to plain PMUv3");
+
 		base_name = pmu->name;
 		pmu->name = kasprintf(GFP_KERNEL, "%s_%d", base_name, pmu_idx++);
 		if (!pmu->name) {
@@ -290,3 +315,5 @@ static int arm_pmu_acpi_init(void)
 	return ret;
 }
 subsys_initcall(arm_pmu_acpi_init)
+
+ACPI_DECLARE_PMU_SENTINEL();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index af24057..ac794b9d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -599,6 +599,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
+	ACPI_PROBE_TABLE(pmu)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a6a7ae8..ba2403a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1156,6 +1156,17 @@ struct acpi_probe_entry {
 					  (&ACPI_PROBE_TABLE_END(t) -	\
 					   &ACPI_PROBE_TABLE(t)));	\
 	})
+
+#define ACPI_DECLARE_PMU_VARIANT(name, hid, init_fn)			\
+	static const struct acpi_device_id __acpi_probe_##name		\
+		__used __section(__pmu_acpi_probe_table)		\
+		= { .id = hid, .driver_data = (kernel_ulong_t)init_fn }
+
+#define ACPI_DECLARE_PMU_SENTINEL()					\
+	static const struct acpi_device_id __acpi_probe_sentinel	\
+		__used __section(__pmu_acpi_probe_table_end)		\
+		= { .id = "", .driver_data = 0 }
+
 #else
 static inline int acpi_dev_get_property(struct acpi_device *adev,
 					const char *name, acpi_object_type type,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 40036a5..ff43d65 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -123,6 +123,7 @@ int armpmu_map_event(struct perf_event *event,
 		     u32 raw_event_mask);
 
 typedef int (*armpmu_init_fn)(struct arm_pmu *);
+typedef int (*armpmu_acpi_init_fn)(struct arm_pmu *, struct device *);
 
 struct pmu_probe_info {
 	unsigned int cpuid;
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
