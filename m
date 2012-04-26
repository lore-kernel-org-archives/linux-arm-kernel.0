From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Apr 2012 11:18:37 +0100
Subject: [PATCH 6/8] ARM: PCI: provide a default bus scan implementation
In-Reply-To: <20120426101626.GE24211@n2100.arm.linux.org.uk>
References: <20120426101626.GE24211@n2100.arm.linux.org.uk>
Message-ID: <E1SNLmX-000817-1y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most PCI implementations perform simple root bus scanning.  Rather than
having each group of platforms provide a duplicated bus scan function,
provide the PCI configuration ops structure via the hw_pci structure,
and call the root bus scanning function from core ARM PCI code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/it8152.c                      |    7 +------
 arch/arm/common/via82c505.c                   |   11 +----------
 arch/arm/include/asm/hardware/it8152.h        |    2 +-
 arch/arm/include/asm/mach/pci.h               |   10 ++++++----
 arch/arm/kernel/bios32.c                      |    6 +++++-
 arch/arm/mach-cns3xxx/pcie.c                  |   10 ++--------
 arch/arm/mach-footbridge/cats-pci.c           |    2 +-
 arch/arm/mach-footbridge/dc21285.c            |    7 +------
 arch/arm/mach-footbridge/ebsa285-pci.c        |    2 +-
 arch/arm/mach-footbridge/netwinder-pci.c      |    2 +-
 arch/arm/mach-footbridge/personal-pci.c       |    2 +-
 arch/arm/mach-integrator/pci.c                |    2 +-
 arch/arm/mach-integrator/pci_v3.c             |    8 +-------
 arch/arm/mach-iop32x/em7210.c                 |    2 +-
 arch/arm/mach-iop32x/glantank.c               |    2 +-
 arch/arm/mach-iop32x/iq31244.c                |    4 ++--
 arch/arm/mach-iop32x/iq80321.c                |    2 +-
 arch/arm/mach-iop32x/n2100.c                  |    2 +-
 arch/arm/mach-iop33x/iq80331.c                |    2 +-
 arch/arm/mach-iop33x/iq80332.c                |    2 +-
 arch/arm/mach-ixp2000/enp2611.c               |    9 +--------
 arch/arm/mach-ixp2000/include/mach/platform.h |    2 +-
 arch/arm/mach-ixp2000/ixdp2400.c              |    2 +-
 arch/arm/mach-ixp2000/ixdp2800.c              |    2 +-
 arch/arm/mach-ixp2000/ixdp2x01.c              |    2 +-
 arch/arm/mach-ixp2000/pci.c                   |    8 +-------
 arch/arm/mach-ixp23xx/include/mach/platform.h |    2 +-
 arch/arm/mach-ixp23xx/ixdp2351.c              |    2 +-
 arch/arm/mach-ixp23xx/pci.c                   |    6 ------
 arch/arm/mach-ixp23xx/roadrunner.c            |    2 +-
 arch/arm/mach-ixp4xx/avila-pci.c              |    2 +-
 arch/arm/mach-ixp4xx/common-pci.c             |    6 ------
 arch/arm/mach-ixp4xx/coyote-pci.c             |    2 +-
 arch/arm/mach-ixp4xx/dsmg600-pci.c            |    2 +-
 arch/arm/mach-ixp4xx/fsg-pci.c                |    2 +-
 arch/arm/mach-ixp4xx/gateway7001-pci.c        |    2 +-
 arch/arm/mach-ixp4xx/goramo_mlr.c             |    2 +-
 arch/arm/mach-ixp4xx/gtwx5715-pci.c           |    2 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h  |    2 +-
 arch/arm/mach-ixp4xx/ixdp425-pci.c            |    2 +-
 arch/arm/mach-ixp4xx/ixdpg425-pci.c           |    2 +-
 arch/arm/mach-ixp4xx/miccpt-pci.c             |    2 +-
 arch/arm/mach-ixp4xx/nas100d-pci.c            |    2 +-
 arch/arm/mach-ixp4xx/nslu2-pci.c              |    2 +-
 arch/arm/mach-ixp4xx/vulcan-pci.c             |    2 +-
 arch/arm/mach-ixp4xx/wg302v2-pci.c            |    2 +-
 arch/arm/mach-ks8695/pci.c                    |    8 +-------
 arch/arm/mach-pxa/cm-x2xx-pci.c               |    2 +-
 arch/arm/mach-sa1100/pci-nanoengine.c         |    8 +-------
 arch/arm/mach-shark/pci.c                     |    2 +-
 arch/arm/mach-versatile/pci.c                 |    8 +-------
 arch/arm/plat-iop/pci.c                       |    8 +-------
 52 files changed, 61 insertions(+), 135 deletions(-)

