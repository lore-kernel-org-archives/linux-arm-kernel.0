From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 27 Apr 2012 18:06:15 +0000
Subject: [PATCH v2] ARM: davinci: implement DEBUG_LL port choice
In-Reply-To: <1332408563-18444-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <DF0F476B391FA8409C78302C7BA518B631800A8C@DBDE01.ent.ti.com>
 <1332408563-18444-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <DF0F476B391FA8409C78302C7BA518B63E9EA512@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Thanks for the patch.

On Thu, Mar 22, 2012 at 14:59:23, Uwe Kleine-K?nig wrote:
> Apart from the necessity to do this change for multi-platform kernels
> the previous logic depended on the zImage decompressor to write the
> physical and virtual address to a magic memory location.
> If the decompressor is unused or not correctly configured for the
> current machid, the addruart macro was an infinite loop. Moreover
> debugging the early zImage code was not possible either.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index e0d236d..4c2fb44 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -108,6 +108,22 @@ choice
>  		bool "Kernel low-level debugging on 9263, 9g45 and cap9"
>  		depends on HAVE_AT91_DBGU1
>  
> +	config DEBUG_DAVINCI_UART0
> +		bool "Kernel low-level debugging on Davinci using uart0"
> +		depends on ARCH_DAVINCI_DM644x

I guess this is meant for the traditional DaVinci DM* devices.
The correct "depends on" in that case is ARCH_DAVINCI_DMx. DM644x
is just one of those DaVinci devices. Also, the config is better
named DEBUG_DAVINCI_DMx_UART0 to remain consistent with the
corresponding ARCH_ config.

> +	config DEBUG_DA8XX_UART1

I would prefer calling this DEBUG_DAVINCI_DA8XX_UART0 for the same
reason of naming consistency with the corresponding ARCH_ config.

> +		bool "Kernel low-level debugging on DA8xx using uart1"
> +		depends on ARCH_DAVINCI_DA8XX
> +
> +	config DEBUG_DA8XX_UART2
> +		bool "Kernel low-level debugging on DA8xx using uart2"
> +		depends on ARCH_DAVINCI_DA8XX
> +
> +	config DEBUG_TNETV107X_UART1
> +		bool "Kernel low-level debugging on TNETV107x using uart1"
> +		depends on ARCH_DAVINCI_TNETV107X

There should be some help text associated with each of these macros.

[...]

> diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S

> +#ifndef UART_VIRTBASE
> +#define UART_VIRTBASE IO_ADDRESS(UART_BASE)
> +#endif

Prefer using tabs for indentation here..

> -100:
> +		.macro addruart, rp, rv, tmp
> +		ldr     \rp, =UART_BASE
> +		ldr     \rv, =UART_VIRTBASE

.. and here (after ldr)

[...]

> diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h

> -#define _DEBUG_LL_ENTRY(machine, phys, virt)			\
> +#define _DEBUG_LL_ENTRY(machine, phys)				\
>  	if (machine_is_##machine()) {				\
> -		set_uart_info(phys, virt);			\
> +		set_uart_info(phys);				\
>  		break;						\
>  	}

So, this throws a checkpatch error:

ERROR: Macros with complex values should be enclosed in parenthesis

I made changes for these issues and in the process also made sure the
patch applies cleanly to latest kernel. Here is the updated patch I
intend to queue for v3.5

Thanks,
Sekhar

-----8<-----
Author: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Commit: Sekhar Nori <nsekhar@ti.com>

    ARM: davinci: implement DEBUG_LL port choice
    
    Apart from the necessity to do this change for multi-platform kernels
    the previous logic depended on the zImage decompressor to write the
    physical and virtual address to a magic memory location.
    If the decompressor is unused or not correctly configured for the
    current machid, the addruart macro was an infinite loop. Moreover
    debugging the early zImage code was not possible either.
    
    Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
    [nsekhar at ti.com: add braces in _DEBUG_LL_ENTRY() macro to fix checkpatch
    error. Fix debug port choice config dependency for traditional DaVincis.
    Modify debug port config names and add help text.]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 85348a0..e561adc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -103,6 +103,35 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_DAVINCI_DA8XX_UART1
+		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
+		depends on ARCH_DAVINCI_DA8XX
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART1 serial port on DaVinci DA8XX devices.
+
+	config DEBUG_DAVINCI_DA8XX_UART2
+		bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
+		depends on ARCH_DAVINCI_DA8XX
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART2 serial port on DaVinci DA8XX devices.
+
+	config DEBUG_DAVINCI_DMx_UART0
+		bool "Kernel low-level debugging on DaVinci DMx using UART0"
+		depends on ARCH_DAVINCI_DMx
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART0 serial port on DaVinci DMx devices.
+
+	config DEBUG_DAVINCI_TNETV107X_UART1
+		bool "Kernel low-level debugging on DaVinci TNETV107x using UART1"
+		depends on ARCH_DAVINCI_TNETV107X
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to UART1 serial port on DaVinci TNETV107X
+		  devices.
+
 	config DEBUG_DC21285_PORT
 		bool "Kernel low-level debugging messages via footbridge serial port"
 		depends on FOOTBRIDGE
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index cf94552..34290d1 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -22,46 +22,28 @@
 
 #define UART_SHIFT	2
 
