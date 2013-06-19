From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 17:30:03 +0100
Subject: [PATCH 6/6] ARM: ensure loader information in LE format for BE kernels
In-Reply-To: <1371659404-20167-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371659404-20167-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1371659404-20167-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nico Pitre <nico@fluxnic.net>

If the loader for the system is assuming we are booting a BE kernel
from a LE loading environment, then ensure that the magic number
and image start/end values are in little endian format.

[ben.dooks at codethink.co.uk: from nico's original email on this subject]
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/Makefile       |    5 ++++-
 arch/arm/boot/compressed/head.S         |    7 ++++---
 arch/arm/boot/compressed/vmlinux.lds.in |   14 ++++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 79e9bdb..633391c 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -194,8 +194,11 @@ CFLAGS_font.o := -Dstatic=
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
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 032a8d9..1b9195c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -130,9 +130,10 @@ start:
  THUMB(		adr	r12, BSYM(1f)	)
  THUMB(		bx	r12		)
 
-		.word	0x016f2818		@ Magic numbers to help the loader
-		.word	start			@ absolute load/run zImage address
-		.word	_edata			@ zImage end address
+		.word	_magic_sig	@ Magic numbers to help the loader
+		.word	_magic_start	@ absolute load/run zImage address
+		.word	_magic_end	@ zImage end address
+
  THUMB(		.thumb			)
 1:
 		mrs	r9, cpsr
diff --git a/arch/arm/boot/compressed/vmlinux.lds.in b/arch/arm/boot/compressed/vmlinux.lds.in
index 4919f2a..567250f 100644
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
-- 
1.7.10.4
