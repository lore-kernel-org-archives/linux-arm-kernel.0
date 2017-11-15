From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:11 -0800
Subject: [PATCH v2 01/18] kbuild: add ld-name macro and support for GNU gold
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-2-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GNU gold may require different flags than GNU ld. Add a macro for
detecting the linker and conditionally add gold specific flags from
LDFLAGS_GOLD.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 Makefile               | 5 +++++
 scripts/Kbuild.include | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Makefile b/Makefile
index 763ab35df12a..f976af9525bf 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,11 @@ include scripts/Makefile.kasan
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
index 9ffd3dda3889..584d6cecd7c0 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -172,6 +172,10 @@ ld-option = $(call try-run,\
 # Important: no spaces around options
 ar-option = $(call try-run, $(AR) rc$(1) "$$TMP",$(1),$(2))
 
+# ld-name
+# Expands to either bfd or gold
+ld-name = $(shell $(LD) -v 2>&1 | grep -q "GNU gold" && echo gold || echo bfd)
+
 # ld-version
 # Note this is mainly for HJ Lu's 3 number binutil versions
 ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
-- 
2.15.0.448.gf294e3d99a-goog
