From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:33 +0100
Subject: [PATCH 05/51] ARM: imx: change static io mapping to use a function
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now only the virtual addresses [0xf4000000, 0xf5ffffff] are used for
static per-SoC mappings.  The few mappings of whole chip selects are
moved accordingly.

The now wrong defines for virtual base addresses are removed.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/hardware.h |   67 +++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx1.h      |    5 +--
 arch/arm/plat-mxc/include/mach/mx21.h     |    9 +---
 arch/arm/plat-mxc/include/mach/mx25.h     |   13 ++----
 arch/arm/plat-mxc/include/mach/mx27.h     |    9 +---
 arch/arm/plat-mxc/include/mach/mx2x.h     |   36 +---------------
 arch/arm/plat-mxc/include/mach/mx31.h     |   16 +------
 arch/arm/plat-mxc/include/mach/mx35.h     |   17 +------
 arch/arm/plat-mxc/include/mach/mx3x.h     |   65 +--------------------------
 arch/arm/plat-mxc/include/mach/mx51.h     |   38 +---------------
 arch/arm/plat-mxc/include/mach/mxc91231.h |   22 +---------
 11 files changed, 89 insertions(+), 208 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 409cec6..dde777c 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -32,6 +32,73 @@
 	(((addr) - module ## _BASE_ADDR) < module ## _SIZE ?		\
 	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0)
 
+/*
+ * This is rather complicated for humans and ugly to verify, but for a machine
+ * it's OK.  Still more as it is usually only applied to constants.  The upsides
+ * on using this approach are:
+ *
+ *  - same mapping on all i.MX machines
+ *  - works for assembler, too
+ *  - no need to nurture #defines for virtual addresses
+ *
+ * The downside it, it's hard to verify (but I have a script for that).
+ *
+ * Obviously this needs to be injective for each SoC.  In general it maps the
+ * whole address space to [0xf4000000, 0xf5ffffff].  So [0xf6000000,0xfeffffff]
+ * is free for per-machine use (e.g. KZM_ARM11_01 uses 64MiB there).
+ *
+ * It applies the following mappings for the different SoCs:
+ *
+ * mx1:
+ *	IO	0x00200000+0x100000	->	0xf4000000+0x100000
+ * mx21:
+ *	AIPI	0x10000000+0x100000	->	0xf4400000+0x100000
+ *	SAHB1	0x80000000+0x100000	->	0xf4000000+0x100000
+ *	X_MEMC	0xdf000000+0x004000	->	0xf5f00000+0x004000
+ * mx25:
+ *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
+ *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
+ *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
+ * mx27:
+ *	AIPI	0x10000000+0x100000	->	0xf4400000+0x100000
+ *	SAHB1	0x80000000+0x100000	->	0xf4000000+0x100000
+ *	X_MEMC	0xd8000000+0x100000	->	0xf5c00000+0x100000
+ * mx31:
+ *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
+ *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
+ *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
+ *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
+ *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
+ * mx35:
+ *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
+ *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
+ *	AVIC	0x68000000+0x100000	->	0xf5800000+0x100000
+ *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
+ *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
+ * mx51:
+ *	IRAM	0x1ffe0000+0x020000	->	0xf4fe0000+0x020000
+ *	DEBUG	0x60000000+0x100000	->	0xf5000000+0x100000
+ *	SPBA0	0x70000000+0x100000	->	0xf5400000+0x100000
+ *	AIPS1	0x73f00000+0x100000	->	0xf5700000+0x100000
+ *	AIPS2	0x83f00000+0x100000	->	0xf4300000+0x100000
+ * mxc91231:
+ *	L2CC	0x30000000+0x010000	->	0xf4400000+0x010000
+ *	X_MEMC	0xb8000000+0x010000	->	0xf4c00000+0x010000
+ *	ROMP	0x60000000+0x010000	->	0xf5000000+0x010000
+ *	AVIC	0x68000000+0x010000	->	0xf5800000+0x010000
+ *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
+ *	SPBA0	0x50000000+0x100000	->	0xf5400000+0x100000
+ *	SPBA1	0x52000000+0x100000	->	0xf5600000+0x100000
+ *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
+ */
+#define IMX_IO_P2V(x)	(						\
+			0xf4000000 +					\
+			(((x) & 0x50000000) >> 6) +			\
+			(((x) & 0x0b000000) >> 4) +			\
+			(((x) & 0x000fffff)))
+
+#define IMX_IO_ADDRESS(x)	IOMEM(IMX_IO_P2V(x))
+
 #ifdef CONFIG_ARCH_MX5
 #include <mach/mx51.h>
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index b41c288..b786ae7 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -19,7 +19,6 @@
  */
 #define MX1_IO_BASE_ADDR	0x00200000
 #define MX1_IO_SIZE		SZ_1M
-#define MX1_IO_BASE_ADDR_VIRT	VMALLOC_END
 
 #define MX1_CS0_PHYS		0x10000000
 #define MX1_CS0_SIZE		0x02000000
@@ -73,8 +72,7 @@
 #define MX1_CSI_BASE_ADDR		(0x24000 + MX1_IO_BASE_ADDR)
 
 /* macro to get at IO space when running virtually */
-#define MX1_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX1_IO))
+#define MX1_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX1_IO_ADDRESS(x)		IOMEM(MX1_IO_P2V(x))
 
 /* fixed interrput numbers */