-		.pushsection .data
-davinci_uart_phys:	.word	0
-davinci_uart_virt:	.word	0
-		.popsection
-
-		.macro addruart, rp, rv, tmp
-
-		/* Use davinci_uart_phys/virt if already configured */
-10:		adr	\rp, 99f		@ get effective addr of 99f
-		ldr	\rv, [\rp]		@ get absolute addr of 99f
-		sub	\rv, \rv, \rp		@ offset between the two
-		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
-		sub	\tmp, \rp, \rv		@ make it effective
-		ldr	\rp, [\tmp, #0]		@ davinci_uart_phys
-		ldr	\rv, [\tmp, #4]		@ davinci_uart_virt
-		cmp	\rp, #0			@ is port configured?
-		cmpne	\rv, #0
-		bne	100f			@ already configured
-
-		/* Check the debug UART address set in uncompress.h */
-		and	\rp, pc, #0xff000000
-		ldr	\rv, =DAVINCI_UART_INFO_OFS
-		add	\rp, \rp, \rv
-
-		/* Copy uart phys address from decompressor uart info */
-		ldr	\rv, [\rp, #0]
-		str	\rv, [\tmp, #0]
-
-		/* Copy uart virt address from decompressor uart info */
-		ldr	\rv, [\rp, #4]
-		str	\rv, [\tmp, #4]
-
-		b	10b
+#if defined(CONFIG_DEBUG_DAVINCI_DMx_UART0)
+#define UART_BASE	DAVINCI_UART0_BASE
+#elif defined(CONFIG_DEBUG_DAVINCI_DA8XX_UART0)
+#define UART_BASE	DA8XX_UART0_BASE
+#elif defined(CONFIG_DEBUG_DAVINCI_DA8XX_UART1)
+#define UART_BASE	DA8XX_UART1_BASE
+#elif defined(CONFIG_DEBUG_DAVINCI_DA8XX_UART2)
+#define UART_BASE	DA8XX_UART2_BASE
+#elif defined(CONFIG_DEBUG_DAVINCI_TNETV107X_UART1)
+#define UART_BASE	TNETV107X_UART2_BASE
+#define UART_VIRTBASE	TNETV107X_UART2_VIRT
+#else
+#error "Select a specifc port for DEBUG_LL"
+#endif
 
-		.align
-99:		.word	.
-		.word	davinci_uart_phys
-		.ltorg
+#ifndef UART_VIRTBASE
+#define UART_VIRTBASE	IO_ADDRESS(UART_BASE)
+#endif
 
-100:
+		.macro addruart, rp, rv, tmp
+		ldr	\rp, =UART_BASE
+		ldr	\rv, =UART_VIRTBASE
 		.endm
 
 		.macro	senduart,rd,rx
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 2184691..16bb422 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -22,7 +22,7 @@
 /*
  * I/O mapping
  */
-#define IO_PHYS				0x01c00000UL
+#define IO_PHYS				UL(0x01c00000)
 #define IO_OFFSET			0xfd000000 /* Virtual IO = 0xfec00000 */
 #define IO_SIZE				0x00400000
 #define IO_VIRT				(IO_PHYS + IO_OFFSET)
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index e347d88..46b3cd1 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -15,16 +15,6 @@
 
 #include <mach/hardware.h>
 
-/*
- * Stolen area that contains debug uart physical and virtual addresses.  These
- * addresses are filled in by the uncompress.h code, and are used by the debug
- * macros in debug-macro.S.
- *
- * This area sits just below the page tables (see arch/arm/kernel/head.S).
- * We define it as a relative offset from start of usable RAM.
- */
-#define DAVINCI_UART_INFO_OFS	0x3ff8
-
 #define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
 #define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
 #define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index da2fb2c..18cfd49 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -43,37 +43,27 @@ static inline void flush(void)
 		barrier();
 }
 
-static inline void set_uart_info(u32 phys, void * __iomem virt)
+static inline void set_uart_info(u32 phys)
 {
-	/*
-	 * Get address of some.bss variable and round it down
-	 * a la CONFIG_AUTO_ZRELADDR.
-	 */
-	u32 ram_start = (u32)&uart & 0xf8000000;
-	u32 *uart_info = (u32 *)(ram_start + DAVINCI_UART_INFO_OFS);
-
 	uart = (u32 *)phys;
-	uart_info[0] = phys;
-	uart_info[1] = (u32)virt;
 }
 
-#define _DEBUG_LL_ENTRY(machine, phys, virt)			\
-	if (machine_is_##machine()) {				\
-		set_uart_info(phys, virt);			\
-		break;						\
+#define _DEBUG_LL_ENTRY(machine, phys)				\
+	{							\
+		if (machine_is_##machine()) {			\
+			set_uart_info(phys);			\
+			break;					\
+		}						\
 	}
 
 #define DEBUG_LL_DAVINCI(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DAVINCI_UART##port##_BASE,	\
-			IO_ADDRESS(DAVINCI_UART##port##_BASE))
+	_DEBUG_LL_ENTRY(machine, DAVINCI_UART##port##_BASE)
 
 #define DEBUG_LL_DA8XX(machine, port)				\
-	_DEBUG_LL_ENTRY(machine, DA8XX_UART##port##_BASE,	\
-			IO_ADDRESS(DA8XX_UART##port##_BASE))
+	_DEBUG_LL_ENTRY(machine, DA8XX_UART##port##_BASE)
 
 #define DEBUG_LL_TNETV107X(machine, port)			\
-	_DEBUG_LL_ENTRY(machine, TNETV107X_UART##port##_BASE,	\
-			TNETV107X_UART##port##_VIRT)
+	_DEBUG_LL_ENTRY(machine, TNETV107X_UART##port##_BASE)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
