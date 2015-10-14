From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Oct 2015 19:17:49 +0100
Subject: [Xen-devel] [PATCH 1/3] xen/arm: Enable cpu_hotplug.c
In-Reply-To: <182B77B3-41AD-4364-B1A0-EC161F546751@oracle.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <1444844997-27314-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <182B77B3-41AD-4364-B1A0-EC161F546751@oracle.com>
Message-ID: <alpine.DEB.2.02.1510141916430.27957@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Oct 2015, Konrad Rzeszutek Wilk wrote:
> On October 14, 2015 1:49:55 PM EDT, Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:
> >Build cpu_hotplug for ARM and ARM64 guests.
> >
> >Rename arch_(un)register_cpu to xen_(un)register_cpu and provide an
> >empty implementation on ARM and ARM64. On x86 just call
> >arch_(un)register_cpu as we are already doing.
> >
> >Initialize cpu_hotplug on ARM.
> 
> Have you tested this on x86? As your changes touch the generic code path.

Only build-tested at this stage, because all my x86 test boxes are
unavailable at the moment (they are being relocated). As soon as they
come back online I will test.


> >Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >---
> > arch/arm/include/asm/xen/hypervisor.h |    8 ++++++++
> > arch/x86/include/asm/xen/hypervisor.h |    5 +++++
> > arch/x86/xen/enlighten.c              |   15 +++++++++++++++
> > drivers/xen/Makefile                  |    2 --
> > drivers/xen/cpu_hotplug.c             |    6 ++++--
> > 5 files changed, 32 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/arm/include/asm/xen/hypervisor.h
> >b/arch/arm/include/asm/xen/hypervisor.h
> >index 04ff8e7..2bc418a 100644
> >--- a/arch/arm/include/asm/xen/hypervisor.h
> >+++ b/arch/arm/include/asm/xen/hypervisor.h
> >@@ -26,4 +26,12 @@ void __init xen_early_init(void);
> > static inline void xen_early_init(void) { return; }
> > #endif
> > 
> >+static inline void xen_arch_register_cpu(int num)
> >+{
> >+}
> >+
> >+static inline void xen_arch_unregister_cpu(int num)
> >+{
> >+}
> >+
> > #endif /* _ASM_ARM_XEN_HYPERVISOR_H */
> >diff --git a/arch/x86/include/asm/xen/hypervisor.h
> >b/arch/x86/include/asm/xen/hypervisor.h
> >index d866959..8b2d4be 100644
> >--- a/arch/x86/include/asm/xen/hypervisor.h
> >+++ b/arch/x86/include/asm/xen/hypervisor.h
> >@@ -57,4 +57,9 @@ static inline bool xen_x2apic_para_available(void)
> > }
> > #endif
> > 
> >+#ifdef CONFIG_HOTPLUG_CPU
> >+void xen_arch_register_cpu(int num);
> >+void xen_arch_unregister_cpu(int num);
> >+#endif
> >+
> > #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> >diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> >index 11d6fb4..ba62d8e 100644
> >--- a/arch/x86/xen/enlighten.c
> >+++ b/arch/x86/xen/enlighten.c
> >@@ -71,6 +71,7 @@
> > #include <asm/mwait.h>
> > #include <asm/pci_x86.h>
> > #include <asm/pat.h>
> >+#include <asm/cpu.h>
> > 
> > #ifdef CONFIG_ACPI
> > #include <linux/acpi.h>
> >@@ -1868,3 +1869,17 @@ const struct hypervisor_x86 x86_hyper_xen = {
> > 	.set_cpu_features       = xen_set_cpu_features,
> > };
> > EXPORT_SYMBOL(x86_hyper_xen);
> >+
> >+#ifdef CONFIG_HOTPLUG_CPU
> >+void xen_arch_register_cpu(int num)
> >+{
> >+	arch_register_cpu(num);
> >+}
> >+EXPORT_SYMBOL(xen_arch_register_cpu);
> >+
> >+void xen_arch_unregister_cpu(int num)
> >+{
> >+	arch_unregister_cpu(num);
> >+}
> >+EXPORT_SYMBOL(xen_arch_unregister_cpu);
> >+#endif
> >diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> >index e293bc5..aa8a7f7 100644
> >--- a/drivers/xen/Makefile
> >+++ b/drivers/xen/Makefile
> >@@ -1,6 +1,4 @@
> >-ifeq ($(filter y, $(CONFIG_ARM) $(CONFIG_ARM64)),)
> > obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
> >-endif
> > obj-$(CONFIG_X86)			+= fallback.o
> > obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o
> > obj-y	+= events/
> >diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
> >index cc6513a..122b351 100644
> >--- a/drivers/xen/cpu_hotplug.c
> >+++ b/drivers/xen/cpu_hotplug.c
> >@@ -11,7 +11,7 @@
> > static void enable_hotplug_cpu(int cpu)
> > {
> > 	if (!cpu_present(cpu))
> >-		arch_register_cpu(cpu);
> >+		xen_arch_register_cpu(cpu);
> > 
> > 	set_cpu_present(cpu, true);
> > }
> >@@ -19,7 +19,7 @@ static void enable_hotplug_cpu(int cpu)
> > static void disable_hotplug_cpu(int cpu)
> > {
> > 	if (cpu_present(cpu))
> >-		arch_unregister_cpu(cpu);
> >+		xen_arch_unregister_cpu(cpu);
> > 
> > 	set_cpu_present(cpu, false);
> > }
> >@@ -102,8 +102,10 @@ static int __init setup_vcpu_hotplug_event(void)
> > 	static struct notifier_block xsn_cpu = {
> > 		.notifier_call = setup_cpu_watcher };
> > 
> >+#ifdef CONFIG_X86
> > 	if (!xen_pv_domain())
> > 		return -ENODEV;
> >+#endif
> > 
> > 	register_xenstore_notifier(&xsn_cpu);
> > 
> 
> 