@@ -171,7 +169,6 @@
 /* these should go away */
 #define IMX_IO_PHYS MX1_IO_BASE_ADDR
 #define IMX_IO_SIZE MX1_IO_SIZE
-#define IMX_IO_BASE MX1_IO_BASE_ADDR_VIRT
 #define IMX_CS0_PHYS MX1_CS0_PHYS
 #define IMX_CS0_SIZE MX1_CS0_SIZE
 #define IMX_CS1_PHYS MX1_CS1_PHYS
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index aed0277..b417e32 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -26,7 +26,6 @@
 #define __MACH_MX21_H__
 
 #define MX21_AIPI_BASE_ADDR		0x10000000
-#define MX21_AIPI_BASE_ADDR_VIRT	0xf4000000
 #define MX21_AIPI_SIZE			SZ_1M
 #define MX21_DMA_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x01000)
 #define MX21_WDOG_BASE_ADDR			(MX21_AIPI_BASE_ADDR + 0x02000)
@@ -64,7 +63,6 @@
 #define MX21_AVIC_BASE_ADDR		0x10040000
 
 #define MX21_SAHB1_BASE_ADDR		0x80000000
-#define MX21_SAHB1_BASE_ADDR_VIRT	0xf4100000
 #define MX21_SAHB1_SIZE			SZ_1M
 #define MX21_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
 
@@ -82,7 +80,6 @@
 
 /* NAND, SDRAM, WEIM etc controllers */
 #define MX21_X_MEMC_BASE_ADDR		0xdf000000
-#define MX21_X_MEMC_BASE_ADDR_VIRT	0xf4200000
 #define MX21_X_MEMC_SIZE		SZ_256K
 
 #define MX21_SDRAMC_BASE_ADDR		(MX21_X_MEMC_BASE_ADDR + 0x0000)
@@ -92,10 +89,7 @@
 
 #define MX21_IRAM_BASE_ADDR		0xffffe800	/* internal ram */
 
-#define MX21_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX21_AIPI) ?:				\
-	IMX_IO_P2V_MODULE(x, MX21_SAHB1) ?:				\
-	IMX_IO_P2V_MODULE(x, MX21_X_MEMC))
+#define MX21_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX21_IO_ADDRESS(x)		IOMEM(MX21_IO_P2V(x))
 
 /* fixed interrupt numbers */
@@ -197,7 +191,6 @@
 #define PCMCIA_MEM_BASE_ADDR MX21_PCMCIA_MEM_BASE_ADDR
 #define CS5_BASE_ADDR MX21_CS5_BASE_ADDR
 #define X_MEMC_BASE_ADDR MX21_X_MEMC_BASE_ADDR
-#define X_MEMC_BASE_ADDR_VIRT MX21_X_MEMC_BASE_ADDR_VIRT
 #define X_MEMC_SIZE MX21_X_MEMC_SIZE
 #define SDRAMC_BASE_ADDR MX21_SDRAMC_BASE_ADDR
 #define EIM_BASE_ADDR MX21_EIM_BASE_ADDR
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 08b5a3a..aac6a9c 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -2,13 +2,11 @@
 #define __MACH_MX25_H__
 
 #define MX25_AIPS1_BASE_ADDR		0x43f00000
-#define MX25_AIPS1_BASE_ADDR_VIRT	0xfc000000
+#define MX25_AIPS1_BASE_ADDR_VIRT	0xf5300000
 #define MX25_AIPS1_SIZE			SZ_1M
 #define MX25_AIPS2_BASE_ADDR		0x53f00000
-#define MX25_AIPS2_BASE_ADDR_VIRT	0xfc200000
 #define MX25_AIPS2_SIZE			SZ_1M
 #define MX25_AVIC_BASE_ADDR		0x68000000
-#define MX25_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX25_AVIC_SIZE			SZ_1M
 
 #define MX25_I2C1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x80000)
@@ -27,12 +25,6 @@
 #define MX25_GPIO2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xd0000)
 #define MX25_WDOG_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xdc000)
 
-#define MX25_IO_P2V(x)	(					\
-	IMX_IO_P2V_MODULE(x, MX25_AIPS1) ?:			\
-	IMX_IO_P2V_MODULE(x, MX25_AIPS2) ?:			\
-	IMX_IO_P2V_MODULE(x, MX25_AVIC))
-#define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))
-
 #define MX25_AIPS1_IO_ADDRESS(x) \
 	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
 
@@ -58,6 +50,9 @@
 #define MX25_OTG_BASE_ADDR		0x53ff4000
 #define MX25_CSI_BASE_ADDR		0x53ff8000
 
+#define MX25_IO_P2V(x)			IMX_IO_P2V(x)
+#define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))
+
 #define MX25_INT_CSPI3		0
 #define MX25_INT_I2C1		3
 #define MX25_INT_I2C2		4
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index c769cc8..e817289 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -29,7 +29,6 @@
 #endif
 
 #define MX27_AIPI_BASE_ADDR		0x10000000
-#define MX27_AIPI_BASE_ADDR_VIRT	0xf4000000
 #define MX27_AIPI_SIZE			SZ_1M
 #define MX27_DMA_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x01000)
 #define MX27_WDOG_BASE_ADDR			(MX27_AIPI_BASE_ADDR + 0x02000)
@@ -87,7 +86,6 @@
 #define MX27_ROMP_BASE_ADDR		0x10041000
 
 #define MX27_SAHB1_BASE_ADDR		0x80000000
