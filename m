From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:10 +0900
Subject: [PATCH 1/8] ARM: S5P: Remove fixed uart offset dependent code
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

The uart offset between channels has been 0x400 for all S5P series
and to present virtual and physical offsets, both number 0x400 and
S3C_UART_OFFSET have been used together.
This patch removes the use of the number 0x400 and expands the virtual
mapping size of S3C_VA_UART from 4KB to 512KB to support the CPU with
S3C_UART_OFFSET being 0x10000.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/cpu.c                  |    2 +-
 arch/arm/plat-s5p/include/plat/map-s5p.h |   11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index 75cb8c3..c478441 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -81,7 +81,7 @@ static struct map_desc s5p_iodesc[] __initdata = {
 	}, {
 		.virtual	= (unsigned long)S3C_VA_UART,
 		.pfn		= __phys_to_pfn(S3C_PA_UART),
-		.length		= SZ_4K,
+		.length		= SZ_512K,
 		.type		= MT_DEVICE,
 	}, {
 		.virtual	= (unsigned long)VA_VIC0,
diff --git a/arch/arm/plat-s5p/include/plat/map-s5p.h b/arch/arm/plat-s5p/include/plat/map-s5p.h
index 1482852..3d815f4 100644
--- a/arch/arm/plat-s5p/include/plat/map-s5p.h
+++ b/arch/arm/plat-s5p/include/plat/map-s5p.h
@@ -18,12 +18,15 @@
 #define S5P_VA_SYSTIMER		S3C_ADDR(0x01200000)
 #define S5P_VA_SROMC		S3C_ADDR(0x01100000)
 
-#define S5P_VA_UART0		(S3C_VA_UART + 0x0)
-#define S5P_VA_UART1		(S3C_VA_UART + 0x400)
-#define S5P_VA_UART2		(S3C_VA_UART + 0x800)
-#define S5P_VA_UART3		(S3C_VA_UART + 0xC00)
+#define S5P_VA_UART(x)		(S3C_VA_UART + ((x) * S3C_UART_OFFSET))
+#define S5P_VA_UART0		S5P_VA_UART(0)
+#define S5P_VA_UART1		S5P_VA_UART(1)
+#define S5P_VA_UART2		S5P_VA_UART(2)
+#define S5P_VA_UART3		S5P_VA_UART(3)
 
+#ifndef S3C_UART_OFFSET
 #define S3C_UART_OFFSET		(0x400)
+#endif
 
 #define VA_VIC(x)		(S3C_VA_IRQ + ((x) * 0x10000))
 #define VA_VIC0			VA_VIC(0)
-- 
1.6.2.5
