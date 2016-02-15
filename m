From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 15 Feb 2016 17:05:17 +0100
Subject: [PATCH 1/3] ARM: zynq: Move early printk virtual address to vmalloc
 area
Message-ID: <67c9013fc61f53515934b54847a05df8b8e1504a.1455552315.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch
"ARM: 8432/1: move VMALLOC_END from 0xff000000 to 0xff800000"
(sha1: 6ff0966052c46efb53980b8a1add2e7b49c9f560)
has moved also start of VMALLOC area because size didn't change.
That's why origin location of vmalloc was
   vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
and now is
   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)

That's why uart virtual addresses need to be changed to reflect this new
memory setup. Starting address should be vmalloc start address.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/include/debug/zynq.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index de86b9247564..060cb5b49bfd 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -20,9 +20,9 @@
 #define UART_SR_TXEMPTY		0x00000008	/* TX FIFO empty */
 
 #define UART0_PHYS		0xE0000000
-#define UART0_VIRT		0xF0000000
+#define UART0_VIRT		0xF0800000
 #define UART1_PHYS		0xE0001000
-#define UART1_VIRT		0xF0001000
+#define UART1_VIRT		0xF0801000
 
 #if IS_ENABLED(CONFIG_DEBUG_ZYNQ_UART1)
 # define LL_UART_PADDR		UART1_PHYS
-- 
1.9.1
