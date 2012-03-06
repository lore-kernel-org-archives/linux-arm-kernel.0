From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 Mar 2012 15:45:15 -0600
Subject: [PATCH v5 5/7] ARM: ixp4xx: use runtime ioremap hook
In-Reply-To: <1331070317-9598-1-git-send-email-robherring2@gmail.com>
References: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
 <1331070317-9598-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331070317-9598-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert ixp4xx platforms to use run-time ioremap hook instead of the
compile time hook.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/avila-setup.c           |    2 +
 arch/arm/mach-ixp4xx/common.c                |   33 ++++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/coyote-setup.c          |    2 +
 arch/arm/mach-ixp4xx/dsmg600-setup.c         |    1 +
 arch/arm/mach-ixp4xx/fsg-setup.c             |    1 +
 arch/arm/mach-ixp4xx/gateway7001-setup.c     |    1 +
 arch/arm/mach-ixp4xx/goramo_mlr.c            |    1 +
 arch/arm/mach-ixp4xx/gtwx5715-setup.c        |    1 +
 arch/arm/mach-ixp4xx/include/mach/io.h       |   18 --------------
 arch/arm/mach-ixp4xx/include/mach/platform.h |    1 +
 arch/arm/mach-ixp4xx/ixdp425-setup.c         |    4 +++
 arch/arm/mach-ixp4xx/nas100d-setup.c         |    1 +
 arch/arm/mach-ixp4xx/nslu2-setup.c           |    1 +
 arch/arm/mach-ixp4xx/omixp-setup.c           |    3 ++
 arch/arm/mach-ixp4xx/vulcan-setup.c          |    1 +
 arch/arm/mach-ixp4xx/wg302v2-setup.c         |    1 +
 16 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
index a7277ad..90e42e9 100644
--- a/arch/arm/mach-ixp4xx/avila-setup.c
+++ b/arch/arm/mach-ixp4xx/avila-setup.c
@@ -165,6 +165,7 @@ static void __init avila_init(void)
 MACHINE_START(AVILA, "Gateworks Avila Network Platform")
 	/* Maintainer: Deepak Saxena <dsaxena@plexity.net> */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
@@ -184,6 +185,7 @@ MACHINE_END
 MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
 	/* Maintainer: Tom Billman <kernel@giantshoulderinc.com> */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index a6329a0..c60e7b8 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -31,6 +31,7 @@
 
 #include <mach/udc.h>
 #include <mach/hardware.h>
+#include <mach/io.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -517,3 +518,35 @@ void ixp4xx_restart(char mode, const char *cmd)
 		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
 	}
 }
+
+#ifdef CONFIG_IXP4XX_INDIRECT_PCI
+/*
+ * In the case of using indirect PCI, we simply return the actual PCI
+ * address and our read/write implementation use that to drive the
+ * access registers. If something outside of PCI is ioremap'd, we
+ * fallback to the default.
+ */
+
+static void __iomem *ixp4xx_ioremap_caller(unsigned long addr, size_t size,
+					   unsigned int mtype, void *caller)
+{
+	if (!is_pci_memory(addr))
+		return __arm_ioremap_caller(addr, size, mtype, caller);
+
+	return (void __iomem *)addr;
+}
+
+static void ixp4xx_iounmap(void __iomem *addr)
+{
+	if (!is_pci_memory((__force u32)addr))
+		__iounmap(addr);
+}
+
+void __init ixp4xx_init_early(void)
+{
+	arch_ioremap_caller = ixp4xx_ioremap_caller;
+	arch_iounmap = ixp4xx_iounmap;
+}
+#else
+void __init ixp4xx_init_early(void) {}
+#endif
diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
index a74f86c..1b83110 100644
--- a/arch/arm/mach-ixp4xx/coyote-setup.c
+++ b/arch/arm/mach-ixp4xx/coyote-setup.c
@@ -110,6 +110,7 @@ static void __init coyote_init(void)
 MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
@@ -129,6 +130,7 @@ MACHINE_END
 MACHINE_START(IXDPG425, "Intel IXDPG425")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 67be177..97a0af8 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -280,6 +280,7 @@ MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
 	/* Maintainer: www.nslu2-linux.org */
 	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &dsmg600_timer,
 	.init_machine	= dsmg600_init,
diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
index 6d58182..9175a25 100644
--- a/arch/arm/mach-ixp4xx/fsg-setup.c
+++ b/arch/arm/mach-ixp4xx/fsg-setup.c
@@ -270,6 +270,7 @@ static void __init fsg_init(void)
 MACHINE_START(FSG, "Freecom FSG-3")
 	/* Maintainer: www.nslu2-linux.org */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
