From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Nov 2014 13:07:33 +0800
Subject: [PATCH v2 3/3] ACPI / processor: Rename acpi_(un)map_lsapic() to
 acpi_(un)map_cpu()
In-Reply-To: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
References: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Message-ID: <1417064853-27905-4-git-send-email-hanjun.guo@linaro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

acpi_map_lsapic() will allocate a logical CPU number and map it to
physical CPU id (such as APIC id) for the hot-added CPU, it will also
do some mapping for NUMA node id and etc, acpi_unmap_lsapic() will
do the reverse.

We can see that the name of the function is a little bit confusing and
arch (IA64) dependent so rename them as acpi_(un)map_cpu() to make arch
agnostic and explicit.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.com>
---
 arch/ia64/kernel/acpi.c       | 9 ++++-----
 arch/x86/kernel/acpi/boot.c   | 9 ++++-----
 drivers/acpi/acpi_processor.c | 6 +++---
 include/linux/acpi.h          | 4 ++--
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index 615ef81..e795cb8 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -893,13 +893,13 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
 }
 
 /* wrapper to silence section mismatch warning */
-int __ref acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
+int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
 {
 	return _acpi_map_lsapic(handle, physid, pcpu);
 }
-EXPORT_SYMBOL(acpi_map_lsapic);
+EXPORT_SYMBOL(acpi_map_cpu);
 
-int acpi_unmap_lsapic(int cpu)
+int acpi_unmap_cpu(int cpu)
 {
 	ia64_cpu_to_sapicid[cpu] = -1;
 	set_cpu_present(cpu, false);
@@ -910,8 +910,7 @@ int acpi_unmap_lsapic(int cpu)
 
 	return (0);
 }
-
-EXPORT_SYMBOL(acpi_unmap_lsapic);
+EXPORT_SYMBOL(acpi_unmap_cpu);
 #endif				/* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4433a4b..d162636 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -750,13 +750,13 @@ static int _acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
 }
 
 /* wrapper to silence section mismatch warning */
-int __ref acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu)
+int __ref acpi_map_cpu(acpi_handle handle, int physid, int *pcpu)
 {
 	return _acpi_map_lsapic(handle, physid, pcpu);
 }
-EXPORT_SYMBOL(acpi_map_lsapic);
+EXPORT_SYMBOL(acpi_map_cpu);
 
-int acpi_unmap_lsapic(int cpu)
+int acpi_unmap_cpu(int cpu)
 {
 #ifdef CONFIG_ACPI_NUMA
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
@@ -768,8 +768,7 @@ int acpi_unmap_lsapic(int cpu)
 
 	return (0);
 }
-
-EXPORT_SYMBOL(acpi_unmap_lsapic);
+EXPORT_SYMBOL(acpi_unmap_cpu);
 #endif				/* CONFIG_ACPI_HOTPLUG_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index f02b29e..1020b1b 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -180,13 +180,13 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	cpu_maps_update_begin();
 	cpu_hotplug_begin();
 
-	ret = acpi_map_lsapic(pr->handle, pr->phys_id, &pr->id);
+	ret = acpi_map_cpu(pr->handle, pr->phys_id, &pr->id);
 	if (ret)
 		goto out;
 
 	ret = arch_register_cpu(pr->id);
 	if (ret) {
-		acpi_unmap_lsapic(pr->id);
+		acpi_unmap_cpu(pr->id);
 		goto out;
 	}
 
@@ -461,7 +461,7 @@ static void acpi_processor_remove(struct acpi_device *device)
 
 	/* Remove the CPU. */
 	arch_unregister_cpu(pr->id);
-	acpi_unmap_lsapic(pr->id);
+	acpi_unmap_cpu(pr->id);
 
 	cpu_hotplug_done();
 	cpu_maps_update_done();
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d22e0a8..0b5d4f0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -143,8 +143,8 @@ void acpi_numa_arch_fixup(void);
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /* Arch dependent functions for cpu hotplug support */
-int acpi_map_lsapic(acpi_handle handle, int physid, int *pcpu);
-int acpi_unmap_lsapic(int cpu);
+int acpi_map_cpu(acpi_handle handle, int physid, int *pcpu);
+int acpi_unmap_cpu(int cpu);
 #endif /* CONFIG_ACPI_HOTPLUG_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
-- 
1.9.1