-#define MX27_SAHB1_BASE_ADDR_VIRT	0xf4100000
 #define MX27_SAHB1_SIZE			SZ_1M
 #define MX27_CSI_BASE_ADDR			(MX27_SAHB1_BASE_ADDR + 0x0000)
 #define MX27_ATA_BASE_ADDR			(MX27_SAHB1_BASE_ADDR + 0x1000)
@@ -105,7 +103,6 @@
 
 /* NAND, SDRAM, WEIM, M3IF, EMI controllers */
 #define MX27_X_MEMC_BASE_ADDR		0xd8000000
-#define MX27_X_MEMC_BASE_ADDR_VIRT	0xf4200000
 #define MX27_X_MEMC_SIZE		SZ_1M
 #define MX27_NFC_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR)
 #define MX27_SDRAMC_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR + 0x1000)
@@ -123,10 +120,7 @@
 /* IRAM */
 #define MX27_IRAM_BASE_ADDR		0xffff4c00	/* internal ram */
 
-#define MX27_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX27_AIPI) ?:				\
-	IMX_IO_P2V_MODULE(x, MX27_SAHB1) ?:				\
-	IMX_IO_P2V_MODULE(x, MX27_X_MEMC))
+#define MX27_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX27_IO_ADDRESS(x)		IOMEM(MX27_IO_P2V(x))
 
 #ifndef __ASSEMBLER__
@@ -280,7 +274,6 @@ extern int mx27_revision(void);
 #define CS4_BASE_ADDR MX27_CS4_BASE_ADDR
 #define CS5_BASE_ADDR MX27_CS5_BASE_ADDR
 #define X_MEMC_BASE_ADDR MX27_X_MEMC_BASE_ADDR
-#define X_MEMC_BASE_ADDR_VIRT MX27_X_MEMC_BASE_ADDR_VIRT
 #define X_MEMC_SIZE MX27_X_MEMC_SIZE
 #define NFC_BASE_ADDR MX27_NFC_BASE_ADDR
 #define SDRAMC_BASE_ADDR MX27_SDRAMC_BASE_ADDR
diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index afb895a..46eeeb2 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -27,7 +27,7 @@
 
 /* Register offsets */
 #define MX2x_AIPI_BASE_ADDR		0x10000000
-#define MX2x_AIPI_BASE_ADDR_VIRT	0xf4000000
+#define MX2x_AIPI_BASE_ADDR_VIRT	0xf4400000
 #define MX2x_AIPI_SIZE			SZ_1M
 #define MX2x_DMA_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x01000)
 #define MX2x_WDOG_BASE_ADDR			(MX2x_AIPI_BASE_ADDR + 0x02000)
@@ -65,43 +65,12 @@
 #define MX2x_AVIC_BASE_ADDR		0x10040000
 
 #define MX2x_SAHB1_BASE_ADDR		0x80000000
-#define MX2x_SAHB1_BASE_ADDR_VIRT	0xf4100000
 #define MX2x_SAHB1_SIZE			SZ_1M
 #define MX2x_CSI_BASE_ADDR			(MX2x_SAHB1_BASE_ADDR + 0x0000)
 
-/*
- * This macro defines the physical to virtual address mapping for all the
- * peripheral modules. It is used by passing in the physical address as x
- * and returning the virtual address. If the physical address is not mapped,
- * it returns 0xDEADBEEF
- */
-#define IO_ADDRESS(x)   \
-	(void __force __iomem *) \
-	(((x >= AIPI_BASE_ADDR) && (x < (AIPI_BASE_ADDR + AIPI_SIZE))) ? \
-		AIPI_IO_ADDRESS(x) : \
-	((x >= SAHB1_BASE_ADDR) && (x < (SAHB1_BASE_ADDR + SAHB1_SIZE))) ? \
-		SAHB1_IO_ADDRESS(x) : \
-	((x >= X_MEMC_BASE_ADDR) && (x < (X_MEMC_BASE_ADDR + X_MEMC_SIZE))) ? \
-		X_MEMC_IO_ADDRESS(x) : 0xDEADBEEF)
-
-/* define the address mapping macros: in physical address order */
-#define AIPI_IO_ADDRESS(x)  \
+#define AIPI_IO_ADDRESS(x)	\
 	(((x) - AIPI_BASE_ADDR) + AIPI_BASE_ADDR_VIRT)
 
-#define AVIC_IO_ADDRESS(x)	AIPI_IO_ADDRESS(x)
-
-#define SAHB1_IO_ADDRESS(x)  \
-	(((x) - SAHB1_BASE_ADDR) + SAHB1_BASE_ADDR_VIRT)
-
-#define CS4_IO_ADDRESS(x)  \
-	(((x) - CS4_BASE_ADDR) + CS4_BASE_ADDR_VIRT)
-
-#define X_MEMC_IO_ADDRESS(x)  \
-	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
-
-#define PCMCIA_IO_ADDRESS(x) \
-	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
-
 /* fixed interrupt numbers */
 #define MX2x_INT_CSPI3		6
 #define MX2x_INT_GPIO		8
@@ -215,7 +184,6 @@
 #define MAX_BASE_ADDR MX2x_MAX_BASE_ADDR
 #define AVIC_BASE_ADDR MX2x_AVIC_BASE_ADDR
 #define SAHB1_BASE_ADDR MX2x_SAHB1_BASE_ADDR
