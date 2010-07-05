From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Jul 2010 16:15:29 +0200
Subject: [PATCH 11/11] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <20100705141344.GA25407@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
Message-ID: <1278339329-23739-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Miao <eric.miao@canonical.com>

As long as the zImage is placed within the 128MB range from the start of
memory, ZRELADDR (Address where the decompressed kernel will be placed,
usually == PHYS_OFFSET + TEXT_OFFSET) can be determined at run-time by
masking PC with 0xf80000000.

Running through all the Makefile.boot, all those zreladdr-y
addresses == 0x[0-f][08]00_0000 + TEXT_OFFSET can be determined at
run-time.

Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
CONFIG_ZRELADDR _must_ be explicitly specified if:

- ((zreladdr-y - TEXT_OFFSET) & ~0xf8000000) != 0, which means
  masking PC with 0xf8000000 will result in an incorrect address.
  Currently this is only a problem on u300.

- or the assumption of the zImage being loaded by the bootloader within
  the first 128MB of RAM is incorrect

- or when ZBOOT_ROM is used, where the above assumption is usually wrong.

[ukleinek: changed mask from 0xf0000000 to 0xf8000000 for mx1 and shark
+ some review fixes from the mailing list]

Signed-off-by: Eric Miao <eric.miao@canonical.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                  |   99 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/Makefile            |    8 +--
 arch/arm/boot/compressed/Makefile |    3 +-
 arch/arm/boot/compressed/head.S   |   12 +++-
 4 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a53ac65..0b0cf0d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1490,6 +1490,105 @@ config ATAGS_PROC
 	  Should the atags used to boot the kernel be exported in an "atags"
 	  file in procfs. Useful with kexec.
 
