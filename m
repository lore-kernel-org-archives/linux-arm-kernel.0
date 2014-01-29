From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jan 2014 17:50:45 +0100
Subject: [PATCH 4/5] arm64: enable generic CPU feature modalias matching for
 this arch
In-Reply-To: <1391014246-9715-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1391014246-9715-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1391014246-9715-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for the generic CPU feature modalias implementation that
wires up optional CPU features to udev based module autoprobing.

A file <asm/cpufeatures.h> is provided that maps CPU feature numbers to
elf_hwcap bits, which is the standard way on arm64 to advertise optional CPU
features both internally and to user space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cpufeature.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpufeature.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dd4327f09ba4..e339099b6fbd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,6 +16,7 @@ config ARM64
 	select DCACHE_WORD_ACCESS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
new file mode 100644
index 000000000000..1d902efa201d
--- /dev/null
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_CPUFEATURE_H
+#define __ASM_CPUFEATURE_H
+
+#include <asm/elf.h>
+#include <asm/hwcap.h>
+
+/*
+ * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
+ * in the kernel and for user space to keep track of which optional features
+ * are supported by the current system. So let's map feature 'x' to HWCAP_x.
+ * Note that HWCAP_x constants are bit fields so we need to take the log.
+ */
+
+#define MAX_CPU_FEATURES	sizeof(elf_hwcap)
+#define cpu_feature(x)		((unsigned int)ilog2(HWCAP_ ## x))
+
+static inline bool cpu_have_feature(unsigned int num)
+{
+	return !!(elf_hwcap & (1 << num));
+}
+
+#endif
-- 
1.8.3.2
