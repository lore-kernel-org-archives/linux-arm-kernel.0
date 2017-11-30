From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:02 -0800
Subject: [PATCH v2 4/7] kbuild: add __ld-ifversion and linker-specific macros
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-5-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros for testing both linker name and version.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Kbuild.include | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 899863e4cd05..2991b463b4ce 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -285,6 +285,18 @@ ld-version = $(call shell-cached,$(LD) --version | $(srctree)/scripts/ld-version
 # Usage:  $(call ld-ifversion, -ge, 22252, y)
 ld-ifversion = $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))
 
+# __ld-ifversion
+# Usage:  $(call __ld-ifversion, gold, -ge, 112000000, y)
+__ld-ifversion = $(shell [ $(ld-name) == $(1) ] && [ $(ld-version) $(2) $(3) ] && echo $(4) || echo $(5))
+
+# bfd-ifversion
+# Usage:  $(call bfd-ifversion, -ge, 227000000, y)
+bfd-ifversion = $(call __ld-ifversion, bfd, $(1), $(2), $(3), $(4))
+
+# gold-ifversion
+# Usage:  $(call gold-ifversion, -ge, 112000000, y)
+gold-ifversion = $(call __ld-ifversion, gold, $(1), $(2), $(3), $(4))
+
 ######
 
 ###
-- 
2.15.0.531.g2ccb3012c9-goog
