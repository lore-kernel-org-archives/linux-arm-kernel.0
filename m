From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 7 Jan 2012 13:07:34 +0100
Subject: Atmel at91x40 ("EB01" eval board) resurected
In-Reply-To: <4EFD107A.4010902@snapgear.com>
References: <CALz2mmXcAk9ZOsAzKMbKVVJ2+Et02+Gxj_z6xSgukC5LjgJTLg@mail.gmail.com>
 <4EFD107A.4010902@snapgear.com>
Message-ID: <20120107120734.GF2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:14 Fri 30 Dec     , Greg Ungerer wrote:
> Hi Phil,
> 
> On 23/12/11 13:18, Phil Budne wrote:
> >I'm new here, so please excuse any protocol violations!
> >
> >I decided to see if I could bring up current kernel sources under
> >skyeye  (at91x40 simulation).
> >I've also been working on a port to the more modern AT91SAM7SE using QEMU.
> >
> >Attached are:
> >
> >diffs from sources from git://github.com/at91linux/linux-at91.git
> >  master branch (current as of 12/21/11)
> >  many of the changes are in generic arch/arm files.
> >
> >Tested on Simulated at91x40xxx "EB01" board
> >kernel built using attached defconfig file.
> 
> There is an at91x40 defconfig in arch/arm/configs/at91x40_defconfig.
> Did you start with that?
> 
> I notice that the processor ID you have in your defconfig is quite
> different to the one in there...
> 
> 
> >4M of RAM at 0x1000000
> >XIP kernel loaded in 4M (of "flash") at 0x1400000
> >root filesystem is a compiled in initramfs
> >   too much pain to build ROMfs and map;
> >    (drivers/mtd/maps/uclinux.c requires rootfs appended after kernel
> >     "uClinux" 11/11/11 dist uclinux.c allows rootfs image at fixed location)
> >
> >
> >new file attached: mach/arm/mach-at91/at91x40_devices.c
> >
> >Runs on locally modified skyeye
> >  based on skyeye-v1.2_Rel.tar (had trouble building latest release)
> >  adds interrupt driven UART output
> >  tweaked for programmed I/O UART input
> >  fix for loading XIP data section (load at physical, not virtual address)
> >
> >Problems:
> >  repeated "free" commands show loss of 12K each time (see atached typescript)
> >  same sh binary (from skyeye test suite)
> >    does not exhibit this on 2.6 and 2.4 kernels (from the skyeye test suite).
> >  breakpointing sys_munmap shows len==0 (could it be an ABI issue?)
> 
> Some comments on the changes below. Ultimately though you need to break this
> single diff up into well defined logical changes. In other words make a patch
> series out of it.
> 
> 
> >diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> >index a8997d7..fcb5757 100644
> >--- a/arch/arm/include/asm/memory.h
> >+++ b/arch/arm/include/asm/memory.h
> >@@ -116,6 +116,8 @@
> > #define MODULES_END		(END_MEM)
> > #define MODULES_VADDR		(PHYS_OFFSET)
> >
> >+#define XIP_VIRT_ADDR(physaddr)  (physaddr)
> >+
> > #endif /* !CONFIG_MMU */
> >
> > /*
> >diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> >index 3448a3f..a63102b 100644
> >--- a/arch/arm/kernel/setup.c
> >+++ b/arch/arm/kernel/setup.c
> >@@ -60,8 +60,12 @@
> > #include "tcm.h"
> >
> > #ifndef MEM_SIZE
> >+#ifdef CONFIG_DRAM_SIZE
> >+#define MEM_SIZE	CONFIG_DRAM_SIZE
> >+#else
> > #define MEM_SIZE	(16*1024*1024)
> > #endif
> >+#endif
> >
> > #if defined(CONFIG_FPE_NWFPE) || defined(CONFIG_FPE_FASTFPE)
> > char fpe_type[8];
> >diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> >index 20b3041..26c7411 100644
> >--- a/arch/arm/kernel/vmlinux.lds.S
> >+++ b/arch/arm/kernel/vmlinux.lds.S
> >@@ -288,6 +288,7 @@ SECTIONS
> > 	NOTES
> >
> > 	BSS_SECTION(0, 0, 0)
> >+	_ebss = .;			/* uClinux MTD */
> 
> You don't need this if you are not using the MTD/uclinux.o driver.
> And your defconfig doesn't have this enabled.
> 
> 
> > 	_end = .;
> >
> > 	STABS_DEBUG
> >diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> >index 242174f..babb6c6 100644
> >--- a/arch/arm/mach-at91/Makefile
> >+++ b/arch/arm/mach-at91/Makefile
> >@@ -19,7 +19,7 @@ obj-$(CONFIG_ARCH_AT91SAM9RL)	+= at91sam9rl.o at91sam926x_time.o at91sam9rl_devi
> > obj-$(CONFIG_ARCH_AT91SAM9G20)	+= at91sam9260.o at91sam926x_time.o at91sam9260_devices.o sam9_smc.o at91sam9_alt_reset.o
> > obj-$(CONFIG_ARCH_AT91SAM9G45)	+= at91sam9g45.o at91sam926x_time.o at91sam9g45_devices.o sam9_smc.o
> > obj-$(CONFIG_ARCH_AT91CAP9)	+= at91cap9.o at91sam926x_time.o at91cap9_devices.o sam9_smc.o
> >-obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o
> >+obj-$(CONFIG_ARCH_AT91X40)	+= at91x40.o at91x40_time.o at91x40_devices.o
> >
> > # AT91RM9200 board-specific support
> > obj-$(CONFIG_MACH_ONEARM)	+= board-1arm.o
> >diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
> >index 56ba3bd..4d5a475 100644
> >--- a/arch/arm/mach-at91/at91x40.c
> >+++ b/arch/arm/mach-at91/at91x40.c
> >@@ -73,6 +73,6 @@ void __init at91x40_init_interrupts(unsigned int priority[NR_AIC_IRQS])
> > 	if (!priority)
> > 		priority = at91x40_default_irq_priority;
> >
> >-	at91_aic_init(priority);
> >+	at91_init_interrupts(priority);
> > }
> >
> >diff --git a/arch/arm/mach-at91/board-eb01.c b/arch/arm/mach-at91/board-eb01.c
> >index d2023f2..902ade9 100644
> >--- a/arch/arm/mach-at91/board-eb01.c
> >+++ b/arch/arm/mach-at91/board-eb01.c
> >@@ -38,6 +38,21 @@ static void __init at91eb01_init_irq(void)
> > static void __init at91eb01_init_early(void)
> > {
> > 	at91x40_initialize(40000000);
> >+
> >+	/* USART0 ttyS0. (Rx & Tx only) */
> >+	at91_register_uart(AT91X40_ID_USART0, 0, 0);
> >+
> >+	/* USART1 ttyS1. (Rx & Tx only) */
> >+	at91_register_uart(AT91X40_ID_USART1, 1, 0);
> >+
> >+	/* set serial console to ttyS0 (USART0) */
> >+	at91_set_serial_console(0);
> >+}
> >+
> >+static void __init at91eb01_init_machine(void)
> >+{
> >+	/* Serial */
> >+	at91_add_device_serial();
> > }
> >
> > MACHINE_START(AT91EB01, "Atmel AT91 EB01")
> >@@ -45,5 +60,5 @@ MACHINE_START(AT91EB01, "Atmel AT91 EB01")
> > 	.timer		= &at91x40_timer,
> > 	.init_early	= at91eb01_init_early,
> > 	.init_irq	= at91eb01_init_irq,
> >+	.init_machine	= at91eb01_init_machine,
> > MACHINE_END
> >-
> >diff --git a/arch/arm/mach-at91/include/mach/at91x40.h b/arch/arm/mach-at91/include/mach/at91x40.h
> >index a152ff8..8d3c57c 100644
> >--- a/arch/arm/mach-at91/include/mach/at91x40.h
> >+++ b/arch/arm/mach-at91/include/mach/at91x40.h
> >@@ -34,8 +34,8 @@
> >
> > #define AT91_EBI	(0xffe00000 - AT91_BASE_SYS)	/* External Bus Interface */
> > #define AT91_SF		(0xfff00000 - AT91_BASE_SYS)	/* Special Function */
> >-#define AT91_USART1	(0xfffcc000 - AT91_BASE_SYS)	/* USART 1 */
> >-#define AT91_USART0	(0xfffd0000 - AT91_BASE_SYS)	/* USART 0 */
> >+#define AT91_USART1	0xfffcc000			/* USART 1 */
> >+#define AT91_USART0	0xfffd0000			/* USART 0 */
> 
> You probably want to leave these as they were. Modify your resource defines
> in at91x40_devices.c and add AT91_BASE_SYS to the AT91_USARTx values. That
> is more consistent with all other users of these defines.
drop AT91_BASE_SYS

I'm dropping it an AT91

don't use at91_sys_read/write too

Best Regards,
J.
