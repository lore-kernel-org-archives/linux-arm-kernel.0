From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:56 +0800
Subject: [RFC PATCH v4 18/34] early kprobes: add CONFIG_EARLY_KPROBES option.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-19-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable early kprobes in Kconfig.

Currently only allow early kprobes for ARM. Following patchs will deal
with KPROBES_ON_FTRACE. After that x86 will also be enabled.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/Kconfig     | 19 +++++++++++++++++++
 arch/arm/Kconfig |  1 +
 2 files changed, 20 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 05d7a8a..8a772ab 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -46,6 +46,22 @@ config KPROBES
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
 
+config EARLY_KPROBES
+	bool "Enable kprobes at very early booting stage"
+	depends on KPROBES
+	depends on HAVE_EARLY_KPROBES
+	def_bool y
+	help
+	  Enable kprobe at very early booting stage.
+
+config NR_EARLY_KPROBES_SLOTS
+	int "Number of possible early kprobes"
+	range 1 64
+	default 16
+	depends on EARLY_KPROBES
+	help
+	  Number of early kprobes slots.
+
 config JUMP_LABEL
        bool "Optimize very unlikely/likely branches"
        depends on HAVE_ARCH_JUMP_LABEL
@@ -170,6 +186,9 @@ config HAVE_IOREMAP_PROT
 config HAVE_KPROBES
 	bool
 
+config HAVE_EARLY_KPROBES
+	bool
+
 config HAVE_KRETPROBES
 	bool
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..84ad7f9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -43,6 +43,7 @@ config ARM
 	select HAVE_DMA_ATTRS
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
+	select HAVE_EARLY_KPROBES if (HAVE_KPROBES)
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
-- 
1.8.4
