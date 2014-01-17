From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:24:55 +0800
Subject: [PATCH 01/20] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-2-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all the ARM64 targets that are using ACPI have PCI, so introduce
some stub functions to make PCI optional for ACPI, and make ACPI core
run without CONFIG_PCI on ARM64.

pcibios_penalize_isa_irq() is arch dependent, introduce asm/pci.h to
include it.

Since ACPI on X86 and IA64 depends on PCI, it will not break X86 and
IA64 with this patch.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/pci.h |   20 ++++++++++++++++++++
 drivers/acpi/Makefile        |    2 +-
 drivers/acpi/internal.h      |    7 +++++++
 drivers/acpi/osl.c           |    3 ++-
 include/linux/pci.h          |   33 ++++++++++++++++++++++++---------
 5 files changed, 54 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/pci.h

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
new file mode 100644
index 0000000..455909d
--- /dev/null
+++ b/arch/arm64/include/asm/pci.h
@@ -0,0 +1,20 @@
+#ifndef __ASMARM64_PCI_H
+#define __ASMARM64_PCI_H
+
+#ifdef __KERNEL__
+
+static inline void pcibios_penalize_isa_irq(int irq, int active)
+{
+	/* We don't do dynamic PCI IRQ allocation */
+}
+
+/*
+ * The PCI address space does equal the physical memory address space.
+ * The networking and block device layers use this boolean for bounce
+ * buffer decisions.
+ */
+#define PCI_DMA_BUS_IS_PHYS     (1)
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASMARM64_PCI_H */
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 0331f91..d8cebe3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -38,7 +38,7 @@ acpi-y				+= acpi_processor.o
 acpi-y				+= processor_core.o
 acpi-y				+= ec.o
 acpi-$(CONFIG_ACPI_DOCK)	+= dock.o
-acpi-y				+= pci_root.o pci_link.o pci_irq.o
+acpi-$(CONFIG_PCI)		+= pci_root.o pci_link.o pci_irq.o
 acpi-$(CONFIG_X86_INTEL_LPSS)	+= acpi_lpss.o
 acpi-y				+= acpi_platform.o
 acpi-y				+= power.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index a29739c..52dff47 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -26,9 +26,16 @@
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
+#ifdef CONFIG_PCI
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
 void acpi_pci_root_hp_init(void);
+#else
+static inline void acpi_pci_root_init(void) {}
+static inline void acpi_pci_link_init(void) {}
+static inline void acpi_pci_root_hp_init(void) {}
+#endif /* CONFIG_PCI */
+
 void acpi_processor_init(void);
 void acpi_platform_init(void);
 int acpi_sysfs_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 54a20ff..14ee6fc 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1050,7 +1050,8 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 	result = raw_pci_read(pci_id->segment, pci_id->bus,
 				PCI_DEVFN(pci_id->device, pci_id->function),
 				reg, size, &value32);
-	*value = value32;
+	if (!result)
+		*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a13d682..726cf2a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -541,15 +541,6 @@ struct pci_ops {
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };
 
-/*
- * ACPI needs to be able to access PCI config space before we've done a
- * PCI bus scan and created pci_bus structures.
- */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val);
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val);
-
 struct pci_bus_region {
 	resource_size_t start;
 	resource_size_t end;
@@ -1281,6 +1272,15 @@ typedef int (*arch_set_vga_state_t)(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 void pci_register_set_vga_state(arch_set_vga_state_t func);
 
+/*
+ * ACPI needs to be able to access PCI config space before we've done a
+ * PCI bus scan and created pci_bus structures.
+ */
+int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
+		 int reg, int len, u32 *val);
+int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
+		  int reg, int len, u32 val);
+
 #else /* CONFIG_PCI is not enabled */
 
 /*
@@ -1477,6 +1477,21 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 static inline struct pci_dev *pci_dev_get(struct pci_dev *dev)
 { return NULL; }
 
+static inline struct pci_bus *pci_find_bus(int domain, int busnr)
+{ return NULL; }
+
+static inline int pci_bus_write_config_byte(struct pci_bus *bus,
+			unsigned int devfn, int where, u8 val)
+{ return -ENODEV; }
+
+static inline int raw_pci_read(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 *val)
+{ return -EINVAL; }
+
+static inline int raw_pci_write(unsigned int domain, unsigned int bus,
+		unsigned int devfn, int reg, int len, u32 val)
+{return -EINVAL; }
+
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)
-- 
1.7.9.5