index 7ecf9b2..033c717 100644
--- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
+++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
@@ -97,6 +97,7 @@ static void __init gateway7001_init(void)
 MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index c0e3d69..0dda8f6 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -497,6 +497,7 @@ subsys_initcall(gmlr_pci_init);
 MACHINE_START(GORAMO_MLR, "MultiLink")
 	/* Maintainer: Krzysztof Halasa */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
index a23f893..18ebc6b 100644
--- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
+++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
@@ -165,6 +165,7 @@ static void __init gtwx5715_init(void)
 MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
 	/* Maintainer: George Joseph */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index ffb9d6a..6a52076 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -57,24 +57,6 @@ static inline int is_pci_memory(u32 addr)
 	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
 }
 
-static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
-						unsigned int mtype)
-{
-	if (!is_pci_memory(addr))
-		return __arm_ioremap(addr, size, mtype);
-
-	return (void __iomem *)addr;
-}
-
-static inline void __indirect_iounmap(void __iomem *addr)
-{
-	if (!is_pci_memory((__force u32)addr))
-		__iounmap(addr);
-}
-
-#define __arch_ioremap			__indirect_ioremap
-#define __arch_iounmap			__indirect_iounmap
-
 #define writeb(v, p)			__indirect_writeb(v, p)
 #define writew(v, p)			__indirect_writew(v, p)
 #define writel(v, p)			__indirect_writel(v, p)
diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
index df9250b..b66bedc 100644
--- a/arch/arm/mach-ixp4xx/include/mach/platform.h
+++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
@@ -121,6 +121,7 @@ extern unsigned long ixp4xx_timer_freq;
  * Functions used by platform-level setup code
  */
 extern void ixp4xx_map_io(void);
+extern void ixp4xx_init_early(void);
 extern void ixp4xx_init_irq(void);
 extern void ixp4xx_sys_init(void);
 extern void ixp4xx_timer_init(void);
diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 8a38b39..3d742ae 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -254,6 +254,7 @@ static void __init ixdp425_init(void)
 MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
@@ -269,6 +270,7 @@ MACHINE_END
 MACHINE_START(IXDP465, "Intel IXDP465 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
@@ -283,6 +285,7 @@ MACHINE_END
 MACHINE_START(IXCDP1100, "Intel IXCDP1100 Development Platform")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
@@ -297,6 +300,7 @@ MACHINE_END
 MACHINE_START(KIXRP435, "Intel KIXRP435 Reference Platform")
 	/* Maintainer: MontaVista Software, Inc. */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 1010eb7..33cb095 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -315,6 +315,7 @@ MACHINE_START(NAS100D, "Iomega NAS 100d")
 	/* Maintainer: www.nslu2-linux.org */
 	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
 	.init_machine	= nas100d_init,
diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
index aa355c3..e2903fa 100644
--- a/arch/arm/mach-ixp4xx/nslu2-setup.c
+++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
@@ -301,6 +301,7 @@ MACHINE_START(NSLU2, "Linksys NSLU2")
 	/* Maintainer: www.nslu2-linux.org */
 	.atag_offset	= 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &nslu2_timer,
 	.init_machine	= nslu2_init,
diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
index 0940869..158ddb7 100644
--- a/arch/arm/mach-ixp4xx/omixp-setup.c
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -243,6 +243,7 @@ static void __init omixp_init(void)
 MACHINE_START(DEVIXP, "Omicron DEVIXP")
 	.atag_offset    = 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
 	.init_machine	= omixp_init,
@@ -254,6 +255,7 @@ MACHINE_END
 MACHINE_START(MICCPT, "Omicron MICCPT")
 	.atag_offset    = 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
 	.init_machine	= omixp_init,
@@ -268,6 +270,7 @@ MACHINE_END
 MACHINE_START(MIC256, "Omicron MIC256")
 	.atag_offset    = 0x100,
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer          = &ixp4xx_timer,
 	.init_machine	= omixp_init,
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
index 9dec206..2798f43 100644
--- a/arch/arm/mach-ixp4xx/vulcan-setup.c
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -237,6 +237,7 @@ static void __init vulcan_init(void)
 MACHINE_START(ARCOM_VULCAN, "Arcom/Eurotech Vulcan")
 	/* Maintainer: Marc Zyngier <maz@misterjones.org> */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
index 5ac0f0a..a785175 100644
--- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
+++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
@@ -98,6 +98,7 @@ static void __init wg302v2_init(void)
 MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
 	/* Maintainer: Imre Kaloz <kaloz@openwrt.org> */
 	.map_io		= ixp4xx_map_io,
+	.init_early	= ixp4xx_init_early,
 	.init_irq	= ixp4xx_init_irq,
 	.timer		= &ixp4xx_timer,
 	.atag_offset	= 0x100,
-- 
1.7.5.4
