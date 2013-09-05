From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  5 Sep 2013 19:38:29 +0200
Subject: [PATCH 1/6] RFC: ARM: delete mach-shark
Message-ID: <1378402709-16346-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Shark machine sub-architecture (also known as DNARD, the
DIGITAL Network Appliance Reference Design) lacks a maintainer
able to apply and test patches to modernize the architecture.

It is suspected that the current kernel, while it compiles,
does not even boot on this machine. The listed maintainer has
expressed that he will not be able to spend any time on the
maintenance for the coming year.

So let's delete it from the kernel for now. It can always be
resurrected with git revert if maintenance is resumed.

As the VIA82c505 PCI adapter was only used by this
architecture, that gets deleted too.

Cc: arm at kernel.org
Cc: Alexander Schulz <alex@shark-linux.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                               |  20 --
 arch/arm/Makefile                              |   1 -
 arch/arm/boot/compressed/Makefile              |   4 -
 arch/arm/boot/compressed/head-shark.S          | 140 -------------
 arch/arm/boot/compressed/ofw-shark.c           | 260 -------------------------
 arch/arm/common/Makefile                       |   1 -
 arch/arm/common/via82c505.c                    |  83 --------
 arch/arm/configs/shark_defconfig               |  80 --------
 arch/arm/include/asm/mach/pci.h                |   4 -
 arch/arm/lib/Makefile                          |   1 -
 arch/arm/lib/io-shark.c                        |  13 --
 arch/arm/mach-shark/Makefile                   |  10 -
 arch/arm/mach-shark/Makefile.boot              |   2 -
 arch/arm/mach-shark/core.c                     | 146 --------------
 arch/arm/mach-shark/dma.c                      |  23 ---
 arch/arm/mach-shark/include/mach/debug-macro.S |  34 ----
 arch/arm/mach-shark/include/mach/entry-macro.S |  36 ----
 arch/arm/mach-shark/include/mach/framebuffer.h |  16 --
 arch/arm/mach-shark/include/mach/hardware.h    |  16 --
 arch/arm/mach-shark/include/mach/irqs.h        |  13 --
 arch/arm/mach-shark/include/mach/isa-dma.h     |  13 --
 arch/arm/mach-shark/include/mach/memory.h      |  26 ---
 arch/arm/mach-shark/include/mach/timex.h       |   7 -
 arch/arm/mach-shark/include/mach/uncompress.h  |  50 -----
 arch/arm/mach-shark/irq.c                      | 108 ----------
 arch/arm/mach-shark/leds.c                     | 117 -----------
 arch/arm/mach-shark/pci.c                      |  57 ------
 27 files changed, 1281 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/head-shark.S
 delete mode 100644 arch/arm/boot/compressed/ofw-shark.c
 delete mode 100644 arch/arm/common/via82c505.c
 delete mode 100644 arch/arm/configs/shark_defconfig
 delete mode 100644 arch/arm/lib/io-shark.c
 delete mode 100644 arch/arm/mach-shark/Makefile
 delete mode 100644 arch/arm/mach-shark/Makefile.boot
 delete mode 100644 arch/arm/mach-shark/core.c
 delete mode 100644 arch/arm/mach-shark/dma.c
 delete mode 100644 arch/arm/mach-shark/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-shark/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-shark/include/mach/framebuffer.h
 delete mode 100644 arch/arm/mach-shark/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-shark/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shark/include/mach/isa-dma.h
 delete mode 100644 arch/arm/mach-shark/include/mach/memory.h
 delete mode 100644 arch/arm/mach-shark/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shark/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-shark/irq.c
 delete mode 100644 arch/arm/mach-shark/leds.c
 delete mode 100644 arch/arm/mach-shark/pci.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..3abc395 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -822,20 +822,6 @@ config ARCH_EXYNOS
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
-config ARCH_SHARK
-	bool "Shark"
-	select ARCH_USES_GETTIMEOFFSET
-	select CPU_SA110
-	select ISA
-	select ISA_DMA
-	select NEED_MACH_MEMORY_H
-	select PCI
-	select VIRT_TO_BUS
-	select ZONE_DMA
-	help
-	  Support for the StrongARM based Digital DNARD machine, also known
-	  as "Shark" (<http://www.shark-linux.de/shark.html>).
-
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -1420,12 +1406,6 @@ config PCI_NANOENGINE
 config PCI_SYSCALL
 	def_bool PCI
 
-# Select the host bridge type
-config PCI_HOST_VIA82C505
-	bool
-	depends on PCI && ARCH_SHARK
-	default y
-
 config PCI_HOST_ITE8152
 	bool
 	depends on PCI && MACH_ARMCORE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 6fd2cea..7b7d284 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -188,7 +188,6 @@ machine-$(CONFIG_ARCH_S5P64X0)		+= s5p64x0
 machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
-machine-$(CONFIG_ARCH_SHARK)		+= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
 machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 7ac1610..e7190bb 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -44,10 +44,6 @@ ifeq ($(CONFIG_ARCH_ACORN),y)
 OBJS		+= ll_char_wr.o font.o
 endif
 
-ifeq ($(CONFIG_ARCH_SHARK),y)
-OBJS		+= head-shark.o ofw-shark.o
-endif
-
 ifeq ($(CONFIG_ARCH_SA1100),y)
 OBJS		+= head-sa1100.o
 endif
diff --git a/arch/arm/boot/compressed/head-shark.S b/arch/arm/boot/compressed/head-shark.S
deleted file mode 100644
index 92b5689..0000000
--- a/arch/arm/boot/compressed/head-shark.S
+++ /dev/null
@@ -1,140 +0,0 @@
-/* The head-file for the Shark
- * by Alexander Schulz
- *
- * Does the following:
- * - get the memory layout from firmware. This can only be done as long as the mmu
- *   is still on.
- * - switch the mmu off, so we have physical addresses
- * - copy the kernel to 0x08508000. This is done to have a fixed address where the
- *   C-parts (misc.c) are executed. This address must be known at compile-time,
- *   but the load-address of the kernel depends on how much memory is installed.
- * - Jump to this location.
- * - Set r8 with 0, r7 with the architecture ID for head.S
- */
-
-#include <linux/linkage.h>
-
-#include <asm/assembler.h>
-	
-		.section	".start", "ax"
-
-		.arch armv4
-		b	__beginning
-	
-__ofw_data:	.long	0				@ the number of memory blocks
-		.space  128				@ (startaddr,size) ...
-		.space  128				@ bootargs
-		.align
-
-__beginning:	mov	r4, r0				@ save the entry to the firmware
-
-		mov	r0, #0xC0			@ disable irq and fiq
-		mov	r1, r0
-		mrs	r3, cpsr
-		bic	r2, r3, r0
-		eor	r2, r2, r1
-		msr	cpsr_c, r2
-
-		mov	r0, r4				@ get the Memory layout from firmware
-		adr	r1, __ofw_data
-		add	r2, r1, #4
-		mov	lr, pc
-		b	ofw_init
-		mov	r1, #0
-
-		adr	r2, __mmu_off			@ calculate physical address
-		sub	r2, r2, #0xf0000000		@ openprom maps us at f000 virt, 0e50 phys
-		adr	r0, __ofw_data
-		ldr	r0, [r0, #4]
-		add	r2, r2, r0
-		add	r2, r2, #0x00500000
-
-		mrc	p15, 0, r3, c1, c0
-		bic	r3, r3, #0xC			@ Write Buffer and DCache
-		bic	r3, r3, #0x1000			@ ICache
-		mcr	p15, 0, r3, c1, c0		@ disabled
-
-		mov	r0, #0
-		mcr	p15, 0, r0, c7, c7		@ flush I,D caches on v4
-		mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer on v4
-		mcr	p15, 0, r0, c8, c7		@ flush I,D TLBs on v4
-
-		bic	r3, r3, #0x1			@ MMU
-		mcr	p15, 0, r3, c1, c0		@ disabled
-
-		mov	pc, r2
-
-__copy_target:	.long	0x08507FFC
-__copy_end:	.long	0x08607FFC
-		
-		.word	_start
-		.word	__bss_start
-
-		.align
-__temp_stack:	.space 128
-
-__mmu_off:
-		adr	r0, __ofw_data			@ read the 1. entry of the memory map
-		ldr	r0, [r0, #4]
-		orr	r0, r0, #0x00600000
-		sub	r0, r0, #4
-	
-		ldr	r1, __copy_end
-		ldr	r3, __copy_target
-
-/* r0 = 0x0e600000 (current end of kernelcode)
- * r3 = 0x08508000 (where it should begin)
- * r1 = 0x08608000 (end of copying area, 1MB)
- * The kernel is compressed, so 1 MB should be enough.
- * copy the kernel to the beginning of physical memory
- * We start from the highest address, so we can copy
- * from 0x08500000 to 0x08508000 if we have only 8MB
- */
-
-/* As we get more 2.6-kernels it gets more and more
- * uncomfortable to be bound to kernel images of 1MB only.
- * So we add a loop here, to be able to copy some more.
- * Alexander Schulz 2005-07-17
- */
-
-		mov	r4, #3				@ How many megabytes to copy
-
-
-__MoveCode:	sub	r4, r4, #1
-	
-__Copy:		ldr	r2, [r0], #-4
-		str	r2, [r1], #-4
-		teq	r1, r3
-		bne	__Copy
-
-		/* The firmware maps us in blocks of 1 MB, the next block is
-		   _below_ the last one. So our decrementing source pointer
-		   ist right here, but the destination pointer must be increased
-		   by 2 MB */
-		add	r1, r1, #0x00200000
-		add	r3, r3, #0x00100000
-
-		teq	r4, #0
-		bne	__MoveCode
-
-
-		/* and jump to it */
-		adr	r2, __go_on			@ where we want to jump
-		adr	r0, __ofw_data			@ read the 1. entry of the memory map
-		ldr	r0, [r0, #4]
-		sub	r2, r2, r0			@ we are mapped add 0e50 now, sub that (-0e00)
-		sub	r2, r2, #0x00500000		@ -0050
-		ldr	r0, __copy_target		@ and add 0850 8000 instead
-		add	r0, r0, #4
-		add	r2, r2, r0
-		mov	pc, r2				@ and jump there
-
-__go_on:
-		adr	sp, __temp_stack
-		add	sp, sp, #128
-		adr	r0, __ofw_data
-		mov	lr, pc
-		b	create_params
-	
-		mov	r8, #0
-		mov	r7, #15
diff --git a/arch/arm/boot/compressed/ofw-shark.c b/arch/arm/boot/compressed/ofw-shark.c
deleted file mode 100644
index 465c54b..0000000
--- a/arch/arm/boot/compressed/ofw-shark.c
+++ /dev/null
@@ -1,260 +0,0 @@
-/*
- * linux/arch/arm/boot/compressed/ofw-shark.c
- *
- * by Alexander Schulz
- *
- * This file is used to get some basic information
- * about the memory layout of the shark we are running
- * on. Memory is usually divided in blocks a 8 MB.
- * And bootargs are copied from OpenFirmware.
- */
-
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <asm/setup.h>
-#include <asm/page.h>
-
-
-asmlinkage void
-create_params (unsigned long *buffer)
-{
-	/* Is there a better address? Also change in mach-shark/core.c */
-	struct tag *tag = (struct tag *) 0x08003000;
-	int j,i,m,k,nr_banks,size;
-	unsigned char *c;
-
-	k = 0;
-
-	/* Head of the taglist */
-	tag->hdr.tag  = ATAG_CORE;
-	tag->hdr.size = tag_size(tag_core);
-	tag->u.core.flags = 1;
-	tag->u.core.pagesize = PAGE_SIZE;
-	tag->u.core.rootdev = 0;
-
-	/* Build up one tagged block for each memory region */
-	size=0;
-	nr_banks=(unsigned int) buffer[0];
-	for (j=0;j<nr_banks;j++){
-		/* search the lowest address and put it into the next entry   */
-		/* not a fast sort algorithm, but there are@most 8 entries */
-		/* and this is used only once anyway                          */
-		m=0xffffffff;
-		for (i=0;i<(unsigned int) buffer[0];i++){
-			if (buffer[2*i+1]<m) {
-				m=buffer[2*i+1];
-				k=i;
-			}
-		}
-	  
-		tag = tag_next(tag);
-		tag->hdr.tag = ATAG_MEM;
-		tag->hdr.size = tag_size(tag_mem32);
-		tag->u.mem.size = buffer[2*k+2];
-		tag->u.mem.start = buffer[2*k+1];
-
-		size += buffer[2*k+2];
-
-		buffer[2*k+1]=0xffffffff;                    /* mark as copied */
-	}
-	
-	/* The command line */
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_CMDLINE;
-	
-	c=(unsigned char *)(&buffer[34]);
-	j=0;
-	while (*c) tag->u.cmdline.cmdline[j++]=*c++;
-
-	tag->u.cmdline.cmdline[j]=0;
-	tag->hdr.size = (j + 7 + sizeof(struct tag_header)) >> 2;
-
-	/* Hardware revision */
-	tag = tag_next(tag);
-	tag->hdr.tag = ATAG_REVISION;
-	tag->hdr.size = tag_size(tag_revision);
-	tag->u.revision.rev = ((unsigned char) buffer[33])-'0';
-
-	/* End of the taglist */
-	tag = tag_next(tag);
-	tag->hdr.tag = 0;
-	tag->hdr.size = 0;
-}
-
-
-typedef int (*ofw_handle_t)(void *);
-
-/* Everything below is called with a wrong MMU setting.
- * This means: no string constants, no initialization of
- * arrays, no global variables! This is ugly but I didn't
- * want to write this in assembler :-)
- */
-
-int
-of_decode_int(const unsigned char *p)
-{
-	unsigned int i = *p++ << 8;
-	i = (i + *p++) << 8;
-	i = (i + *p++) << 8;
-	return (i + *p);
-}
-  
-int
-OF_finddevice(ofw_handle_t openfirmware, char *name)
-{
-	unsigned int args[8];
-	char service[12];
-
-	service[0]='f';
-	service[1]='i';
-	service[2]='n';
-	service[3]='d';
-	service[4]='d';
-	service[5]='e';
-	service[6]='v';
-	service[7]='i';
-	service[8]='c';
-	service[9]='e';
-	service[10]='\0';
-
-	args[0]=(unsigned int)service;
-	args[1]=1;
-	args[2]=1;
-	args[3]=(unsigned int)name;
-
-	if (openfirmware(args) == -1)
-		return -1;
-	return args[4];
-}
-
-int
-OF_getproplen(ofw_handle_t openfirmware, int handle, char *prop)
-{
-	unsigned int args[8];
-	char service[12];
-
-	service[0]='g';
-	service[1]='e';
-	service[2]='t';
-	service[3]='p';
-	service[4]='r';
-	service[5]='o';
-	service[6]='p';
-	service[7]='l';
-	service[8]='e';
-	service[9]='n';
-	service[10]='\0';
-
-	args[0] = (unsigned int)service;
-	args[1] = 2;
-	args[2] = 1;
-	args[3] = (unsigned int)handle;
-	args[4] = (unsigned int)prop;
-
-	if (openfirmware(args) == -1)
-		return -1;
-	return args[5];
-}
-  
-int
-OF_getprop(ofw_handle_t openfirmware, int handle, char *prop, void *buf, unsigned int buflen)
-{
-	unsigned int args[8];
-	char service[8];
-
-	service[0]='g';
-	service[1]='e';
-	service[2]='t';
-	service[3]='p';
-	service[4]='r';
-	service[5]='o';
-	service[6]='p';
-	service[7]='\0';
-
-	args[0] = (unsigned int)service;
-	args[1] = 4;
-	args[2] = 1;
-	args[3] = (unsigned int)handle;
-	args[4] = (unsigned int)prop;
-	args[5] = (unsigned int)buf;
-	args[6] = buflen;
-
-	if (openfirmware(args) == -1)
-		return -1;
-	return args[7];
-}
-  
-asmlinkage void ofw_init(ofw_handle_t o, int *nomr, int *pointer)
-{
-	int phandle,i,mem_len,buffer[32];
-	char temp[15];
-  
-	temp[0]='/';
-	temp[1]='m';
-	temp[2]='e';
-	temp[3]='m';
-	temp[4]='o';
-	temp[5]='r';
-	temp[6]='y';
-	temp[7]='\0';
-
-	phandle=OF_finddevice(o,temp);
-
-	temp[0]='r';
-	temp[1]='e';
-	temp[2]='g';
-	temp[3]='\0';
-
-	mem_len = OF_getproplen(o,phandle, temp);
-	OF_getprop(o,phandle, temp, buffer, mem_len);
-	*nomr=mem_len >> 3;
-
-	for (i=0; i<=mem_len/4; i++) pointer[i]=of_decode_int((const unsigned char *)&buffer[i]);
-
-	temp[0]='/';
-	temp[1]='c';
-	temp[2]='h';
-	temp[3]='o';
-	temp[4]='s';
-	temp[5]='e';
-	temp[6]='n';
-	temp[7]='\0';
-
-	phandle=OF_finddevice(o,temp);
-
-	temp[0]='b';
-	temp[1]='o';
-	temp[2]='o';
-	temp[3]='t';
-	temp[4]='a';
-	temp[5]='r';
-	temp[6]='g';
-	temp[7]='s';
-	temp[8]='\0';
-
-	mem_len = OF_getproplen(o,phandle, temp);
-	OF_getprop(o,phandle, temp, buffer, mem_len);
-	if (mem_len > 128) mem_len=128;
-	for (i=0; i<=mem_len/4; i++) pointer[i+33]=buffer[i];
-	pointer[i+33]=0;
-
-	temp[0]='/';
-	temp[1]='\0';
-	phandle=OF_finddevice(o,temp);
-	temp[0]='b';
-	temp[1]='a';
-	temp[2]='n';
-	temp[3]='n';
-	temp[4]='e';
-	temp[5]='r';
-	temp[6]='-';
-	temp[7]='n';
-	temp[8]='a';
-	temp[9]='m';
-	temp[10]='e';
-	temp[11]='\0';
-	mem_len = OF_getproplen(o,phandle, temp);
-	OF_getprop(o,phandle, temp, buffer, mem_len);
-	* ((unsigned char *) &pointer[32]) = ((unsigned char *) buffer)[mem_len-2];
-}
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 8c60f47..eaa9cf4 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -6,7 +6,6 @@ obj-y				+= firmware.o
 
 obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
-obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
diff --git a/arch/arm/common/via82c505.c b/arch/arm/common/via82c505.c
deleted file mode 100644
index 6cb362e..0000000
--- a/arch/arm/common/via82c505.c
+++ /dev/null
@@ -1,83 +0,0 @@
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/mm.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-
-
-#include <asm/mach/pci.h>
-
-#define MAX_SLOTS		7
-
-#define CONFIG_CMD(bus, devfn, where)   (0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
-
-static int
-via82c505_read_config(struct pci_bus *bus, unsigned int devfn, int where,
-		      int size, u32 *value)
-{
-	outl(CONFIG_CMD(bus,devfn,where),0xCF8);
-	switch (size) {
-	case 1:
-		*value=inb(0xCFC + (where&3));
-		break;
-	case 2:
-		*value=inw(0xCFC + (where&2));
-		break;
-	case 4:
-		*value=inl(0xCFC);
-		break;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-via82c505_write_config(struct pci_bus *bus, unsigned int devfn, int where,
-		       int size, u32 value)
-{
-	outl(CONFIG_CMD(bus,devfn,where),0xCF8);
-	switch (size) {
-	case 1:
-		outb(value, 0xCFC + (where&3));
-		break;
-	case 2:
-		outw(value, 0xCFC + (where&2));
-		break;
-	case 4:
-		outl(value, 0xCFC);
-		break;
-	}
-	return PCIBIOS_SUCCESSFUL;
-}
-
-struct pci_ops via82c505_ops = {
-	.read	= via82c505_read_config,
-	.write	= via82c505_write_config,
-};
-
-void __init via82c505_preinit(void)
-{
-	printk(KERN_DEBUG "PCI: VIA 82c505\n");
-	if (!request_region(0xA8,2,"via config")) {
-		printk(KERN_WARNING"VIA 82c505: Unable to request region 0xA8\n");
-		return;
-	}
-	if (!request_region(0xCF8,8,"pci config")) {
-		printk(KERN_WARNING"VIA 82c505: Unable to request region 0xCF8\n");
-		release_region(0xA8, 2);
-		return;
-	}
-
-	/* Enable compatible Mode */
-	outb(0x96,0xA8);
-	outb(0x18,0xA9);
-	outb(0x93,0xA8);
-	outb(0xd0,0xA9);
-
-}
-
-int __init via82c505_setup(int nr, struct pci_sys_data *sys)
-{
-	return (nr == 0);
-}
diff --git a/arch/arm/configs/shark_defconfig b/arch/arm/configs/shark_defconfig
deleted file mode 100644
index e319b2c..0000000
--- a/arch/arm/configs/shark_defconfig
+++ /dev/null
@@ -1,80 +0,0 @@
-CONFIG_EXPERIMENTAL=y
-# CONFIG_LOCALVERSION_AUTO is not set
-CONFIG_SYSVIPC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_SHARK=y
-CONFIG_LEDS=y
-CONFIG_LEDS_TIMER=y
-CONFIG_ZBOOT_ROM_TEXT=0x0
-CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_FPE_NWFPE=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-# CONFIG_STANDALONE is not set
-# CONFIG_FIRMWARE_IN_KERNEL is not set
-CONFIG_PARPORT=m
-CONFIG_PARPORT_PC=m
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=m
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
-CONFIG_CHR_DEV_ST=m
-CONFIG_BLK_DEV_SR=m
-CONFIG_CHR_DEV_SG=m
-CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
-CONFIG_CS89x0=y
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_PRINTER=m
-# CONFIG_HWMON is not set
-CONFIG_FB=y
-CONFIG_FB_CYBER2000=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_SOUND=m
-CONFIG_SOUND_PRIME=m
-CONFIG_SOUND_OSS=m
-CONFIG_SOUND_SB=m
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_CMOS=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
-CONFIG_NFSD=m
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_NLS_CODEPAGE_437=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_ISO8859_1=m
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_RCU_CPU_STALL_DETECTOR is not set
-CONFIG_DEBUG_USER=y
diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index a1c90d7..b355e90 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -102,8 +102,4 @@ extern int dc21285_setup(int nr, struct pci_sys_data *);
 extern void dc21285_preinit(void);
 extern void dc21285_postinit(void);
 
-extern struct pci_ops via82c505_ops;
-extern int via82c505_setup(int nr, struct pci_sys_data *);
-extern void via82c505_init(void *sysdata);
-
 #endif /* __ASM_MACH_PCI_H */
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index af72969..0f49398 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -41,7 +41,6 @@ else
 endif
 
 lib-$(CONFIG_ARCH_RPC)		+= ecard.o io-acorn.o floppydma.o
-lib-$(CONFIG_ARCH_SHARK)	+= io-shark.o
 
 $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
diff --git a/arch/arm/lib/io-shark.c b/arch/arm/lib/io-shark.c
deleted file mode 100644
index 8242539..0000000
--- a/arch/arm/lib/io-shark.c
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *  linux/arch/arm/lib/io-shark.c
- *
- *  by Alexander Schulz
- *
- * derived from:
- * linux/arch/arm/lib/io-ebsa.S
- * Copyright (C) 1995, 1996 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
diff --git a/arch/arm/mach-shark/Makefile b/arch/arm/mach-shark/Makefile
deleted file mode 100644
index 2965718..0000000
--- a/arch/arm/mach-shark/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-# Object file lists.
-
-obj-y			:= core.o dma.o irq.o pci.o leds.o
-obj-m			:=
-obj-n			:=
-obj-			:=
diff --git a/arch/arm/mach-shark/Makefile.boot b/arch/arm/mach-shark/Makefile.boot
deleted file mode 100644
index e40e24e..0000000
--- a/arch/arm/mach-shark/Makefile.boot
+++ /dev/null
@@ -1,2 +0,0 @@
-   zreladdr-y	+= 0x08008000
-
diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
deleted file mode 100644
index 1d32c5e..0000000
--- a/arch/arm/mach-shark/core.c
+++ /dev/null
@@ -1,146 +0,0 @@
-/*
- *  linux/arch/arm/mach-shark/arch.c
- *
- *  Architecture specific stuff.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/sched.h>
-#include <linux/serial_8250.h>
-#include <linux/io.h>
-#include <linux/cpu.h>
-#include <linux/reboot.h>
-
-#include <asm/setup.h>
-#include <asm/mach-types.h>
-#include <asm/param.h>
-#include <asm/system_misc.h>
-
-#include <asm/mach/map.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
-#define ROMCARD_SIZE            0x08000000
-#define ROMCARD_START           0x10000000
-
-static void shark_restart(enum reboot_mode mode, const char *cmd)
-{
-        short temp;
-        /* Reset the Machine via pc[3] of the sequoia chipset */
-        outw(0x09,0x24);
-        temp=inw(0x26);
-        temp = temp | (1<<3) | (1<<10);
-        outw(0x09,0x24);
-        outw(temp,0x26);
-}
-
-static struct plat_serial8250_port serial_platform_data[] = {
-	{
-		.iobase		= 0x3f8,
-		.irq		= 4,
-		.uartclk	= 1843200,
-		.regshift	= 0,
-		.iotype		= UPIO_PORT,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-	{
-		.iobase		= 0x2f8,
-		.irq		= 3,
-		.uartclk	= 1843200,
-		.regshift	= 0,
-		.iotype		= UPIO_PORT,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
-	},
-	{ },
-};
-
-static struct platform_device serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
-};
-
-static struct resource rtc_resources[] = {
-	[0] = {
-		.start	= 0x70,
-		.end	= 0x73,
-		.flags	= IORESOURCE_IO,
-	},
-	[1] = {
-		.start	= IRQ_ISA_RTC_ALARM,
-		.end	= IRQ_ISA_RTC_ALARM,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device rtc_device = {
-	.name		= "rtc_cmos",
-	.id		= -1,
-	.resource	= rtc_resources,
-	.num_resources	= ARRAY_SIZE(rtc_resources),
-};
-
-static int __init shark_init(void)
-{
-	int ret;
-
-	if (machine_is_shark())
-	{
-	        ret = platform_device_register(&rtc_device);
-		if (ret) printk(KERN_ERR "Unable to register RTC device: %d\n", ret);
-		ret = platform_device_register(&serial_device);
-		if (ret) printk(KERN_ERR "Unable to register Serial device: %d\n", ret);
-	}
-	return 0;
-}
-
-arch_initcall(shark_init);
-
-extern void shark_init_irq(void);
-
-#define IRQ_TIMER 0
-#define HZ_TIME ((1193180 + HZ/2) / HZ)
-
-static irqreturn_t
-shark_timer_interrupt(int irq, void *dev_id)
-{
-	timer_tick();
-	return IRQ_HANDLED;
-}
-
-static struct irqaction shark_timer_irq = {
-	.name		= "Shark Timer Tick",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= shark_timer_interrupt,
-};
-
-/*
- * Set up timer interrupt, and return the current time in seconds.
- */
-static void __init shark_timer_init(void)
-{
-	outb(0x34, 0x43);               /* binary, mode 0, LSB/MSB, Ch 0 */
-	outb(HZ_TIME & 0xff, 0x40);     /* LSB of count */
-	outb(HZ_TIME >> 8, 0x40);
-
-	setup_irq(IRQ_TIMER, &shark_timer_irq);
-}
-
-static void shark_init_early(void)
-{
-	cpu_idle_poll_ctrl(true);
-}
-
-MACHINE_START(SHARK, "Shark")
-	/* Maintainer: Alexander Schulz */
-	.atag_offset	= 0x3000,
-	.init_early	= shark_init_early,
-	.init_irq	= shark_init_irq,
-	.init_time	= shark_timer_init,
-	.dma_zone_size	= SZ_4M,
-	.restart	= shark_restart,
-MACHINE_END
diff --git a/arch/arm/mach-shark/dma.c b/arch/arm/mach-shark/dma.c
deleted file mode 100644
index 10b5b8b..0000000
--- a/arch/arm/mach-shark/dma.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- *  linux/arch/arm/mach-shark/dma.c
- *
- *  by Alexander Schulz
- *
- *  derived from:
- *  arch/arm/kernel/dma-ebsa285.c
- *  Copyright (C) 1998 Phil Blundell
- */
-
-#include <linux/init.h>
-
-#include <asm/dma.h>
-#include <asm/mach/dma.h>
-
-static int __init shark_dma_init(void)
-{
-#ifdef CONFIG_ISA_DMA
-	isa_init_dma();
-#endif
-	return 0;
-}
-core_initcall(shark_dma_init);
diff --git a/arch/arm/mach-shark/include/mach/debug-macro.S b/arch/arm/mach-shark/include/mach/debug-macro.S
deleted file mode 100644
index d129119..0000000
--- a/arch/arm/mach-shark/include/mach/debug-macro.S
+++ /dev/null
@@ -1,34 +0,0 @@
-/* arch/arm/mach-shark/include/mach/debug-macro.S
- *
- * Debugging macro include header
- *
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
-*/
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #0x3f8
-		orr	\rv, \rp, #0xfe000000
-		orr	\rv, \rv, #0x00e00000
-		orr	\rp, \rp, #0x40000000
-		.endm
-
-		.macro	senduart,rd,rx
-		strb	\rd, [\rx]
-		.endm
-
-		.macro waituart,rd,rx
-		.endm
-
-		.macro	busyuart,rd,rx
-		mov	\rd, #0
-1001:		add	\rd, \rd, #1
-		teq	\rd, #0x10000
-		bne	1001b
-		.endm
-
diff --git a/arch/arm/mach-shark/include/mach/entry-macro.S b/arch/arm/mach-shark/include/mach/entry-macro.S
deleted file mode 100644
index c9e49f0..0000000
--- a/arch/arm/mach-shark/include/mach/entry-macro.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for Shark platform
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-		.macro  get_irqnr_preamble, base, tmp
-		mov	\base, #0xfe000000
-		orr	\base, \base, #0x00e00000
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		mov	\irqstat, #0x0C
-		strb	\irqstat, [\base, #0x20]	@outb(0x0C, 0x20) /* Poll command */
-		ldrb	\irqnr, [\base, #0x20]		@irq = inb(0x20) & 7
-		and	\irqstat, \irqnr, #0x80
-		teq	\irqstat, #0
-		beq	43f
-		and	\irqnr, \irqnr, #7
-		teq	\irqnr, #2
-		bne	44f
-43:		mov	\irqstat, #0x0C
-		strb	\irqstat, [\base, #0xa0]	@outb(0x0C, 0xA0) /* Poll command */
-		ldrb	\irqnr, [\base, #0xa0]		@irq = (inb(0xA0) & 7) + 8
-		and	\irqstat, \irqnr, #0x80
-		teq	\irqstat, #0
-		beq	44f
-		and	\irqnr, \irqnr, #7
-		add	\irqnr, \irqnr, #8
-44:		teq	\irqstat, #0
-		.endm
-
diff --git a/arch/arm/mach-shark/include/mach/framebuffer.h b/arch/arm/mach-shark/include/mach/framebuffer.h
deleted file mode 100644
index 84a5bf6..0000000
--- a/arch/arm/mach-shark/include/mach/framebuffer.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/framebuffer.h
- *
- * by Alexander Schulz
- *
- */
-
-#ifndef __ASM_ARCH_FRAMEBUFFER_H
-#define __ASM_ARCH_FRAMEBUFFER_H
-
-/* defines for the Framebuffer */
-#define FB_START		0x06000000
-#define FB_SIZE			0x01000000
-
-#endif
-
diff --git a/arch/arm/mach-shark/include/mach/hardware.h b/arch/arm/mach-shark/include/mach/hardware.h
deleted file mode 100644
index 663f952..0000000
--- a/arch/arm/mach-shark/include/mach/hardware.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/hardware.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-ebsa110/include/mach/hardware.h
- * Copyright (C) 1996-1999 Russell King.
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#define UNCACHEABLE_ADDR        0xdf010000
-
-#endif
-
diff --git a/arch/arm/mach-shark/include/mach/irqs.h b/arch/arm/mach-shark/include/mach/irqs.h
deleted file mode 100644
index c8e8a4e..0000000
--- a/arch/arm/mach-shark/include/mach/irqs.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/irqs.h
- *
- * by Alexander Schulz
- */
-
-#define NR_IRQS			16
-
-#define IRQ_ISA_KEYBOARD	 1
-#define IRQ_ISA_RTC_ALARM	 8
-#define I8042_KBD_IRQ		 1
-#define I8042_AUX_IRQ		12
-#define IRQ_HARDDISK            14
diff --git a/arch/arm/mach-shark/include/mach/isa-dma.h b/arch/arm/mach-shark/include/mach/isa-dma.h
deleted file mode 100644
index 96c43b8..0000000
--- a/arch/arm/mach-shark/include/mach/isa-dma.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/isa-dma.h
- *
- * by Alexander Schulz
- */
-#ifndef __ASM_ARCH_DMA_H
-#define __ASM_ARCH_DMA_H
-
-#define MAX_DMA_CHANNELS	8
-#define DMA_ISA_CASCADE         4
-
-#endif /* _ASM_ARCH_DMA_H */
-
diff --git a/arch/arm/mach-shark/include/mach/memory.h b/arch/arm/mach-shark/include/mach/memory.h
deleted file mode 100644
index 1cf8d69..0000000
--- a/arch/arm/mach-shark/include/mach/memory.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/memory.h
- *
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-ebsa110/include/mach/memory.h
- * Copyright (c) 1996-1999 Russell King.
- */
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#include <asm/sizes.h>
-
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET     UL(0x08000000)
-
-/*
- * Cache flushing area
- */
-#define FLUSH_BASE_PHYS		0x80000000
-#define FLUSH_BASE		0xdf000000
-
-#endif
diff --git a/arch/arm/mach-shark/include/mach/timex.h b/arch/arm/mach-shark/include/mach/timex.h
deleted file mode 100644
index bb6eeae..0000000
--- a/arch/arm/mach-shark/include/mach/timex.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/timex.h
- *
- * by Alexander Schulz
- */
-
-#define CLOCK_TICK_RATE 1193180
diff --git a/arch/arm/mach-shark/include/mach/uncompress.h b/arch/arm/mach-shark/include/mach/uncompress.h
deleted file mode 100644
index a168435..0000000
--- a/arch/arm/mach-shark/include/mach/uncompress.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/*
- * arch/arm/mach-shark/include/mach/uncompress.h
- * by Alexander Schulz
- *
- * derived from:
- * arch/arm/mach-footbridge/include/mach/uncompress.h
- * Copyright (C) 1996,1997,1998 Russell King
- */
-
-#define SERIAL_BASE ((volatile unsigned char *)0x400003f8)
-
-static inline void putc(int c)
-{
-	volatile int t;
-
-	SERIAL_BASE[0] = c;
-	t=0x10000;
-	while (t--);
-}
-
-static inline void flush(void)
-{
-}
-
-#ifdef DEBUG
-static void putn(unsigned long z)
-{
-	int i;
-	char x;
-
-	putc('0');
-	putc('x');
-	for (i=0;i<8;i++) {
-		x='0'+((z>>((7-i)*4))&0xf);
-		if (x>'9') x=x-'0'+'A'-10;
-		putc(x);
-	}
-}
-
-static void putr()
-{
-	putc('\n');
-	putc('\r');
-}
-#endif
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
diff --git a/arch/arm/mach-shark/irq.c b/arch/arm/mach-shark/irq.c
deleted file mode 100644
index 5dce13e..0000000
--- a/arch/arm/mach-shark/irq.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- *  linux/arch/arm/mach-shark/irq.c
- *
- * by Alexander Schulz
- *
- * derived from linux/arch/ppc/kernel/i8259.c and:
- * arch/arm/mach-ebsa110/include/mach/irq.h
- * Copyright (C) 1996-1998 Russell King
- */
-
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
-
-/*
- * 8259A PIC functions to handle ISA devices:
- */
-
-/*
- * This contains the irq mask for both 8259A irq controllers,
- * Let through the cascade-interrupt no. 2 (ff-(1<<2)==fb)
- */
-static unsigned char cached_irq_mask[2] = { 0xfb, 0xff };
-
-/*
- * These have to be protected by the irq controller spinlock
- * before being called.
- */
-static void shark_disable_8259A_irq(struct irq_data *d)
-{
-	unsigned int mask;
-	if (d->irq<8) {
-	  mask = 1 << d->irq;
-	  cached_irq_mask[0] |= mask;
-	  outb(cached_irq_mask[1],0xA1);
-	} else {
-	  mask = 1 << (d->irq-8);
-	  cached_irq_mask[1] |= mask;
-	  outb(cached_irq_mask[0],0x21);
-	}
-}
-
-static void shark_enable_8259A_irq(struct irq_data *d)
-{
-	unsigned int mask;
-	if (d->irq<8) {
-	  mask = ~(1 << d->irq);
-	  cached_irq_mask[0] &= mask;
-	  outb(cached_irq_mask[0],0x21);
-	} else {
-	  mask = ~(1 << (d->irq-8));
-	  cached_irq_mask[1] &= mask;
-	  outb(cached_irq_mask[1],0xA1);
-	}
-}
-
-static void shark_ack_8259A_irq(struct irq_data *d){}
-
-static irqreturn_t bogus_int(int irq, void *dev_id)
-{
-	printk("Got interrupt %i!\n",irq);
-	return IRQ_NONE;
-}
-
-static struct irqaction cascade;
-
-static struct irq_chip fb_chip = {
-	.name		= "XT-PIC",
-	.irq_ack	= shark_ack_8259A_irq,
-	.irq_mask	= shark_disable_8259A_irq,
-	.irq_unmask	= shark_enable_8259A_irq,
-};
-
-void __init shark_init_irq(void)
-{
-	int irq;
-
-	for (irq = 0; irq < NR_IRQS; irq++) {
-		irq_set_chip_and_handler(irq, &fb_chip, handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	/* init master interrupt controller */
-	outb(0x11, 0x20); /* Start init sequence, edge triggered (level: 0x19)*/
-	outb(0x00, 0x21); /* Vector base */
-	outb(0x04, 0x21); /* Cascade (slave) on IRQ2 */
-	outb(0x03, 0x21); /* Select 8086 mode , auto eoi*/
-	outb(0x0A, 0x20);
-	/* init slave interrupt controller */
-	outb(0x11, 0xA0); /* Start init sequence, edge triggered */
-	outb(0x08, 0xA1); /* Vector base */
-	outb(0x02, 0xA1); /* Cascade (slave) on IRQ2 */
-	outb(0x03, 0xA1); /* Select 8086 mode, auto eoi */
-	outb(0x0A, 0xA0);
-	outb(cached_irq_mask[1],0xA1);
-	outb(cached_irq_mask[0],0x21);
-	//request_region(0x20,0x2,"pic1");
-	//request_region(0xA0,0x2,"pic2");
-
-	cascade.handler = bogus_int;
-	cascade.name = "cascade";
-	setup_irq(2,&cascade);
-}
-
diff --git a/arch/arm/mach-shark/leds.c b/arch/arm/mach-shark/leds.c
deleted file mode 100644
index 081c778..0000000
--- a/arch/arm/mach-shark/leds.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * DIGITAL Shark LED control routines.
- *
- * Driver for the 3 user LEDs found on the Shark
- * Based on Versatile and RealView machine LED code
- *
- * License terms: GNU General Public License (GPL) version 2
- * Author: Bryan Wu <bryan.wu@canonical.com>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/slab.h>
-#include <linux/leds.h>
-
-#include <asm/mach-types.h>
-
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-struct shark_led {
-	struct led_classdev cdev;
-	u8 mask;
-};
-
-/*
- * The triggers lines up below will only be used if the
- * LED triggers are compiled in.
- */
-static const struct {
-	const char *name;
-	const char *trigger;
-} shark_leds[] = {
-	{ "shark:amber0", "default-on", },	/* Bit 5 */
-	{ "shark:green", "heartbeat", },	/* Bit 6 */
-	{ "shark:amber1", "cpu0" },		/* Bit 7 */
-};
-
-static u16 led_reg_read(void)
-{
-	outw(0x09, 0x24);
-	return inw(0x26);
-}
-
-static void led_reg_write(u16 value)
-{
-	outw(0x09, 0x24);
-	outw(value, 0x26);
-}
-
-static void shark_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
-{
-	struct shark_led *led = container_of(cdev,
-						 struct shark_led, cdev);
-	u16 reg = led_reg_read();
-
-	if (b != LED_OFF)
-		reg |= led->mask;
-	else
-		reg &= ~led->mask;
-
-	led_reg_write(reg);
-}
-
-static enum led_brightness shark_led_get(struct led_classdev *cdev)
-{
-	struct shark_led *led = container_of(cdev,
-						 struct shark_led, cdev);
-	u16 reg = led_reg_read();
-
-	return (reg & led->mask) ? LED_FULL : LED_OFF;
-}
-
-static int __init shark_leds_init(void)
-{
-	int i;
-	u16 reg;
-
-	if (!machine_is_shark())
-		return -ENODEV;
-
-	for (i = 0; i < ARRAY_SIZE(shark_leds); i++) {
-		struct shark_led *led;
-
-		led = kzalloc(sizeof(*led), GFP_KERNEL);
-		if (!led)
-			break;
-
-		led->cdev.name = shark_leds[i].name;
-		led->cdev.brightness_set = shark_led_set;
-		led->cdev.brightness_get = shark_led_get;
-		led->cdev.default_trigger = shark_leds[i].trigger;
-
-		/* Count in 5 bits offset */
-		led->mask = BIT(i + 5);
-
-		if (led_classdev_register(NULL, &led->cdev) < 0) {
-			kfree(led);
-			break;
-		}
-	}
-
-	/* Make LEDs independent of power-state */
-	request_region(0x24, 4, "led_reg");
-	reg = led_reg_read();
-	reg |= 1 << 10;
-	led_reg_write(reg);
-
-	return 0;
-}
-
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(shark_leds_init);
-#endif
diff --git a/arch/arm/mach-shark/pci.c b/arch/arm/mach-shark/pci.c
deleted file mode 100644
index 6d91a91..0000000
--- a/arch/arm/mach-shark/pci.c
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- *  linux/arch/arm/mach-shark/pci.c
- *
- *  PCI bios-type initialisation for PCI machines
- *
- *  Bits taken from various places.
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <video/vga.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/mach-types.h>
-
-#define IO_START	0x40000000
-
-static int __init shark_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (dev->bus->number == 0)
-		if (dev->devfn == 0)
-			return 255;
-		else
-			return 11;
-	else
-		return 255;
-}
-
-extern void __init via82c505_preinit(void);
-
-static struct hw_pci shark_pci __initdata = {
-	.setup		= via82c505_setup,
-	.map_irq	= shark_map_irq,
-	.nr_controllers = 1,
-	.ops		= &via82c505_ops,
-	.preinit	= via82c505_preinit,
-};
-
-static int __init shark_pci_init(void)
-{
-	if (!machine_is_shark())
-		return -ENODEV;
-
-	pcibios_min_io = 0x6000;
-	pcibios_min_mem = 0x50000000;
-	vga_base = 0xe8000000;
-
-	pci_ioremap_io(0, IO_START);
-
-	pci_common_init(&shark_pci);
-
-	return 0;
-}
-
-subsys_initcall(shark_pci_init);
-- 
1.8.3.1
