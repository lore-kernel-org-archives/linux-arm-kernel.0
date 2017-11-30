From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:04 -0800
Subject: [PATCH v2 6/7] arm64: explicitly pass --no-fix-cortex-a53-843419 to
 GNU gold
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-7-samitolvanen@google.com>
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
index 82a0df6e865e..68eed687e468 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -26,8 +26,17 @@ ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
   ifeq ($(call ld-option, --fix-cortex-a53-843419),)
 $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
   else
+    ifeq ($(call gold-ifversion, -lt, 114000000, y), y)
+$(warning This version of GNU gold may generate incorrect code with --fix-cortex-a53-843419;\
+	see https://sourceware.org/bugzilla/show_bug.cgi?id=21491)
+    endif
 LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
+else
+  ifeq ($(ld-name),gold)
+# Pass --no-fix-cortex-a53-843419 to ensure the erratum fix is disabled
+LDFLAGS	+= --no-fix-cortex-a53-843419
+  endif
 endif
 
 KBUILD_DEFCONFIG := defconfig
-- 
2.15.0.531.g2ccb3012c9-goog