+config AUTO_ZRELADDR
+	bool "Auto calculation of the decompressed kernel image address"
+	depends on !ZBOOT_ROM && !ARCH_U300
+	help
+	  ZRELADDR is the physical address where the decompressed kernel
+	  image will be placed. If AUTO_ZRELADDR is selected, the address
+	  will be determined at run-time by masking the current IP with
+	  0xf8000000. This assumes the zImage being placed in the first 128MB
+	  from start of memory.
+
+config ZRELADDR
+	hex "Physical address of the decompressed kernel image"
+	depends on !AUTO_ZRELADDR
+	default 0x00008000 if ARCH_BCMRING ||\
+		ARCH_CNS3XXX ||\
+		ARCH_DOVE ||\
+		ARCH_EBSA110 ||\
+		ARCH_FOOTBRIDGE ||\
+		ARCH_INTEGRATOR ||\
+		ARCH_IOP13XX ||\
+		ARCH_IOP33X ||\
+		ARCH_IXP2000 ||\
+		ARCH_IXP23XX ||\
+		ARCH_IXP4XX ||\
+		ARCH_KIRKWOOD ||\
+		ARCH_KS8695 ||\
+		ARCH_LOKI ||\
+		ARCH_MMP ||\
+		ARCH_MV78XX0 ||\
+		ARCH_NOMADIK ||\
+		ARCH_NUC93X ||\
+		ARCH_NS9XXX ||\
+		ARCH_ORION5X ||\
+		ARCH_SPEAR3XX ||\
+		ARCH_SPEAR6XX ||\
+		ARCH_U8500 ||\
+		ARCH_VERSATILE ||\
+		ARCH_W90X900
+	default 0x08008000 if ARCH_MX1 ||\
+		ARCH_SHARK
+	default 0x10008000 if ARCH_MSM ||\
+		ARCH_OMAP1 ||\
+		ARCH_RPC
+	default 0x20008000 if ARCH_S5P6440 ||\
+		ARCH_S5P6442 ||\
+		ARCH_S5PC100 ||\
+		ARCH_S5PV210
+	default 0x30008000 if ARCH_S3C2410 ||\
+		ARCH_S3C2400 ||\
+		ARCH_S3C2412 ||\
+		ARCH_S3C2416 ||\
+		ARCH_S3C2440 ||\
+		ARCH_S3C2443
+	default 0x40008000 if ARCH_STMP378X ||\
+		ARCH_STMP37XX ||\
+		ARCH_SH7372 ||\
+		ARCH_SH7377
+	default 0x50008000 if ARCH_S3C64XX ||\
+		ARCH_SH7367
+	default 0x60008000 if ARCH_VEXPRESS
+	default 0x80008000 if ARCH_MX25 ||\
+		ARCH_MX3 ||\
+		ARCH_NETX ||\
+		ARCH_OMAP2PLUS ||\
+		ARCH_PNX4008
+	default 0x90008000 if ARCH_MX5 ||\
+		ARCH_MX91231
+	default 0xa0008000 if ARCH_IOP32X ||\
+		ARCH_PXA ||\
+		MACH_MX27
+	default 0xc0008000 if ARCH_LH7A40X ||\
+		MACH_MX21
+	default 0xf0008000 if ARCH_AAEC2000 ||\
+		ARCH_L7200
+	default 0xc0028000 if ARCH_CLPS711X
+	default 0x70008000 if ARCH_AT91 && (ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
+	default 0x20008000 if ARCH_AT91 && !(ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
+	default 0xc0008000 if ARCH_DAVINCI && ARCH_DAVINCI_DA8XX
+	default 0x80008000 if ARCH_DAVINCI && !ARCH_DAVINCI_DA8XX
+	default 0x00008000 if ARCH_EP93XX && EP93XX_SDCE3_SYNC_PHYS_OFFSET
+	default 0xc0008000 if ARCH_EP93XX && EP93XX_SDCE0_PHYS_OFFSET
+	default 0xd0008000 if ARCH_EP93XX && EP93XX_SDCE1_PHYS_OFFSET
+	default 0xe0008000 if ARCH_EP93XX && EP93XX_SDCE2_PHYS_OFFSET
+	default 0xf0008000 if ARCH_EP93XX && EP93XX_SDCE3_ASYNC_PHYS_OFFSET
+	default 0x00008000 if ARCH_GEMINI && GEMINI_MEM_SWAP
+	default 0x10008000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
+	default 0x70008000 if ARCH_REALVIEW && REALVIEW_HIGH_PHYS_OFFSET
+	default 0x00008000 if ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET
+	default 0xc0208000 if ARCH_SA1100 && SA1111
+	default 0xc0008000 if ARCH_SA1100 && !SA1111
+	default 0x30108000 if ARCH_S3C2410 && PM_H1940
+	default 0x28E08000 if ARCH_U300 && MACH_U300_SINGLE_RAM
+	default 0x48008000 if ARCH_U300 && !MACH_U300_SINGLE_RAM
+	help
+	  ZRELADDR is the physical address where the decompressed kernel
+	  image will be placed. ZRELADDR has to be specified when the
+	  assumption of AUTO_ZRELADDR is not valid, or when ZBOOT_ROM is
+	  selected.
+
 endmenu
 
 menu "CPU Power Management"
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 264dccf..5e89c2c 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -14,18 +14,16 @@
 MKIMAGE         := $(srctree)/scripts/mkuboot.sh
 
 ifneq ($(MACHINE),)
-include $(srctree)/$(MACHINE)/Makefile.boot
+-include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
 # Note: the following conditions must always be true:
-#   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
-ZRELADDR    := $(zreladdr-y)
 PARAMS_PHYS := $(params_phys-y)
 INITRD_PHYS := $(initrd_phys-y)
 
-export ZRELADDR INITRD_PHYS PARAMS_PHYS
+export INITRD_PHYS PARAMS_PHYS
 
 targets := Image zImage xipImage bootpImage uImage
 
@@ -68,7 +66,7 @@ ifeq ($(CONFIG_RUNTIME_PHYS_OFFSET),)
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
-$(obj)/uImage: LOADADDR=$(ZRELADDR)
+$(obj)/uImage: LOADADDR=$(CONFIG_ZRELADDR)
 endif
 endif
 
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 2a80c9d..cc8380b 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -4,6 +4,7 @@
 # create a compressed vmlinuz image from the original vmlinux
 #
 
+AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
 HEAD	= head.o
 OBJS	= misc.o decompress.o
 FONTC	= $(srctree)/drivers/video/console/font_acorn_8x8.c
@@ -79,8 +80,6 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
-# Supply ZRELADDR to the decompressor via a linker symbol.
-LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d27faa1..abf4d65 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -170,9 +170,16 @@ not_angel:
 
 		.text
 		adr	r0, LC0
- ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip, sp})
- THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip}	)
+ ARM(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip, sp})
+ THUMB(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}	)
  THUMB(		ldr	sp, [r0, #32]				)
+#ifdef CONFIG_AUTO_ZRELADDR
+		@ determine final kernel image address
+		and	r4, pc, #0xf8000000
+		add	r4, r4, #TEXT_OFFSET
+#else
+		ldr	r4, =CONFIG_ZRELADDR
+#endif
 		subs	r0, r0, r1		@ calculate the delta offset
 
 						@ if delta is zero, we are
@@ -310,7 +317,6 @@ wont_overwrite:	mov	r0, r4
 LC0:		.word	LC0			@ r1
 		.word	__bss_start		@ r2
 		.word	_end			@ r3
-		.word	zreladdr		@ r4
 		.word	_start			@ r5
 		.word	_image_size		@ r6
 		.word	_got_start		@ r11
-- 
1.7.1
