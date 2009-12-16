From: richardliu@ms1.techarea.org (Richard Liu)
Date: Wed, 16 Dec 2009 22:13:35 +0800
Subject: [Fwd: [PATCH] PCI Domains Support]
Message-ID: <4B28EB0F.3070409@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all:

    Seems ARM don's support PCI Domains function now.
Here is a tiny patch for PCI Domains support

    It's work on my platform,
There are two PCIe host controller on my platform, and both bus number
should be 0
So, use PCI Domain to control both PCIe host controller is better choice.

Here is platform PCIe sample code,
static struct hw_pci cxxxxxx_pcie0 __initdata = {
        .swizzle = pci_std_swizzle,
        .map_irq = cxxxxxx_pcie0_map_irq,
        .nr_controllers = 1,
        .nr_domains = 0,
        .setup = cxxxxxx_pci_setup,
        .scan = cxxxxxx_pci_scan_bus,
        .preinit = cxxxxxx_pci_preinit,
        .postinit = cxxxxxx_pcie0_postinit,
};
static struct hw_pci cxxxxxx_pcie1 __initdata = {
        .swizzle = pci_std_swizzle,
        .map_irq = cxxxxxx_pcie1_map_irq,
        .nr_controllers = 1,
        .nr_domains = 1,
        .setup = cxxxxxx_pci_setup,
        .scan = cxxxxxx_pci_scan_bus,
        .postinit = cxxxxxx_pcie1_postinit,
};

static int __init cxxxxxx_pci_init(void)
{
        pci_common_init(&cxxxxxx_pcie0);
        pci_common_init(&cxxxxxx_pcie1);
        return 0;
}


--
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79a3074..33a49ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -865,6 +865,10 @@ config PCI
       your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
       VESA. If you have PCI, say Y, otherwise N.
 
+config PCI_DOMAINS
+        def_bool y
+        depends on PCI
+
 config PCI_SYSCALL
     def_bool PCI
 
diff --git a/arch/arm/include/asm/mach/pci.h
b/arch/arm/include/asm/mach/pci.h
index a38bdc7..f099067 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -20,6 +20,9 @@ struct hw_pci {
     void        (*postinit)(void);
     u8        (*swizzle)(struct pci_dev *dev, u8 *pin);
     int        (*map_irq)(struct pci_dev *dev, u8 slot, u8 pin);
+#ifdef CONFIG_PCI_DOMAINS
+    int        nr_domains;
+#endif
 };
 
 /*
@@ -37,8 +40,12 @@ struct pci_sys_data {
                     /* IRQ mapping                */
     int        (*map_irq)(struct pci_dev *, u8, u8);
     struct hw_pci    *hw;
+#ifdef CONFIG_PCI_DOMAINS
+    int        domain;
+#endif
 };
 
+
 /*
  * This is the standard PCI-PCI bridge swizzling algorithm.
  */
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 0abf386..57ce5bd 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -25,6 +25,11 @@ static inline void pcibios_penalize_isa_irq(int irq,
int active)
     /* We don't do dynamic PCI IRQ allocation */
 }
 
+#ifdef CONFIG_PCI_DOMAINS
+int pci_domain_nr(struct pci_bus *bus);
+int pci_proc_domain(struct pci_bus *bus);
+#endif
+
 /*
  * The PCI address space does equal the physical memory address space.
  * The networking and block device layers use this boolean for bounce
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 8096819..b364ca8 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -531,6 +531,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
         sys->busnr   = busnr;
         sys->swizzle = hw->swizzle;
         sys->map_irq = hw->map_irq;
+        sys->domain  = hw->nr_domains;
         sys->resource[0] = &ioport_resource;
         sys->resource[1] = &iomem_resource;
 
@@ -694,3 +695,20 @@ int pci_mmap_page_range(struct pci_dev *dev, struct
vm_area_struct *vma,
 
     return 0;
 }
+#ifdef CONFIG_PCI_DOMAINS
+int pci_domain_nr(struct pci_bus *bus)
+{
+
+        //struct pci_sysdata *sd = bus->sysdata;
+        struct pci_sys_data *sd = bus->sysdata;
+        return sd->domain;
+
+}
+EXPORT_SYMBOL(pci_domain_nr);
+
+int pci_proc_domain(struct pci_bus *bus)
+{
+        return pci_domain_nr(bus);
+}
+EXPORT_SYMBOL(pci_proc_domain);
+#endif
