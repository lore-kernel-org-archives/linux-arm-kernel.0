From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 23:34:37 +0200
Subject: [PATCH 09/24] ARM: ixp4xx: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-1-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <1347658492-11608-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM is moving to stricter checks on readl/write functions,
so we need to use the correct types everywhere.

At the moment, this patch conflicts with other patches in linux-next,
need to sort this out.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/common.c                   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 8c9cd5d..fdf91a1 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -70,7 +70,7 @@ static struct map_desc ixp4xx_io_desc[] __initdata = {
 	},
 #ifdef CONFIG_DEBUG_LL
 	{	/* Debug UART mapping */
-		.virtual	= IXP4XX_DEBUG_UART_BASE_VIRT,
+		.virtual	= (unsigned long)IXP4XX_DEBUG_UART_BASE_VIRT,
 		.pfn		= __phys_to_pfn(IXP4XX_DEBUG_UART_BASE_PHYS),
 		.length		= IXP4XX_DEBUG_UART_REGION_SIZE,
 		.type		= MT_DEVICE
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index 2272f5a..eb68b61 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -49,21 +49,21 @@
  * Expansion BUS Configuration registers
  */
 #define IXP4XX_EXP_CFG_BASE_PHYS	(0xC4000000)
-#define IXP4XX_EXP_CFG_BASE_VIRT	(0xFFBFE000)
+#define IXP4XX_EXP_CFG_BASE_VIRT	IOMEM(0xFFBFE000)
 #define IXP4XX_EXP_CFG_REGION_SIZE	(0x00001000)
 
 /*
  * PCI Config registers
  */
 #define IXP4XX_PCI_CFG_BASE_PHYS	(0xC0000000)
-#define	IXP4XX_PCI_CFG_BASE_VIRT	(0xFFBFF000)
+#define	IXP4XX_PCI_CFG_BASE_VIRT	IOMEM(0xFFBFF000)
 #define IXP4XX_PCI_CFG_REGION_SIZE	(0x00001000)
 
 /*
  * Peripheral space
  */
 #define IXP4XX_PERIPHERAL_BASE_PHYS	(0xC8000000)
-#define IXP4XX_PERIPHERAL_BASE_VIRT	(0xFFBEB000)
+#define IXP4XX_PERIPHERAL_BASE_VIRT	IOMEM(0xFFBEB000)
 #define IXP4XX_PERIPHERAL_REGION_SIZE	(0x00013000)
 
 /*
@@ -73,7 +73,7 @@
  * aligned so that it * can be used with the low-level debug code.
  */
 #define	IXP4XX_DEBUG_UART_BASE_PHYS	(0xC8000000)
-#define	IXP4XX_DEBUG_UART_BASE_VIRT	(0xffb00000)
+#define	IXP4XX_DEBUG_UART_BASE_VIRT	IOMEM(0xffb00000)
 #define	IXP4XX_DEBUG_UART_REGION_SIZE	(0x00001000)
 
 #define IXP4XX_EXP_CS0_OFFSET	0x00
-- 
1.7.10
