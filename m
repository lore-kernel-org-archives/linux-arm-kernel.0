From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Dec 2015 22:27:05 +0100
Subject: [PATCH 3/7] ARM: orion: use SPARSE_IRQ everywhere
In-Reply-To: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
References: <1449091629-2155735-1-git-send-email-arnd@arndb.de>
Message-ID: <1449091629-2155735-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a preparation for multiplatform support, this moves all the
code using plat-orion over to use sparse irq support, which is
enabled implicitly for multiplatform.

In particular, the hardcoded NR_IRQS macro gets replaced with
a machine specific one that is set in the machine descriptor
in order to set up a static mapping for all legacy interrupts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/Kconfig                               | 3 +++
 arch/arm/mach-dove/cm-a510.c                   | 1 +
 arch/arm/mach-dove/dove-db-setup.c             | 1 +
 arch/arm/mach-dove/include/mach/dove.h         | 2 ++
 arch/arm/mach-dove/include/mach/irqs.h         | 2 +-
 arch/arm/mach-dove/include/mach/pm.h           | 2 +-
 arch/arm/mach-dove/irq.c                       | 2 +-
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c      | 1 +
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c       | 1 +
 arch/arm/mach-mv78xx0/include/mach/irqs.h      | 2 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h   | 2 ++
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c     | 1 +
 arch/arm/mach-orion5x/db88f5281-setup.c        | 1 +
 arch/arm/mach-orion5x/dns323-setup.c           | 1 +
 arch/arm/mach-orion5x/include/mach/irqs.h      | 2 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h   | 2 ++
 arch/arm/mach-orion5x/kurobox_pro-setup.c      | 2 ++
 arch/arm/mach-orion5x/ls-chl-setup.c           | 1 +
 arch/arm/mach-orion5x/ls_hgl-setup.c           | 1 +
 arch/arm/mach-orion5x/mv2120-setup.c           | 1 +
 arch/arm/mach-orion5x/net2big-setup.c          | 1 +
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   | 1 +
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    | 1 +
 arch/arm/mach-orion5x/rd88f5182-setup.c        | 1 +
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   | 1 +
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 1 +
 arch/arm/mach-orion5x/ts209-setup.c            | 1 +
 arch/arm/mach-orion5x/ts409-setup.c            | 1 +
 arch/arm/mach-orion5x/ts78xx-setup.c           | 1 +
 arch/arm/mach-orion5x/wnr854t-setup.c          | 1 +
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       | 1 +
 31 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 227ff489a080..99676c25536f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -517,6 +517,7 @@ config ARCH_DOVE
 	select PINCTRL
 	select PINCTRL_DOVE
 	select PLAT_ORION_LEGACY
+	select SPARSE_IRQ
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
@@ -529,6 +530,7 @@ config ARCH_MV78XX0
 	select MULTI_IRQ_HANDLER
 	select PCI
 	select PLAT_ORION_LEGACY
+	select SPARSE_IRQ
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
@@ -544,6 +546,7 @@ config ARCH_ORION5X
 	select PCI
 	select PLAT_ORION_LEGACY
 	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 0dc39cf30fdd..b9a7c33db29a 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -88,6 +88,7 @@ static void __init cm_a510_init(void)
 
 MACHINE_START(CM_A510, "Compulab CM-A510 Board")
 	.atag_offset	= 0x100,
+	.nr_irqs	= DOVE_NR_IRQS,
 	.init_machine	= cm_a510_init,
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 76e26f949c27..bcb678fd2415 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -94,6 +94,7 @@ static void __init dove_db_init(void)
 
 MACHINE_START(DOVE_DB, "Marvell DB-MV88AP510-BP Development Board")
 	.atag_offset	= 0x100,
+	.nr_irqs	= DOVE_NR_IRQS,
 	.init_machine	= dove_db_init,
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
index 0c4b35f4ee5b..00f45458b3ec 100644
--- a/arch/arm/mach-dove/include/mach/dove.h
+++ b/arch/arm/mach-dove/include/mach/dove.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_ARCH_DOVE_H
 #define __ASM_ARCH_DOVE_H
 
