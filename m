From: huawei.libin@huawei.com (Li Bin)
Date: Mon, 10 Apr 2017 09:52:12 +0800
Subject: [PATCH] arm64: kaslr: fix ARM64_MODULE_PLTS dependency
Message-ID: <1491789132-18933-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a bug that when RANDOMIZE_BASE enabled and
RANDOMIZE_MODULE_REGION_FULL disabled, and assume that there are
many modules, and module space is not enabled, module_alloc code
now will alloc space in vmalloc space, and the patch
"fe88a4 arm64: kaslr: keep modules close to the kernel when
DYNAMIC_FTRACE=y" will be invalid.

In fact, we only need plt when RANDOMIZE_MODULE_REGION_FULL enabled,
so fix the dependency, that only RANDOMIZE_MODULE_REGION_FULL select
ARM64_MODULE_PLTS.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3741859..40692bb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -952,7 +952,6 @@ config RELOCATABLE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image"
-	select ARM64_MODULE_PLTS if MODULES
 	select RELOCATABLE
 	help
 	  Randomizes the virtual address at which the kernel image is
@@ -972,6 +971,7 @@ config RANDOMIZE_BASE
 config RANDOMIZE_MODULE_REGION_FULL
 	bool "Randomize the module region independently from the core kernel"
 	depends on RANDOMIZE_BASE && !DYNAMIC_FTRACE
+	select ARM64_MODULE_PLTS if MODULES
 	default y
 	help
 	  Randomizes the location of the module region without considering the
-- 
1.7.12.4
