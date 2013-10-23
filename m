From: y@lunn.ch (y at lunn.ch)
Date: Wed, 23 Oct 2013 16:12:51 +0200
Subject: [PATCH 2/3] ARM: Orion5x: Fix warnings when using C=1.
In-Reply-To: <1382537572-31472-1-git-send-email-y>
References: <y>
 <1382537572-31472-1-git-send-email-y>
Message-ID: <1382537572-31472-2-git-send-email-y>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add missing include files, missing static keyword, and use NULL instead
of 0, in order to fix warnings when compiling with C=1.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-orion5x/board-dt.c               | 2 +-
 arch/arm/mach-orion5x/common.c                 | 6 +++---
 arch/arm/mach-orion5x/db88f5281-setup.c        | 2 +-
 arch/arm/mach-orion5x/irq.c                    | 1 +
 arch/arm/mach-orion5x/pci.c                    | 4 ++--
 arch/arm/mach-orion5x/rd88f5182-setup.c        | 2 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
 arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           | 2 +-
 9 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index b91002c..c134a82 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -21,7 +21,7 @@
 #include <plat/irq.h>
 #include "common.h"
 
-struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
+static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
 	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
 		       NULL),
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 91a5852..4d8fc76 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -135,7 +135,7 @@ void __init orion5x_sata_init(struct mv_sata_platform_data *sata_data)
 /*****************************************************************************
  * SPI
  ****************************************************************************/
-void __init orion5x_spi_init()
+void __init orion5x_spi_init(void)
 {
 	orion_spi_init(SPI_PHYS_BASE);
 }
@@ -185,7 +185,7 @@ static void __init orion5x_crypto_init(void)
 /*****************************************************************************
  * Watchdog
  ****************************************************************************/
-void __init orion5x_wdt_init(void)
+static void __init orion5x_wdt_init(void)
 {
 	orion_wdt_init();
 }
@@ -246,7 +246,7 @@ void orion5x_setup_wins(void)
 
 int orion5x_tclk;
 
-int __init orion5x_find_tclk(void)
+static int __init orion5x_find_tclk(void)
 {
 	u32 dev, rev;
 
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 4b2aefd..dc01c4f 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -202,7 +202,7 @@ __initcall(db88f5281_7seg_init);
  * PCI
  ****************************************************************************/
 
-void __init db88f5281_pci_preinit(void)
+static void __init db88f5281_pci_preinit(void)
 {
 	int pin;
 
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 30a192b..9654b0c 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -16,6 +16,7 @@
 #include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
+#include "common.h"
 
 static int __initdata gpio0_irqs[4] = {
 	IRQ_ORION5X_GPIO_0_7,
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 7fab670..87a12d6 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -240,11 +240,11 @@ static int __init pcie_setup(struct pci_sys_data *sys)
 #define PCI_BAR_SIZE_DDR_CS(n)	(((n) == 0) ? ORION5X_PCI_REG(0xc08) : \
 				 ((n) == 1) ? ORION5X_PCI_REG(0xd08) : \
 				 ((n) == 2) ? ORION5X_PCI_REG(0xc0c) : \
-				 ((n) == 3) ? ORION5X_PCI_REG(0xd0c) : 0)
+				 ((n) == 3) ? ORION5X_PCI_REG(0xd0c) : NULL)
 #define PCI_BAR_REMAP_DDR_CS(n)	(((n) == 0) ? ORION5X_PCI_REG(0xc48) : \
 				 ((n) == 1) ? ORION5X_PCI_REG(0xd48) : \
 				 ((n) == 2) ? ORION5X_PCI_REG(0xc4c) : \
-				 ((n) == 3) ? ORION5X_PCI_REG(0xd4c) : 0)
+				 ((n) == 3) ? ORION5X_PCI_REG(0xd4c) : NULL)
 #define PCI_BAR_ENABLE		ORION5X_PCI_REG(0xc3c)
 #define PCI_ADDR_DECODE_CTRL	ORION5X_PCI_REG(0xd3c)
 
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index b1cf684..b576ef5 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -108,7 +108,7 @@ static struct platform_device rd88f5182_gpio_leds = {
  * PCI
  ****************************************************************************/
 
-void __init rd88f5182_pci_preinit(void)
+static void __init rd88f5182_pci_preinit(void)
 {
 	int pin;
 
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 7e90648..6208d12 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -77,7 +77,7 @@ static struct platform_device tsp2_nor_flash = {
 #define TSP2_PCI_SLOT0_OFFS		7
 #define TSP2_PCI_SLOT0_IRQ_PIN		11
 
-void __init tsp2_pci_preinit(void)
+static void __init tsp2_pci_preinit(void)
 {
 	int pin;
 
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index e90c061..9136797 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -106,7 +106,7 @@ static struct platform_device qnap_ts209_nor_flash = {
 #define QNAP_TS209_PCI_SLOT0_IRQ_PIN	6
 #define QNAP_TS209_PCI_SLOT1_IRQ_PIN	7
 
-void __init qnap_ts209_pci_preinit(void)
+static void __init qnap_ts209_pci_preinit(void)
 {
 	int pin;
 
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index e960855..db16dae 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -57,7 +57,7 @@ static struct map_desc ts78xx_io_desc[] __initdata = {
 	},
 };
 
-void __init ts78xx_map_io(void)
+static void __init ts78xx_map_io(void)
 {
 	orion5x_map_io();
 	iotable_init(ts78xx_io_desc, ARRAY_SIZE(ts78xx_io_desc));
-- 
1.8.4.rc3
