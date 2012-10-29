From: josh.cartwright@ni.com (Josh Cartwright)
Date: Mon, 29 Oct 2012 10:56:21 -0600
Subject: [PATCH] ARM: zynq: Allow UART1 to be used as DEBUG_LL console.
In-Reply-To: <1351205254-2409-1-git-send-email-nbowler@elliptictech.com>
References: <20121025224108.GA30705@elliptictech.com>
 <1351205254-2409-1-git-send-email-nbowler@elliptictech.com>
Message-ID: <20121029165621.GF5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2012 at 06:47:34PM -0400, Nick Bowler wrote:
> The main UART on the Xilinx ZC702 board is UART1, located at address
> e0001000.  Add a Kconfig option to select this device as the low-level
> debugging port.  This allows the really early boot printouts to reach
> the USB serial adaptor on this board.
> 
> For consistency's sake, add a choice entry for UART0 even though it is
> the the default if UART1 is not selected.
> 
> As there are currently known issues related to the UART virtual
> mappings, this is KNOWN BROKEN, not to be merged yet!
> 
> Not-Yet-Signed-off-by: Nick Bowler <nbowler@elliptictech.com>

Tested-by: Josh Cartwright <josh.cartwright@ni.com>

Now that v5 of the initial zynq cleanup patchset is queued up for
merging (with a workaround for the uart mapping problem), what would it
take for you to sign off on this patch?

There is some trivial merging that has to be done to get it to apply
cleanly on v5.  See a rebased version below.

Thanks,
  Josh

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..7754d51 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -132,6 +132,23 @@ choice
 		  their output to UART1 serial port on DaVinci TNETV107X
 		  devices.
 
+	config DEBUG_ZYNQ_UART0
+		bool "Kernel low-level debugging on Xilinx Zynq using UART0"
+		depends on ARCH_ZYNQ
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 on the Zynq platform.
+
+	config DEBUG_ZYNQ_UART1
+		bool "Kernel low-level debugging on Xilinx Zynq using UART1"
+		depends on ARCH_ZYNQ
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART1 on the Zynq platform.
+
+		  If you have a ZC702 board and want early boot messages to
+		  appear on the USB serial adaptor, select this option.
+
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
 		depends on FOOTBRIDGE
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index ba8d14f..93b9105 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -84,9 +84,9 @@ static struct map_desc io_desc[] __initdata = {
 
 #ifdef CONFIG_DEBUG_LL
 	{
-		.virtual	= UART0_VIRT,
-		.pfn		= __phys_to_pfn(UART0_PHYS),
-		.length		= UART0_SIZE,
+		.virtual	= LL_UART_VADDR,
+		.pfn		= __phys_to_pfn(LL_UART_PADDR),
+		.length		= UART_SIZE,
 		.type		= MT_DEVICE,
 	},
 #endif
diff --git a/arch/arm/mach-zynq/include/mach/zynq_soc.h b/arch/arm/mach-zynq/include/mach/zynq_soc.h
index 1b8bf0e..7f4f38b 100644
--- a/arch/arm/mach-zynq/include/mach/zynq_soc.h
+++ b/arch/arm/mach-zynq/include/mach/zynq_soc.h
@@ -25,8 +25,9 @@
  * address that is known to work.
  */
 #define UART0_PHYS		0xE0000000
-#define UART0_SIZE		SZ_4K
-#define UART0_VIRT		0xF0001000
+#define UART1_PHYS		0xE0001000
+#define UART_SIZE		SZ_4K
+#define UART_VIRT		0xF0001000
 
 #define TTC0_PHYS		0xF8001000
 #define TTC0_SIZE		SZ_4K
@@ -36,12 +37,17 @@
 #define SCU_PERIPH_SIZE		SZ_8K
 #define SCU_PERIPH_VIRT		(TTC0_VIRT - SCU_PERIPH_SIZE)
 
+#if IS_ENABLED(CONFIG_DEBUG_ZYNQ_UART1)
+#	define LL_UART_PADDR	UART1_PHYS
+#	define LL_UART_VADDR	UART_VIRT
+#else
+#	define LL_UART_PADDR	UART0_PHYS
+#	define LL_UART_VADDR	UART_VIRT
+#endif
+
 /* The following are intended for the devices that are mapped early */
 
 #define TTC0_BASE			IOMEM(TTC0_VIRT)
 #define SCU_PERIPH_BASE			IOMEM(SCU_PERIPH_VIRT)
 
-#define LL_UART_PADDR	UART0_PHYS
-#define LL_UART_VADDR	UART0_VIRT
-
 #endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121029/8d89fb91/attachment-0001.sig>
