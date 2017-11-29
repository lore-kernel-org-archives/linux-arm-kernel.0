From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 29 Nov 2017 15:44:41 -0800
Subject: [PATCH 6/7] arm64: explicitly pass --no-fix-cortex-a53-843419 to GNU
 gold
In-Reply-To: <20171129234442.655-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
Message-ID: <20171129234442.655-7-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some versions of GNU gold are known to produce broken code with
--fix-cortex-a53-843419 as explained in this bug:

  https://sourceware.org/bugzilla/show_bug.cgi?id=21491

If ARM64_ERRATUM_843419 is disabled and we're using GNU gold, pass
--no-fix-cortex-a53-843419 to the linker to ensure the erratum
fix is not used even if the linker is configured to enable it by
default.

This change also adds a warning if the erratum fix is enabled and
gold version <1.14 is used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 82a0df6e865e..81a12713f7af 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -26,10 +26,19 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
   ifeq ($(call ld-option, --fix-cortex-a53-843419),)
 $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
   else
+    ifeq ($(call gold-ifversion, -lt, 114000000, y), y)
+$(warning This version of GNU gold may generate incorrect code with --fix-cortex-a53-843419;\
+	see https://sourceware.org/bugzilla/show_bug.cgi?id=21491)
+    endif
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+ifeq ($(CONFIG_ARM64_ERRATUM_843419),)
+# https://sourceware.org/bugzilla/show_bug.cgi?id=21491
+LDFLAGS_GOLD	+= --no-fix-cortex-a53-843419
+endif
+
 KBUILD_DEFCONFIG := defconfig
 
 # Check for binutils support for specific extensions
-- 
2.15.0.531.g2ccb3012c9-goog
