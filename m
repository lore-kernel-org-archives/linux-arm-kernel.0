From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 16 Jul 2010 15:09:06 +0200
Subject: [PATCH 2/3] imx25: fix low level debug
In-Reply-To: <1279285747-7860-1-git-send-email-eric@eukrea.com>
References: <1279285747-7860-1-git-send-email-eric@eukrea.com>
Message-ID: <1279285747-7860-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DEBUG_LL is actually broken on i.MX25, this patch fix it.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c                   |    3 +++
 arch/arm/plat-mxc/include/mach/debug-macro.S |    4 ++--
 arch/arm/plat-mxc/include/mach/mx25.h        |    8 +++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 1a58cae..02f8247 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -292,6 +292,9 @@ int __init mx25_clocks_init(void)
 	__raw_writel((1 << 19), CRM_BASE + CCM_CGCR0);
 	__raw_writel((0xf << 16) | (3 << 26), CRM_BASE + CCM_CGCR1);
 	__raw_writel((1 << 5), CRM_BASE + CCM_CGCR2);
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
+	clk_enable(&uart1_clk);
+#endif
 
 	/* Clock source for lcdc and csi is upll */
 	__raw_writel(__raw_readl(CRM_BASE+0x64) | (1 << 7) | (1 << 0),
diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 0b6e11e..2560640 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -23,8 +23,8 @@
 #error "CONFIG_DEBUG_LL is incompatible with multiple archs"
 #endif
 #include <mach/mx25.h>
-#define UART_PADDR	UART1_BASE_ADDR
-#define UART_VADDR	MX25_AIPS1_IO_ADDRESS(UART1_BASE_ADDR)
+#define UART_PADDR	MX25_UART1_BASE_ADDR
+#define UART_VADDR	MX25_AIPS1_IO_ADDRESS(MX25_UART1_BASE_ADDR)
 #endif
 
 #ifdef CONFIG_ARCH_MX2
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 2f2aad1..11b044f 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -31,6 +31,9 @@
 	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
 	IMX_IO_ADDRESS(x, MX25_AVIC))
 
+#define MX25_AIPS1_IO_ADDRESS(x) \
+	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
+
 #define MX25_UART1_BASE_ADDR		0x43f90000
 #define MX25_UART2_BASE_ADDR		0x43f94000
 #define MX25_AUDMUX_BASE_ADDR		0x43fb0000
@@ -70,9 +73,4 @@
 #define MX25_INT_UART1		45
 #define MX25_INT_FEC		57
 
-#if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
-#define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
-#define UART2_BASE_ADDR			MX25_UART2_BASE_ADDR
-#endif
-
 #endif /* ifndef __MACH_MX25_H__ */
-- 
1.6.3.3