-#define SAHB1_BASE_ADDR_VIRT MX2x_SAHB1_BASE_ADDR_VIRT
 #define SAHB1_SIZE MX2x_SAHB1_SIZE
 #define CSI_BASE_ADDR MX2x_CSI_BASE_ADDR
 #define MXC_INT_CSPI3 MX2x_INT_CSPI3
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index eb4a28d..9ed9975 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -15,7 +15,6 @@
 #define MX31_L2CC_SIZE			SZ_1M
 
 #define MX31_AIPS1_BASE_ADDR		0x43f00000
-#define MX31_AIPS1_BASE_ADDR_VIRT	0xfc000000
 #define MX31_AIPS1_SIZE			SZ_1M
 #define MX31_MAX_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x04000)
 #define MX31_EVTMON_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0x08000)
@@ -41,7 +40,6 @@
 #define MX31_ECT_IP2_BASE_ADDR			(MX31_AIPS1_BASE_ADDR + 0xbc000)
 
 #define MX31_SPBA0_BASE_ADDR		0x50000000
-#define MX31_SPBA0_BASE_ADDR_VIRT	0xfc100000
 #define MX31_SPBA0_SIZE			SZ_1M
 #define MX31_MMC_SDHC1_BASE_ADDR		(MX31_SPBA0_BASE_ADDR + 0x04000)
 #define MX31_MMC_SDHC2_BASE_ADDR		(MX31_SPBA0_BASE_ADDR + 0x08000)
@@ -55,7 +53,6 @@
 #define MX31_SPBA_CTRL_BASE_ADDR		(MX31_SPBA0_BASE_ADDR + 0x3c000)
 
 #define MX31_AIPS2_BASE_ADDR		0x53f00000
-#define MX31_AIPS2_BASE_ADDR_VIRT	0xfc200000
 #define MX31_AIPS2_SIZE			SZ_1M
 #define MX31_CCM_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0x80000)
 #define MX31_CSPI3_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0x84000)
@@ -84,7 +81,6 @@
 #define MX31_ROMP_SIZE			SZ_1M
 
 #define MX31_AVIC_BASE_ADDR		0x68000000
-#define MX31_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX31_AVIC_SIZE			SZ_1M
 
 #define MX31_IPU_MEM_BASE_ADDR		0x70000000
@@ -97,15 +93,14 @@
 #define MX31_CS3_BASE_ADDR		0xb2000000
 
 #define MX31_CS4_BASE_ADDR		0xb4000000
-#define MX31_CS4_BASE_ADDR_VIRT		0xf4000000
+#define MX31_CS4_BASE_ADDR_VIRT		0xf6000000
 #define MX31_CS4_SIZE			SZ_32M
 
 #define MX31_CS5_BASE_ADDR		0xb6000000
-#define MX31_CS5_BASE_ADDR_VIRT		0xf6000000
+#define MX31_CS5_BASE_ADDR_VIRT		0xf8000000
 #define MX31_CS5_SIZE			SZ_32M
 
 #define MX31_X_MEMC_BASE_ADDR		0xb8000000
-#define MX31_X_MEMC_BASE_ADDR_VIRT	0xfc320000
 #define MX31_X_MEMC_SIZE		SZ_64K
 #define MX31_NFC_BASE_ADDR			(MX31_X_MEMC_BASE_ADDR + 0x0000)
 #define MX31_ESDCTL_BASE_ADDR			(MX31_X_MEMC_BASE_ADDR + 0x1000)
@@ -121,12 +116,7 @@
 
 #define MX31_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-#define MX31_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX31_AIPS1) ?:				\
-	IMX_IO_P2V_MODULE(x, MX31_AIPS2) ?:				\
-	IMX_IO_P2V_MODULE(x, MX31_AVIC) ?:				\
-	IMX_IO_P2V_MODULE(x, MX31_X_MEMC) ?:				\
-	IMX_IO_P2V_MODULE(x, MX31_SPBA0))
+#define MX31_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX31_IO_ADDRESS(x)		IOMEM(MX31_IO_P2V(x))
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ce1a24b..3678ca3 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -11,7 +11,6 @@
 #define MX35_L2CC_SIZE			SZ_1M
 
 #define MX35_AIPS1_BASE_ADDR		0x43f00000
-#define MX35_AIPS1_BASE_ADDR_VIRT	0xfc000000
 #define MX35_AIPS1_SIZE			SZ_1M
 #define MX35_MAX_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x04000)
 #define MX35_EVTMON_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0x08000)
@@ -33,7 +32,6 @@
 #define MX35_ECT_IP2_BASE_ADDR			(MX35_AIPS1_BASE_ADDR + 0xbc000)
 
 #define MX35_SPBA0_BASE_ADDR		0x50000000
-#define MX35_SPBA0_BASE_ADDR_VIRT	0xfc100000
 #define MX35_SPBA0_SIZE			SZ_1M
 #define MX35_UART3_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x0c000)
 #define MX35_CSPI2_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x10000)
@@ -44,7 +42,6 @@
 #define MX35_SPBA_CTRL_BASE_ADDR		(MX35_SPBA0_BASE_ADDR + 0x3c000)
 
 #define MX35_AIPS2_BASE_ADDR		0x53f00000
