From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 26 Oct 2010 10:49:51 +0200
Subject: [PATCH 2/7] imx: refactor the io mapping macro
In-Reply-To: <20101022175702.GI19834@pengutronix.de>
References: <20101022175702.GI19834@pengutronix.de>
Message-ID: <1288082996-21981-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it more assembler friendly and allows it to be used in situation
that need an unsigned long and not a pointer.  Also the naming is
clearer.  IOMEM is introduced without IMX_ prefix as it is used this way
in more than one ARM subarch and it might become globally available
soon.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/mach-kzm_arm11_01.c     |    6 +++---
 arch/arm/plat-mxc/include/mach/hardware.h |   13 +++++++++----
 arch/arm/plat-mxc/include/mach/mx1.h      |    5 +++--
 arch/arm/plat-mxc/include/mach/mx21.h     |    9 +++++----
 arch/arm/plat-mxc/include/mach/mx25.h     |    9 +++++----
 arch/arm/plat-mxc/include/mach/mx27.h     |    9 +++++----
 arch/arm/plat-mxc/include/mach/mx31.h     |   13 +++++++------
 arch/arm/plat-mxc/include/mach/mx35.h     |   13 +++++++------
 arch/arm/plat-mxc/include/mach/mx51.h     |   13 +++++++------
 arch/arm/plat-mxc/include/mach/mxc91231.h |   19 ++++++++++---------
 10 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 5b23e41..423387d 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -41,9 +41,9 @@
 #include "devices-imx31.h"
 #include "devices.h"
 
-#define KZM_ARM11_IO_ADDRESS(x) (					\
-	IMX_IO_ADDRESS(x, MX31_CS4) ?:					\
-	IMX_IO_ADDRESS(x, MX31_CS5) ?:					\
+#define KZM_ARM11_IO_ADDRESS(x) (IOMEM(					\
+	IMX_IO_P2V_MODULE(x, MX31_CS4) ?:				\
+	IMX_IO_P2V_MODULE(x, MX31_CS5)) ?:				\
 	MX31_IO_ADDRESS(x))
 
 /*
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index ebadf4a..4bbe506 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -22,10 +22,15 @@
 
 #include <asm/sizes.h>
 
-#define IMX_IO_ADDRESS(addr, module)					\
-	((void __force __iomem *)					\
-	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
-	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
+#ifdef __ASSEMBLER__
+#define IOMEM(addr)	(addr)
+#else
+#define IOMEM(addr)	((void __force __iomem *)(addr))
+#endif
+
+#define IMX_IO_P2V_MODULE(addr, module)					\
+	(((addr) - module ## _BASE_ADDR) < module ## _SIZE ?		\
+	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0)
 
 #ifdef CONFIG_ARCH_MX5
 #include <mach/mx51.h>
diff --git a/arch/arm/plat-mxc/include/mach/mx1.h b/arch/arm/plat-mxc/include/mach/mx1.h
index 641b246..6faa7d2 100644
--- a/arch/arm/plat-mxc/include/mach/mx1.h
+++ b/arch/arm/plat-mxc/include/mach/mx1.h
@@ -73,8 +73,9 @@
 #define MX1_CSI_BASE_ADDR		(0x24000 + MX1_IO_BASE_ADDR)
 
 /* macro to get at IO space when running virtually */
-#define MX1_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX1_IO))
+#define MX1_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX1_IO))
+#define MX1_IO_ADDRESS(x) 		IOMEM(MX1_IO_P2V(x))
 
 /* fixed interrput numbers */
 #define MX1_INT_SOFTINT		0
diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index 8bc5972..aed0277 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -92,10 +92,11 @@
 
 #define MX21_IRAM_BASE_ADDR		0xffffe800	/* internal ram */
 
-#define MX21_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX21_AIPI) ?:					\
-	IMX_IO_ADDRESS(x, MX21_SAHB1) ?:				\
-	IMX_IO_ADDRESS(x, MX21_X_MEMC))
+#define MX21_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX21_AIPI) ?:				\
+	IMX_IO_P2V_MODULE(x, MX21_SAHB1) ?:				\
+	IMX_IO_P2V_MODULE(x, MX21_X_MEMC))
+#define MX21_IO_ADDRESS(x)		IOMEM(MX21_IO_P2V(x))
 
 /* fixed interrupt numbers */
 #define MX21_INT_CSPI3		6
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index cf46a45..6f9e1d4 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -28,10 +28,11 @@
 #define MX25_GPIO3_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xa4000)
 #define MX25_GPIO4_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0x9c000)
 
-#define MX25_IO_ADDRESS(x) (					\
-	IMX_IO_ADDRESS(x, MX25_AIPS1) ?:			\
-	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
-	IMX_IO_ADDRESS(x, MX25_AVIC))
+#define MX25_IO_P2V(x)	(					\
+	IMX_IO_P2V_MODULE(x, MX25_AIPS1) ?:			\
+	IMX_IO_P2V_MODULE(x, MX25_AIPS2) ?:			\
+	IMX_IO_P2V_MODULE(x, MX25_AVIC))
+#define MX25_IO_ADDRESS(x)		IOMEM(MX25_IO_P2V(x))
 
 #define MX25_AIPS1_IO_ADDRESS(x) \
 	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 2237ba2..c769cc8 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -123,10 +123,11 @@
 /* IRAM */
 #define MX27_IRAM_BASE_ADDR		0xffff4c00	/* internal ram */
 
