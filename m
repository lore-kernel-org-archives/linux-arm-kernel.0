From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 19 Oct 2015 17:55:33 +0100
Subject: [PATCH v3 1/3] xen/arm: Enable cpu_hotplug.c
In-Reply-To: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
Message-ID: <1445273735-15758-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build cpu_hotplug for ARM and ARM64 guests.

Rename arch_(un)register_cpu to xen_(un)register_cpu and provide an
empty implementation on ARM and ARM64. On x86 just call
arch_(un)register_cpu as we are already doing.

Initialize cpu_hotplug on ARM.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Reviewed-by: Julien Grall <julien.grall@citrix.com>

---

Changes in v2:
- don't initialize if not a xen_domain() on arm
- protect xen_arch_(un)register_cpu with ifdef CONFIG_HOTPLUG_CPU on arm
---
 arch/arm/include/asm/xen/hypervisor.h |   10 ++++++++++
 arch/x86/include/asm/xen/hypervisor.h |    5 +++++
 arch/x86/xen/enlighten.c              |   15 +++++++++++++++
 drivers/xen/Makefile                  |    2 --
 drivers/xen/cpu_hotplug.c             |    8 ++++++--
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/xen/hypervisor.h b/arch/arm/include/asm/xen/hypervisor.h
index 04ff8e7..9525151 100644
--- a/arch/arm/include/asm/xen/hypervisor.h
+++ b/arch/arm/include/asm/xen/hypervisor.h
@@ -26,4 +26,14 @@ void __init xen_early_init(void);
 static inline void xen_early_init(void) { return; }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+static inline void xen_arch_register_cpu(int num)
+{
+}
+
+static inline void xen_arch_unregister_cpu(int num)
+{
+}
+#endif
+
 #endif /* _ASM_ARM_XEN_HYPERVISOR_H */
diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index d866959..8b2d4be 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -57,4 +57,9 @@ static inline bool xen_x2apic_para_available(void)
 }
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+void xen_arch_register_cpu(int num);
+void xen_arch_unregister_cpu(int num);
+#endif
+
 #endif /* _ASM_X86_XEN_HYPERVISOR_H */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 11d6fb4..ba62d8e 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -71,6 +71,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/pat.h>
+#include <asm/cpu.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1868,3 +1869,17 @@ const struct hypervisor_x86 x86_hyper_xen = {
 	.set_cpu_features       = xen_set_cpu_features,
 };
 EXPORT_SYMBOL(x86_hyper_xen);
+
+#ifdef CONFIG_HOTPLUG_CPU
+void xen_arch_register_cpu(int num)
+{
+	arch_register_cpu(num);
+}
+EXPORT_SYMBOL(xen_arch_register_cpu);
+
+void xen_arch_unregister_cpu(int num)
+{
+	arch_unregister_cpu(num);
+}
+EXPORT_SYMBOL(xen_arch_unregister_cpu);
+#endif
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index e293bc5..aa8a7f7 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -1,6 +1,4 @@
-ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
 obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
-endif
 obj-$(CONFIG_X86)			+= fallback.o
 obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o
 obj-y	+= events/
diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
index cc6513a..43de1f5 100644
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -11,7 +11,7 @@
 static void enable_hotplug_cpu(int cpu)
 {
 	if (!cpu_present(cpu))
-		arch_register_cpu(cpu);
+		xen_arch_register_cpu(cpu);
 
 	set_cpu_present(cpu, true);
 }
@@ -19,7 +19,7 @@ static void enable_hotplug_cpu(int cpu)
 static void disable_hotplug_cpu(int cpu)
 {
 	if (cpu_present(cpu))
-		arch_unregister_cpu(cpu);
+		xen_arch_unregister_cpu(cpu);
 
 	set_cpu_present(cpu, false);
 }
@@ -102,7 +102,11 @@ static int __init setup_vcpu_hotplug_event(void)
 	static struct notifier_block xsn_cpu = {
 		.notifier_call = setup_cpu_watcher };
 
+#ifdef CONFIG_X86
 	if (!xen_pv_domain())
+#else
+	if (!xen_domain())
+#endif
 		return -ENODEV;
 
 	register_xenstore_notifier(&xsn_cpu);
-- 
1.7.10.4
