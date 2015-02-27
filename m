From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Feb 2015 09:11:37 +0000
Subject: [PATCH resend 1/2] ARM: KVM: avoid "HYP init code too big" error
In-Reply-To: <1425028298-17289-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425028298-17289-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1425028298-17289-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

When building large kernels, the linker will emit lots of veneers
into the .hyp.idmap.text section, which causes it to grow beyond
one page, and that triggers the build error.

This moves the section into .rodata instead, which avoids the
veneers and is safe because the code is not executed directly
but remapped by the hypervisor into its own executable address
space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ardb: move the ALIGN() to .rodata as well, update log s/copied/remapped/]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/vmlinux.lds.S | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b31aa73e8076..2787eb8d3616 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -22,11 +22,15 @@
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
 	*(.idmap.text)							\
-	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
+	VMLINUX_SYMBOL(__idmap_text_end) = .;
+
+#define IDMAP_RODATA							\
+	.rodata : {							\
 	. = ALIGN(32);							\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
 	*(.hyp.idmap.text)						\
-	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
+	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;			\
+	}
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -124,6 +128,7 @@ SECTIONS
 	. = ALIGN(1<<SECTION_SHIFT);
 #endif
 	RO_DATA(PAGE_SIZE)
+	IDMAP_RODATA
 
 	. = ALIGN(4);
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
-- 
1.8.3.2
