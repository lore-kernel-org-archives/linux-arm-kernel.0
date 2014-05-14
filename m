From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 14 May 2014 16:53:29 +0200
Subject: [PATCH] ARM: zynq: Fix uart0 early console virtual address
Message-ID: <c2e5957287cc60655ac4cdd754bb34e874865d2a.1400079202.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Virtual address have to have the same offset within
a 2MB aligned section of virtual/phycial address space.

Fix uart0 virtual address to be align with physical one.
Also remove UART_SIZE which is completely unused.

Reported-by: Russ Smith <russells@google.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/include/debug/zynq.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index 0b762fafa758..3edfef7b34ae 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -20,18 +20,18 @@
 #define UART_SR_TXEMPTY		0x00000008	/* TX FIFO empty */

 #define UART0_PHYS		0xE0000000
+#define UART0_VIRT		0xF0000000
 #define UART1_PHYS		0xE0001000
-#define UART_SIZE		SZ_4K
-#define UART_VIRT		0xF0001000
+#define UART1_VIRT		0xF0001000

 #if IS_ENABLED(CONFIG_DEBUG_ZYNQ_UART1)
 # define LL_UART_PADDR		UART1_PHYS
+# define LL_UART_VADDR		UART1_VIRT
 #else
 # define LL_UART_PADDR		UART0_PHYS
+# define LL_UART_VADDR		UART0_VIRT
 #endif

-#define LL_UART_VADDR		UART_VIRT
-
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =LL_UART_PADDR	@ physical
 		ldr	\rv, =LL_UART_VADDR	@ virtual
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/6dfcd305/attachment-0001.sig>
