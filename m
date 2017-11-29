From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 29 Nov 2017 15:44:36 -0800
Subject: [PATCH 1/7] kbuild: add ld-name macro and support for GNU gold
In-Reply-To: <20171129234442.655-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
Message-ID: <20171129234442.655-2-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU gold may require different flags than GNU ld. Add a macro for
detecting the linker and conditionally add gold specific flags from
LDFLAGS_GOLD.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile               | 5 +++++
 scripts/Kbuild.include | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index f761bf475ba5..a16c98d6e3ba 100644
--- a/Makefile
+++ b/Makefile
@@ -814,6 +814,11 @@ include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 include scripts/Makefile.ubsan
 
+# Add any flags specific to ld.gold
+ifeq ($(ld-name),gold)
+LDFLAGS		+= $(LDFLAGS_GOLD)
+endif
+
 # Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS as the
 # last assignments
 KBUILD_CPPFLAGS += $(ARCH_CPPFLAGS) $(KCPPFLAGS)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b6d7d347b203..a7c7843c2cf1 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -277,6 +277,10 @@ ld-option = $(call try-run-cached,\
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
