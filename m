From: Barry.Song@csr.com (Barry Song)
Date: Tue, 22 Jan 2013 20:22:10 +0800
Subject: [PATCH v3 9/9] ARM: PRIMA2: provide two DEBUG_LL ports for prima2 and
 marco
In-Reply-To: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
References: <1358857330-10101-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1358857330-10101-5-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

prima2 and marco has different memory base, the old code will
fail if we enable DEBUG_LL in marco.
this patch adds two debuf port, while debugging, we select one
of PRIMA2 and MARCO debug ports, in the products, we disable
DEBUG_LL.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig.debug                         |   14 ++++++++++++++
 arch/arm/mach-prima2/include/mach/uart.h       |    6 ++++++
 arch/arm/mach-prima2/include/mach/uncompress.h |    3 +++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 661030d..00ad1f8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -386,6 +386,20 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on Tegra based platforms.
 
+	config DEBUG_SIRFPRIMA2_UART1
+		bool "Kernel low-level debugging messages via SiRFprimaII UART1"
+		depends on ARCH_PRIMA2
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart1 port on SiRFprimaII devices.
+
+	config DEBUG_SIRFMARCO_UART1
+		bool "Kernel low-level debugging messages via SiRFmarco UART1"
+		depends on ARCH_MARCO
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the uart1 port on SiRFmarco devices.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
diff --git a/arch/arm/mach-prima2/include/mach/uart.h b/arch/arm/mach-prima2/include/mach/uart.h
index c98b4d5..c10510d 100644
--- a/arch/arm/mach-prima2/include/mach/uart.h
+++ b/arch/arm/mach-prima2/include/mach/uart.h
@@ -10,7 +10,13 @@
 #define __MACH_PRIMA2_SIRFSOC_UART_H
 
 /* UART-1: used as serial debug port */
+#if defined(CONFIG_DEBUG_SIRFPRIMA2_UART1)
 #define SIRFSOC_UART1_PA_BASE          0xb0060000
+#elif defined(CONFIG_DEBUG_SIRFMARCO_UART1)
+#define SIRFSOC_UART1_PA_BASE          0xcc060000
+#else
+#define SIRFSOC_UART1_PA_BASE          0
+#endif
 #define SIRFSOC_UART1_VA_BASE          SIRFSOC_VA(0x060000)
 #define SIRFSOC_UART1_SIZE		SZ_4K
 
diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
index 0c898fc..15f3edc 100644
--- a/arch/arm/mach-prima2/include/mach/uncompress.h
+++ b/arch/arm/mach-prima2/include/mach/uncompress.h
@@ -25,6 +25,9 @@ static __inline__ void putc(char c)
 	 * during kernel decompression, all mappings are flat:
 	 *  virt_addr == phys_addr
 	 */
+	if (!SIRFSOC_UART1_PA_BASE)
+		return;
+
 	while (__raw_readl((void __iomem *)SIRFSOC_UART1_PA_BASE + SIRFSOC_UART_TXFIFO_STATUS)
 		& SIRFSOC_UART1_TXFIFO_FULL)
 		barrier();
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