-#define MX35_AIPS2_BASE_ADDR_VIRT	0xfc200000
 #define MX35_AIPS2_SIZE			SZ_1M
 #define MX35_CCM_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0x80000)
 #define MX35_GPT1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0x90000)
@@ -72,11 +69,9 @@
 #define MX35_OTG_BASE_ADDR		0x53ff4000
 
 #define MX35_ROMP_BASE_ADDR		0x60000000
-#define MX35_ROMP_BASE_ADDR_VIRT	0xfc500000
 #define MX35_ROMP_SIZE			SZ_1M
 
 #define MX35_AVIC_BASE_ADDR		0x68000000
-#define MX35_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX35_AVIC_SIZE			SZ_1M
 
 /*
@@ -92,18 +87,17 @@
 #define MX35_CS3_BASE_ADDR		0xb2000000
 
 #define MX35_CS4_BASE_ADDR		0xb4000000
-#define MX35_CS4_BASE_ADDR_VIRT		0xf4000000
+#define MX35_CS4_BASE_ADDR_VIRT		0xf6000000
 #define MX35_CS4_SIZE			SZ_32M
 
 #define MX35_CS5_BASE_ADDR		0xb6000000
-#define MX35_CS5_BASE_ADDR_VIRT		0xf6000000
+#define MX35_CS5_BASE_ADDR_VIRT		0xf8000000
 #define MX35_CS5_SIZE			SZ_32M
 
 /*
  * NAND, SDRAM, WEIM, M3IF, EMI controllers
  */
 #define MX35_X_MEMC_BASE_ADDR		0xb8000000
-#define MX35_X_MEMC_BASE_ADDR_VIRT	0xfc320000
 #define MX35_X_MEMC_SIZE		SZ_64K
 #define MX35_ESDCTL_BASE_ADDR			(MX35_X_MEMC_BASE_ADDR + 0x1000)
 #define MX35_WEIM_BASE_ADDR			(MX35_X_MEMC_BASE_ADDR + 0x2000)
@@ -114,12 +108,7 @@
 #define MX35_NFC_BASE_ADDR		0xbb000000
 #define MX35_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-#define MX35_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX35_AIPS1) ?:				\
-	IMX_IO_P2V_MODULE(x, MX35_AIPS2) ?:				\
-	IMX_IO_P2V_MODULE(x, MX35_AVIC) ?:				\
-	IMX_IO_P2V_MODULE(x, MX35_X_MEMC) ?:				\
-	IMX_IO_P2V_MODULE(x, MX35_SPBA0))
+#define MX35_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX35_IO_ADDRESS(x)		IOMEM(MX35_IO_P2V(x))
 
 /*
diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index d1bd26d..da22cd4 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -44,7 +44,7 @@
  * AIPS 1
  */
 #define MX3x_AIPS1_BASE_ADDR		0x43f00000
-#define MX3x_AIPS1_BASE_ADDR_VIRT	0xfc000000
+#define MX3x_AIPS1_BASE_ADDR_VIRT	0xf5300000
 #define MX3x_AIPS1_SIZE			SZ_1M
 #define MX3x_MAX_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x04000)
 #define MX3x_EVTMON_BASE_ADDR			(MX3x_AIPS1_BASE_ADDR + 0x08000)
@@ -69,7 +69,6 @@
  * SPBA global module enabled #0
  */
 #define MX3x_SPBA0_BASE_ADDR		0x50000000
-#define MX3x_SPBA0_BASE_ADDR_VIRT	0xfc100000
 #define MX3x_SPBA0_SIZE			SZ_1M
 #define MX3x_UART3_BASE_ADDR			(MX3x_SPBA0_BASE_ADDR + 0x0c000)
 #define MX3x_CSPI2_BASE_ADDR			(MX3x_SPBA0_BASE_ADDR + 0x10000)
@@ -82,7 +81,6 @@
  * AIPS 2
  */
 #define MX3x_AIPS2_BASE_ADDR		0x53f00000
-#define MX3x_AIPS2_BASE_ADDR_VIRT	0xfc200000
 #define MX3x_AIPS2_SIZE			SZ_1M
 #define MX3x_CCM_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0x80000)
 #define MX3x_GPT1_BASE_ADDR			(MX3x_AIPS2_BASE_ADDR + 0x90000)
@@ -105,11 +103,9 @@
  * ROMP and AVIC
  */
 #define MX3x_ROMP_BASE_ADDR		0x60000000
-#define MX3x_ROMP_BASE_ADDR_VIRT	0xfc500000
 #define MX3x_ROMP_SIZE			SZ_1M
 
 #define MX3x_AVIC_BASE_ADDR		0x68000000
-#define MX3x_AVIC_BASE_ADDR_VIRT	0xfc400000
 #define MX3x_AVIC_SIZE			SZ_1M
 
 /*
@@ -125,18 +121,17 @@
 #define MX3x_CS3_BASE_ADDR		0xb2000000
 
 #define MX3x_CS4_BASE_ADDR		0xb4000000
-#define MX3x_CS4_BASE_ADDR_VIRT		0xf4000000
+#define MX3x_CS4_BASE_ADDR_VIRT		0xf6000000
 #define MX3x_CS4_SIZE			SZ_32M
 
 #define MX3x_CS5_BASE_ADDR		0xb6000000
-#define MX3x_CS5_BASE_ADDR_VIRT		0xf6000000
+#define MX3x_CS5_BASE_ADDR_VIRT		0xf8000000
 #define MX3x_CS5_SIZE			SZ_32M
 
 /*
  * NAND, SDRAM, WEIM, M3IF, EMI controllers
  */
 #define MX3x_X_MEMC_BASE_ADDR		0xb8000000
