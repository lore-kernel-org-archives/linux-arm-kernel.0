From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 21 Oct 2014 22:11:31 +0800
Subject: [PATCH 1/4] ARM: introduce a CONFIG_ARCH_MULTIPLATFORM_STRICT Kconfig
 option
In-Reply-To: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
References: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1413900694-29571-2-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current allmodconfig kernel boot fails on OMAP4460. There
are several configuration options that can only work on a subset
of the available machines, and enabling them will break other
machines that may be enabled in a multiplatform kernel.

Now we introduce a CONFIG_ARCH_MULTIPLATFORM_STRICT Kconfig 
option that prevent those other options from getting enabled
and get a strict multiplatform kernel.

Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
---
 arch/arm/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5c..50762cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -840,6 +840,20 @@ config ARCH_MULTI_CPU_AUTO
 
 endmenu
 
+config ARCH_MULTIPLATFORM_STRICT
+	bool "Only allow options that do not break other platforms"
+	depends on ARCH_MULTIPLATFORM
+	default y
+	help
+         There are several configuration options that can only work
+         on a subset of the available machines, and enabling them
+         will break running the kernel on other machines that may be
+         enabled in a multiplatform kernel.
+
+         Enabling ARCH_MULTIPLATFORM_STRICT will prevent those other
+         options from getting enabled, so the kernel should always
+         run on any hardware that is part of the configuration.
+
 config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
 	select ARM_AMBA
-- 
2.1.1
