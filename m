From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 30 Mar 2010 23:14:42 +0400
Subject: [PATCH] ARM: Add support for PCI domains
Message-ID: <20100330191442.GA13557@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for PCI domains on ARM platforms.

Also, protect asm/mach/pci.h from multiple inclustions, otherwise
build fails because of pci_domain_nr() and pci_proc_domain()
redefinitions.

p.s.

Not sure if it makes sense to do PCI domains support optional.

With PCI domains:
   text    data     bss     dec     hex filename
3407890  139808  102016 3649714  37b0b2 vmlinux

Without PCI domains:
   text    data     bss     dec     hex filename
3407730  139808  102016 3649554  37b012 vmlinux

I.e. 160 bytes saved. Is it worth the amount of ifdefs? We can
just make it always enabled (and it seems other architectures
always enable it).

pp.s.
I found that Richard Liu seem to have posted a similar patch[1],
but it wasn't propely signed off... Heh.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/006244.html

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/Kconfig                |    4 ++++
 arch/arm/include/asm/mach/pci.h |   11 +++++++++++
 arch/arm/include/asm/pci.h      |   15 +++++++++++++++
 arch/arm/kernel/bios32.c        |    3 +++
 4 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d779e25..2a1bc52 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1075,6 +1075,10 @@ config PCI
 	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
 	  VESA. If you have PCI, say Y, otherwise N.
 
+config PCI_DOMAINS
+	bool
+	depends on PCI
+
 config PCI_SYSCALL
 	def_bool PCI
 
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index a38bdc7..52f0da1 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -8,10 +8,16 @@
  * published by the Free Software Foundation.
  */
 
+#ifndef __ASM_MACH_PCI_H
+#define __ASM_MACH_PCI_H
+
 struct pci_sys_data;
 struct pci_bus;
 
 struct hw_pci {
+#ifdef CONFIG_PCI_DOMAINS
+	int		domain;
+#endif
 	struct list_head buses;
 	int		nr_controllers;
 	int		(*setup)(int nr, struct pci_sys_data *);
@@ -26,6 +32,9 @@ struct hw_pci {
  * Per-controller structure
  */
 struct pci_sys_data {
+#ifdef CONFIG_PCI_DOMAINS
+	int		domain;
+#endif
 	struct list_head node;
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
@@ -70,3 +79,5 @@ extern int pci_v3_setup(int nr, struct pci_sys_data *);
 extern struct pci_bus *pci_v3_scan_bus(int nr, struct pci_sys_data *);
 extern void pci_v3_preinit(void);
 extern void pci_v3_postinit(void);
+
+#endif /* __ASM_MACH_PCI_H */
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 4798011..92e2a83 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -4,8 +4,23 @@
 #ifdef __KERNEL__
 #include <asm-generic/pci-dma-compat.h>
 
+#include <asm/mach/pci.h> /* for pci_sys_data */
 #include <mach/hardware.h> /* for PCIBIOS_MIN_* */
 
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_domain_nr(struct pci_bus *bus)
+{
+	struct pci_sys_data *root = bus->sysdata;
+
+	return root->domain;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	return pci_domain_nr(bus);
+}
+#endif /* CONFIG_PCI_DOMAINS */
+
 #ifdef CONFIG_PCI_HOST_ITE8152
 /* ITE bridge requires setting latency timer to avoid early bus access
    termination by PIC bus mater devices
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index bd397e0..c6273a3 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -527,6 +527,9 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 		if (!sys)
 			panic("PCI: unable to allocate sys data!");
 
+#ifdef CONFIG_PCI_DOMAINS
+		sys->domain  = hw->domain;
+#endif
 		sys->hw      = hw;
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
-- 
1.7.0.3