diff --git a/arch/arm/common/it8152.c b/arch/arm/common/it8152.c
index dcb1349..c4110d1 100644
--- a/arch/arm/common/it8152.c
+++ b/arch/arm/common/it8152.c
@@ -222,7 +222,7 @@ static int it8152_pci_write_config(struct pci_bus *bus,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops it8152_ops = {
+struct pci_ops it8152_ops = {
 	.read = it8152_pci_read_config,
 	.write = it8152_pci_write_config,
 };
@@ -346,9 +346,4 @@ void pcibios_set_master(struct pci_dev *dev)
 }
 
 
-struct pci_bus * __init it8152_pci_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, nr, &it8152_ops, sys, &sys->resources);
-}
-
 EXPORT_SYMBOL(dma_set_coherent_mask);
diff --git a/arch/arm/common/via82c505.c b/arch/arm/common/via82c505.c
index 1171a50..6cb362e 100644
--- a/arch/arm/common/via82c505.c
+++ b/arch/arm/common/via82c505.c
@@ -51,7 +51,7 @@ via82c505_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops via82c505_ops = {
+struct pci_ops via82c505_ops = {
 	.read	= via82c505_read_config,
 	.write	= via82c505_write_config,
 };
@@ -81,12 +81,3 @@ int __init via82c505_setup(int nr, struct pci_sys_data *sys)
 {
 	return (nr == 0);
 }
-
-struct pci_bus * __init via82c505_scan_bus(int nr, struct pci_sys_data *sysdata)
-{
-	if (nr == 0)
-		return pci_scan_root_bus(NULL, 0, &via82c505_ops, sysdata,
-					 &sysdata->resources);
-
-	return NULL;
-}
diff --git a/arch/arm/include/asm/hardware/it8152.h b/arch/arm/include/asm/hardware/it8152.h
index 73f84fa..d36a73d 100644
--- a/arch/arm/include/asm/hardware/it8152.h
+++ b/arch/arm/include/asm/hardware/it8152.h
@@ -110,6 +110,6 @@ extern void it8152_irq_demux(unsigned int irq, struct irq_desc *desc);
 extern void it8152_init_irq(void);
 extern int it8152_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
 extern int it8152_pci_setup(int nr, struct pci_sys_data *sys);
-extern struct pci_bus *it8152_pci_scan_bus(int nr, struct pci_sys_data *sys);
+extern struct pci_ops it8152_ops;
 
 #endif /* __ASM_HARDWARE_IT8152_H */
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index ff8146a..b4b94b4 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -12,6 +12,7 @@
 #define __ASM_MACH_PCI_H
 
 struct pci_sys_data;
+struct pci_ops;
 struct pci_bus;
 
 struct hw_pci {
@@ -19,6 +20,7 @@ struct hw_pci {
 	int		domain;
 #endif
 	struct list_head buses;
+	struct pci_ops	*ops;
 	int		nr_controllers;
 	int		(*setup)(int nr, struct pci_sys_data *);
 	struct pci_bus *(*scan)(int nr, struct pci_sys_data *);
@@ -56,22 +58,22 @@ void pci_common_init(struct hw_pci *);
 /*
  * PCI controllers
  */
+extern struct pci_ops iop3xx_ops;
 extern int iop3xx_pci_setup(int nr, struct pci_sys_data *);
-extern struct pci_bus *iop3xx_pci_scan_bus(int nr, struct pci_sys_data *);
 extern void iop3xx_pci_preinit(void);
 extern void iop3xx_pci_preinit_cond(void);
 
+extern struct pci_ops dc21285_ops;
 extern int dc21285_setup(int nr, struct pci_sys_data *);
-extern struct pci_bus *dc21285_scan_bus(int nr, struct pci_sys_data *);
 extern void dc21285_preinit(void);
 extern void dc21285_postinit(void);
 
+extern struct pci_ops via82c505_ops;
 extern int via82c505_setup(int nr, struct pci_sys_data *);
-extern struct pci_bus *via82c505_scan_bus(int nr, struct pci_sys_data *);
 extern void via82c505_init(void *sysdata);
 
+extern struct pci_ops pci_v3_ops;
 extern int pci_v3_setup(int nr, struct pci_sys_data *);
-extern struct pci_bus *pci_v3_scan_bus(int nr, struct pci_sys_data *);
 extern void pci_v3_preinit(void);
 extern void pci_v3_postinit(void);
 
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index d22e351..00a506f 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -452,7 +452,11 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 					 &iomem_resource, sys->mem_offset);
 			}
 
-			sys->bus = hw->scan(nr, sys);
+			if (hw->scan)
+				sys->bus = hw->scan(nr, sys);
+			else
+				sys->bus = pci_scan_root_bus(NULL, sys->busnr,
+						hw->ops, sys, &sys->resources);
 
 			if (!sys->bus)
 				panic("PCI: unable to scan bus!");
diff --git a/arch/arm/mach-cns3xxx/pcie.c b/arch/arm/mach-cns3xxx/pcie.c
index 62f861b..3113283 100644
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -166,12 +166,6 @@ static struct pci_ops cns3xxx_pcie_ops = {
 	.write = cns3xxx_pci_write_config,
 };
 
-static struct pci_bus *cns3xxx_pci_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &cns3xxx_pcie_ops, sys,
-				 &sys->resources);
-}
-
 static int cns3xxx_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct cns3xxx_pcie *cnspci = pdev_to_cnspci(dev);
