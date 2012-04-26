From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:18:16 +0100
Subject: [PATCH 5/8] ARM: PCI: get rid of pci_std_swizzle()
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLmC-000811-KT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most PCI implementations use the standard PCI swizzle function, which
handles the well defined behaviour of PCI-to-PCI bridges which can be
found on cards (eg, four port ethernet cards.)

Rather than having almost every platform specify the standard swizzle
function, make this the default when no swizzle function is supplied.
Therefore, a swizzle function only needs to be provided when there is
something exceptional which needs to be handled.

This gets rid of the swizzle initializer from 47 files, and leaves us
with just two platforms specifying a swizzle function: ARM Integrator
and Chalice CATS.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/pci.h                |    5 -----
 arch/arm/kernel/bios32.c                       |   19 ++++++++++++++++---
 arch/arm/mach-cns3xxx/pcie.c                   |    2 --
 arch/arm/mach-dove/pcie.c                      |    1 -
 arch/arm/mach-footbridge/ebsa285-pci.c         |    1 -
 arch/arm/mach-footbridge/netwinder-pci.c       |    1 -
 arch/arm/mach-iop13xx/iq81340mc.c              |    1 -
 arch/arm/mach-iop13xx/iq81340sc.c              |    1 -
 arch/arm/mach-iop32x/em7210.c                  |    1 -
 arch/arm/mach-iop32x/glantank.c                |    1 -
 arch/arm/mach-iop32x/iq31244.c                 |    2 --
 arch/arm/mach-iop32x/iq80321.c                 |    1 -
 arch/arm/mach-iop32x/n2100.c                   |    1 -
 arch/arm/mach-iop33x/iq80331.c                 |    1 -
 arch/arm/mach-iop33x/iq80332.c                 |    1 -
 arch/arm/mach-ixp4xx/avila-pci.c               |    1 -
 arch/arm/mach-ixp4xx/coyote-pci.c              |    1 -
 arch/arm/mach-ixp4xx/dsmg600-pci.c             |    1 -
 arch/arm/mach-ixp4xx/fsg-pci.c                 |    1 -
 arch/arm/mach-ixp4xx/gateway7001-pci.c         |    1 -
 arch/arm/mach-ixp4xx/goramo_mlr.c              |    1 -
 arch/arm/mach-ixp4xx/gtwx5715-pci.c            |    1 -
 arch/arm/mach-ixp4xx/ixdp425-pci.c             |    1 -
 arch/arm/mach-ixp4xx/ixdpg425-pci.c            |    1 -
 arch/arm/mach-ixp4xx/miccpt-pci.c              |    1 -
 arch/arm/mach-ixp4xx/nas100d-pci.c             |    1 -
 arch/arm/mach-ixp4xx/nslu2-pci.c               |    1 -
 arch/arm/mach-ixp4xx/vulcan-pci.c              |    1 -
 arch/arm/mach-ixp4xx/wg302v2-pci.c             |    1 -
 arch/arm/mach-kirkwood/pcie.c                  |    1 -
 arch/arm/mach-ks8695/pci.c                     |    1 -
 arch/arm/mach-mv78xx0/pcie.c                   |    1 -
 arch/arm/mach-orion5x/db88f5281-setup.c        |    1 -
 arch/arm/mach-orion5x/dns323-setup.c           |    1 -
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |    1 -
 arch/arm/mach-orion5x/mss2-setup.c             |    1 -
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |    1 -
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |    1 -
 arch/arm/mach-orion5x/rd88f5182-setup.c        |    1 -
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 -
 arch/arm/mach-orion5x/terastation_pro2-setup.c |    1 -
 arch/arm/mach-orion5x/ts209-setup.c            |    1 -
 arch/arm/mach-orion5x/ts409-setup.c            |    1 -
 arch/arm/mach-orion5x/wnr854t-setup.c          |    1 -
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |    1 -
 arch/arm/mach-pxa/cm-x2xx-pci.c                |    1 -
 arch/arm/mach-shark/pci.c                      |    1 -
 arch/arm/mach-tegra/pcie.c                     |    1 -
 arch/arm/mach-versatile/pci.c                  |    1 -
 49 files changed, 16 insertions(+), 57 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index 0fc8548..ff8146a 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -49,11 +49,6 @@ struct pci_sys_data {
 };
 
 /*
- * This is the standard PCI-PCI bridge swizzling algorithm.
- */
-#define pci_std_swizzle pci_common_swizzle
-
-/*
  * Call this with your hw_pci struct to initialise the PCI system.
  */
 void pci_common_init(struct hw_pci *);
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index e17dd25..d22e351 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -374,16 +374,29 @@ EXPORT_SYMBOL(pcibios_fixup_bus);
 #endif
 
 /*
- * Swizzle the device pin each time we cross a bridge.
- * This might update pin and returns the slot number.
+ * Swizzle the device pin each time we cross a bridge.  If a platform does
+ * not provide a swizzle function, we perform the standard PCI swizzling.
+ *
+ * The default swizzling walks up the bus tree one level at a time, applying
+ * the standard swizzle function at each step, stopping when it finds the PCI
+ * root bus.  This will return the slot number of the bridge device on the
+ * root bus and the interrupt pin on that device which should correspond
+ * with the downstream device interrupt.
+ *
+ * Platforms may override this, in which case the slot and pin returned
+ * depend entirely on the platform code.  However, please note that the
+ * PCI standard swizzle is implemented on plug-in cards and Cardbus based
+ * PCI extenders, so it can not be ignored.
  */
 static u8 __devinit pcibios_swizzle(struct pci_dev *dev, u8 *pin)
 {
 	struct pci_sys_data *sys = dev->sysdata;
-	int slot = 0, oldpin = *pin;
+	int slot, oldpin = *pin;
 
 	if (sys->swizzle)
 		slot = sys->swizzle(dev, pin);
+	else
+		slot = pci_common_swizzle(dev, pin);
 
 	if (debug_pci)
 		printk("PCI: %s swizzling pin %d => pin %d slot %d\n",
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 79d001f..62f861b 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -221,7 +221,6 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 		.irqs = { IRQ_CNS3XXX_PCIE0_RC, IRQ_CNS3XXX_PCIE0_DEVICE, },
 		.hw_pci = {
 			.domain = 0,
-			.swizzle = pci_std_swizzle,
 			.nr_controllers = 1,
 			.setup = cns3xxx_pci_setup,
 			.scan = cns3xxx_pci_scan_bus,
@@ -264,7 +263,6 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 		.irqs = { IRQ_CNS3XXX_PCIE1_RC, IRQ_CNS3XXX_PCIE1_DEVICE, },
 		.hw_pci = {
 			.domain = 1,
-			.swizzle = pci_std_swizzle,
 			.nr_controllers = 1,
 			.setup = cns3xxx_pci_setup,
 			.scan = cns3xxx_pci_scan_bus,
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index 48a0320..cebf6a3 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -201,7 +201,6 @@ static int __init dove_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci dove_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= dove_pcie_setup,
 	.scan		= dove_pcie_scan_bus,
 	.map_irq	= dove_pcie_map_irq,
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
index 511c673..a5bed6e 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -29,7 +29,6 @@ static int __init ebsa285_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci ebsa285_pci __initdata = {
-	.swizzle		= pci_std_swizzle,
 	.map_irq		= ebsa285_map_irq,
 	.nr_controllers		= 1,
 	.setup			= dc21285_setup,
diff --git a/arch/arm/mach-footbridge/netwinder-pci.c b/arch/arm/mach-footbridge/netwinder-pci.c
index 6218761..3f66e89 100644
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ b/arch/arm/mach-footbridge/netwinder-pci.c
@@ -43,7 +43,6 @@ static int __init netwinder_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci netwinder_pci __initdata = {
-	.swizzle		= pci_std_swizzle,
 	.map_irq		= netwinder_map_irq,
 	.nr_controllers		= 1,
 	.setup			= dc21285_setup,
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 5c96b73..e3f3e7d 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -54,7 +54,6 @@ iq81340mc_pcix_map_irq(const struct pci_dev *dev, u8 idsel, u8 pin)
 }
 
 static struct hw_pci iq81340mc_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 0,
 	.setup		= iop13xx_pci_setup,
 	.map_irq	= iq81340mc_pcix_map_irq,
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index aa4dd75..060cddd 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -56,7 +56,6 @@ iq81340sc_atux_map_irq(struct pci_dev *dev, u8 idsel, u8 pin)
 }
 
 static struct hw_pci iq81340sc_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 0,
 	.setup		= iop13xx_pci_setup,
 	.scan		= iop13xx_scan_bus,
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 24069e0..4915013 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -103,7 +103,6 @@ em7210_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci em7210_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index 204e1d1..456a414 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -96,7 +96,6 @@ glantank_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci glantank_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index 3eb642a..b795e6b 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -130,7 +130,6 @@ ep80219_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci ep80219_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
@@ -166,7 +165,6 @@ iq31244_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci iq31244_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index 2ec724b..ac6d962 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -101,7 +101,6 @@ iq80321_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci iq80321_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 6b6d559..adf257a 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -114,7 +114,6 @@ n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci n2100_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index abce934..3298a8a 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -84,7 +84,6 @@ iq80331_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci iq80331_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 7513559..87b0e9d 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -84,7 +84,6 @@ iq80332_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci iq80332_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.nr_controllers = 1,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 8fea0a3..89d1f35 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -66,7 +66,6 @@ static int __init avila_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci avila_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit	= avila_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= avila_map_irq,
diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index 71f5c9c..d876a4f 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -49,7 +49,6 @@ static int __init coyote_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci coyote_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =        coyote_pci_preinit,
-	.swizzle =        pci_std_swizzle,
 	.setup =          ixp4xx_setup,
 	.scan =           ixp4xx_scan_bus,
 	.map_irq =        coyote_map_irq,
diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index 0532510..6648597 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -63,7 +63,6 @@ static int __init dsmg600_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci __initdata dsmg600_pci = {
 	.nr_controllers = 1,
 	.preinit	= dsmg600_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= dsmg600_map_irq,
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index d2ac803..528e4af 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -60,7 +60,6 @@ static int __init fsg_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci fsg_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =	  fsg_pci_preinit,
-	.swizzle =	  pci_std_swizzle,
 	.setup =	  ixp4xx_setup,
 	.scan =		  ixp4xx_scan_bus,
 	.map_irq =	  fsg_map_irq,
diff --git a/arch/arm/mach-ixp4xx/gateway7001-pci.c b/arch/arm/mach-ixp4xx/gateway7001-pci.c
index 76581fb..1d1134b 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-pci.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-pci.c
@@ -48,7 +48,6 @@ static int __init gateway7001_map_irq(const struct pci_dev *dev, u8 slot,
 struct hw_pci gateway7001_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =        gateway7001_pci_preinit,
-	.swizzle =        pci_std_swizzle,
 	.setup =          ixp4xx_setup,
 	.scan =           ixp4xx_scan_bus,
 	.map_irq =        gateway7001_map_irq,
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 46bb924..c97a1a8 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -475,7 +475,6 @@ static struct hw_pci gmlr_hw_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit	= gmlr_pci_preinit,
 	.postinit	= gmlr_pci_postinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= gmlr_map_irq,
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index d68fc06..4bd8770 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -68,7 +68,6 @@ static int __init gtwx5715_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci gtwx5715_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =        gtwx5715_pci_preinit,
-	.swizzle =        pci_std_swizzle,
 	.setup =          ixp4xx_setup,
 	.scan =           ixp4xx_scan_bus,
 	.map_irq =        gtwx5715_map_irq,
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index fffd8c5..3e1a229 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -61,7 +61,6 @@ static int __init ixdp425_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci ixdp425_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit	= ixdp425_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= ixdp425_map_irq,
diff --git a/arch/arm/mach-ixp4xx/ixdpg425-pci.c b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
index 34efe75..5c70e92 100644
--- a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -43,7 +43,6 @@ static int __init ixdpg425_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci ixdpg425_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =        ixdpg425_pci_preinit,
-	.swizzle =        pci_std_swizzle,
 	.setup =          ixp4xx_setup,
 	.scan =           ixp4xx_scan_bus,
 	.map_irq =        ixdpg425_map_irq,
diff --git a/arch/arm/mach-ixp4xx/miccpt-pci.c b/arch/arm/mach-ixp4xx/miccpt-pci.c
index ca0bae7..8d4ba71 100644
--- a/arch/arm/mach-ixp4xx/miccpt-pci.c
+++ b/arch/arm/mach-ixp4xx/miccpt-pci.c
@@ -62,7 +62,6 @@ static int __init miccpt_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci miccpt_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit	= miccpt_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= miccpt_map_irq,
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index 5434ccf..ba1ad20 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -59,7 +59,6 @@ static int __init nas100d_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci __initdata nas100d_pci = {
 	.nr_controllers = 1,
 	.preinit	= nas100d_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= nas100d_map_irq,
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index b571605..ffc060f 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -55,7 +55,6 @@ static int __init nslu2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci __initdata nslu2_pci = {
 	.nr_controllers = 1,
 	.preinit	= nslu2_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= nslu2_map_irq,
diff --git a/arch/arm/mach-ixp4xx/vulcan-pci.c b/arch/arm/mach-ixp4xx/vulcan-pci.c
index 0bc3f34..b9b1c42 100644
--- a/arch/arm/mach-ixp4xx/vulcan-pci.c
+++ b/arch/arm/mach-ixp4xx/vulcan-pci.c
@@ -57,7 +57,6 @@ static int __init vulcan_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci vulcan_pci __initdata = {
 	.nr_controllers	= 1,
 	.preinit	= vulcan_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= ixp4xx_setup,
 	.scan		= ixp4xx_scan_bus,
 	.map_irq	= vulcan_map_irq,
diff --git a/arch/arm/mach-ixp4xx/wg302v2-pci.c b/arch/arm/mach-ixp4xx/wg302v2-pci.c
index f27dfcf..f39a242 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-pci.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-pci.c
@@ -47,7 +47,6 @@ static int __init wg302v2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 struct hw_pci wg302v2_pci __initdata = {
 	.nr_controllers = 1,
 	.preinit =        wg302v2_pci_preinit,
-	.swizzle =        pci_std_swizzle,
 	.setup =          ixp4xx_setup,
 	.scan =           ixp4xx_scan_bus,
 	.map_irq =        wg302v2_map_irq,
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
index f56a011..b1034b0 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-kirkwood/pcie.c
@@ -254,7 +254,6 @@ static int __init kirkwood_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 }
 
 static struct hw_pci kirkwood_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.setup		= kirkwood_pcie_setup,
 	.scan		= kirkwood_pcie_scan_bus,
 	.map_irq	= kirkwood_pcie_map_irq,
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index acc7014..f2235e8 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -306,7 +306,6 @@ static struct hw_pci ks8695_pci __initdata = {
 	.setup		= ks8695_pci_setup,
 	.scan		= ks8695_pci_scan_bus,
 	.postinit	= NULL,
-	.swizzle	= pci_std_swizzle,
 	.map_irq	= NULL,
 };
 
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index df3e380..53f2fb5 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -271,7 +271,6 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
 static struct hw_pci mv78xx0_pci __initdata = {
 	.nr_controllers	= 8,
 	.preinit	= mv78xx0_pcie_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= mv78xx0_pcie_setup,
 	.scan		= mv78xx0_pcie_scan_bus,
 	.map_irq	= mv78xx0_pcie_map_irq,
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index e52108c..49a3fd6 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -265,7 +265,6 @@ static int __init db88f5281_pci_map_irq(const struct pci_dev *dev, u8 slot,
 static struct hw_pci db88f5281_pci __initdata = {
 	.nr_controllers	= 2,
 	.preinit	= db88f5281_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= db88f5281_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index c3ed15b..8c06cca 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -86,7 +86,6 @@ static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci dns323_pci __initdata = {
 	.nr_controllers = 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= dns323_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 47587b8..1e458ef 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -138,7 +138,6 @@ static int __init kurobox_pro_pci_map_irq(const struct pci_dev *dev, u8 slot,
 
 static struct hw_pci kurobox_pro_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= kurobox_pro_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
index 65faaa3..1c16d04 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion5x/mss2-setup.c
@@ -89,7 +89,6 @@ static int __init mss2_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci mss2_pci __initdata = {
 	.nr_controllers = 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= mss2_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index 292038f..78a6a11 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -149,7 +149,6 @@ rd88f5181l_fxo_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci rd88f5181l_fxo_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= rd88f5181l_fxo_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index c44eaba..2f5dc54 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -161,7 +161,6 @@ rd88f5181l_ge_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci rd88f5181l_ge_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= rd88f5181l_ge_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index e3ce617..399130f 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -200,7 +200,6 @@ static int __init rd88f5182_pci_map_irq(const struct pci_dev *dev, u8 slot,
 static struct hw_pci rd88f5182_pci __initdata = {
 	.nr_controllers	= 2,
 	.preinit	= rd88f5182_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= rd88f5182_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 2c5fab0..e91bf0b 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -102,7 +102,6 @@ static void __init rd88f6183ap_ge_init(void)
 
 static struct hw_pci rd88f6183ap_ge_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= orion5x_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
index 632a861..90e571d 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
@@ -122,7 +122,6 @@ static int __init tsp2_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static struct hw_pci tsp2_pci __initdata = {
 	.nr_controllers = 2,
 	.preinit        = tsp2_pci_preinit,
-	.swizzle        = pci_std_swizzle,
 	.setup          = orion5x_pci_sys_setup,
 	.scan           = orion5x_pci_sys_scan_bus,
 	.map_irq        = tsp2_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
index 5d64087..b184f68 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion5x/ts209-setup.c
@@ -170,7 +170,6 @@ static int __init qnap_ts209_pci_map_irq(const struct pci_dev *dev, u8 slot,
 static struct hw_pci qnap_ts209_pci __initdata = {
 	.nr_controllers	= 2,
 	.preinit	= qnap_ts209_pci_preinit,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= qnap_ts209_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
index 4e6ff75..a5c2e64 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion5x/ts409-setup.c
@@ -140,7 +140,6 @@ static int __init qnap_ts409_pci_map_irq(const struct pci_dev *dev, u8 slot,
 
 static struct hw_pci qnap_ts409_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= qnap_ts409_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 078c03f..754c12b 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -155,7 +155,6 @@ static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
 
 static struct hw_pci wnr854t_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= wnr854t_pci_map_irq,
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index 46a9778..45c2125 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -243,7 +243,6 @@ static int __init wrt350n_v2_pci_map_irq(const struct pci_dev *dev, u8 slot,
 
 static struct hw_pci wrt350n_v2_pci __initdata = {
 	.nr_controllers	= 2,
-	.swizzle	= pci_std_swizzle,
 	.setup		= orion5x_pci_sys_setup,
 	.scan		= orion5x_pci_sys_scan_bus,
 	.map_irq	= wrt350n_v2_pci_map_irq,
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index ebd9259..f83f04a 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -181,7 +181,6 @@ static void cmx2xx_pci_preinit(void)
 }
 
 static struct hw_pci cmx2xx_pci __initdata = {
-	.swizzle	= pci_std_swizzle,
 	.map_irq	= cmx2xx_pci_map_irq,
 	.nr_controllers	= 1,
 	.setup		= it8152_pci_setup,
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index 7cb79a0..f7fa937 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -29,7 +29,6 @@ extern void __init via82c505_preinit(void);
 
 static struct hw_pci shark_pci __initdata = {
 	.setup		= via82c505_setup,
-	.swizzle	= pci_std_swizzle,
 	.map_irq	= shark_map_irq,
 	.nr_controllers = 1,
 	.scan		= via82c505_scan_bus,
diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index 54a816f..0e09137 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -475,7 +475,6 @@ static struct hw_pci tegra_pcie_hw __initdata = {
 	.nr_controllers	= 2,
 	.setup		= tegra_pcie_setup,
 	.scan		= tegra_pcie_scan_bus,
-	.swizzle	= pci_std_swizzle,
 	.map_irq	= tegra_pcie_map_irq,
 };
 
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 24dd4b1..80a93ff 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -345,7 +345,6 @@ static int __init versatile_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 }
 
 static struct hw_pci versatile_pci __initdata = {
-	.swizzle		= pci_std_swizzle,
 	.map_irq		= versatile_map_irq,
 	.nr_controllers		= 1,
 	.setup			= pci_versatile_setup,
-- 
1.7.4.4
