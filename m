From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 12 Feb 2013 17:13:13 -0500 (EST)
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <511A7CEB.9000006@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212171310.GS17833@n2100.arm.linux.org.uk>
 <511A7CEB.9000006@codethink.co.uk>
Message-ID: <alpine.LFD.2.03.1302121707250.1242@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Feb 2013, Ben Dooks wrote:

> If we ignore the ATAG issue, then most of the support is currently in
> the kernel to do this and there's not a lot of changes.

You could make CPU_BE8_BOOT_LE depend on !ATAG.

> I think that some of the boot changes could be dealt with by a 
> post-process of the zImage (such as the zImage magic) which would make 
> this series less intrusive to the kernel.

No, please don't do that.  Especially if the kernel binary _expects_ to 
be booted from a LE environment.  Otherwise we might end up with 
kernels that don't boot because there are environment expectation 
mismatch, etc.

Here's what could be done for the zImage header:

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4d5f4192ee..2077ebb734 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -129,9 +129,9 @@ start:
  THUMB(		adr	r12, BSYM(1f)	)
  THUMB(		bx	r12		)
 
-		.word	0x016f2818		@ Magic numbers to help the loader
-		.word	start			@ absolute load/run zImage address
-		.word	_edata			@ zImage end address
+		.word	_magic_sig	@ Signature to help the loader (0x016f2818)
+		.word	_magic_start	@ zImage load/run address (0 if relocatable)
+		.word	_magic_end	@ zImage end address
  THUMB(		.thumb			)
 1:
 		mrs	r9, cpsr
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index a517153a13..52539f46c1 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -200,8 +200,11 @@ CFLAGS_font.o := -Dstatic=
 $(obj)/font.c: $(FONTC)
 	$(call cmd,shipped)
 
-$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile $(KCONFIG_CONFIG)
+$(obj)/vmlinux.lds.S: $(obj)/vmlinux.lds.in arch/arm/boot/Makefile $(KCONFIG_CONFIG)
 	@sed "$(SEDFLAGS)" < $< > $@
 
+$(obj)/vmlinux.lds: $(obj)/vmlinux.lds.S
+	$(call if_changed,cpp_lds_S)
+
 $(obj)/hyp-stub.S: $(srctree)/arch/$(SRCARCH)/kernel/hyp-stub.S
 	$(call cmd,shipped)
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 4919f2ac8b..567250fb7d 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.in
+++ b/arch/arm/boot/compressed/vmlinux.lds.in
@@ -7,6 +7,16 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#ifdef CONFIG_CPU_BE8_BOOT_LE
+#define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
+			  (((x) >>  8) & 0x0000ff00) | \
+			  (((x) <<  8) & 0x00ff0000) | \
+			  (((x) << 24) & 0xff000000) )
+#else
+#define ZIMAGE_MAGIC(x) (x)
+#endif
+
 OUTPUT_ARCH(arm)
 ENTRY(_start)
 SECTIONS
@@ -57,6 +67,10 @@ SECTIONS
   .pad			: { BYTE(0); . = ALIGN(8); }
   _edata = .;
 
+  _magic_sig = ZIMAGE_MAGIC(0x016f2818);
+  _magic_start = ZIMAGE_MAGIC(_start);
+  _magic_end = ZIMAGE_MAGIC(_edata);
+
   . = BSS_START;
   __bss_start = .;
   .bss			: { *(.bss) }