@@ -222,8 +216,8 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 		.hw_pci = {
 			.domain = 0,
 			.nr_controllers = 1,
+			.ops = &cns3xxx_pcie_ops,
 			.setup = cns3xxx_pci_setup,
-			.scan = cns3xxx_pci_scan_bus,
 			.map_irq = cns3xxx_pcie_map_irq,
 		},
 	},
@@ -264,8 +258,8 @@ static struct cns3xxx_pcie cns3xxx_pcie[] = {
 		.hw_pci = {
 			.domain = 1,
 			.nr_controllers = 1,
+			.ops = &cns3xxx_pcie_ops,
 			.setup = cns3xxx_pci_setup,
-			.scan = cns3xxx_pci_scan_bus,
 			.map_irq = cns3xxx_pcie_map_irq,
 		},
 	},
diff --git a/arch/arm/mach-footbridge/cats-pci.c b/arch/arm/mach-footbridge/cats-pci.c
index dc13c87..5cec256 100644
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ b/arch/arm/mach-footbridge/cats-pci.c
@@ -47,8 +47,8 @@ static struct hw_pci cats_pci __initdata = {
 	.swizzle		= cats_no_swizzle,
 	.map_irq		= cats_map_irq,
 	.nr_controllers		= 1,
+	.ops			= &dc21285_ops,
 	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
 	.preinit		= dc21285_preinit,
 	.postinit		= dc21285_postinit,
 };
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index e17e11d..9d62e33 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -129,7 +129,7 @@ dc21285_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops dc21285_ops = {
+struct pci_ops dc21285_ops = {
 	.read	= dc21285_read_config,
 	.write	= dc21285_write_config,
 };
@@ -284,11 +284,6 @@ int __init dc21285_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-struct pci_bus * __init dc21285_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, 0, &dc21285_ops, sys, &sys->resources);
-}
-
 #define dc21285_request_irq(_a, _b, _c, _d, _e) \
 	WARN_ON(request_irq(_a, _b, _c, _d, _e) < 0)
 
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
index a5bed6e..fd12d8a 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -31,8 +31,8 @@ static int __init ebsa285_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static struct hw_pci ebsa285_pci __initdata = {
 	.map_irq		= ebsa285_map_irq,
 	.nr_controllers		= 1,
+	.ops			= &dc21285_ops,
 	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
 	.preinit		= dc21285_preinit,
 	.postinit		= dc21285_postinit,
 };
diff --git a/arch/arm/mach-footbridge/netwinder-pci.c b/arch/arm/mach-footbridge/netwinder-pci.c
index 3f66e89..0fba513 100644
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ b/arch/arm/mach-footbridge/netwinder-pci.c
@@ -45,8 +45,8 @@ static int __init netwinder_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static struct hw_pci netwinder_pci __initdata = {
 	.map_irq		= netwinder_map_irq,
 	.nr_controllers		= 1,
+	.ops			= &dc21285_ops,
 	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
 	.preinit		= dc21285_preinit,
 	.postinit		= dc21285_postinit,
 };