-#define MX3x_X_MEMC_BASE_ADDR_VIRT	0xfc320000
 #define MX3x_X_MEMC_SIZE		SZ_64K
 #define MX3x_ESDCTL_BASE_ADDR			(MX3x_X_MEMC_BASE_ADDR + 0x1000)
 #define MX3x_WEIM_BASE_ADDR			(MX3x_X_MEMC_BASE_ADDR + 0x2000)
@@ -146,56 +141,9 @@
 
 #define MX3x_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-/*!
- * This macro defines the physical to virtual address mapping for all the
- * peripheral modules. It is used by passing in the physical address as x
- * and returning the virtual address. If the physical address is not mapped,
- * it returns 0xDEADBEEF
- */
-#define IO_ADDRESS(x)   \
-	(void __force __iomem *) \
-	(((x >= AIPS1_BASE_ADDR) && (x < (AIPS1_BASE_ADDR + AIPS1_SIZE))) ? AIPS1_IO_ADDRESS(x):\
-	((x >= SPBA0_BASE_ADDR) && (x < (SPBA0_BASE_ADDR + SPBA0_SIZE))) ? SPBA0_IO_ADDRESS(x):\
-	((x >= AIPS2_BASE_ADDR) && (x < (AIPS2_BASE_ADDR + AIPS2_SIZE))) ? AIPS2_IO_ADDRESS(x):\
-	((x >= ROMP_BASE_ADDR) && (x < (ROMP_BASE_ADDR + ROMP_SIZE))) ? ROMP_IO_ADDRESS(x):\
-	((x >= AVIC_BASE_ADDR) && (x < (AVIC_BASE_ADDR + AVIC_SIZE))) ? AVIC_IO_ADDRESS(x):\
-	((x >= CS4_BASE_ADDR) && (x < (CS4_BASE_ADDR + CS4_SIZE))) ? CS4_IO_ADDRESS(x):\
-	((x >= X_MEMC_BASE_ADDR) && (x < (X_MEMC_BASE_ADDR + X_MEMC_SIZE))) ? X_MEMC_IO_ADDRESS(x):\
-	0xDEADBEEF)
-
-/*
- * define the address mapping macros: in physical address order
- */
-#define L2CC_IO_ADDRESS(x)  \
-	(((x) - L2CC_BASE_ADDR) + L2CC_BASE_ADDR_VIRT)
-
 #define AIPS1_IO_ADDRESS(x)  \
 	(((x) - AIPS1_BASE_ADDR) + AIPS1_BASE_ADDR_VIRT)
 
-#define SPBA0_IO_ADDRESS(x)  \
-	(((x) - SPBA0_BASE_ADDR) + SPBA0_BASE_ADDR_VIRT)
-
-#define AIPS2_IO_ADDRESS(x)  \
-	(((x) - AIPS2_BASE_ADDR) + AIPS2_BASE_ADDR_VIRT)
-
-#define ROMP_IO_ADDRESS(x)  \
-	(((x) - ROMP_BASE_ADDR) + ROMP_BASE_ADDR_VIRT)
-
-#define AVIC_IO_ADDRESS(x)  \
-	(((x) - AVIC_BASE_ADDR) + AVIC_BASE_ADDR_VIRT)
-
-#define CS4_IO_ADDRESS(x)  \
-	(((x) - CS4_BASE_ADDR) + CS4_BASE_ADDR_VIRT)
-
-#define CS5_IO_ADDRESS(x)  \
-	(((x) - CS5_BASE_ADDR) + CS5_BASE_ADDR_VIRT)
-
-#define X_MEMC_IO_ADDRESS(x)  \
-	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
-
-#define PCMCIA_IO_ADDRESS(x) \
-	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
-
 /*
  * Interrupt numbers
  */
@@ -303,7 +251,6 @@ static inline int mx35_revision(void)
 #define ECT_IP1_BASE_ADDR MX3x_ECT_IP1_BASE_ADDR
 #define ECT_IP2_BASE_ADDR MX3x_ECT_IP2_BASE_ADDR
 #define SPBA0_BASE_ADDR MX3x_SPBA0_BASE_ADDR
-#define SPBA0_BASE_ADDR_VIRT MX3x_SPBA0_BASE_ADDR_VIRT
 #define SPBA0_SIZE MX3x_SPBA0_SIZE
 #define UART3_BASE_ADDR MX3x_UART3_BASE_ADDR
 #define CSPI2_BASE_ADDR MX3x_CSPI2_BASE_ADDR
@@ -312,7 +259,6 @@ static inline int mx35_revision(void)
 #define MSHC1_BASE_ADDR MX3x_MSHC1_BASE_ADDR
 #define SPBA_CTRL_BASE_ADDR MX3x_SPBA_CTRL_BASE_ADDR
 #define AIPS2_BASE_ADDR MX3x_AIPS2_BASE_ADDR
-#define AIPS2_BASE_ADDR_VIRT MX3x_AIPS2_BASE_ADDR_VIRT
 #define AIPS2_SIZE MX3x_AIPS2_SIZE
 #define CCM_BASE_ADDR MX3x_CCM_BASE_ADDR
 #define GPT1_BASE_ADDR MX3x_GPT1_BASE_ADDR
