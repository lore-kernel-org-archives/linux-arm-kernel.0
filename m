From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 9 Jul 2010 11:18:30 +0800
Subject: [RFC PATCH] Make PCIBIOS_* into global variables and initialized with
	pci_common_init()
Message-ID: <AANLkTimyhcNIRj0BqiQkzS35XWLr3W8KWKSN7hIPgFpd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

    [ARM] Make PCIBIOS_* into global variables

    And initialized with pci_common_init(), so that now <asm/pci.h>
    doesn't depend on <mach/hardware.h> any more.

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 52f0da1..4c6b457 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -56,7 +56,7 @@ struct pci_sys_data {
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
-void pci_common_init(struct hw_pci *);
+void pci_common_init(struct hw_pci *, unsigned long, unsigned long, int);

 /*
  * PCI controllers
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 92e2a83..1d10f65 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -5,7 +5,18 @@
 #include <asm-generic/pci-dma-compat.h>

 #include <asm/mach/pci.h> /* for pci_sys_data */
-#include <mach/hardware.h> /* for PCIBIOS_MIN_* */
+
+extern unsigned long pcibios_min_io;
+extern unsigned long pcibios_min_mem;
+extern int pcibios_assign_all;
+
+#define PCIBIOS_MIN_IO		(pcibios_min_io)
+#define PCIBIOS_MIN_MEM		(pcibios_min_mem)
+
+static inline int pcibios_assign_all(void)
+{
+	return pcibios_assign_all;
+}

 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index c6273a3..d239a6a 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -18,6 +18,14 @@
 static int debug_pci;
 static int use_firmware;

+unsigned long pcibios_min_io = 0x1000;
+EXPORT_SYMBOL(pcibios_min_io);
+
+unsigned long pcibios_min_mem = 0xaeedbabe;
+EXPORT_SYMBOL(pcibios_min_mem);
+
+int pcibios_assign_all;
+
 /*
  * We can't use pci_find_device() here since we are
  * called from interrupt context.
@@ -556,12 +564,19 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 	}
 }

-void __init pci_common_init(struct hw_pci *hw)
+void __init pci_common_init(struct hw_pci *hw,
+			    unsigned long min_io,
+			    unsigned long min_mem,
+			    int assign_all)
 {
 	struct pci_sys_data *sys;

 	INIT_LIST_HEAD(&hw->buses);

+	pcibios_min_io = min_io;
+	pcibios_min_mem = min_mem;
+	pcibios_assign_all = assign_all;
+
 	if (hw->preinit)
 		hw->preinit();
 	pcibios_init_hw(hw);
diff --git a/arch/arm/mach-dove/include/mach/hardware.h
b/arch/arm/mach-dove/include/mach/hardware.h
index 32b0826..f619fb9 100644
--- a/arch/arm/mach-dove/include/mach/hardware.h
+++ b/arch/arm/mach-dove/include/mach/hardware.h
@@ -11,8 +11,6 @@

 #include "dove.h"

-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO			0x1000
 #define PCIBIOS_MIN_MEM			0x01000000
 #define PCIMEM_BASE			DOVE_PCIE0_MEM_PHYS_BASE
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 502d1ca..5a541e7 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -234,5 +234,5 @@ void __init dove_pcie_init(int init_port0, int init_port1)
 	if (init_port1)
 		add_pcie_port(1, DOVE_PCIE1_VIRT_BASE);

-	pci_common_init(&dove_pci);
+	pci_common_init(&dove_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 }
diff --git a/arch/arm/mach-footbridge/cats-pci.c
b/arch/arm/mach-footbridge/cats-pci.c
index ae3e1c8..9d600ac 100644
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ b/arch/arm/mach-footbridge/cats-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 /* cats host-specific stuff */
 static int irqmap_cats[] __initdata = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
@@ -51,7 +52,7 @@ static struct hw_pci cats_pci __initdata = {
 static int __init cats_pci_init(void)
 {
 	if (machine_is_cats())
-		pci_common_init(&cats_pci);
+		pci_common_init(&cats_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c
b/arch/arm/mach-footbridge/ebsa285-pci.c
index e5ab5bd..d04b0f0 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 static int irqmap_ebsa285[] __initdata = { IRQ_IN3, IRQ_IN1, IRQ_IN0,
IRQ_PCI };

@@ -41,7 +42,8 @@ static struct hw_pci ebsa285_pci __initdata = {
 static int __init ebsa285_init_pci(void)
 {
 	if (machine_is_ebsa285())
-		pci_common_init(&ebsa285_pci);
+		pci_common_init(&ebsa285_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h
b/arch/arm/mach-footbridge/include/mach/hardware.h
index 51dd902..541aa70 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -93,8 +93,6 @@ extern unsigned int nw_gpio_read(void);
 extern void nw_cpld_modify(unsigned int mask, unsigned int set);
 #endif

-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x1000
 #define PCIBIOS_MIN_MEM 	0x81000000

diff --git a/arch/arm/mach-footbridge/netwinder-pci.c
b/arch/arm/mach-footbridge/netwinder-pci.c
index e263d6d..fe84879 100644
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ b/arch/arm/mach-footbridge/netwinder-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 /*
  * We now use the slot ID instead of the device identifiers to select
@@ -55,7 +56,8 @@ static struct hw_pci netwinder_pci __initdata = {
 static int __init netwinder_pci_init(void)
 {
 	if (machine_is_netwinder())
-		pci_common_init(&netwinder_pci);
+		pci_common_init(&netwinder_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-footbridge/personal-pci.c
b/arch/arm/mach-footbridge/personal-pci.c
index d5fca95..ec73e03 100644
--- a/arch/arm/mach-footbridge/personal-pci.c
+++ b/arch/arm/mach-footbridge/personal-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 static int irqmap_personal_server[] __initdata = {
 	IRQ_IN0, IRQ_IN1, IRQ_IN2, IRQ_IN3, 0, 0, 0,
@@ -49,7 +50,8 @@ static struct hw_pci personal_server_pci __initdata = {
 static int __init personal_pci_init(void)
 {
 	if (machine_is_personal_server())
-		pci_common_init(&personal_server_pci);
+		pci_common_init(&personal_server_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-integrator/include/mach/hardware.h
b/arch/arm/mach-integrator/include/mach/hardware.h
index 8e26360..2905966 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -35,8 +35,6 @@
 #define PCIO_BASE		PCI_IO_VADDR
 #define PCIMEM_BASE		PCI_MEMORY_VADDR

-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x6000
 #define PCIBIOS_MIN_MEM 	0x00100000

diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 2fdb954..43eab96 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -30,6 +30,7 @@
 #include <asm/system.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 /*
  * A small note about bridges and interrupts.  The DECchip 21050 (and
@@ -117,7 +118,8 @@ static struct hw_pci integrator_pci __initdata = {
 static int __init integrator_pci_init(void)
 {
 	if (machine_is_integrator())
-		pci_common_init(&integrator_pci);
+		pci_common_init(&integrator_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-iop13xx/include/mach/hardware.h
b/arch/arm/mach-iop13xx/include/mach/hardware.h
index 8e1d562..ba81e50 100644
--- a/arch/arm/mach-iop13xx/include/mach/hardware.h
+++ b/arch/arm/mach-iop13xx/include/mach/hardware.h
@@ -2,8 +2,6 @@
 #define __ASM_ARCH_HARDWARE_H
 #include <asm/types.h>

-#define pcibios_assign_all_busses() 1
-
 #ifndef __ASSEMBLY__
 extern unsigned long iop13xx_pcibios_min_io;
 extern unsigned long iop13xx_pcibios_min_mem;
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c
b/arch/arm/mach-iop13xx/iq81340mc.c
index f91f315..cd90bcc 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -65,7 +65,7 @@ static struct hw_pci iq81340mc_pci __initdata = {
 static int __init iq81340mc_pci_init(void)
 {
 	iop13xx_atu_select(&iq81340mc_pci);
-	pci_common_init(&iq81340mc_pci);
+	pci_common_init(&iq81340mc_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	iop13xx_map_pci_memory();

 	return 0;
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c
b/arch/arm/mach-iop13xx/iq81340sc.c
index ddb7a34..f502f5b 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -67,7 +67,7 @@ static struct hw_pci iq81340sc_pci __initdata = {
 static int __init iq81340sc_pci_init(void)
 {
 	iop13xx_atu_select(&iq81340sc_pci);
-	pci_common_init(&iq81340sc_pci);
+	pci_common_init(&iq81340sc_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	iop13xx_map_pci_memory();

 	return 0;
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 2bef9b6..49c4eee 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -114,7 +114,7 @@ static struct hw_pci em7210_pci __initdata = {
 static int __init em7210_pci_init(void)
 {
 	if (machine_is_em7210())
-		pci_common_init(&em7210_pci);
+		pci_common_init(&em7210_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index 10384fc..efa3ea4 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -107,7 +107,8 @@ static struct hw_pci glantank_pci __initdata = {
 static int __init glantank_pci_init(void)
 {
 	if (machine_is_glantank())
-		pci_common_init(&glantank_pci);
+		pci_common_init(&glantank_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/include/mach/hardware.h
b/arch/arm/mach-iop32x/include/mach/hardware.h
index d559c4e..e68bf97 100644
--- a/arch/arm/mach-iop32x/include/mach/hardware.h
+++ b/arch/arm/mach-iop32x/include/mach/hardware.h
@@ -18,7 +18,6 @@
  * but when we read them, we convert them to virtual addresses. See
  * arch/arm/plat-iop/pci.c.
  */
-#define pcibios_assign_all_busses() 1
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0x00000000

diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index d6ac85f..2b873e7 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -177,7 +177,8 @@ static struct hw_pci iq31244_pci __initdata = {
 static int __init iq31244_pci_init(void)
 {
 	if (is_ep80219())
-		pci_common_init(&ep80219_pci);
+		pci_common_init(&ep80219_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	else if (machine_is_iq31244()) {
 		if (is_80219()) {
 			printk("note: iq31244 board type has been selected\n");
@@ -187,7 +188,8 @@ static int __init iq31244_pci_init(void)
 			printk("\t2/ update boot loader to pass"
 				" the ep80219 id: %d\n", MACH_TYPE_EP80219);
 		}
-		pci_common_init(&iq31244_pci);
+		pci_common_init(&iq31244_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	}

 	return 0;
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index c6a0e4e..f30b0af 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -113,7 +113,8 @@ static int __init iq80321_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
 		machine_is_iq80321())
-		pci_common_init(&iq80321_pci);
+		pci_common_init(&iq80321_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index f108a31..a5801ff 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -139,7 +139,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK,
PCI_ANY_ID, n2100_fixup_r8169);
 static int __init n2100_pci_init(void)
 {
 	if (machine_is_n2100())
-		pci_common_init(&n2100_pci);
+		pci_common_init(&n2100_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-iop33x/include/mach/hardware.h
b/arch/arm/mach-iop33x/include/mach/hardware.h
index 8c10e43..215065b 100644
--- a/arch/arm/mach-iop33x/include/mach/hardware.h
+++ b/arch/arm/mach-iop33x/include/mach/hardware.h
@@ -18,7 +18,6 @@
  * but when we read them, we convert them to virtual addresses.  See
  * arch/arm/mach-iop3xx/iop3xx-pci.c
  */
-#define pcibios_assign_all_busses()	1
 #define PCIBIOS_MIN_IO		0x00000000
 #define PCIBIOS_MIN_MEM		0x00000000

diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index c6ff552..ebfe608 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -96,7 +96,8 @@ static int __init iq80331_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
 		machine_is_iq80331())
-		pci_common_init(&iq80331_pci);
+		pci_common_init(&iq80331_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index fbf5514..cdccfd6 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -96,7 +96,8 @@ static int __init iq80332_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
 		machine_is_iq80332())
-		pci_common_init(&iq80332_pci);
+		pci_common_init(&iq80332_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index 1a557e0..b597a02 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -188,7 +188,8 @@ struct hw_pci enp2611_pci __initdata = {
 int __init enp2611_pci_init(void)
 {
 	if (machine_is_enp2611())
-		pci_common_init(&enp2611_pci);
+		pci_common_init(&enp2611_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/include/mach/hardware.h
b/arch/arm/mach-ixp2000/include/mach/hardware.h
index f033de4..6c92008 100644
--- a/arch/arm/mach-ixp2000/include/mach/hardware.h
+++ b/arch/arm/mach-ixp2000/include/mach/hardware.h
@@ -27,8 +27,6 @@

 #include "ixp2000-regs.h"	/* Chipset Registers */

-#define pcibios_assign_all_busses() 0
-
 /*
  * Platform helper functions
  */
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index 55e5c69..5d31208 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -156,7 +156,8 @@ static struct hw_pci ixdp2400_pci __initdata = {
 int __init ixdp2400_pci_init(void)
 {
 	if (machine_is_ixdp2400())
-		pci_common_init(&ixdp2400_pci);
+		pci_common_init(&ixdp2400_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index 237b61a..4c84373 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -258,7 +258,8 @@ int __init ixdp2800_pci_init(void)
 	if (machine_is_ixdp2800()) {
 		struct pci_dev *dev;

-		pci_common_init(&ixdp2800_pci);
+		pci_common_init(&ixdp2800_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);
 		if (ixdp2x00_master_npu()) {
 			dev = pci_get_bus_and_slot(1, IXDP2800_SLAVE_ENET_DEVFN);
 			pci_remove_bus_device(dev);
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 0369ec4..930f4b0 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -337,7 +337,8 @@ int __init ixdp2x01_pci_init(void)
 {
 	if (machine_is_ixdp2401() || machine_is_ixdp2801() ||\
 		machine_is_ixdp28x5())
-		pci_common_init(&ixdp2x01_pci);
+		pci_common_init(&ixdp2x01_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/hardware.h
b/arch/arm/mach-ixp23xx/include/mach/hardware.h
index c319200..940f802 100644
--- a/arch/arm/mach-ixp23xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp23xx/include/mach/hardware.h
@@ -21,8 +21,6 @@

 #include "ixp23xx.h"

-#define pcibios_assign_all_busses()	0
-
 /*
  * Platform helper functions
  */
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index f1b124a..756966a 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -261,7 +261,8 @@ struct hw_pci ixdp2351_pci __initdata = {
 int __init ixdp2351_pci_init(void)
 {
 	if (machine_is_ixdp2351())
-		pci_common_init(&ixdp2351_pci);
+		pci_common_init(&ixdp2351_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp23xx/roadrunner.c
b/arch/arm/mach-ixp23xx/roadrunner.c
index 6d38d76..2c35b5b 100644
--- a/arch/arm/mach-ixp23xx/roadrunner.c
+++ b/arch/arm/mach-ixp23xx/roadrunner.c
@@ -127,7 +127,8 @@ static struct hw_pci roadrunner_pci __initdata = {
 static int __init roadrunner_pci_init(void)
 {
 	if (machine_is_roadrunner())
-		pci_common_init(&roadrunner_pci);
+		pci_common_init(&roadrunner_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 0);

 	return 0;
 };
diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 845e1b5..157aa69 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -75,7 +75,7 @@ struct hw_pci avila_pci __initdata = {
 int __init avila_pci_init(void)
 {
 	if (machine_is_avila() || machine_is_loft())
-		pci_common_init(&avila_pci);
+		pci_common_init(&avila_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c
b/arch/arm/mach-ixp4xx/coyote-pci.c
index b978ea8..2affd35 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -58,7 +58,8 @@ struct hw_pci coyote_pci __initdata = {
 int __init coyote_pci_init(void)
 {
 	if (machine_is_adi_coyote())
-		pci_common_init(&coyote_pci);
+		pci_common_init(&coyote_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c
b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index fa70fed..4ff588a 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -72,7 +72,8 @@ struct hw_pci __initdata dsmg600_pci = {
 int __init dsmg600_pci_init(void)
 {
 	if (machine_is_dsmg600())
-		pci_common_init(&dsmg600_pci);
+		pci_common_init(&dsmg600_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index 5a810c9..4a65c8e 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -69,7 +69,8 @@ struct hw_pci fsg_pci __initdata = {
 int __init fsg_pci_init(void)
 {
 	if (machine_is_fsg())
-		pci_common_init(&fsg_pci);
+		pci_common_init(&fsg_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/gateway7001-pci.c
b/arch/arm/mach-ixp4xx/gateway7001-pci.c
index 7e93a09..e6b2e45 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-pci.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-pci.c
@@ -56,7 +56,8 @@ struct hw_pci gateway7001_pci __initdata = {
 int __init gateway7001_pci_init(void)
 {
 	if (machine_is_gateway7001())
-		pci_common_init(&gateway7001_pci);
+		pci_common_init(&gateway7001_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c
b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 1c28048..59494c4 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -486,7 +486,8 @@ static int __init gmlr_pci_init(void)
 {
 	if (machine_is_goramo_mlr() &&
 	    (hw_bits & (CFG_HW_USB_PORTS | CFG_HW_HAS_PCI_SLOT)))
-		pci_common_init(&gmlr_hw_pci);
+		pci_common_init(&gmlr_hw_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 25d2c33..9daaddc 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -77,7 +77,8 @@ struct hw_pci gtwx5715_pci __initdata = {
 int __init gtwx5715_pci_init(void)
 {
 	if (machine_is_gtwx5715())
-		pci_common_init(&gtwx5715_pci);
+		pci_common_init(&gtwx5715_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h
b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index f91ca6d..a0921c6 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -26,8 +26,6 @@
 #define PCIBIOS_MAX_MEM		0x4BFFFFFF
 #endif

-#define pcibios_assign_all_busses()	1
-
 /* Register locations and bits */
 #include "ixp4xx-regs.h"

diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c
b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index 1ba165a..afcc015 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -71,7 +71,8 @@ int __init ixdp425_pci_init(void)
 {
 	if (machine_is_ixdp425() || machine_is_ixcdp1100() ||
 			machine_is_ixdp465() || machine_is_kixrp435())
-		pci_common_init(&ixdp425_pci);
+		pci_common_init(&ixdp425_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
index 4ed7ac6..43f477e 100644
--- a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -52,7 +52,8 @@ struct hw_pci ixdpg425_pci __initdata = {
 int __init ixdpg425_pci_init(void)
 {
 	if (machine_is_ixdpg425())
-		pci_common_init(&ixdpg425_pci);
+		pci_common_init(&ixdpg425_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c
b/arch/arm/mach-ixp4xx/nas100d-pci.c
index d0cea34..73e077f 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -68,7 +68,8 @@ struct hw_pci __initdata nas100d_pci = {
 int __init nas100d_pci_init(void)
 {
 	if (machine_is_nas100d())
-		pci_common_init(&nas100d_pci);
+		pci_common_init(&nas100d_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index 1eb5a90..e96007b 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -64,7 +64,7 @@ struct hw_pci __initdata nslu2_pci = {
 int __init nslu2_pci_init(void) /* monkey see, monkey do */
 {
 	if (machine_is_nslu2())
-		pci_common_init(&nslu2_pci);
+		pci_common_init(&nslu2_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/wg302v2-pci.c
b/arch/arm/mach-ixp4xx/wg302v2-pci.c
index 9b59ed0..2753725 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-pci.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-pci.c
@@ -56,7 +56,8 @@ struct hw_pci wg302v2_pci __initdata = {
 int __init wg302v2_pci_init(void)
 {
 	if (machine_is_wg302v2())
-		pci_common_init(&wg302v2_pci);
+		pci_common_init(&wg302v2_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-kirkwood/include/mach/hardware.h
b/arch/arm/mach-kirkwood/include/mach/hardware.h
index cde8528..79f0641 100644
--- a/arch/arm/mach-kirkwood/include/mach/hardware.h
+++ b/arch/arm/mach-kirkwood/include/mach/hardware.h
@@ -11,8 +11,6 @@

 #include "kirkwood.h"

-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO			0x00001000
 #define PCIBIOS_MIN_MEM			0x01000000
 #define PCIMEM_BASE			KIRKWOOD_PCIE_MEM_PHYS_BASE /* mem base for VGA */
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index dee1eff..227861a 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -16,6 +16,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <mach/bridge-regs.h>
+#include <mach/hardware.h>
 #include "common.h"


@@ -188,5 +189,6 @@ static struct hw_pci kirkwood_pci __initdata = {

 void __init kirkwood_pcie_init(void)
 {
-	pci_common_init(&kirkwood_pci);
+	pci_common_init(&kirkwood_pci,
+			PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 }
diff --git a/arch/arm/mach-ks8695/include/mach/hardware.h
b/arch/arm/mach-ks8695/include/mach/hardware.h
index e0f911d..a46be88 100644
--- a/arch/arm/mach-ks8695/include/mach/hardware.h
+++ b/arch/arm/mach-ks8695/include/mach/hardware.h
@@ -46,8 +46,6 @@
 /*
  * PCI support
  */
-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0
 #define PCIBIOS_MIN_MEM		0

diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index 7849966..1beeec0 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -325,5 +325,5 @@ void __init ks8695_init_pci(struct ks8695_pci_cfg *cfg)

 	ks8695_pci.map_irq = cfg->map_irq;	/* board-specific map_irq method */

-	pci_common_init(&ks8695_pci);
+	pci_common_init(&ks8695_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 }
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c
b/arch/arm/mach-orion5x/db88f5281-setup.c
index d318bea..8926519 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -25,6 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include <plat/orion_nand.h>
 #include "common.h"
 #include "mpp.h"
@@ -274,7 +275,8 @@ static struct hw_pci db88f5281_pci __initdata = {
 static int __init db88f5281_pci_init(void)
 {
 	if (machine_is_db88f5281())
-		pci_common_init(&db88f5281_pci);
+		pci_common_init(&db88f5281_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/dns323-setup.c
b/arch/arm/mach-orion5x/dns323-setup.c
index fe0de16..9e2c137 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -28,6 +28,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -83,7 +84,8 @@ static int __init dns323_pci_init(void)
 	 * gets in the way of initialising the SATA controller.
 	 */
 	if (machine_is_dns323() && dns323_dev_id() != MV88F5182_DEV_ID)
-		pci_common_init(&dns323_pci);
+		pci_common_init(&dns323_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h
b/arch/arm/mach-orion5x/include/mach/hardware.h
index e51aaf4..a42b743 100644
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ b/arch/arm/mach-orion5x/include/mach/hardware.h
@@ -11,8 +11,6 @@

 #include "orion5x.h"

-#define pcibios_assign_all_busses()	1
-
 #define PCIBIOS_MIN_IO		0x00001000
 #define PCIBIOS_MIN_MEM		0x01000000
 #define PCIMEM_BASE		ORION5X_PCIE_MEM_PHYS_BASE
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c
b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index dfbb68d..f27228b 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -25,6 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include <plat/orion_nand.h>
 #include "common.h"
 #include "mpp.h"
@@ -148,7 +149,8 @@ static int __init kurobox_pro_pci_init(void)
 {
 	if (machine_is_kurobox_pro()) {
 		orion5x_pci_disable();
-		pci_common_init(&kurobox_pro_pci);
+		pci_common_init(&kurobox_pro_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	}

 	return 0;
diff --git a/arch/arm/mach-orion5x/mss2-setup.c
b/arch/arm/mach-orion5x/mss2-setup.c
index 61c086b..b900a92 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -27,6 +27,7 @@
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
 #include <mach/bridge-regs.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -98,7 +99,7 @@ static struct hw_pci mss2_pci __initdata = {
 static int __init mss2_pci_init(void)
 {
 	if (machine_is_mss2())
-		pci_common_init(&mss2_pci);
+		pci_common_init(&mss2_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 9c1ca41..e9d35e9 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -23,6 +23,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -160,7 +161,8 @@ static int __init rd88f5181l_fxo_pci_init(void)
 {
 	if (machine_is_rd88f5181l_fxo()) {
 		orion5x_pci_set_cardbus_mode();
-		pci_common_init(&rd88f5181l_fxo_pci);
+		pci_common_init(&rd88f5181l_fxo_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	}

 	return 0;
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index ee1399f..8e02e61 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -172,7 +173,8 @@ static int __init rd88f5181l_ge_pci_init(void)
 {
 	if (machine_is_rd88f5181l_ge()) {
 		orion5x_pci_set_cardbus_mode();
-		pci_common_init(&rd88f5181l_ge_pci);
+		pci_common_init(&rd88f5181l_ge_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	}

 	return 0;
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c
b/arch/arm/mach-orion5x/rd88f5182-setup.c
index a04f9e4..be8f833 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -25,6 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -209,7 +210,8 @@ static struct hw_pci rd88f5182_pci __initdata = {
 static int __init rd88f5182_pci_init(void)
 {
 	if (machine_is_rd88f5182())
-		pci_common_init(&rd88f5182_pci);
+		pci_common_init(&rd88f5182_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 7737cf9..1cf3ee7 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -26,6 +26,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -114,7 +115,8 @@ static int __init rd88f6183ap_ge_pci_init(void)
 {
 	if (machine_is_rd88f6183ap_ge()) {
 		orion5x_pci_disable();
-		pci_common_init(&rd88f6183ap_ge_pci);
+		pci_common_init(&rd88f6183ap_ge_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	}

 	return 0;
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c
b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 0b101d7..f2f928d 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -132,7 +133,7 @@ static struct hw_pci tsp2_pci __initdata = {
 static int __init tsp2_pci_init(void)
 {
 	if (machine_is_terastation_pro2())
-		pci_common_init(&tsp2_pci);
+		pci_common_init(&tsp2_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/ts209-setup.c
b/arch/arm/mach-orion5x/ts209-setup.c
index 9d68905..abdd1c8 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -27,6 +27,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 #include "tsx09-common.h"
@@ -179,7 +180,8 @@ static struct hw_pci qnap_ts209_pci __initdata = {
 static int __init qnap_ts209_pci_init(void)
 {
 	if (machine_is_ts_x09())
-		pci_common_init(&qnap_ts209_pci);
+		pci_common_init(&qnap_ts209_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/ts409-setup.c
b/arch/arm/mach-orion5x/ts409-setup.c
index d85588a..b81f4e7 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -29,6 +29,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 #include "tsx09-common.h"
@@ -149,7 +150,8 @@ static struct hw_pci qnap_ts409_pci __initdata = {
 static int __init qnap_ts409_pci_init(void)
 {
 	if (machine_is_ts409())
-		pci_common_init(&qnap_ts409_pci);
+		pci_common_init(&qnap_ts409_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c
b/arch/arm/mach-orion5x/wnr854t-setup.c
index 6920821..af71cb9 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"

@@ -164,7 +165,8 @@ static struct hw_pci wnr854t_pci __initdata = {
 static int __init wnr854t_pci_init(void)
 {
 	if (machine_is_wnr854t())
-		pci_common_init(&wnr854t_pci);
+		pci_common_init(&wnr854t_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index f9f222e..2053043 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -252,7 +252,8 @@ static struct hw_pci wrt350n_v2_pci __initdata = {
 static int __init wrt350n_v2_pci_init(void)
 {
 	if (machine_is_wrt350n_v2())
-		pci_common_init(&wrt350n_v2_pci);
+		pci_common_init(&wrt350n_v2_pci,
+				PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 0f31305..1e803e4 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -215,7 +215,7 @@ static struct hw_pci cmx2xx_pci __initdata = {
 static int __init cmx2xx_init_pci(void)
 {
 	if (machine_is_armcore())
-		pci_common_init(&cmx2xx_pci);
+		pci_common_init(&cmx2xx_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);

 	return 0;
 }
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h
b/arch/arm/mach-pxa/include/mach/hardware.h
index 3d8d8cb..f38a311 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -313,7 +313,6 @@ extern unsigned long get_clock_tick_rate(void);
 #if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
 #define PCIBIOS_MIN_IO		0
 #define PCIBIOS_MIN_MEM		0
-#define pcibios_assign_all_busses()	1
 #endif


diff --git a/arch/arm/mach-shark/include/mach/hardware.h
b/arch/arm/mach-shark/include/mach/hardware.h
index 94d84b2..24639ce 100644
--- a/arch/arm/mach-shark/include/mach/hardware.h
+++ b/arch/arm/mach-shark/include/mach/hardware.h
@@ -12,8 +12,6 @@

 #define UNCACHEABLE_ADDR        0xdf010000

-#define pcibios_assign_all_busses()     1
-
 #define PCIBIOS_MIN_IO          0x6000
 #define PCIBIOS_MIN_MEM         0x50000000
 #define PCIMEM_BASE		0xe8000000
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 89d175c..9c056aa 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>

 static int __init shark_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -38,7 +39,7 @@ static struct hw_pci shark_pci __initdata = {
 static int __init shark_pci_init(void)
 {
 	if (machine_is_shark())
-		pci_common_init(&shark_pci);
+		pci_common_init(&shark_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }

diff --git a/arch/arm/mach-versatile/include/mach/hardware.h
b/arch/arm/mach-versatile/include/mach/hardware.h
index 4f8f99a..59fb6e5 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -43,8 +43,6 @@
 #define PCIBIOS_MIN_IO			0x44000000
 #define PCIBIOS_MIN_MEM			0x50000000

-#define pcibios_assign_all_busses()     1
-
 /* macro to get at IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) &
0x0f000000) + 0xf0000000)

diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 334f0df..5c400b9 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -354,7 +354,7 @@ static struct hw_pci versatile_pci __initdata = {

 static int __init versatile_pci_init(void)
 {
-	pci_common_init(&versatile_pci);
+	pci_common_init(&versatile_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM, 1);
 	return 0;
 }
