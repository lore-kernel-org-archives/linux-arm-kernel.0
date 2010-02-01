From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Feb 2010 17:01:32 +0100
Subject: [PATCH 5/8] mxc91231: redefine MXC91231_IO_ADDRESS using
	IMX_IO_ADDRESS
In-Reply-To: <20100201155625.GA22413@pengutronix.de>
References: <20100201155625.GA22413@pengutronix.de>
Message-ID: <1265040095-31656-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the macro and makes is similar to the other
..._IO_ADDRESS macros defined for imx SOCs.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mxc91231.h |   58 +++++------------------------
 1 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc91231.h b/arch/arm/plat-mxc/include/mach/mxc91231.h
index 81484d1..5182b98 100644
--- a/arch/arm/plat-mxc/include/mach/mxc91231.h
+++ b/arch/arm/plat-mxc/include/mach/mxc91231.h
@@ -184,60 +184,22 @@
 #define MXC91231_CS4_BASE_ADDR		0xB4000000
 #define MXC91231_CS5_BASE_ADDR		0xB6000000
 
-/* Is given address belongs to the specified memory region? */
-#define ADDRESS_IN_REGION(addr, start, size) \
-	(((addr) >= (start)) && ((addr) < (start)+(size)))
-
-/* Is given address belongs to the specified named `module'? */
-#define MXC91231_IS_MODULE(addr, module) \
-	ADDRESS_IN_REGION(addr, MXC91231_ ## module ## _BASE_ADDR, \
-	                        MXC91231_ ## module ## _SIZE)
 /*
  * This macro defines the physical to virtual address mapping for all the
  * peripheral modules. It is used by passing in the physical address as x
  * and returning the virtual address. If the physical address is not mapped,
- * it returns 0xDEADBEEF
- */
-
-#define MXC91231_IO_ADDRESS(x) \
-	(void __iomem *) \
-	(MXC91231_IS_MODULE(x, L2CC) ? MXC91231_L2CC_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, AIPS1) ? MXC91231_AIPS1_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, AIPS2) ? MXC91231_AIPS2_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, SPBA0) ? MXC91231_SPBA0_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, SPBA1) ? MXC91231_SPBA1_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, ROMP) ? MXC91231_ROMP_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, AVIC) ? MXC91231_AVIC_IO_ADDRESS(x) : \
-	 MXC91231_IS_MODULE(x, X_MEMC) ? MXC91231_X_MEMC_IO_ADDRESS(x) : \
-	 0xDEADBEEF)
-
-
-/*
- * define the address mapping macros: in physical address order
+ * it returns 0.
  */
-#define MXC91231_L2CC_IO_ADDRESS(x)  \
-	(((x) - MXC91231_L2CC_BASE_ADDR) + MXC91231_L2CC_BASE_ADDR_VIRT)
-
-#define MXC91231_AIPS1_IO_ADDRESS(x)  \
-	(((x) - MXC91231_AIPS1_BASE_ADDR) + MXC91231_AIPS1_BASE_ADDR_VIRT)
-
-#define MXC91231_SPBA0_IO_ADDRESS(x)  \
-	(((x) - MXC91231_SPBA0_BASE_ADDR) + MXC91231_SPBA0_BASE_ADDR_VIRT)
-
-#define MXC91231_SPBA1_IO_ADDRESS(x)  \
-	(((x) - MXC91231_SPBA1_BASE_ADDR) + MXC91231_SPBA1_BASE_ADDR_VIRT)
-
-#define MXC91231_AIPS2_IO_ADDRESS(x)  \
-	(((x) - MXC91231_AIPS2_BASE_ADDR) + MXC91231_AIPS2_BASE_ADDR_VIRT)
-
-#define MXC91231_ROMP_IO_ADDRESS(x)  \
-	(((x) - MXC91231_ROMP_BASE_ADDR) + MXC91231_ROMP_BASE_ADDR_VIRT)
-
-#define MXC91231_AVIC_IO_ADDRESS(x)  \
-	(((x) - MXC91231_AVIC_BASE_ADDR) + MXC91231_AVIC_BASE_ADDR_VIRT)
 
-#define MXC91231_X_MEMC_IO_ADDRESS(x)  \
-	(((x) - MXC91231_X_MEMC_BASE_ADDR) + MXC91231_X_MEMC_BASE_ADDR_VIRT)
+#define MXC91231_IO_ADDRESS(x) (					\
+	IMX_IO_ADDRESS(x, MXC91231_L2CC) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_X_MEMC) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_ROMP) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_AVIC) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_AIPS1) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_SPBA0) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_SPBA1) ?:				\
+	IMX_IO_ADDRESS(x, MXC91231_AIPS2))
 
 /*
  * Interrupt numbers
-- 
1.6.6
