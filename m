From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  8 Sep 2017 12:16:12 +0900
Subject: [PATCH 5/9] arm64: kexec_file: create purgatory
In-Reply-To: <20170908031616.17916-1-takahiro.akashi@linaro.org>
References: <20170908031616.17916-1-takahiro.akashi@linaro.org>
Message-ID: <20170908031616.17916-6-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a basic purgatory, or a kind of glue code between the two kernels,
for arm64.

Since purgatory is assumed to be relocatable (not executable) object by
kexec generic code, arch_kexec_apply_relocations_add() is required in
general. Arm64's purgatory, however, is a simple asm and all the references
can be resolved as local, no re-linking is needed here.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile           |  1 +
 arch/arm64/kernel/Makefile    |  1 +
 arch/arm64/purgatory/Makefile | 24 +++++++++++++++++++
 arch/arm64/purgatory/entry.S  | 55 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 arch/arm64/purgatory/Makefile
 create mode 100644 arch/arm64/purgatory/entry.S

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9b41f1e3b1a0..429f60728c0a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -105,6 +105,7 @@ core-$(CONFIG_XEN) += arch/arm64/xen/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+core-$(CONFIG_KEXEC_FILE) += arch/arm64/purgatory/
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index f2b4e816b6de..16e9f56b536a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -50,6 +50,7 @@ arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/purgatory/Makefile b/arch/arm64/purgatory/Makefile
new file mode 100644
index 000000000000..c2127a2cbd51
--- /dev/null
+++ b/arch/arm64/purgatory/Makefile
@@ -0,0 +1,24 @@
+OBJECT_FILES_NON_STANDARD := y
+
+purgatory-y := entry.o
+
+targets += $(purgatory-y)
+PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
+
+LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined \
+					-nostdlib -z nodefaultlib
+targets += purgatory.ro
+
+$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+		$(call if_changed,ld)
+
+targets += kexec_purgatory.c
+
+CMD_BIN2C = $(objtree)/scripts/basic/bin2c
+quiet_cmd_bin2c = BIN2C $@
+	cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
+
+$(obj)/kexec_purgatory.c: $(obj)/purgatory.ro FORCE
+	$(call if_changed,bin2c)
+
+obj-${CONFIG_KEXEC_FILE}	+= kexec_purgatory.o
diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
new file mode 100644
index 000000000000..fe6e968076db
--- /dev/null
+++ b/arch/arm64/purgatory/entry.S
@@ -0,0 +1,55 @@
+/*
+ * kexec core purgatory
+ */
+#include <linux/linkage.h>
+#include <uapi/linux/kexec.h>
+
+#define SHA256_DIGEST_SIZE	32 /* defined in crypto/sha.h */
+
+.text
+
+ENTRY(purgatory_start)
+	/* Start new image. */
+	ldr	x17, __kernel_entry
+	ldr	x0, __dtb_addr
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	br	x17
+END(purgatory_start)
+
+/*
+ * data section:
+ * kernel_entry and dtb_addr are global but also labelled as local,
+ * "__xxx:", to avoid unwanted re-linking.
+ *
+ * purgatory_sha_regions and purgatory_sha256_digest are referenced
+ * by kexec generic code and so must exist, but not actually used
+ * here because hash check is not that useful in purgatory.
+ */
+.align 3
+
+.globl kernel_entry
+kernel_entry:
+__kernel_entry:
+	.quad	0
+END(kernel_entry)
+
+.globl dtb_addr
+dtb_addr:
+__dtb_addr:
+	.quad	0
+END(dtb_addr)
+
+.globl purgatory_sha_regions
+purgatory_sha_regions:
+	.rept	KEXEC_SEGMENT_MAX
+	.quad	0
+	.quad	0
+	.endr
+END(purgatory_sha_regions)
+
+.globl purgatory_sha256_digest
+purgatory_sha256_digest:
+        .skip   SHA256_DIGEST_SIZE
+END(purgatory_sha256_digest)
-- 
2.14.1
