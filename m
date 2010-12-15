From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 15 Dec 2010 03:03:31 +0100
Subject: [PATCH 07/16] ARM: Make PCIBIOS_* into global variables.
In-Reply-To: <cover.1292377339.git.buytenh@wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
Message-ID: <20101215020331.GZ15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

And initialized with pci_common_init(), so that now <asm/pci.h>
doesn't depend on <mach/hardware.h> any more.

Signed-off-by: Eric Miao <eric.miao@canonical.com>

[ buytenh at wantstofly.org: adapt to "Always reassign PCI bus numbers"
  change, added support for cns3xxx, ixp4xx/vulcan-pci.c, mv78xx0,
  tegra, rename platform PCIBIOS_MIN_* defines to avoid namespace
  clashes, rename the arch-wide global variables themselves to
  PCIBIOS_MIN_* to match mips/sh, build fixes. ]

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/include/asm/mach/pci.h                  |    2 +-
 arch/arm/include/asm/pci.h                       |    4 +++-
 arch/arm/kernel/bios32.c                         |   12 +++++++++++-
 arch/arm/mach-cns3xxx/include/mach/hardware.h    |    5 +++--
 arch/arm/mach-cns3xxx/pcie.c                     |    4 +++-
 arch/arm/mach-dove/include/mach/hardware.h       |    5 +++--
 arch/arm/mach-dove/pcie.c                        |    3 ++-
 arch/arm/mach-footbridge/cats-pci.c              |    8 ++++++--
 arch/arm/mach-footbridge/ebsa285-pci.c           |    8 ++++++--
 arch/arm/mach-footbridge/include/mach/hardware.h |    4 ++--
 arch/arm/mach-footbridge/netwinder-pci.c         |    8 ++++++--
 arch/arm/mach-footbridge/personal-pci.c          |    8 ++++++--
 arch/arm/mach-integrator/include/mach/hardware.h |    4 ++--
 arch/arm/mach-integrator/pci.c                   |    8 ++++++--
 arch/arm/mach-iop13xx/include/mach/hardware.h    |    4 ++--
 arch/arm/mach-iop13xx/iq81340mc.c                |    3 ++-
 arch/arm/mach-iop13xx/iq81340sc.c                |    3 ++-
 arch/arm/mach-iop32x/em7210.c                    |    6 ++++--
 arch/arm/mach-iop32x/glantank.c                  |    6 ++++--
 arch/arm/mach-iop32x/include/mach/hardware.h     |    4 ++--
 arch/arm/mach-iop32x/iq31244.c                   |    9 +++++----
 arch/arm/mach-iop32x/iq80321.c                   |    6 ++++--
 arch/arm/mach-iop32x/n2100.c                     |    6 ++++--
 arch/arm/mach-iop33x/include/mach/hardware.h     |    4 ++--
 arch/arm/mach-iop33x/iq80331.c                   |    6 ++++--
 arch/arm/mach-iop33x/iq80332.c                   |    6 ++++--
 arch/arm/mach-ixp2000/enp2611.c                  |    6 ++++--
 arch/arm/mach-ixp2000/include/mach/hardware.h    |    4 ++--
 arch/arm/mach-ixp2000/ixdp2400.c                 |    6 ++++--
 arch/arm/mach-ixp2000/ixdp2800.c                 |    4 +++-
 arch/arm/mach-ixp2000/ixdp2x01.c                 |    6 ++++--
 arch/arm/mach-ixp23xx/include/mach/hardware.h    |    4 ++--
 arch/arm/mach-ixp23xx/ixdp2351.c                 |    6 ++++--
 arch/arm/mach-ixp23xx/roadrunner.c               |    6 ++++--
 arch/arm/mach-ixp4xx/avila-pci.c                 |    7 +++++--
 arch/arm/mach-ixp4xx/common-pci.c                |    4 ++--
 arch/arm/mach-ixp4xx/coyote-pci.c                |    7 +++++--
 arch/arm/mach-ixp4xx/dsmg600-pci.c               |    7 +++++--
 arch/arm/mach-ixp4xx/fsg-pci.c                   |    8 ++++++--
 arch/arm/mach-ixp4xx/gateway7001-pci.c           |    7 +++++--
 arch/arm/mach-ixp4xx/goramo_mlr.c                |    8 ++++++--
 arch/arm/mach-ixp4xx/gtwx5715-pci.c              |    6 ++++--
 arch/arm/mach-ixp4xx/include/mach/hardware.h     |   10 +++++-----
 arch/arm/mach-ixp4xx/include/mach/io.h           |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-pci.c               |    7 +++++--
 arch/arm/mach-ixp4xx/ixdpg425-pci.c              |    7 +++++--
 arch/arm/mach-ixp4xx/nas100d-pci.c               |    7 +++++--
 arch/arm/mach-ixp4xx/nslu2-pci.c                 |    7 +++++--
 arch/arm/mach-ixp4xx/vulcan-pci.c                |    8 ++++++--
 arch/arm/mach-ixp4xx/wg302v2-pci.c               |    7 +++++--
 arch/arm/mach-kirkwood/include/mach/hardware.h   |    5 +++--
 arch/arm/mach-kirkwood/pcie.c                    |    4 +++-
 arch/arm/mach-ks8695/include/mach/hardware.h     |    4 ++--
 arch/arm/mach-ks8695/pci.c                       |    3 ++-
 arch/arm/mach-mv78xx0/include/mach/hardware.h    |    5 +++--
 arch/arm/mach-mv78xx0/pcie.c                     |    4 +++-
 arch/arm/mach-orion5x/db88f5281-setup.c          |    7 +++++--
 arch/arm/mach-orion5x/dns323-setup.c             |    7 +++++--
 arch/arm/mach-orion5x/include/mach/hardware.h    |    7 ++++---
 arch/arm/mach-orion5x/kurobox_pro-setup.c        |    4 +++-
 arch/arm/mach-orion5x/mss2-setup.c               |    7 +++++--
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c     |    4 +++-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c      |    4 +++-
 arch/arm/mach-orion5x/rd88f5182-setup.c          |    7 +++++--
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c     |    4 +++-
 arch/arm/mach-orion5x/terastation_pro2-setup.c   |    7 +++++--
 arch/arm/mach-orion5x/ts209-setup.c              |    7 +++++--
 arch/arm/mach-orion5x/ts409-setup.c              |    7 +++++--
 arch/arm/mach-orion5x/wnr854t-setup.c            |    7 +++++--
 arch/arm/mach-orion5x/wrt350n-v2-setup.c         |    7 +++++--
 arch/arm/mach-pxa/cm-x2xx-pci.c                  |    8 ++++++--
 arch/arm/mach-pxa/include/mach/hardware.h        |    4 ++--
 arch/arm/mach-shark/include/mach/hardware.h      |    5 +++--
 arch/arm/mach-shark/pci.c                        |    8 ++++++--
 arch/arm/mach-tegra/include/mach/hardware.h      |    5 +++--
 arch/arm/mach-tegra/pcie.c                       |    8 +++++---
 arch/arm/mach-versatile/include/mach/hardware.h  |    4 ++--
 arch/arm/mach-versatile/pci.c                    |    4 +++-
 78 files changed, 308 insertions(+), 146 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 16330bd..d16e81a 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -57,7 +57,7 @@ struct pci_sys_data {
 /*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
-void pci_common_init(struct hw_pci *);
+void pci_common_init(struct hw_pci *, unsigned long, unsigned long);
 
 /*
  * PCI controllers
diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
index 038da6e..122679a 100644
--- a/arch/arm/include/asm/pci.h
+++ b/arch/arm/include/asm/pci.h
@@ -5,7 +5,9 @@
 #include <asm-generic/pci-dma-compat.h>
 
 #include <asm/mach/pci.h> /* for pci_sys_data */
-#include <mach/hardware.h> /* for PCIBIOS_MIN_* */
+
+extern unsigned long PCIBIOS_MIN_IO;
+extern unsigned long PCIBIOS_MIN_MEM;
 
 #ifdef CONFIG_PCI_DOMAINS
 static inline int pci_domain_nr(struct pci_bus *bus)
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index c6273a3..acc4f95 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -18,6 +18,12 @@
 static int debug_pci;
 static int use_firmware;
 
+unsigned long PCIBIOS_MIN_IO;
+EXPORT_SYMBOL(PCIBIOS_MIN_IO);
+
+unsigned long PCIBIOS_MIN_MEM;
+EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
+
 /*
  * We can't use pci_find_device() here since we are
  * called from interrupt context.
@@ -556,12 +562,16 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void __init
+pci_common_init(struct hw_pci *hw, unsigned long min_io, unsigned long min_mem)
 {
 	struct pci_sys_data *sys;
 
 	INIT_LIST_HEAD(&hw->buses);
 
+	PCIBIOS_MIN_IO = min_io;
+	PCIBIOS_MIN_MEM = min_mem;
+
 	if (hw->preinit)
 		hw->preinit();
 	pcibios_init_hw(hw);
diff --git a/arch/arm/mach-cns3xxx/include/mach/hardware.h b/arch/arm/mach-cns3xxx/include/mach/hardware.h
index 82a0d4e..c194e25 100644
--- a/arch/arm/mach-cns3xxx/include/mach/hardware.h
+++ b/arch/arm/mach-cns3xxx/include/mach/hardware.h
@@ -15,7 +15,8 @@
 #include <asm/sizes.h>
 
 /* macro to get at IO space when running virtually */
-#define PCIBIOS_MIN_IO		0x00000000
-#define PCIBIOS_MIN_MEM		0x00000000
+#define CNS3XXX_PCIBIOS_MIN_IO		0x00000000
+#define CNS3XXX_PCIBIOS_MIN_MEM		0x00000000
+
 
 #endif
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 78defd7..fd89456 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <asm/mach/map.h>
 #include <mach/cns3xxx.h>
+#include <mach/hardware.h>
 #include "core.h"
 
 enum cns3xxx_access_type {
@@ -379,7 +380,8 @@ static int __init cns3xxx_pcie_init(void)
 		cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
 		cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
 		cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
-		pci_common_init(&cns3xxx_pcie[i].hw_pci);
+		pci_common_init(&cns3xxx_pcie[i].hw_pci, CNS3XXX_PCIBIOS_MIN_IO,
+				CNS3XXX_PCIBIOS_MIN_MEM);
 	}
 
 	pci_assign_unassigned_resources();
diff --git a/arch/arm/mach-dove/include/mach/hardware.h b/arch/arm/mach-dove/include/mach/hardware.h
index f619fb9..87a22e6 100644
--- a/arch/arm/mach-dove/include/mach/hardware.h
+++ b/arch/arm/mach-dove/include/mach/hardware.h
@@ -11,8 +11,9 @@
 
 #include "dove.h"
 
-#define PCIBIOS_MIN_IO			0x1000
-#define PCIBIOS_MIN_MEM			0x01000000
+#define DOVE_PCIBIOS_MIN_IO		0x1000
+#define DOVE_PCIBIOS_MIN_MEM		0x01000000
+
 #define PCIMEM_BASE			DOVE_PCIE0_MEM_PHYS_BASE
 
 
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 502d1ca..f93fd41 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -18,6 +18,7 @@
 #include <plat/pcie.h>
 #include <mach/irqs.h>
 #include <mach/bridge-regs.h>
+#include <mach/hardware.h>
 #include "common.h"
 
 struct pcie_port {
@@ -234,5 +235,5 @@ void __init dove_pcie_init(int init_port0, int init_port1)
 	if (init_port1)
 		add_pcie_port(1, DOVE_PCIE1_VIRT_BASE);
 
-	pci_common_init(&dove_pci);
+	pci_common_init(&dove_pci, DOVE_PCIBIOS_MIN_IO, DOVE_PCIBIOS_MIN_MEM);
 }
diff --git a/arch/arm/mach-footbridge/cats-pci.c b/arch/arm/mach-footbridge/cats-pci.c
index ae3e1c8..8c9bf30 100644
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ b/arch/arm/mach-footbridge/cats-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 /* cats host-specific stuff */
 static int irqmap_cats[] __initdata = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
@@ -50,8 +51,11 @@ static struct hw_pci cats_pci __initdata = {
 
 static int __init cats_pci_init(void)
 {
-	if (machine_is_cats())
-		pci_common_init(&cats_pci);
+	if (machine_is_cats()) {
+		pci_common_init(&cats_pci, FOOTBRIDGE_PCIBIOS_MIN_IO,
+				FOOTBRIDGE_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
index e5ab5bd..d369a86 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 static int irqmap_ebsa285[] __initdata = { IRQ_IN3, IRQ_IN1, IRQ_IN0, IRQ_PCI };
 
@@ -40,8 +41,11 @@ static struct hw_pci ebsa285_pci __initdata = {
 
 static int __init ebsa285_init_pci(void)
 {
-	if (machine_is_ebsa285())
-		pci_common_init(&ebsa285_pci);
+	if (machine_is_ebsa285()) {
+		pci_common_init(&ebsa285_pci, FOOTBRIDGE_PCIBIOS_MIN_IO,
+				FOOTBRIDGE_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 541aa70..1f3950b 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -93,7 +93,7 @@ extern unsigned int nw_gpio_read(void);
 extern void nw_cpld_modify(unsigned int mask, unsigned int set);
 #endif
 
-#define PCIBIOS_MIN_IO		0x1000
-#define PCIBIOS_MIN_MEM 	0x81000000
+#define FOOTBRIDGE_PCIBIOS_MIN_IO	0x1000
+#define FOOTBRIDGE_PCIBIOS_MIN_MEM 	0x81000000
 
 #endif
diff --git a/arch/arm/mach-footbridge/netwinder-pci.c b/arch/arm/mach-footbridge/netwinder-pci.c
index e263d6d..722a1e6 100644
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ b/arch/arm/mach-footbridge/netwinder-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 /*
  * We now use the slot ID instead of the device identifiers to select
@@ -54,8 +55,11 @@ static struct hw_pci netwinder_pci __initdata = {
 
 static int __init netwinder_pci_init(void)
 {
-	if (machine_is_netwinder())
-		pci_common_init(&netwinder_pci);
+	if (machine_is_netwinder()) {
+		pci_common_init(&netwinder_pci, FOOTBRIDGE_PCIBIOS_MIN_IO,
+				FOOTBRIDGE_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-footbridge/personal-pci.c b/arch/arm/mach-footbridge/personal-pci.c
index d5fca95..4064060 100644
--- a/arch/arm/mach-footbridge/personal-pci.c
+++ b/arch/arm/mach-footbridge/personal-pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 static int irqmap_personal_server[] __initdata = {
 	IRQ_IN0, IRQ_IN1, IRQ_IN2, IRQ_IN3, 0, 0, 0,
@@ -48,8 +49,11 @@ static struct hw_pci personal_server_pci __initdata = {
 
 static int __init personal_pci_init(void)
 {
-	if (machine_is_personal_server())
-		pci_common_init(&personal_server_pci);
+	if (machine_is_personal_server()) {
+		pci_common_init(&personal_server_pci, FOOTBRIDGE_PCIBIOS_MIN_IO,
+				FOOTBRIDGE_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-integrator/include/mach/hardware.h b/arch/arm/mach-integrator/include/mach/hardware.h
index 37323ea..4b9c9a7 100644
--- a/arch/arm/mach-integrator/include/mach/hardware.h
+++ b/arch/arm/mach-integrator/include/mach/hardware.h
@@ -34,8 +34,8 @@
 
 #define PCIMEM_BASE		PCI_MEMORY_VADDR
 
-#define PCIBIOS_MIN_IO		0x6000
-#define PCIBIOS_MIN_MEM 	0x00100000
+#define INTEGRATOR_PCIBIOS_MIN_IO	0x6000
+#define INTEGRATOR_PCIBIOS_MIN_MEM 	0x00100000
 
 /* macro to get at IO space when running virtually */
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 2fdb954..4bfb0c2 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -30,6 +30,7 @@
 #include <asm/system.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 /* 
  * A small note about bridges and interrupts.  The DECchip 21050 (and
@@ -116,8 +117,11 @@ static struct hw_pci integrator_pci __initdata = {
 
 static int __init integrator_pci_init(void)
 {
-	if (machine_is_integrator())
-		pci_common_init(&integrator_pci);
+	if (machine_is_integrator()) {
+		pci_common_init(&integrator_pci, INTEGRATOR_PCIBIOS_MIN_IO,
+				INTEGRATOR_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-iop13xx/include/mach/hardware.h b/arch/arm/mach-iop13xx/include/mach/hardware.h
index 8e8ec74..75c0159 100644
--- a/arch/arm/mach-iop13xx/include/mach/hardware.h
+++ b/arch/arm/mach-iop13xx/include/mach/hardware.h
@@ -7,8 +7,8 @@ extern u16 iop13xx_dev_id(void);
 extern void iop13xx_set_atu_mmr_bases(void);
 #endif
 
-#define PCIBIOS_MIN_IO      0x00000000
-#define PCIBIOS_MIN_MEM     IOP13XX_PCIX_LOWER_MEM_BA
+#define IOP13XX_PCIBIOS_MIN_IO      0x00000000
+#define IOP13XX_PCIBIOS_MIN_MEM     IOP13XX_PCIX_LOWER_MEM_BA
 
 /*
  * Generic chipset bits
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9b5a63f..3e37d1b 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -65,7 +65,8 @@ static struct hw_pci iq81340mc_pci __initdata = {
 static int __init iq81340mc_pci_init(void)
 {
 	iop13xx_atu_select(&iq81340mc_pci);
-	pci_common_init(&iq81340mc_pci);
+	pci_common_init(&iq81340mc_pci, IOP13XX_PCIBIOS_MIN_IO,
+			IOP13XX_PCIBIOS_MIN_MEM);
 	iop13xx_map_pci_memory();
 
 	return 0;
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index df3492a..6ba9771 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -67,7 +67,8 @@ static struct hw_pci iq81340sc_pci __initdata = {
 static int __init iq81340sc_pci_init(void)
 {
 	iop13xx_atu_select(&iq81340sc_pci);
-	pci_common_init(&iq81340sc_pci);
+	pci_common_init(&iq81340sc_pci, IOP13XX_PCIBIOS_MIN_IO,
+			IOP13XX_PCIBIOS_MIN_MEM);
 	iop13xx_map_pci_memory();
 
 	return 0;
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 779f924..ead3c18 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -113,8 +113,10 @@ static struct hw_pci em7210_pci __initdata = {
 
 static int __init em7210_pci_init(void)
 {
-	if (machine_is_em7210())
-		pci_common_init(&em7210_pci);
+	if (machine_is_em7210()) {
+		pci_common_init(&em7210_pci, IOP32X_PCIBIOS_MIN_IO,
+				IOP32X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index c6b6f9c..5b952c7 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -106,8 +106,10 @@ static struct hw_pci glantank_pci __initdata = {
 
 static int __init glantank_pci_init(void)
 {
-	if (machine_is_glantank())
-		pci_common_init(&glantank_pci);
+	if (machine_is_glantank()) {
+		pci_common_init(&glantank_pci, IOP32X_PCIBIOS_MIN_IO,
+				IOP32X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/include/mach/hardware.h b/arch/arm/mach-iop32x/include/mach/hardware.h
index e68bf97..2857d93 100644
--- a/arch/arm/mach-iop32x/include/mach/hardware.h
+++ b/arch/arm/mach-iop32x/include/mach/hardware.h
@@ -18,8 +18,8 @@
  * but when we read them, we convert them to virtual addresses. See
  * arch/arm/plat-iop/pci.c.
  */
-#define PCIBIOS_MIN_IO		0x00000000
-#define PCIBIOS_MIN_MEM		0x00000000
+#define IOP32X_PCIBIOS_MIN_IO		0x00000000
+#define IOP32X_PCIBIOS_MIN_MEM		0x00000000
 
 #ifndef __ASSEMBLY__
 void iop32x_init_irq(void);
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index fde962c..686743a 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -176,9 +176,10 @@ static struct hw_pci iq31244_pci __initdata = {
 
 static int __init iq31244_pci_init(void)
 {
-	if (is_ep80219())
-		pci_common_init(&ep80219_pci);
-	else if (machine_is_iq31244()) {
+	if (is_ep80219()) {
+		pci_common_init(&ep80219_pci, IOP32X_PCIBIOS_MIN_IO,
+				IOP32X_PCIBIOS_MIN_MEM);
+	} else if (machine_is_iq31244()) {
 		if (is_80219()) {
 			printk("note: iq31244 board type has been selected\n");
 			printk("note: to select ep80219 operation:\n");
@@ -187,7 +188,7 @@ static int __init iq31244_pci_init(void)
 			printk("\t2/ update boot loader to pass"
 				" the ep80219 id: %d\n", MACH_TYPE_EP80219);
 		}
-		pci_common_init(&iq31244_pci);
+		pci_common_init(&iq31244_pci, PCIBIOS_MIN_IO, PCIBIOS_MIN_MEM);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index 3a95950..c5b4cfe 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -112,8 +112,10 @@ static struct hw_pci iq80321_pci __initdata = {
 static int __init iq80321_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
-		machine_is_iq80321())
-		pci_common_init(&iq80321_pci);
+		machine_is_iq80321()) {
+		pci_common_init(&iq80321_pci, IOP32X_PCIBIOS_MIN_IO,
+				IOP32X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 626aa37..e515129 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -138,8 +138,10 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, PCI_ANY_ID, n2100_fixup_r8169);
 
 static int __init n2100_pci_init(void)
 {
-	if (machine_is_n2100())
-		pci_common_init(&n2100_pci);
+	if (machine_is_n2100()) {
+		pci_common_init(&n2100_pci, IOP32X_PCIBIOS_MIN_IO,
+				IOP32X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop33x/include/mach/hardware.h b/arch/arm/mach-iop33x/include/mach/hardware.h
index 215065b..428fc66 100644
--- a/arch/arm/mach-iop33x/include/mach/hardware.h
+++ b/arch/arm/mach-iop33x/include/mach/hardware.h
@@ -18,8 +18,8 @@
  * but when we read them, we convert them to virtual addresses.  See
  * arch/arm/mach-iop3xx/iop3xx-pci.c
  */
-#define PCIBIOS_MIN_IO		0x00000000
-#define PCIBIOS_MIN_MEM		0x00000000
+#define IOP33X_PCIBIOS_MIN_IO		0x00000000
+#define IOP33X_PCIBIOS_MIN_MEM		0x00000000
 
 #ifndef __ASSEMBLY__
 void iop33x_init_irq(void);
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index c565f8d..3268484 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -95,8 +95,10 @@ static struct hw_pci iq80331_pci __initdata = {
 static int __init iq80331_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
-		machine_is_iq80331())
-		pci_common_init(&iq80331_pci);
+		machine_is_iq80331()) {
+		pci_common_init(&iq80331_pci, IOP33X_PCIBIOS_MIN_IO,
+				IOP33X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 36a9efb..f8ba3b8 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -95,8 +95,10 @@ static struct hw_pci iq80332_pci __initdata = {
 static int __init iq80332_pci_init(void)
 {
 	if ((iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE) &&
-		machine_is_iq80332())
-		pci_common_init(&iq80332_pci);
+		machine_is_iq80332()) {
+		pci_common_init(&iq80332_pci, IOP33X_PCIBIOS_MIN_IO,
+				IOP33X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index 88663ab..b1c8661 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -187,8 +187,10 @@ struct hw_pci enp2611_pci __initdata = {
 
 int __init enp2611_pci_init(void)
 {
-	if (machine_is_enp2611())
-		pci_common_init(&enp2611_pci);
+	if (machine_is_enp2611()) {
+		pci_common_init(&enp2611_pci, IXP2000_PCIBIOS_MIN_IO,
+				IXP2000_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/include/mach/hardware.h b/arch/arm/mach-ixp2000/include/mach/hardware.h
index 6c92008..b8a6ce7 100644
--- a/arch/arm/mach-ixp2000/include/mach/hardware.h
+++ b/arch/arm/mach-ixp2000/include/mach/hardware.h
@@ -22,8 +22,8 @@
 /*
  * This needs to be platform-specific?
  */
-#define PCIBIOS_MIN_IO          0x00000000
-#define PCIBIOS_MIN_MEM         0x00000000
+#define IXP2000_PCIBIOS_MIN_IO          0x00000000
+#define IXP2000_PCIBIOS_MIN_MEM         0x00000000
 
 #include "ixp2000-regs.h"	/* Chipset Registers */
 
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index dfffc1e..54285c1 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -155,8 +155,10 @@ static struct hw_pci ixdp2400_pci __initdata = {
 
 int __init ixdp2400_pci_init(void)
 {
-	if (machine_is_ixdp2400())
-		pci_common_init(&ixdp2400_pci);
+	if (machine_is_ixdp2400()) {
+		pci_common_init(&ixdp2400_pci, IXP2000_PCIBIOS_MIN_IO,
+				IXP2000_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index cd4c9bc..c73ebe1 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -258,7 +258,9 @@ int __init ixdp2800_pci_init(void)
 	if (machine_is_ixdp2800()) {
 		struct pci_dev *dev;
 
-		pci_common_init(&ixdp2800_pci);
+		pci_common_init(&ixdp2800_pci, IXP2000_PCIBIOS_MIN_IO,
+				IXP2000_PCIBIOS_MIN_MEM);
+
 		if (ixdp2x00_master_npu()) {
 			dev = pci_get_bus_and_slot(1, IXDP2800_SLAVE_ENET_DEVFN);
 			pci_remove_bus_device(dev);
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 6c121bd..9edcd87 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -336,8 +336,10 @@ struct hw_pci ixdp2x01_pci __initdata = {
 int __init ixdp2x01_pci_init(void)
 {
 	if (machine_is_ixdp2401() || machine_is_ixdp2801() ||\
-		machine_is_ixdp28x5())
-		pci_common_init(&ixdp2x01_pci);
+		machine_is_ixdp28x5()) {
+		pci_common_init(&ixdp2x01_pci, IXP2000_PCIBIOS_MIN_IO,
+				IXP2000_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp23xx/include/mach/hardware.h b/arch/arm/mach-ixp23xx/include/mach/hardware.h
index b8bb781..658cb03 100644
--- a/arch/arm/mach-ixp23xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp23xx/include/mach/hardware.h
@@ -15,8 +15,8 @@
 #define __ASM_ARCH_HARDWARE_H
 
 /* PCI IO info */
-#define PCIBIOS_MIN_IO		0x00000000
-#define PCIBIOS_MIN_MEM		0xe0000000
+#define IXP23XX_PCIBIOS_MIN_IO		0x00000000
+#define IXP23XX_PCIBIOS_MIN_MEM		0xe0000000
 
 #include "ixp23xx.h"
 
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index 664e39c..bcc56c4 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -260,8 +260,10 @@ struct hw_pci ixdp2351_pci __initdata = {
 
 int __init ixdp2351_pci_init(void)
 {
-	if (machine_is_ixdp2351())
-		pci_common_init(&ixdp2351_pci);
+	if (machine_is_ixdp2351()) {
+		pci_common_init(&ixdp2351_pci, IXP23XX_PCIBIOS_MIN_IO,
+				IXP23XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp23xx/roadrunner.c b/arch/arm/mach-ixp23xx/roadrunner.c
index 76c61ba..e6c321a 100644
--- a/arch/arm/mach-ixp23xx/roadrunner.c
+++ b/arch/arm/mach-ixp23xx/roadrunner.c
@@ -126,8 +126,10 @@ static struct hw_pci roadrunner_pci __initdata = {
 
 static int __init roadrunner_pci_init(void)
 {
-	if (machine_is_roadrunner())
-		pci_common_init(&roadrunner_pci);
+	if (machine_is_roadrunner()) {
+		pci_common_init(&roadrunner_pci, IXP23XX_PCIBIOS_MIN_IO,
+				IXP23XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 };
diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 845e1b5..f40ccd8 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -74,8 +74,11 @@ struct hw_pci avila_pci __initdata = {
 
 int __init avila_pci_init(void)
 {
-	if (machine_is_avila() || machine_is_loft())
-		pci_common_init(&avila_pci);
+	if (machine_is_avila() || machine_is_loft()) {
+		pci_common_init(&avila_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 24498a9..24f4f58 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -481,8 +481,8 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 	res[0].flags = IORESOURCE_IO;
 
 	res[1].name = "PCI Memory Space";
-	res[1].start = PCIBIOS_MIN_MEM;
-	res[1].end = PCIBIOS_MAX_MEM;
+	res[1].start = IXP4XX_PCIBIOS_MIN_MEM;
+	res[1].end = IXP4XX_PCIBIOS_MAX_MEM;
 	res[1].flags = IORESOURCE_MEM;
 
 	request_resource(&ioport_resource, &res[0]);
diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index b978ea8..66fbab2 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -57,8 +57,11 @@ struct hw_pci coyote_pci __initdata = {
 
 int __init coyote_pci_init(void)
 {
-	if (machine_is_adi_coyote())
-		pci_common_init(&coyote_pci);
+	if (machine_is_adi_coyote()) {
+		pci_common_init(&coyote_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index fa70fed..e13d3bc 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <mach/hardware.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -71,8 +72,10 @@ struct hw_pci __initdata dsmg600_pci = {
 
 int __init dsmg600_pci_init(void)
 {
-	if (machine_is_dsmg600())
-		pci_common_init(&dsmg600_pci);
+	if (machine_is_dsmg600()) {
+		pci_common_init(&dsmg600_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index 5a810c9..79becbd 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <mach/hardware.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -68,8 +69,11 @@ struct hw_pci fsg_pci __initdata = {
 
 int __init fsg_pci_init(void)
 {
-	if (machine_is_fsg())
-		pci_common_init(&fsg_pci);
+	if (machine_is_fsg()) {
+		pci_common_init(&fsg_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/gateway7001-pci.c b/arch/arm/mach-ixp4xx/gateway7001-pci.c
index 7e93a09..2917679 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-pci.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-pci.c
@@ -55,8 +55,11 @@ struct hw_pci gateway7001_pci __initdata = {
 
 int __init gateway7001_pci_init(void)
 {
-	if (machine_is_gateway7001())
-		pci_common_init(&gateway7001_pci);
+	if (machine_is_gateway7001()) {
+		pci_common_init(&gateway7001_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index d0e4861..5dde50c 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/serial_8250.h>
+#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/system.h>
 #include <asm/mach/arch.h>
@@ -485,8 +486,11 @@ static struct hw_pci gmlr_hw_pci __initdata = {
 static int __init gmlr_pci_init(void)
 {
 	if (machine_is_goramo_mlr() &&
-	    (hw_bits & (CFG_HW_USB_PORTS | CFG_HW_HAS_PCI_SLOT)))
-		pci_common_init(&gmlr_hw_pci);
+	    (hw_bits & (CFG_HW_USB_PORTS | CFG_HW_HAS_PCI_SLOT))) {
+		pci_common_init(&gmlr_hw_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 25d2c33..7359a95 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -76,8 +76,10 @@ struct hw_pci gtwx5715_pci __initdata = {
 
 int __init gtwx5715_pci_init(void)
 {
-	if (machine_is_gtwx5715())
-		pci_common_init(&gtwx5715_pci);
+	if (machine_is_gtwx5715()) {
+		pci_common_init(&gtwx5715_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/include/mach/hardware.h b/arch/arm/mach-ixp4xx/include/mach/hardware.h
index 163e506..63fc093 100644
--- a/arch/arm/mach-ixp4xx/include/mach/hardware.h
+++ b/arch/arm/mach-ixp4xx/include/mach/hardware.h
@@ -17,13 +17,13 @@
 #ifndef __ASM_ARCH_HARDWARE_H__
 #define __ASM_ARCH_HARDWARE_H__
 
-#define PCIBIOS_MIN_IO		0x00001000
+#define IXP4XX_PCIBIOS_MIN_IO		0x00001000
 #ifdef CONFIG_IXP4XX_INDIRECT_PCI
-#define PCIBIOS_MIN_MEM		0x10000000 /* 1 GB of indirect PCI MMIO space */
-#define PCIBIOS_MAX_MEM		0x4FFFFFFF
+#define IXP4XX_PCIBIOS_MIN_MEM		0x10000000 /* 1 GB of indirect PCI MMIO space */
+#define IXP4XX_PCIBIOS_MAX_MEM		0x4FFFFFFF
 #else
-#define PCIBIOS_MIN_MEM		0x48000000 /* 64 MB of PCI MMIO space */
-#define PCIBIOS_MAX_MEM		0x4BFFFFFF
+#define IXP4XX_PCIBIOS_MIN_MEM		0x48000000 /* 64 MB of PCI MMIO space */
+#define IXP4XX_PCIBIOS_MAX_MEM		0x4BFFFFFF
 #endif
 
 #define ARCH_HAS_DMA_SET_COHERENT_MASK
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index de274a1..2885ffd 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -56,7 +56,7 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
 
 static inline int is_pci_memory(u32 addr)
 {
-	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
+	return (addr >= IXP4XX_PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
 }
 
 static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index 1ba165a..94681c6 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -70,8 +70,11 @@ struct hw_pci ixdp425_pci __initdata = {
 int __init ixdp425_pci_init(void)
 {
 	if (machine_is_ixdp425() || machine_is_ixcdp1100() ||
-			machine_is_ixdp465() || machine_is_kixrp435())
-		pci_common_init(&ixdp425_pci);
+			machine_is_ixdp465() || machine_is_kixrp435()) {
+		pci_common_init(&ixdp425_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/ixdpg425-pci.c b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
index 4ed7ac6..9886406 100644
--- a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -51,8 +51,11 @@ struct hw_pci ixdpg425_pci __initdata = {
 
 int __init ixdpg425_pci_init(void)
 {
-	if (machine_is_ixdpg425())
-		pci_common_init(&ixdpg425_pci);
+	if (machine_is_ixdpg425()) {
+		pci_common_init(&ixdpg425_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index d0cea34..e37e380 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <mach/hardware.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -67,8 +68,10 @@ struct hw_pci __initdata nas100d_pci = {
 
 int __init nas100d_pci_init(void)
 {
-	if (machine_is_nas100d())
-		pci_common_init(&nas100d_pci);
+	if (machine_is_nas100d()) {
+		pci_common_init(&nas100d_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index 1eb5a90..495d65f 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <mach/hardware.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -63,8 +64,10 @@ struct hw_pci __initdata nslu2_pci = {
 
 int __init nslu2_pci_init(void) /* monkey see, monkey do */
 {
-	if (machine_is_nslu2())
-		pci_common_init(&nslu2_pci);
+	if (machine_is_nslu2()) {
+		pci_common_init(&nslu2_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-ixp4xx/vulcan-pci.c b/arch/arm/mach-ixp4xx/vulcan-pci.c
index f3111c6..cd99d1a 100644
--- a/arch/arm/mach-ixp4xx/vulcan-pci.c
+++ b/arch/arm/mach-ixp4xx/vulcan-pci.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <mach/hardware.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -65,8 +66,11 @@ struct hw_pci vulcan_pci __initdata = {
 
 int __init vulcan_pci_init(void)
 {
-	if (machine_is_arcom_vulcan())
-		pci_common_init(&vulcan_pci);
+	if (machine_is_arcom_vulcan()) {
+		pci_common_init(&vulcan_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-ixp4xx/wg302v2-pci.c b/arch/arm/mach-ixp4xx/wg302v2-pci.c
index 9b59ed0..4ddde25 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-pci.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-pci.c
@@ -55,8 +55,11 @@ struct hw_pci wg302v2_pci __initdata = {
 
 int __init wg302v2_pci_init(void)
 {
-	if (machine_is_wg302v2())
-		pci_common_init(&wg302v2_pci);
+	if (machine_is_wg302v2()) {
+		pci_common_init(&wg302v2_pci, IXP4XX_PCIBIOS_MIN_IO,
+				IXP4XX_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-kirkwood/include/mach/hardware.h b/arch/arm/mach-kirkwood/include/mach/hardware.h
index 79f0641..72763e7 100644
--- a/arch/arm/mach-kirkwood/include/mach/hardware.h
+++ b/arch/arm/mach-kirkwood/include/mach/hardware.h
@@ -11,8 +11,9 @@
 
 #include "kirkwood.h"
 
-#define PCIBIOS_MIN_IO			0x00001000
-#define PCIBIOS_MIN_MEM			0x01000000
+#define KIRKWOOD_PCIBIOS_MIN_IO		0x00001000
+#define KIRKWOOD_PCIBIOS_MIN_MEM	0x01000000
+
 #define PCIMEM_BASE			KIRKWOOD_PCIE_MEM_PHYS_BASE /* mem base for VGA */
 
 
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index 513ad31..ee38ad5 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -16,6 +16,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <mach/bridge-regs.h>
+#include <mach/hardware.h>
 #include "common.h"
 
 void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
@@ -270,5 +271,6 @@ void __init kirkwood_pcie_init(unsigned int portmask)
 		add_pcie_port(1, PCIE1_VIRT_BASE);
 
 	kirkwood_pci.nr_controllers = num_pcie_ports;
-	pci_common_init(&kirkwood_pci);
+	pci_common_init(&kirkwood_pci, KIRKWOOD_PCIBIOS_MIN_IO,
+			KIRKWOOD_PCIBIOS_MIN_MEM);
 }
diff --git a/arch/arm/mach-ks8695/include/mach/hardware.h b/arch/arm/mach-ks8695/include/mach/hardware.h
index a46be88..54e0638 100644
--- a/arch/arm/mach-ks8695/include/mach/hardware.h
+++ b/arch/arm/mach-ks8695/include/mach/hardware.h
@@ -46,7 +46,7 @@
 /*
  * PCI support
  */
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
+#define KS8695_PCIBIOS_MIN_IO		0
+#define KS8695_PCIBIOS_MIN_MEM		0
 
 #endif
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index 5fcd082..eb272af 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -325,5 +325,6 @@ void __init ks8695_init_pci(struct ks8695_pci_cfg *cfg)
 
 	ks8695_pci.map_irq = cfg->map_irq;	/* board-specific map_irq method */
 
-	pci_common_init(&ks8695_pci);
+	pci_common_init(&ks8695_pci, KS8695_PCIBIOS_MIN_IO,
+			KS8695_PCIBIOS_MIN_MEM);
 }
diff --git a/arch/arm/mach-mv78xx0/include/mach/hardware.h b/arch/arm/mach-mv78xx0/include/mach/hardware.h
index c76b93f..69f9588 100644
--- a/arch/arm/mach-mv78xx0/include/mach/hardware.h
+++ b/arch/arm/mach-mv78xx0/include/mach/hardware.h
@@ -11,8 +11,9 @@
 
 #include "mv78xx0.h"
 
-#define PCIBIOS_MIN_IO			0x00001000
-#define PCIBIOS_MIN_MEM			0x01000000
+#define MV78XX0_PCIBIOS_MIN_IO		0x00001000
+#define MV78XX0_PCIBIOS_MIN_MEM		0x01000000
+
 #define PCIMEM_BASE			MV78XX0_PCIE_MEM_PHYS_BASE /* mem base for VGA */
 
 
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index a560439..f6558f1 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/mbus.h>
+#include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
@@ -315,5 +316,6 @@ void __init mv78xx0_pcie_init(int init_port0, int init_port1)
 		}
 	}
 
-	pci_common_init(&mv78xx0_pci);
+	pci_common_init(&mv78xx0_pci, MV78XX0_PCIBIOS_MIN_IO,
+			MV78XX0_PCIBIOS_MIN_MEM);
 }
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index df1083f..f46b478 100644
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
@@ -273,8 +274,10 @@ static struct hw_pci db88f5281_pci __initdata = {
 
 static int __init db88f5281_pci_init(void)
 {
-	if (machine_is_db88f5281())
-		pci_common_init(&db88f5281_pci);
+	if (machine_is_db88f5281()) {
+		pci_common_init(&db88f5281_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 3a7bc0e..6f6edd7 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -34,6 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -97,8 +98,10 @@ static int __init dns323_pci_init(void)
 	/* Rev B1 and C1 doesn't really use its PCI bus, and initialising PCI
 	 * gets in the way of initialising the SATA controller.
 	 */
-	if (machine_is_dns323() && system_rev == DNS323_REV_A1)
-		pci_common_init(&dns323_pci);
+	if (machine_is_dns323() && system_rev == DNS323_REV_A1) {
+		pci_common_init(&dns323_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h b/arch/arm/mach-orion5x/include/mach/hardware.h
index a42b743..921abd1 100644
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ b/arch/arm/mach-orion5x/include/mach/hardware.h
@@ -11,9 +11,10 @@
 
 #include "orion5x.h"
 
-#define PCIBIOS_MIN_IO		0x00001000
-#define PCIBIOS_MIN_MEM		0x01000000
-#define PCIMEM_BASE		ORION5X_PCIE_MEM_PHYS_BASE
+#define ORION5X_PCIBIOS_MIN_IO		0x00001000
+#define ORION5X_PCIBIOS_MIN_MEM		0x01000000
+
+#define PCIMEM_BASE			ORION5X_PCIE_MEM_PHYS_BASE
 
 
 #endif
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 4be9aa0..84de118 100644
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
+		pci_common_init(&kurobox_pro_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 2f0e16c..9af4b7b 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -27,6 +27,7 @@
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
 #include <mach/bridge-regs.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -97,8 +98,10 @@ static struct hw_pci mss2_pci __initdata = {
 
 static int __init mss2_pci_init(void)
 {
-	if (machine_is_mss2())
-		pci_common_init(&mss2_pci);
+	if (machine_is_mss2()) {
+		pci_common_init(&mss2_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index f4c26fd..c438504 100644
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
+		pci_common_init(&rd88f5181l_fxo_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index b594290..8ae3336 100644
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
+		pci_common_init(&rd88f5181l_ge_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index 165ed87..ff66a7b 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -25,6 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -208,8 +209,10 @@ static struct hw_pci rd88f5182_pci __initdata = {
 
 static int __init rd88f5182_pci_init(void)
 {
-	if (machine_is_rd88f5182())
-		pci_common_init(&rd88f5182_pci);
+	if (machine_is_rd88f5182()) {
+		pci_common_init(&rd88f5182_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 02ff45f..6ceba26 100644
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
+		pci_common_init(&rd88f6183ap_ge_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 4403fae..d85be46 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -131,8 +132,10 @@ static struct hw_pci tsp2_pci __initdata = {
 
 static int __init tsp2_pci_init(void)
 {
-	if (machine_is_terastation_pro2())
-		pci_common_init(&tsp2_pci);
+	if (machine_is_terastation_pro2()) {
+		pci_common_init(&tsp2_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 1e19612..c36c698 100644
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
@@ -178,8 +179,10 @@ static struct hw_pci qnap_ts209_pci __initdata = {
 
 static int __init qnap_ts209_pci_init(void)
 {
-	if (machine_is_ts_x09())
-		pci_common_init(&qnap_ts209_pci);
+	if (machine_is_ts_x09()) {
+		pci_common_init(&qnap_ts209_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 428af20..89e20e4 100644
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
@@ -148,8 +149,10 @@ static struct hw_pci qnap_ts409_pci __initdata = {
 
 static int __init qnap_ts409_pci_init(void)
 {
-	if (machine_is_ts409())
-		pci_common_init(&qnap_ts409_pci);
+	if (machine_is_ts409()) {
+		pci_common_init(&qnap_ts409_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 7994d6e..46aa7ee 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -21,6 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -163,8 +164,10 @@ static struct hw_pci wnr854t_pci __initdata = {
 
 static int __init wnr854t_pci_init(void)
 {
-	if (machine_is_wnr854t())
-		pci_common_init(&wnr854t_pci);
+	if (machine_is_wnr854t()) {
+		pci_common_init(&wnr854t_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index a5989b7..083906f 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -24,6 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
+#include <mach/hardware.h>
 #include "common.h"
 #include "mpp.h"
 
@@ -251,8 +252,10 @@ static struct hw_pci wrt350n_v2_pci __initdata = {
 
 static int __init wrt350n_v2_pci_init(void)
 {
-	if (machine_is_wrt350n_v2())
-		pci_common_init(&wrt350n_v2_pci);
+	if (machine_is_wrt350n_v2()) {
+		pci_common_init(&wrt350n_v2_pci, ORION5X_PCIBIOS_MIN_IO,
+				ORION5X_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index 0f31305..f810a0e 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -21,6 +21,8 @@
 #include <linux/irq.h>
 #include <linux/gpio.h>
 
+#include <mach/hardware.h>
+
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
@@ -214,8 +216,10 @@ static struct hw_pci cmx2xx_pci __initdata = {
 
 static int __init cmx2xx_init_pci(void)
 {
-	if (machine_is_armcore())
-		pci_common_init(&cmx2xx_pci);
+	if (machine_is_armcore()) {
+		pci_common_init(&cmx2xx_pci, PXA_PCIBIOS_MIN_IO,
+				PXA_PCIBIOS_MIN_MEM);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index ad448af..86ea43f 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -318,8 +318,8 @@ extern unsigned long get_clock_tick_rate(void);
 #endif
 
 #if defined(CONFIG_MACH_ARMCORE) && defined(CONFIG_PCI)
-#define PCIBIOS_MIN_IO		0
-#define PCIBIOS_MIN_MEM		0
+#define PXA_PCIBIOS_MIN_IO	0
+#define PXA_PCIBIOS_MIN_MEM	0
 #define ARCH_HAS_DMA_SET_COHERENT_MASK
 #endif
 
diff --git a/arch/arm/mach-shark/include/mach/hardware.h b/arch/arm/mach-shark/include/mach/hardware.h
index 24639ce..7d3f0e3 100644
--- a/arch/arm/mach-shark/include/mach/hardware.h
+++ b/arch/arm/mach-shark/include/mach/hardware.h
@@ -12,8 +12,9 @@
 
 #define UNCACHEABLE_ADDR        0xdf010000
 
-#define PCIBIOS_MIN_IO          0x6000
-#define PCIBIOS_MIN_MEM         0x50000000
+#define SHARK_PCIBIOS_MIN_IO    0x6000
+#define SHARK_PCIBIOS_MIN_MEM   0x50000000
+
 #define PCIMEM_BASE		0xe8000000
 
 #endif
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 89d175c..89bef74 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -12,6 +12,7 @@
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
+#include <mach/hardware.h>
 
 static int __init shark_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -37,8 +38,11 @@ static struct hw_pci shark_pci __initdata = {
 
 static int __init shark_pci_init(void)
 {
-	if (machine_is_shark())
-		pci_common_init(&shark_pci);
+	if (machine_is_shark()) {
+		pci_common_init(&shark_pci, SHARK_PCIBIOS_MIN_IO,
+				SHARK_PCIBIOS_MIN_MEM);
+	}
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-tegra/include/mach/hardware.h b/arch/arm/mach-tegra/include/mach/hardware.h
index 84c2658..c0cc236 100644
--- a/arch/arm/mach-tegra/include/mach/hardware.h
+++ b/arch/arm/mach-tegra/include/mach/hardware.h
@@ -21,7 +21,8 @@
 #ifndef __MACH_TEGRA_HARDWARE_H
 #define __MACH_TEGRA_HARDWARE_H
 
-#define PCIBIOS_MIN_IO			0x1000
-#define PCIBIOS_MIN_MEM			0
+#define TEGRA_PCIBIOS_MIN_IO			0x1000
+#define TEGRA_PCIBIOS_MIN_MEM			0
+
 
 #endif
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 53f5fa3..8ef8dc4 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -39,6 +39,7 @@
 #include <mach/pinmux.h>
 #include <mach/iomap.h>
 #include <mach/clk.h>
+#include <mach/hardware.h>
 
 /* register definitions */
 #define AFI_OFFSET	0x3800
@@ -396,10 +397,10 @@ static int tegra_pcie_setup(int nr, struct pci_sys_data *sys)
 	pp->io_space_name[sizeof(pp->io_space_name) - 1] = 0;
 	pp->res[0].name = pp->io_space_name;
 	if (pp->index == 0) {
-		pp->res[0].start = PCIBIOS_MIN_IO;
+		pp->res[0].start = TEGRA_PCIBIOS_MIN_IO;
 		pp->res[0].end = pp->res[0].start + SZ_32K - 1;
 	} else {
-		pp->res[0].start = PCIBIOS_MIN_IO + SZ_32K;
+		pp->res[0].start = TEGRA_PCIBIOS_MIN_IO + SZ_32K;
 		pp->res[0].end = IO_SPACE_LIMIT;
 	}
 	pp->res[0].flags = IORESOURCE_IO;
@@ -909,7 +910,8 @@ int __init tegra_pcie_init(bool init_port0, bool init_port1)
 	if (init_port1)
 		tegra_pcie_add_port(1, RP1_OFFSET, AFI_PEX1_CTRL);
 
-	pci_common_init(&tegra_pcie_hw);
+	pci_common_init(&tegra_pcie_hw, TEGRA_PCIBIOS_MIN_IO,
+			TEGRA_PCIBIOS_MIN_MEM);
 
 	return 0;
 }
diff --git a/arch/arm/mach-versatile/include/mach/hardware.h b/arch/arm/mach-versatile/include/mach/hardware.h
index 74e0ea8..5511a22 100644
--- a/arch/arm/mach-versatile/include/mach/hardware.h
+++ b/arch/arm/mach-versatile/include/mach/hardware.h
@@ -31,8 +31,8 @@
 #define VERSATILE_PCI_CFG_VIRT_BASE	(void __iomem *)0xe9000000ul
 
 /* CIK guesswork */
-#define PCIBIOS_MIN_IO			0x44000000
-#define PCIBIOS_MIN_MEM			0x50000000
+#define VERSATILE_PCIBIOS_MIN_IO		0x44000000
+#define VERSATILE_PCIBIOS_MIN_MEM		0x50000000
 
 /* macro to get at IO space when running virtually */
 #define IO_ADDRESS(x)		(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + 0xf0000000)
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 13c7e5f..7ed57f8 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -354,7 +354,9 @@ static struct hw_pci versatile_pci __initdata = {
 
 static int __init versatile_pci_init(void)
 {
-	pci_common_init(&versatile_pci);
+	pci_common_init(&versatile_pci, VERSATILE_PCIBIOS_MIN_IO,
+			VERSATILE_PCIBIOS_MIN_MEM);
+
 	return 0;
 }
 
-- 
1.7.1