@@ -331,10 +277,8 @@ static inline int mx35_revision(void)
 #define PWM_BASE_ADDR MX3x_PWM_BASE_ADDR
 #define RTIC_BASE_ADDR MX3x_RTIC_BASE_ADDR
 #define ROMP_BASE_ADDR MX3x_ROMP_BASE_ADDR
-#define ROMP_BASE_ADDR_VIRT MX3x_ROMP_BASE_ADDR_VIRT
 #define ROMP_SIZE MX3x_ROMP_SIZE
 #define AVIC_BASE_ADDR MX3x_AVIC_BASE_ADDR
-#define AVIC_BASE_ADDR_VIRT MX3x_AVIC_BASE_ADDR_VIRT
 #define AVIC_SIZE MX3x_AVIC_SIZE
 #define IPU_MEM_BASE_ADDR MX3x_IPU_MEM_BASE_ADDR
 #define CSD0_BASE_ADDR MX3x_CSD0_BASE_ADDR
@@ -344,13 +288,10 @@ static inline int mx35_revision(void)
 #define CS2_BASE_ADDR MX3x_CS2_BASE_ADDR
 #define CS3_BASE_ADDR MX3x_CS3_BASE_ADDR
 #define CS4_BASE_ADDR MX3x_CS4_BASE_ADDR
-#define CS4_BASE_ADDR_VIRT MX3x_CS4_BASE_ADDR_VIRT
 #define CS4_SIZE MX3x_CS4_SIZE
 #define CS5_BASE_ADDR MX3x_CS5_BASE_ADDR
-#define CS5_BASE_ADDR_VIRT MX3x_CS5_BASE_ADDR_VIRT
 #define CS5_SIZE MX3x_CS5_SIZE
 #define X_MEMC_BASE_ADDR MX3x_X_MEMC_BASE_ADDR
-#define X_MEMC_BASE_ADDR_VIRT MX3x_X_MEMC_BASE_ADDR_VIRT
 #define X_MEMC_SIZE MX3x_X_MEMC_SIZE
 #define ESDCTL_BASE_ADDR MX3x_ESDCTL_BASE_ADDR
 #define WEIM_BASE_ADDR MX3x_WEIM_BASE_ADDR
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index e93cf5b..1b8715f 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -2,31 +2,6 @@
 #define __MACH_MX51_H__
 
 /*
- * MX51 memory map:
- *
- *
- * Virt		Phys		Size	What
- * ---------------------------------------------------------------------------
- * fa3e0000	1ffe0000	128K	IRAM (SCCv2 RAM)
- *         	30000000	256M	GPU
- *         	40000000	512M	IPU
- * fa200000	60000000	1M	DEBUG
- * fb100000	70000000	1M	SPBA 0
- * fb000000	73f00000	1M	AIPS 1
- * fb200000	83f00000	1M	AIPS 2
- *		8fffc000	16K	TZIC (interrupt controller)
- *         	90000000	256M	CSD0 SDRAM/DDR
- *         	a0000000	256M	CSD1 SDRAM/DDR
- *         	b0000000	128M	CS0 Flash
- *         	b8000000	128M	CS1 Flash
- *         	c0000000	128M	CS2 Flash
- *         	c8000000	64M	CS3 Flash
- *         	cc000000	32M	CS4 SRAM
- *         	ce000000	32M	CS5 SRAM
- *		cfff0000	64K	NFC (NAND Flash AXI)
- */
-
-/*
  * IROM
  */
 #define MX51_IROM_BASE_ADDR		0x0
@@ -36,7 +11,6 @@
  * IRAM
  */
 #define MX51_IRAM_BASE_ADDR		0x1ffe0000	/* internal ram */
-#define MX51_IRAM_BASE_ADDR_VIRT	0xfa3e0000
 #define MX51_IRAM_PARTITIONS		16
 #define MX51_IRAM_SIZE		(MX51_IRAM_PARTITIONS * SZ_8K)	/* 128KB */
 
@@ -45,7 +19,6 @@
 #define MX51_IPU_CTRL_BASE_ADDR		0x40000000
 
 #define MX51_DEBUG_BASE_ADDR		0x60000000
-#define MX51_DEBUG_BASE_ADDR_VIRT	0xfa200000
 #define MX51_DEBUG_SIZE			SZ_1M
 
 #define MX51_ETB_BASE_ADDR		(MX51_DEBUG_BASE_ADDR + 0x01000)
@@ -61,7 +34,6 @@
  * SPBA global module enabled #0
  */
 #define MX51_SPBA0_BASE_ADDR		0x70000000
-#define MX51_SPBA0_BASE_ADDR_VIRT	0xfb100000
 #define MX51_SPBA0_SIZE			SZ_1M
 
 #define MX51_ESDHC1_BASE_ADDR		(MX51_SPBA0_BASE_ADDR + 0x04000)
@@ -81,7 +53,7 @@
  * AIPS 1
  */
 #define MX51_AIPS1_BASE_ADDR		0x73f00000
-#define MX51_AIPS1_BASE_ADDR_VIRT	0xfb000000
+#define MX51_AIPS1_BASE_ADDR_VIRT	0xf5700000
 #define MX51_AIPS1_SIZE			SZ_1M
 
 #define MX51_OTG_BASE_ADDR		(MX51_AIPS1_BASE_ADDR + 0x80000)
