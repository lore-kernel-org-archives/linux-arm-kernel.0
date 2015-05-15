From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 15 May 2015 16:59:00 +0300
Subject: [PATCH v2 1/5] kasan,
 x86: move KASAN_SHADOW_OFFSET to the arch Kconfig
In-Reply-To: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1431698344-28054-2-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KASAN_SHADOW_OFFSET is purely arch specific setting,
so it should be in arch's Kconfig file. This simplifies
porting KASan to other architectures and maintenance of it.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/x86/Kconfig  | 4 ++++
 lib/Kconfig.kasan | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c92fdcc..b530967 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -251,6 +251,10 @@ config ARCH_SUPPORTS_OPTIMIZED_INLINING
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	def_bool y
 
+config KASAN_SHADOW_OFFSET
+	hex
+	default 0xdffffc0000000000
+
 config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 777eda7..39f24d6 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -18,10 +18,6 @@ config KASAN
 	  For better error detection enable CONFIG_STACKTRACE,
 	  and add slub_debug=U to boot cmdline.
 
-config KASAN_SHADOW_OFFSET
-	hex
-	default 0xdffffc0000000000 if X86_64
-
 choice
 	prompt "Instrumentation type"
 	depends on KASAN
-- 
2.4.0