diff --git a/arch/arm/mach-footbridge/personal-pci.c b/arch/arm/mach-footbridge/personal-pci.c
index aeb651d..5c9ee54 100644
--- a/arch/arm/mach-footbridge/personal-pci.c
+++ b/arch/arm/mach-footbridge/personal-pci.c
@@ -41,8 +41,8 @@ static int __init personal_server_map_irq(const struct pci_dev *dev, u8 slot,
 static struct hw_pci personal_server_pci __initdata = {
 	.map_irq		= personal_server_map_irq,
 	.nr_controllers		= 1,
+	.ops			= &dc21285_ops,
 	.setup			= dc21285_setup,
-	.scan			= dc21285_scan_bus,
 	.preinit		= dc21285_preinit,
 	.postinit		= dc21285_postinit,
 };
diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 5715c63..40f4b4f 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -98,7 +98,7 @@ static struct hw_pci integrator_pci __initdata = {
 	.map_irq		= integrator_map_irq,
 	.setup			= pci_v3_setup,
 	.nr_controllers		= 1,
-	.scan			= pci_v3_scan_bus,
+	.ops			= &pci_v3_ops,
 	.preinit		= pci_v3_preinit,
 	.postinit		= pci_v3_postinit,
 };
diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index 67e6f9a..b866880 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -340,7 +340,7 @@ static int v3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops pci_v3_ops = {
+struct pci_ops pci_v3_ops = {
 	.read	= v3_read_config,
 	.write	= v3_write_config,
 };
@@ -488,12 +488,6 @@ int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
 	return ret;
 }
 
-struct pci_bus * __init pci_v3_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &pci_v3_ops, sys,
-				 &sys->resources);
-}
-
 /*
  * V3_LB_BASE? - local bus address
  * V3_LB_MAP?  - pci bus address
diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 4915013..9f369f0 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -104,9 +104,9 @@ em7210_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci em7210_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= em7210_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
index 456a414..c15a100 100644
--- a/arch/arm/mach-iop32x/glantank.c
+++ b/arch/arm/mach-iop32x/glantank.c
@@ -97,9 +97,9 @@ glantank_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci glantank_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= glantank_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
index b795e6b..ddd1c7e 100644
--- a/arch/arm/mach-iop32x/iq31244.c
+++ b/arch/arm/mach-iop32x/iq31244.c
@@ -131,9 +131,9 @@ ep80219_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci ep80219_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= ep80219_pci_map_irq,
 };
 
@@ -166,9 +166,9 @@ iq31244_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci iq31244_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= iq31244_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
index ac6d962..bf155e6 100644
--- a/arch/arm/mach-iop32x/iq80321.c
+++ b/arch/arm/mach-iop32x/iq80321.c
@@ -102,9 +102,9 @@ iq80321_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci iq80321_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= iq80321_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index adf257a..5a7ae91 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -115,9 +115,9 @@ n2100_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci n2100_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= n2100_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
index 3298a8a..e74a7de 100644
--- a/arch/arm/mach-iop33x/iq80331.c
+++ b/arch/arm/mach-iop33x/iq80331.c
@@ -85,9 +85,9 @@ iq80331_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci iq80331_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= iq80331_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
index 87b0e9d..e2f5bee 100644
--- a/arch/arm/mach-iop33x/iq80332.c
+++ b/arch/arm/mach-iop33x/iq80332.c
@@ -85,9 +85,9 @@ iq80332_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci iq80332_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &iop3xx_ops,
 	.setup		= iop3xx_pci_setup,
 	.preinit	= iop3xx_pci_preinit_cond,
-	.scan		= iop3xx_pci_scan_bus,
 	.map_irq	= iq80332_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp2000/enp2611.c b/arch/arm/mach-ixp2000/enp2611.c
index 4867f40..73df2f6 100644
--- a/arch/arm/mach-ixp2000/enp2611.c
+++ b/arch/arm/mach-ixp2000/enp2611.c
@@ -141,13 +141,6 @@ static struct pci_ops enp2611_pci_ops = {
 	.write  = enp2611_pci_write_config
 };
 
-static struct pci_bus * __init enp2611_pci_scan_bus(int nr,
-						struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &enp2611_pci_ops, sys,
-				 &sys->resources);
-}
-
 static int __init enp2611_pci_map_irq(const struct pci_dev *dev, u8 slot,
 	u8 pin)
 {
@@ -180,9 +173,9 @@ static int __init enp2611_pci_map_irq(const struct pci_dev *dev, u8 slot,
 
 struct hw_pci enp2611_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &enp2611_pci_ops,
 	.setup		= enp2611_pci_setup,
 	.preinit	= enp2611_pci_preinit,
-	.scan		= enp2611_pci_scan_bus,
 	.map_irq	= enp2611_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp2000/include/mach/platform.h b/arch/arm/mach-ixp2000/include/mach/platform.h
index bb0f8dc..6b500c0 100644
--- a/arch/arm/mach-ixp2000/include/mach/platform.h
+++ b/arch/arm/mach-ixp2000/include/mach/platform.h
@@ -127,10 +127,10 @@ unsigned long ixp2000_gettimeoffset(void);
 
 struct pci_sys_data;
 
+extern struct pci_ops ixp2000_pci_ops;
 u32 *ixp2000_pci_config_addr(unsigned int bus, unsigned int devfn, int where);
 void ixp2000_pci_preinit(void);
 int ixp2000_pci_setup(int, struct pci_sys_data*);
-struct pci_bus* ixp2000_pci_scan_bus(int, struct pci_sys_data*);
 int ixp2000_pci_read_config(struct pci_bus*, unsigned int, int, int, u32 *);
 int ixp2000_pci_write_config(struct pci_bus*, unsigned int, int, int, u32);
 
diff --git a/arch/arm/mach-ixp2000/ixdp2400.c b/arch/arm/mach-ixp2000/ixdp2400.c
index 915ad49..4ec4480 100644
--- a/arch/arm/mach-ixp2000/ixdp2400.c
+++ b/arch/arm/mach-ixp2000/ixdp2400.c
@@ -146,10 +146,10 @@ static void ixdp2400_pci_postinit(void)
 
 static struct hw_pci ixdp2400_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp2000_pci_ops,
 	.setup		= ixdp2400_pci_setup,
 	.preinit	= ixdp2400_pci_preinit,
 	.postinit	= ixdp2400_pci_postinit,
-	.scan		= ixp2000_pci_scan_bus,
 	.map_irq	= ixdp2400_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp2000/ixdp2800.c b/arch/arm/mach-ixp2000/ixdp2800.c
index a9f1819..44378c3 100644
--- a/arch/arm/mach-ixp2000/ixdp2800.c
+++ b/arch/arm/mach-ixp2000/ixdp2800.c
@@ -246,10 +246,10 @@ static void __init ixdp2800_pci_postinit(void)
 
 struct __initdata hw_pci ixdp2800_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp2000_pci_ops,
 	.setup		= ixdp2800_pci_setup,
 	.preinit	= ixdp2800_pci_preinit,
 	.postinit	= ixdp2800_pci_postinit,
-	.scan		= ixp2000_pci_scan_bus,
 	.map_irq	= ixdp2800_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 5196c39..af8b801 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -327,9 +327,9 @@ static int ixdp2x01_pci_setup(int nr, struct pci_sys_data *sys)
 
 struct hw_pci ixdp2x01_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp2000_pci_ops,
 	.setup		= ixdp2x01_pci_setup,
 	.preinit	= ixdp2x01_pci_preinit,
-	.scan		= ixp2000_pci_scan_bus,
 	.map_irq	= ixdp2x01_pci_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
index 9c02de9..d706838 100644
--- a/arch/arm/mach-ixp2000/pci.c
+++ b/arch/arm/mach-ixp2000/pci.c
@@ -124,17 +124,11 @@ int ixp2000_pci_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 }
 
 
-static struct pci_ops ixp2000_pci_ops = {
+struct pci_ops ixp2000_pci_ops = {
 	.read	= ixp2000_pci_read_config,
 	.write	= ixp2000_pci_write_config
 };
 
-struct pci_bus *ixp2000_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
-{
-	return pci_scan_root_bus(NULL, sysdata->busnr, &ixp2000_pci_ops,
-				 sysdata, &sysdata->resources);
-}
-
 
 int ixp2000_pci_abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
diff --git a/arch/arm/mach-ixp23xx/include/mach/platform.h b/arch/arm/mach-ixp23xx/include/mach/platform.h
index 50de558..798d8b4 100644
--- a/arch/arm/mach-ixp23xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp23xx/include/mach/platform.h
@@ -37,7 +37,7 @@ void ixp23xx_sys_init(void);
 void ixp23xx_restart(char, const char *);
 int ixp23xx_pci_setup(int, struct pci_sys_data *);
 void ixp23xx_pci_preinit(void);
-struct pci_bus *ixp23xx_pci_scan_bus(int, struct pci_sys_data*);
+extern struct pci_ops ixp23xx_pci_ops;
 void ixp23xx_pci_slave_init(void);
 
 extern struct sys_timer ixp23xx_timer;
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index b0e07db..8b48e32 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -251,9 +251,9 @@ static int __init ixdp2351_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci ixdp2351_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp23xx_pci_ops,
 	.preinit	= ixp23xx_pci_preinit,
 	.setup		= ixp23xx_pci_setup,
-	.scan		= ixp23xx_pci_scan_bus,
 	.map_irq	= ixdp2351_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp23xx/pci.c b/arch/arm/mach-ixp23xx/pci.c
index 911f5a5..9211506 100644
--- a/arch/arm/mach-ixp23xx/pci.c
+++ b/arch/arm/mach-ixp23xx/pci.c
@@ -140,12 +140,6 @@ struct pci_ops ixp23xx_pci_ops = {
 	.write	= ixp23xx_pci_write_config,
 };
 
-struct pci_bus *ixp23xx_pci_scan_bus(int nr, struct pci_sys_data *sysdata)
-{
-	return pci_scan_root_bus(NULL, sysdata->busnr, &ixp23xx_pci_ops,
-				 sysdata, &sysdata->resources);
-}
-
 int ixp23xx_pci_abort_handler(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	volatile unsigned long temp;
diff --git a/arch/arm/mach-ixp23xx/roadrunner.c b/arch/arm/mach-ixp23xx/roadrunner.c
index eaaa3fa..8c0e5de 100644
--- a/arch/arm/mach-ixp23xx/roadrunner.c
+++ b/arch/arm/mach-ixp23xx/roadrunner.c
@@ -118,9 +118,9 @@ static void __init roadrunner_pci_preinit(void)
 
 static struct hw_pci roadrunner_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp23xx_pci_ops,
 	.preinit	= roadrunner_pci_preinit,
 	.setup		= ixp23xx_pci_setup,
-	.scan		= ixp23xx_pci_scan_bus,
 	.map_irq	= roadrunner_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/avila-pci.c b/arch/arm/mach-ixp4xx/avila-pci.c
index 89d1f35..548c7d4 100644
--- a/arch/arm/mach-ixp4xx/avila-pci.c
+++ b/arch/arm/mach-ixp4xx/avila-pci.c
@@ -65,9 +65,9 @@ static int __init avila_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci avila_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= avila_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= avila_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index d5719eb..1694f01 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -480,12 +480,6 @@ int ixp4xx_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-struct pci_bus * __devinit ixp4xx_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &ixp4xx_ops, sys,
-				 &sys->resources);
-}
-
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
 	if (mask >= SZ_64M - 1)
diff --git a/arch/arm/mach-ixp4xx/coyote-pci.c b/arch/arm/mach-ixp4xx/coyote-pci.c
index d876a4f..5d14ce2 100644
--- a/arch/arm/mach-ixp4xx/coyote-pci.c
+++ b/arch/arm/mach-ixp4xx/coyote-pci.c
@@ -48,9 +48,9 @@ static int __init coyote_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci coyote_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit =        coyote_pci_preinit,
 	.setup =          ixp4xx_setup,
-	.scan =           ixp4xx_scan_bus,
 	.map_irq =        coyote_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-pci.c b/arch/arm/mach-ixp4xx/dsmg600-pci.c
index 6648597..8dca769 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-pci.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-pci.c
@@ -62,9 +62,9 @@ static int __init dsmg600_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci __initdata dsmg600_pci = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= dsmg600_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= dsmg600_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/fsg-pci.c b/arch/arm/mach-ixp4xx/fsg-pci.c
index 528e4af..fd4a862 100644
--- a/arch/arm/mach-ixp4xx/fsg-pci.c
+++ b/arch/arm/mach-ixp4xx/fsg-pci.c
@@ -59,9 +59,9 @@ static int __init fsg_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci fsg_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit =	  fsg_pci_preinit,
 	.setup =	  ixp4xx_setup,
-	.scan =		  ixp4xx_scan_bus,
 	.map_irq =	  fsg_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/gateway7001-pci.c b/arch/arm/mach-ixp4xx/gateway7001-pci.c
index 1d1134b..d9d6cc0 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-pci.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-pci.c
@@ -47,9 +47,9 @@ static int __init gateway7001_map_irq(const struct pci_dev *dev, u8 slot,
 
 struct hw_pci gateway7001_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit =        gateway7001_pci_preinit,
 	.setup =          ixp4xx_setup,
-	.scan =           ixp4xx_scan_bus,
 	.map_irq =        gateway7001_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index c97a1a8..b800a03 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -473,10 +473,10 @@ static int __init gmlr_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 static struct hw_pci gmlr_hw_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= gmlr_pci_preinit,
 	.postinit	= gmlr_pci_postinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= gmlr_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-pci.c b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
index 4bd8770..551d114 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-pci.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-pci.c
@@ -67,9 +67,9 @@ static int __init gtwx5715_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci gtwx5715_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit =        gtwx5715_pci_preinit,
 	.setup =          ixp4xx_setup,
-	.scan =           ixp4xx_scan_bus,
 	.map_irq =        gtwx5715_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index b66bedc..5bce94a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -130,7 +130,7 @@ extern void ixp4xx_restart(char, const char *);
 extern void ixp4xx_pci_preinit(void);
 struct pci_sys_data;
 extern int ixp4xx_setup(int nr, struct pci_sys_data *sys);
-extern struct pci_bus *ixp4xx_scan_bus(int nr, struct pci_sys_data *sys);
+extern struct pci_ops ixp4xx_ops;
 
 /*
  * GPIO-functions
diff --git a/arch/arm/mach-ixp4xx/ixdp425-pci.c b/arch/arm/mach-ixp4xx/ixdp425-pci.c
index 3e1a229..318424d 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-pci.c
@@ -60,9 +60,9 @@ static int __init ixdp425_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci ixdp425_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= ixdp425_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= ixdp425_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/ixdpg425-pci.c b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
index 5c70e92..1f8717b 100644
--- a/arch/arm/mach-ixp4xx/ixdpg425-pci.c
+++ b/arch/arm/mach-ixp4xx/ixdpg425-pci.c
@@ -42,9 +42,9 @@ static int __init ixdpg425_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci ixdpg425_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit =        ixdpg425_pci_preinit,
 	.setup =          ixp4xx_setup,
-	.scan =           ixp4xx_scan_bus,
 	.map_irq =        ixdpg425_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/miccpt-pci.c b/arch/arm/mach-ixp4xx/miccpt-pci.c
index 8d4ba71..d114ccd 100644
--- a/arch/arm/mach-ixp4xx/miccpt-pci.c
+++ b/arch/arm/mach-ixp4xx/miccpt-pci.c
@@ -61,9 +61,9 @@ static int __init miccpt_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci miccpt_pci __initdata = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= miccpt_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= miccpt_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/nas100d-pci.c b/arch/arm/mach-ixp4xx/nas100d-pci.c
index ba1ad20..8f0eba0 100644
--- a/arch/arm/mach-ixp4xx/nas100d-pci.c
+++ b/arch/arm/mach-ixp4xx/nas100d-pci.c
@@ -58,9 +58,9 @@ static int __init nas100d_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci __initdata nas100d_pci = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= nas100d_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= nas100d_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/nslu2-pci.c b/arch/arm/mach-ixp4xx/nslu2-pci.c
index ffc060f..032defe 100644
--- a/arch/arm/mach-ixp4xx/nslu2-pci.c
+++ b/arch/arm/mach-ixp4xx/nslu2-pci.c
@@ -54,9 +54,9 @@ static int __init nslu2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci __initdata nslu2_pci = {
 	.nr_controllers = 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= nslu2_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= nslu2_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/vulcan-pci.c b/arch/arm/mach-ixp4xx/vulcan-pci.c
index b9b1c42..a4220fa 100644
--- a/arch/arm/mach-ixp4xx/vulcan-pci.c
+++ b/arch/arm/mach-ixp4xx/vulcan-pci.c
@@ -56,9 +56,9 @@ static int __init vulcan_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci vulcan_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ixp4xx_ops,
 	.preinit	= vulcan_pci_preinit,
 	.setup		= ixp4xx_setup,
-	.scan		= ixp4xx_scan_bus,
 	.map_irq	= vulcan_map_irq,
 };
 
diff --git a/arch/arm/mach-ixp4xx/wg302v2-pci.c b/arch/arm/mach-ixp4xx/wg302v2-pci.c
index f39a242..c92e5b8 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-pci.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-pci.c
@@ -46,9 +46,9 @@ static int __init wg302v2_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 struct hw_pci wg302v2_pci __initdata = {
 	.nr_controllers = 1,
+	.ops = &ixp4xx_ops,
 	.preinit =        wg302v2_pci_preinit,
 	.setup =          ixp4xx_setup,
-	.scan =           ixp4xx_scan_bus,
 	.map_irq =        wg302v2_map_irq,
 };
 
diff --git a/arch/arm/mach-ks8695/pci.c b/arch/arm/mach-ks8695/pci.c
index f2235e8..bb18193 100644
--- a/arch/arm/mach-ks8695/pci.c
+++ b/arch/arm/mach-ks8695/pci.c
@@ -141,12 +141,6 @@ static struct pci_ops ks8695_pci_ops = {
 	.write	= ks8695_pci_writeconfig,
 };
 
-static struct pci_bus* __init ks8695_pci_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &ks8695_pci_ops, sys,
-				 &sys->resources);
-}
-
 static struct resource pci_mem = {
 	.name	= "PCI Memory space",
 	.start	= KS8695_PCIMEM_PA,
@@ -302,9 +296,9 @@ static void ks8695_show_pciregs(void)
 
 static struct hw_pci ks8695_pci __initdata = {
 	.nr_controllers	= 1,
+	.ops		= &ks8695_pci_ops,
 	.preinit	= ks8695_pci_preinit,
 	.setup		= ks8695_pci_setup,
-	.scan		= ks8695_pci_scan_bus,
 	.postinit	= NULL,
 	.map_irq	= NULL,
 };
diff --git a/arch/arm/mach-pxa/cm-x2xx-pci.c b/arch/arm/mach-pxa/cm-x2xx-pci.c
index f83f04a..d8f816c 100644
--- a/arch/arm/mach-pxa/cm-x2xx-pci.c
+++ b/arch/arm/mach-pxa/cm-x2xx-pci.c
@@ -183,8 +183,8 @@ static void cmx2xx_pci_preinit(void)
 static struct hw_pci cmx2xx_pci __initdata = {
 	.map_irq	= cmx2xx_pci_map_irq,
 	.nr_controllers	= 1,
+	.ops		= &it8152_ops,
 	.setup		= it8152_pci_setup,
-	.scan		= it8152_pci_scan_bus,
 	.preinit	= cmx2xx_pci_preinit,
 };
 
diff --git a/arch/arm/mach-sa1100/pci-nanoengine.c b/arch/arm/mach-sa1100/pci-nanoengine.c
index b49108b..ff02e2d 100644
--- a/arch/arm/mach-sa1100/pci-nanoengine.c
+++ b/arch/arm/mach-sa1100/pci-nanoengine.c
@@ -129,12 +129,6 @@ static int __init pci_nanoengine_map_irq(const struct pci_dev *dev, u8 slot,
 	return NANOENGINE_IRQ_GPIO_PCI;
 }
 
-struct pci_bus * __init pci_nanoengine_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &pci_nano_ops, sys,
-				 &sys->resources);
-}
-
 static struct resource pci_io_ports =
 	DEFINE_RES_IO_NAMED(0x400, 0x400, "PCI IO");
 
@@ -274,7 +268,7 @@ int __init pci_nanoengine_setup(int nr, struct pci_sys_data *sys)
 static struct hw_pci nanoengine_pci __initdata = {
 	.map_irq		= pci_nanoengine_map_irq,
 	.nr_controllers		= 1,
-	.scan			= pci_nanoengine_scan_bus,
+	.ops			= &pci_nano_ops,
 	.setup			= pci_nanoengine_setup,
 };
 
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
index f7fa937..9089407 100644
--- a/arch/arm/mach-shark/pci.c
+++ b/arch/arm/mach-shark/pci.c
@@ -31,7 +31,7 @@ static struct hw_pci shark_pci __initdata = {
 	.setup		= via82c505_setup,
 	.map_irq	= shark_map_irq,
 	.nr_controllers = 1,
-	.scan		= via82c505_scan_bus,
+	.ops		= &via82c505_ops,
 	.preinit	= via82c505_preinit,
 };
 
diff --git a/arch/arm/mach-versatile/pci.c b/arch/arm/mach-versatile/pci.c
index 80a93ff..15c6a00 100644
--- a/arch/arm/mach-versatile/pci.c
+++ b/arch/arm/mach-versatile/pci.c
@@ -303,12 +303,6 @@ int __init pci_versatile_setup(int nr, struct pci_sys_data *sys)
 }
 
 
-struct pci_bus * __init pci_versatile_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &pci_versatile_ops, sys,
-				 &sys->resources);
-}
-
 void __init pci_versatile_preinit(void)
 {
 	pcibios_min_io = 0x44000000;
@@ -347,8 +341,8 @@ static int __init versatile_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 static struct hw_pci versatile_pci __initdata = {
 	.map_irq		= versatile_map_irq,
 	.nr_controllers		= 1,
+	.ops			= &pci_versatile_ops,
 	.setup			= pci_versatile_setup,
-	.scan			= pci_versatile_scan_bus,
 	.preinit		= pci_versatile_preinit,
 };
 
diff --git a/arch/arm/plat-iop/pci.c b/arch/arm/plat-iop/pci.c
index 0da4205..8daae9b 100644
--- a/arch/arm/plat-iop/pci.c
+++ b/arch/arm/plat-iop/pci.c
@@ -160,7 +160,7 @@ iop3xx_write_config(struct pci_bus *bus, unsigned int devfn, int where,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static struct pci_ops iop3xx_ops = {
+struct pci_ops iop3xx_ops = {
 	.read	= iop3xx_read_config,
 	.write	= iop3xx_write_config,
 };
@@ -220,12 +220,6 @@ int iop3xx_pci_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-struct pci_bus *iop3xx_pci_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	return pci_scan_root_bus(NULL, sys->busnr, &iop3xx_ops, sys,
-				 &sys->resources);
-}
-
 void __init iop3xx_atu_setup(void)
 {
 	/* BAR 0 ( Disabled ) */
-- 
1.7.4.4
