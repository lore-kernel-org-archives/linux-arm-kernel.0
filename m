From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  4 Mar 2014 09:10:04 +0800
Subject: [PATCH] arm64: enable generic CPU feature modalias matching for this
 architecture
Message-ID: <1393895404-14776-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables support for the generic CPU feature modalias implementation that
wires up optional CPU features to udev based module autoprobing.

A file <asm/cpufeature.h> is provided that maps CPU feature numbers to
elf_hwcap bits, which is the standard way on arm64 to advertise optional CPU
features both internally and to user space.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
The generic part of this code was pulled by Greg-KH into driver-core and has
been sitting in -next for about 2 weeks, so it is expected to be merged in 3.15.

http://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=67bad2fdb754

This is a soft prerequisite for the crypto patches that enable v8 Crypto
Extensions in the kernel, as it allows those modules to be loaded automatically
based on the presence of the extensions.

The modalias advertised by the CPU looks something like

  cpu:type:aarch64:features:,0001,0002,0003

The modalias match entry in, e.g., the AES module would look like

  cpu:type:*:features:*0003*


 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/cpufeature.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpufeature.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc7202a..3d27a1c4e4ad 100644
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
index 000000000000..019e4fe24d56
--- /dev/null
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -0,0 +1,29 @@
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
+#include <asm/hwcap.h>
+
+/*
+ * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
+ * in the kernel and for user space to keep track of which optional features
+ * are supported by the current system. So let's map feature 'x' to HWCAP_x.
+ * Note that HWCAP_x constants are bit fields so we need to take the log.
+ */
+
+#define MAX_CPU_FEATURES	(8 * sizeof(elf_hwcap))
+#define cpu_feature(x)		ilog2(HWCAP_ ## x)
+
+static inline bool cpu_have_feature(unsigned int num)
+{
+	return !!(elf_hwcap & (1UL << num));
+}
+
+#endif
-- 
1.8.3.2
