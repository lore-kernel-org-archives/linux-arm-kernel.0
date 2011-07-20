From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jul 2011 21:13:19 +0800
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART_PADDR definition for i.mx53 and i.mx50 is missing in
debug-macro.S.  It causes the build of i.mx53/50 fail.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reported-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
Troy,

Since I'm keen to get the build failure fixed, I just repost
the patch you sent with Sascha's comment fixed.  Hope you do
not mind.

 arch/arm/plat-mxc/include/mach/debug-macro.S |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 91fc7cd..8cf8dee 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -44,6 +44,14 @@
 #define UART_PADDR	MX51_UART1_BASE_ADDR
 #endif
 
+#if defined(CONFIG_SOC_IMX50) || defined(CONFIG_SOC_IMX53)
+#ifdef UART_PADDR
+#error "CONFIG_DEBUG_LL is incompatible with multiple archs"
+#endif
+/* i.MX50 gets the same UART1 base address as i.MX53 */
+#define UART_PADDR	MX53_UART1_BASE_ADDR
+#endif
+
 #define UART_VADDR	IMX_IO_ADDRESS(UART_PADDR)
 
 		.macro	addruart, rp, rv
-- 
1.7.4.1
