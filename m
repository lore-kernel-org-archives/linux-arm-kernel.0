From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:01 -0800
Subject: [PATCH v2 3/7] kbuild: add ld-name macro
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-4-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU gold may require different flags than GNU ld. Add a macro for
detecting the linker.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/Kbuild.include | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index eb2cf2780f6e..899863e4cd05 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -273,6 +273,10 @@ ld-option = $(call try-run-cached,\
 # Important: no spaces around options
 ar-option = $(call try-run-cached, $(AR) rc$(1) "$$TMP",$(1),$(2))
 
+# ld-name
+# Expands to either bfd or gold
+ld-name = $(shell $(LD) -v 2>&1 | grep -q "GNU gold" && echo gold || echo bfd)
+
 # ld-version
 # Note this is mainly for HJ Lu's 3 number binutil versions
 ld-version = $(call shell-cached,$(LD) --version | $(srctree)/scripts/ld-version.sh)
-- 
2.15.0.531.g2ccb3012c9-goog
