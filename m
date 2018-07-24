From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 24 Jul 2018 15:57:52 +0900
Subject: [PATCH v12 09/16] arm64: enable KEXEC_FILE config
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Message-ID: <20180724065759.19186-10-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify arm64/Kconfig to enable kexec_file_load support.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: James Morse <james.morse@arm.com>
---
 arch/arm64/Kconfig                     |  9 +++++++++
 arch/arm64/kernel/Makefile             |  3 ++-
 arch/arm64/kernel/machine_kexec_file.c | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..a9a3a5583c8b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -835,6 +835,15 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	help
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 0025f8691046..06281e1ad7ed 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -48,8 +48,9 @@ arm64-obj-$(CONFIG_ARM64_ACPI_PARKING_PROTOCOL)	+= acpi_parking_protocol.o
 arm64-obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 arm64-obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
 arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
-arm64-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o	\
+arm64-obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 					   cpu-reset.o
+arm64-obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o
 arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
 arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
new file mode 100644
index 000000000000..c38a8048ed00
--- /dev/null
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * kexec_file for arm64
+ *
+ * Copyright (C) 2018 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "kexec_file: " fmt
+
+#include <linux/kexec.h>
+
+const struct kexec_file_ops * const kexec_file_loaders[] = {
+	NULL
+};
-- 
2.18.0
