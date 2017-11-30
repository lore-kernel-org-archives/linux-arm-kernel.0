From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:38:27 -0800
Subject: [PATCH v2 2/2] kbuild: add __cc-ifversion and compiler-specific
 variants
In-Reply-To: <20171130233827.130069-1-samitolvanen@google.com>
References: <20171129000011.55235-1-samitolvanen@google.com>
 <20171130233827.130069-1-samitolvanen@google.com>
Message-ID: <20171130233827.130069-3-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds macros for testing both compiler name and
version. Current cc-version, cc-ifversion etc. macros that test
gcc version are left unchanged to prevent compatibility issues
with existing tests.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Kbuild.include | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 065324a8046f..eb2cf2780f6e 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -215,6 +215,37 @@ cc-disable-warning = $(call try-run-cached,\
 # Expands to either gcc or clang
 cc-name = $(call shell-cached,$(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
 
+# __cc-version
+# Returns compiler version
+__cc-version = $(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/$(cc-name)-version.sh $(CC))
+
+# __cc-fullversion
+# Returns full compiler version
+__cc-fullversion = $(call shell-cached,$(CONFIG_SHELL) \
+	$(srctree)/scripts/$(cc-name)-version.sh -p $(CC))
+
+# __cc-ifversion
+# Matches compiler name and version
+# Usage:  EXTRA_CFLAGS += $(call cc-if-name-version, gcc, -lt, 0402, -O1)
+__cc-ifversion = $(shell [ $(cc-name) = $(1) ] && [ $(__cc-version) $(2) $(3) ] && echo $(4) || echo $(5))
+
+# __cc-if-fullversion
+# Matches compiler name and full version
+# Usage:  EXTRA_CFLAGS += $(call cc-if-name-fullversion, gcc, -lt, 040502, -O1)
+__cc-if-fullversion = $(shell [ $(cc-name) = $(1) ] && [ $(__cc-fullversion) $(2) $(3) ] && echo $(4) || echo $(5))
+
+# gcc-ifversion
+gcc-ifversion = $(call __cc-ifversion, gcc, $(1), $(2), $(3), $(4))
+
+# gcc-if-fullversion
+gcc-if-fullversion = (call __cc-if-fullversion, gcc, $(1), $(2), $(3), $(4))
+
+# clang-ifversion
+clang-ifversion =  $(call __cc-ifversion, clang, $(1), $(2), $(3), $(4))
+
+# clang-if-fullversion
+clang-if-fullversion = (call __cc-if-fullversion, clang, $(1), $(2), $(3), $(4))
+
 # cc-version
 cc-version = $(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
@@ -222,13 +253,9 @@ cc-version = $(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-version.
 cc-fullversion = $(call shell-cached,$(CONFIG_SHELL) \
 	$(srctree)/scripts/gcc-version.sh -p $(CC))
 
-# cc-ifversion
-# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
-cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
-
-# cc-if-fullversion
-# Usage:  EXTRA_CFLAGS += $(call cc-if-fullversion, -lt, 040502, -O1)
-cc-if-fullversion = $(shell [ $(cc-fullversion) $(1) $(2) ] && echo $(3) || echo $(4))
+# backward compatibility
+cc-ifversion = $(gcc-ifversion)
+cc-if-fullversion = $(gcc-if-fullversion)
 
 # cc-ldoption
 # Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
-- 
2.15.0.531.g2ccb3012c9-goog