+#include <mach/irqs.h>
+
 /*
  * Marvell Dove address maps.
  *
diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-dove/include/mach/irqs.h
index 3f29e6bca058..8ff0fa8b4fcd 100644
--- a/arch/arm/mach-dove/include/mach/irqs.h
+++ b/arch/arm/mach-dove/include/mach/irqs.h
@@ -90,7 +90,7 @@
 #define NR_PMU_IRQS		7
 #define IRQ_DOVE_RTC		(IRQ_DOVE_PMU_START + 5)
 
-#define NR_IRQS			(IRQ_DOVE_PMU_START + NR_PMU_IRQS)
+#define DOVE_NR_IRQS		(IRQ_DOVE_PMU_START + NR_PMU_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
index b47f75038686..9834ba10cd13 100644
--- a/arch/arm/mach-dove/include/mach/pm.h
+++ b/arch/arm/mach-dove/include/mach/pm.h
@@ -63,7 +63,7 @@ static inline int pmu_to_irq(int pin)
 
 static inline int irq_to_pmu(int irq)
 {
-	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
+	if (IRQ_DOVE_PMU_START <= irq && irq < DOVE_NR_IRQS)
 		return irq - IRQ_DOVE_PMU_START;
 
 	return -EINVAL;
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index b1c7cae1486b..ad785d34c1e7 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -160,7 +160,7 @@ void __init dove_init_irq(void)
 	writel(0, PMU_INTERRUPT_MASK);
 	writel(0, PMU_INTERRUPT_CAUSE);
 
-	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
+	for (i = IRQ_DOVE_PMU_START; i < DOVE_NR_IRQS; i++) {
 		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
 		irq_set_status_flags(i, IRQ_LEVEL);
 		irq_clear_status_flags(i, IRQ_NOREQUEST);
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index 1f2ef98b37c6..1607fd5e206e 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -146,6 +146,7 @@ subsys_initcall(wxl_pci_init);
 MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
 	/* Maintainer: Sebastien Requiem <sebastien@requiem.fr> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= MV78XX0_NR_IRQS,
 	.init_machine	= wxl_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index 4e0f22b30bc8..0c5dd6fceb6b 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -94,6 +94,7 @@ subsys_initcall(db78x00_pci_init);
 MACHINE_START(DB78X00_BP, "Marvell DB-78x00-BP Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= MV78XX0_NR_IRQS,
 	.init_machine	= db78x00_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
diff --git a/arch/arm/mach-mv78xx0/include/mach/irqs.h b/arch/arm/mach-mv78xx0/include/mach/irqs.h
index fa1d422196c2..ac96bcf3d268 100644
--- a/arch/arm/mach-mv78xx0/include/mach/irqs.h
+++ b/arch/arm/mach-mv78xx0/include/mach/irqs.h
@@ -88,7 +88,7 @@
 #define IRQ_MV78XX0_GPIO_START	96
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_MV78XX0_GPIO_START + NR_GPIO_IRQS)
+#define MV78XX0_NR_IRQS		(IRQ_MV78XX0_GPIO_START + NR_GPIO_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
index 723748d8ba7d..0972d5f9b46d 100644
--- a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_ARCH_MV78XX0_H
 #define __ASM_ARCH_MV78XX0_H
 
+#include "irqs.h"
+
 /*
  * Marvell MV78xx0 address maps.
  *
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index d2d06f3957f3..a0a3debf8c21 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -79,6 +79,7 @@ subsys_initcall(rd78x00_pci_init);
 MACHINE_START(RD78X00_MASA, "Marvell RD-78x00-MASA Development Board")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= MV78XX0_NR_IRQS,
 	.init_machine	= rd78x00_masa_init,
 	.map_io		= mv78xx0_map_io,
 	.init_early	= mv78xx0_init_early,
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index dc01c4ffc9a8..698528fee39d 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -369,6 +369,7 @@ static void __init db88f5281_init(void)
 MACHINE_START(DB88F5281, "Marvell Orion-2 Development Board")
 	/* Maintainer: Tzachi Perelstein <tzachi@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= db88f5281_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index bc279a853075..96a8c50e7223 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -666,6 +666,7 @@ static void __init dns323_init(void)
 MACHINE_START(DNS323, "D-Link DNS-323")
 	/* Maintainer: Herbert Valerio Riedel <hvr@gnu.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= dns323_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion5x/include/mach/irqs.h
index 2431d9923427..4b8703cd1ccb 100644
--- a/arch/arm/mach-orion5x/include/mach/irqs.h
+++ b/arch/arm/mach-orion5x/include/mach/irqs.h
@@ -54,7 +54,7 @@
 #define IRQ_ORION5X_GPIO_START	33
 #define NR_GPIO_IRQS		32
 
-#define NR_IRQS			(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
+#define ORION5X_NR_IRQS		(IRQ_ORION5X_GPIO_START + NR_GPIO_IRQS)
 
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion5x/include/mach/orion5x.h
index b78ff3248868..7be7c2e05465 100644
--- a/arch/arm/mach-orion5x/include/mach/orion5x.h
+++ b/arch/arm/mach-orion5x/include/mach/orion5x.h
@@ -14,6 +14,8 @@
 #ifndef __ASM_ARCH_ORION5X_H
 #define __ASM_ARCH_ORION5X_H
 
+#include <mach/irqs.h>
+
 /*****************************************************************************
  * Orion Address Maps
  *
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index fe6a48a325e8..b1ebb3721638 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -383,6 +383,7 @@ static void __init kurobox_pro_init(void)
 MACHINE_START(KUROBOX_PRO, "Buffalo/Revogear Kurobox Pro")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
@@ -397,6 +398,7 @@ MACHINE_END
 MACHINE_START(LINKSTATION_PRO, "Buffalo Linkstation Pro/Live")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= kurobox_pro_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
index 028ea038d404..cb8720e6d02b 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion5x/ls-chl-setup.c
@@ -320,6 +320,7 @@ static void __init lschl_init(void)
 MACHINE_START(LINKSTATION_LSCHL, "Buffalo Linkstation LiveV3 (LS-CHL)")
 	/* Maintainer: Ash Hughes <ashley.hughes@blueyonder.co.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= lschl_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 32b7129b767d..0ddfa23821ec 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -267,6 +267,7 @@ static void __init ls_hgl_init(void)
 MACHINE_START(LINKSTATION_LS_HGL, "Buffalo Linkstation LS-HGL")
 	/* Maintainer: Zhu Qingsen <zhuqs@cn.fujistu.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= ls_hgl_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
index e032f01da49e..11985dc45c47 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion5x/mv2120-setup.c
@@ -232,6 +232,7 @@ static void __init mv2120_init(void)
 MACHINE_START(MV2120, "HP Media Vault mv2120")
 	/* Maintainer: Martin Michlmayr <tbm@cyrius.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= mv2120_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index ba73dc7ffb9e..e91abcc2213d 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -423,6 +423,7 @@ static void __init net2big_init(void)
 /* Warning: LaCie use a wrong mach-type (0x20e=526) in their bootloader. */
 MACHINE_START(NET2BIG, "LaCie 2Big Network")
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= net2big_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 213b3e143c57..69a6e5b20b0b 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -169,6 +169,7 @@ subsys_initcall(rd88f5181l_fxo_pci_init);
 MACHINE_START(RD88F5181L_FXO, "Marvell Orion-VoIP FXO Reference Design")
 	/* Maintainer: Nicolas Pitre <nico@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= rd88f5181l_fxo_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 594800e1d691..e19f8b7f87b3 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -181,6 +181,7 @@ subsys_initcall(rd88f5181l_ge_pci_init);
 MACHINE_START(RD88F5181L_GE, "Marvell Orion-VoIP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= rd88f5181l_ge_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index b576ef5f18a1..180a4f972d3d 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -281,6 +281,7 @@ static void __init rd88f5182_init(void)
 MACHINE_START(RD88F5182, "Marvell Orion-NAS Reference Design")
 	/* Maintainer: Ronen Shitrit <rshitrit@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= rd88f5182_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 78a1e6ab1b9d..cc5bdbe70fa9 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -119,6 +119,7 @@ subsys_initcall(rd88f6183ap_ge_pci_init);
 MACHINE_START(RD88F6183AP_GE, "Marvell Orion-1-90 AP GE Reference Design")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= rd88f6183ap_ge_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 12086745c9fd..ad2057514deb 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -359,6 +359,7 @@ static void __init tsp2_init(void)
 MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@googlemail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= tsp2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index c725b7cb9875..1cfc364c9b1e 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -324,6 +324,7 @@ static void __init qnap_ts209_init(void)
 MACHINE_START(TS209, "QNAP TS-109/TS-209")
 	/* Maintainer: Byron Bradley <byron.bbradley@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= qnap_ts209_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index cf2ab531cabc..bc985cf44625 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -313,6 +313,7 @@ static void __init qnap_ts409_init(void)
 MACHINE_START(TS409, "QNAP TS-409")
 	/* Maintainer:  Sylver Bruneau <sylver.bruneau@gmail.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= qnap_ts409_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 1b704d35cf5b..5a61a66ce012 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -615,6 +615,7 @@ static void __init ts78xx_init(void)
 MACHINE_START(TS78XX, "Technologic Systems TS-78xx SBC")
 	/* Maintainer: Alexander Clouter <alex@digriz.org.uk> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= ts78xx_init,
 	.map_io		= ts78xx_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 80a56ee245b3..bcc6e12dcdac 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -174,6 +174,7 @@ subsys_initcall(wnr854t_pci_init);
 MACHINE_START(WNR854T, "Netgear WNR854T")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= wnr854t_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 670e30dc0d1b..4068d7a3e466 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -262,6 +262,7 @@ subsys_initcall(wrt350n_v2_pci_init);
 MACHINE_START(WRT350N_V2, "Linksys WRT350N v2")
 	/* Maintainer: Lennert Buytenhek <buytenh@marvell.com> */
 	.atag_offset	= 0x100,
+	.nr_irqs	= ORION5X_NR_IRQS,
 	.init_machine	= wrt350n_v2_init,
 	.map_io		= orion5x_map_io,
 	.init_early	= orion5x_init_early,
-- 
2.1.0.rc2