@@ -109,7 +81,6 @@
  * AIPS 2
  */
 #define MX51_AIPS2_BASE_ADDR		0x83f00000
-#define MX51_AIPS2_BASE_ADDR_VIRT	0xfb200000
 #define MX51_AIPS2_SIZE			SZ_1M
 
 #define MX51_PLL1_BASE_ADDR		(MX51_AIPS2_BASE_ADDR + 0x80000)
@@ -163,12 +134,7 @@
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
 
-#define MX51_IO_P2V(x)	(						\
-	IMX_IO_P2V_MODULE(x, MX51_IRAM) ?:				\
-	IMX_IO_P2V_MODULE(x, MX51_DEBUG) ?:				\
-	IMX_IO_P2V_MODULE(x, MX51_SPBA0) ?:				\
-	IMX_IO_P2V_MODULE(x, MX51_AIPS1) ?:				\
-	IMX_IO_P2V_MODULE(x, MX51_AIPS2))
+#define MX51_IO_P2V(x)			IMX_IO_P2V(x)
 #define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
 
 /* This is currently used in <mach/debug-macro.S>, but should go away */
diff --git a/arch/arm/plat-mxc/include/mach/mxc91231.h b/arch/arm/plat-mxc/include/mach/mxc91231.h
index 49e5e25..765190f 100644
--- a/arch/arm/plat-mxc/include/mach/mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/mxc91231.h
@@ -21,14 +21,12 @@
  * L2CC
  */
 #define MXC91231_L2CC_BASE_ADDR		0x30000000
-#define MXC91231_L2CC_BASE_ADDR_VIRT	0xF9000000
 #define MXC91231_L2CC_SIZE		SZ_64K
 
 /*
  * AIPS 1
  */
 #define MXC91231_AIPS1_BASE_ADDR	0x43F00000
-#define MXC91231_AIPS1_BASE_ADDR_VIRT	0xFC000000
 #define MXC91231_AIPS1_SIZE		SZ_1M
 
 #define MXC91231_AIPS1_CTRL_BASE_ADDR	MXC91231_AIPS1_BASE_ADDR
@@ -53,7 +51,6 @@
  * AIPS 2
  */
 #define MXC91231_AIPS2_BASE_ADDR	0x53F00000
-#define MXC91231_AIPS2_BASE_ADDR_VIRT	0xFC100000
 #define MXC91231_AIPS2_SIZE		SZ_1M
 
 #define MXC91231_GEMK_BASE_ADDR		(MXC91231_AIPS2_BASE_ADDR + 0x8C000)
@@ -79,7 +76,6 @@
  * SPBA global module 0
  */
 #define MXC91231_SPBA0_BASE_ADDR	0x50000000
-#define MXC91231_SPBA0_BASE_ADDR_VIRT	0xFC200000
 #define MXC91231_SPBA0_SIZE		SZ_1M
 
 #define MXC91231_MMC_SDHC1_BASE_ADDR	(MXC91231_SPBA0_BASE_ADDR + 0x04000)
@@ -109,7 +105,6 @@
  * SPBA global module 1
  */
 #define MXC91231_SPBA1_BASE_ADDR	0x52000000
-#define MXC91231_SPBA1_BASE_ADDR_VIRT	0xFC300000
 #define MXC91231_SPBA1_SIZE		SZ_1M
 
 #define MXC91231_MQSPI_BASE_ADDR	(MXC91231_SPBA1_BASE_ADDR + 0x34000)
@@ -144,18 +139,15 @@
  * ROMP and AVIC
  */
 #define MXC91231_ROMP_BASE_ADDR		0x60000000
-#define MXC91231_ROMP_BASE_ADDR_VIRT	0xFC400000
 #define MXC91231_ROMP_SIZE		SZ_64K
 
 #define MXC91231_AVIC_BASE_ADDR		0x68000000
-#define MXC91231_AVIC_BASE_ADDR_VIRT	0xFC410000
 #define MXC91231_AVIC_SIZE		SZ_64K
 
 /*
  * NAND, SDRAM, WEIM, M3IF, EMI controllers
  */
 #define MXC91231_X_MEMC_BASE_ADDR	0xB8000000
-#define MXC91231_X_MEMC_BASE_ADDR_VIRT	0xFC420000
 #define MXC91231_X_MEMC_SIZE		SZ_64K
 
 #define MXC91231_NFC_BASE_ADDR		(MXC91231_X_MEMC_BASE_ADDR + 0x0000)
@@ -183,19 +175,9 @@
 /*
  * This macro defines the physical to virtual address mapping for all the
  * peripheral modules. It is used by passing in the physical address as x
- * and returning the virtual address. If the physical address is not mapped,
- * it returns 0.
+ * and returning the virtual address.
  */
-
-#define MXC91231_IO_P2V(x)	(					\
-	IMX_IO_P2V_MODULE(x, MXC91231_L2CC) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_X_MEMC) ?:			\
-	IMX_IO_P2V_MODULE(x, MXC91231_ROMP) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_AVIC) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_AIPS1) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_SPBA0) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_SPBA1) ?:				\
-	IMX_IO_P2V_MODULE(x, MXC91231_AIPS2))
+#define MXC91231_IO_P2V(x)		IMX_IO_P2V(x)
 #define MXC91231_IO_ADDRESS(x)		IOMEM(MXC91231_IO_P2V(x))
 
 /*
-- 
1.7.2.3
