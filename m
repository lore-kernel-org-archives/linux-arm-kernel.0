From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 14 Apr 2011 11:37:51 +0200
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <201104141151.50497.anarsoul@gmail.com>
References: <20110413172547.GA27819@dandreoli.com>
	<201104141151.50497.anarsoul@gmail.com>
Message-ID: <20110414093751.GA6955@dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 11:51:50AM +0300, Vasily Khoruzhick wrote:
> On Wednesday 13 April 2011 20:25:47 Domenico Andreoli wrote:
> > From: Domenico Andreoli <cavokz@gmail.com>
> > 
> > This patch adds DeviceTree support to the S3C SDI driver.
> > 
> > It implements all the configurations of the platform driver except the
> > set_power() callback and the ocr_avail mask.
> > 
> > Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> Hm, but is there any bootloader with dt support for s3c24xx?

I don't know, probably no - I don't care. IMHO main gain doesn't come
from the bootloader.

I use this patch by Jeremy Kerr to bundle dtb with the kernel. Another
solution has been proposed [0] but has some issue. More will come,
maybe allowing the bundle of multiple dtbs.

cheers,
Domenico

[0] http://article.gmane.org/gmane.linux.drivers.devicetree/5068


Index: arm-2.6.git/arch/arm/Kconfig
===================================================================
--- arm-2.6.git.orig/arch/arm/Kconfig	2011-04-05 16:06:26.000000000 +0200
+++ arm-2.6.git/arch/arm/Kconfig	2011-04-05 16:06:54.000000000 +0200
@@ -1694,6 +1694,10 @@
 	help
 	  Include support for flattened device tree machine descriptions.
 
+config ARM_EMBEDDED_DTB
+	string "Embedded device tree blob" if OF
+	default ""
+
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
Index: arm-2.6.git/arch/arm/Makefile
===================================================================
--- arm-2.6.git.orig/arch/arm/Makefile	2011-04-05 16:06:26.000000000 +0200
+++ arm-2.6.git/arch/arm/Makefile	2011-04-05 16:06:54.000000000 +0200
@@ -281,7 +281,7 @@
 # Convert bzImage to zImage
 bzImage: zImage
 
-zImage Image xipImage bootpImage uImage: vmlinux
+zImage Image xipImage bootpImage uImage dtbImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
 zinstall uinstall install: vmlinux
Index: arm-2.6.git/arch/arm/boot/Makefile
===================================================================
--- arm-2.6.git.orig/arch/arm/boot/Makefile	2011-04-05 16:06:26.000000000 +0200
+++ arm-2.6.git/arch/arm/boot/Makefile	2011-04-05 16:06:54.000000000 +0200
@@ -27,7 +27,7 @@
 
 export ZRELADDR INITRD_PHYS PARAMS_PHYS
 
-targets := Image zImage xipImage bootpImage uImage
+targets := Image zImage xipImage bootpImage uImage dtbImage
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
 
@@ -90,6 +90,14 @@
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
 
+$(obj)/dt/dtb: $(obj)/zImage FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/dt $@
+	@:
+
+$(obj)/dtbImage: $(obj)/dt/dtb FORCE
+	$(call if_changed,objcopy)
+	@echo '  Kernel: $@ is ready'
+
 PHONY += initrd FORCE
 initrd:
 	@test "$(INITRD_PHYS)" != "" || \
Index: arm-2.6.git/arch/arm/boot/dt/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ arm-2.6.git/arch/arm/boot/dt/Makefile	2011-04-05 16:06:54.000000000 +0200
@@ -0,0 +1,15 @@
+#
+# linux/arch/arm/dt/Makefile
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies.
+#
+
+LDFLAGS_dtb	:=-p --no-undefined -X -T
+
+targets	:= dtb dtb.o
+
+$(obj)/dtb:	$(src)/dtb.lds $(src)/dtb.o FORCE
+	$(call if_changed,ld)
+
+$(obj)/dtb.o: arch/arm/boot/zImage FORCE
Index: arm-2.6.git/arch/arm/boot/dt/dtb.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ arm-2.6.git/arch/arm/boot/dt/dtb.S	2011-04-05 16:06:54.000000000 +0200
@@ -0,0 +1,52 @@
+/*
+ * If we have an embedded dtb (_dtb_start < _dtb_end), then add a pointer
+ * to it in r2, as per the DT-on-ARM boot interface.
+ *
+ * r2-r14 overwritten
+ */
+
+#define DTB_ADDR		0x00001000
+
+	.globl start
+start:
+setup_dtb:
+	ldr	r4, =dtb_start
+	ldr	r5, =dtb_end
+
+	cmp	r4, r5		/* skip the init if there's no DTB */
+	beq	zimage_start
+
+	/* Find our offset from the link address, and update dtb start
+	 * and end pointers. */
+	bl	1f
+1:	sub	r6, lr, #(1b)
+	add	r4, r4, r6
+	add	r5, r5, r6
+
+	/* calculate final DTB address into r2 */
+	ldr	r7, =0xfff00000
+	and	r2, r6, r7
+	add	r2, r2, #DTB_ADDR
+
+	/* copy dtb to final address */
+	mov	r3, r2
+2:	ldmia	r4!, {r7-r14}
+	stmia	r3!, {r7-r14}
+	cmp	r4, r5
+	blo	2b
+
+	b	zimage_start
+
+	.ltorg
+
+	.align 4
+	.section .dtb,"a"
+dtb_start:
+	.incbin CONFIG_ARM_EMBEDDED_DTB
+dtb_end:
+	.align 4
+
+	.section .zimage,"ax"
+zimage_start:
+	.incbin "arch/arm/boot/zImage"
+
Index: arm-2.6.git/arch/arm/boot/dt/dtb.lds
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ arm-2.6.git/arch/arm/boot/dt/dtb.lds	2011-04-05 16:06:54.000000000 +0200
@@ -0,0 +1,25 @@
+/*
+ *  linux/arch/arm/boot/dt/dtb.lds
+ *
+ *  Copyright (C) 2009-2010 Jeremy Kerr <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+OUTPUT_ARCH(arm)
+ENTRY(start)
+SECTIONS
+{
+	.text : {
+		*(.text)
+	}
+
+	.dtb : {
+		*(.dtb)
+	}
+
+	.zimage : {
+		*(.zimage)
+	}
+}

-----[ Domenico Andreoli, aka cavok
 --[ http://www.dandreoli.com/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
