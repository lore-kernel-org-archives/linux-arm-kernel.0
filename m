From: jeffv@google.com (Jeff Vander Stoep)
Date: Tue, 26 Jul 2016 10:16:55 -0700
Subject: [PATCH] arm64: Fix Kconfig dependencies for RANDOMIZE_BASE
Message-ID: <1469553415-26839-1-git-send-email-jeffv@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting CONFIG_RANDOMIZE_BASE=y and CONFIG_MODULES=n causes a
build error due to dependencies on modules. This patch makes KASLR
module config options dependent on CONFIG_MODULES=y.

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 arch/arm64/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e23f95..c9eff79 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -891,7 +891,6 @@ config RELOCATABLE
 
 config RANDOMIZE_BASE
 	bool "Randomize the address of the kernel image"
-	select ARM64_MODULE_PLTS
 	select RELOCATABLE
 	help
 	  Randomizes the virtual address at which the kernel image is
@@ -911,6 +910,8 @@ config RANDOMIZE_BASE
 config RANDOMIZE_MODULE_REGION_FULL
 	bool "Randomize the module region independently from the core kernel"
 	depends on RANDOMIZE_BASE
+	depends on MODULES
+	select ARM64_MODULE_PLTS
 	default y
 	help
 	  Randomizes the location of the module region without considering the
-- 
2.8.0.rc3.226.g39d4020