-#define MX27_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
-	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
-	IMX_IO_ADDRESS(x, MX27_X_MEMC))
+#define MX27_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX27_AIPI) ?:				\
+	IMX_IO_P2V_MODULE(x, MX27_SAHB1) ?:				\
+	IMX_IO_P2V_MODULE(x, MX27_X_MEMC))
+#define MX27_IO_ADDRESS(x)		IOMEM(MX27_IO_P2V(x))
 
 #ifndef __ASSEMBLER__
 static inline void mx27_setup_weimcs(size_t cs,
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 61cfe82..eb4a28d 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -121,12 +121,13 @@
 
 #define MX31_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-#define MX31_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX31_AIPS1) ?:				\
-	IMX_IO_ADDRESS(x, MX31_AIPS2) ?:				\
-	IMX_IO_ADDRESS(x, MX31_AVIC) ?:					\
-	IMX_IO_ADDRESS(x, MX31_X_MEMC) ?:				\
-	IMX_IO_ADDRESS(x, MX31_SPBA0))
+#define MX31_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX31_AIPS1) ?:				\
+	IMX_IO_P2V_MODULE(x, MX31_AIPS2) ?:				\
+	IMX_IO_P2V_MODULE(x, MX31_AVIC) ?:				\
+	IMX_IO_P2V_MODULE(x, MX31_X_MEMC) ?:				\
+	IMX_IO_P2V_MODULE(x, MX31_SPBA0))
+#define MX31_IO_ADDRESS(x)		IOMEM(MX31_IO_P2V(x))
 
 #ifndef __ASSEMBLER__
 static inline void mx31_setup_weimcs(size_t cs,
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 6267cff..ce1a24b 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -114,12 +114,13 @@
 #define MX35_NFC_BASE_ADDR		0xbb000000
 #define MX35_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
-#define MX35_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX35_AIPS1) ?:				\
-	IMX_IO_ADDRESS(x, MX35_AIPS2) ?:				\
-	IMX_IO_ADDRESS(x, MX35_AVIC) ?:					\
-	IMX_IO_ADDRESS(x, MX35_X_MEMC) ?:				\
-	IMX_IO_ADDRESS(x, MX35_SPBA0))
+#define MX35_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX35_AIPS1) ?:				\
+	IMX_IO_P2V_MODULE(x, MX35_AIPS2) ?:				\
+	IMX_IO_P2V_MODULE(x, MX35_AVIC) ?:				\
+	IMX_IO_P2V_MODULE(x, MX35_X_MEMC) ?:				\
+	IMX_IO_P2V_MODULE(x, MX35_SPBA0))
+#define MX35_IO_ADDRESS(x)		IOMEM(MX35_IO_P2V(x))
 
 /*
  * Interrupt numbers
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index 2af7a10..e93cf5b 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -163,12 +163,13 @@
 #define MX51_GPU2D_BASE_ADDR		0xd0000000
 #define MX51_TZIC_BASE_ADDR		0xe0000000
 
-#define MX51_IO_ADDRESS(x) (						\
-	IMX_IO_ADDRESS(x, MX51_IRAM) ?:					\
-	IMX_IO_ADDRESS(x, MX51_DEBUG) ?:				\
-	IMX_IO_ADDRESS(x, MX51_SPBA0) ?:				\
-	IMX_IO_ADDRESS(x, MX51_AIPS1) ?:				\
-	IMX_IO_ADDRESS(x, MX51_AIPS2))
+#define MX51_IO_P2V(x)	(						\
+	IMX_IO_P2V_MODULE(x, MX51_IRAM) ?:				\
+	IMX_IO_P2V_MODULE(x, MX51_DEBUG) ?:				\
+	IMX_IO_P2V_MODULE(x, MX51_SPBA0) ?:				\
+	IMX_IO_P2V_MODULE(x, MX51_AIPS1) ?:				\
+	IMX_IO_P2V_MODULE(x, MX51_AIPS2))
+#define MX51_IO_ADDRESS(x)		IOMEM(MX51_IO_P2V(x))
 
 /* This is currently used in <mach/debug-macro.S>, but should go away */
 #define MX51_AIPS1_IO_ADDRESS(x)  \
diff --git a/arch/arm/plat-mxc/include/mach/mxc91231.h b/arch/arm/plat-mxc/include/mach/mxc91231.h
index 0ca3101..49e5e25 100644
--- a/arch/arm/plat-mxc/include/mach/mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/mxc91231.h
@@ -187,15 +187,16 @@
  * it returns 0.
  */
 
-#define MXC91231_IO_ADDRESS(x) (					\
-	IMX_IO_ADDRESS(x, MXC91231_L2CC) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_X_MEMC) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_ROMP) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_AVIC) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_AIPS1) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_SPBA0) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_SPBA1) ?:				\
-	IMX_IO_ADDRESS(x, MXC91231_AIPS2))
+#define MXC91231_IO_P2V(x)	(					\
+	IMX_IO_P2V_MODULE(x, MXC91231_L2CC) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_X_MEMC) ?:			\
+	IMX_IO_P2V_MODULE(x, MXC91231_ROMP) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_AVIC) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_AIPS1) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_SPBA0) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_SPBA1) ?:				\
+	IMX_IO_P2V_MODULE(x, MXC91231_AIPS2))
+#define MXC91231_IO_ADDRESS(x)		IOMEM(MXC91231_IO_P2V(x))
 
 /*
  * Interrupt numbers
-- 
1.7.2.3
