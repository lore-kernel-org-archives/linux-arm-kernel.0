From: dann.frazier@canonical.com (dann frazier)
Date: Fri, 22 Jan 2016 16:07:02 -0700
Subject: [PATCH] arm64: errata: Add -mpc-relative-literal-loads to erratum
 #843419 build flags
Message-ID: <1453504022-7890-1-git-send-email-dann.frazier@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC6 (and Linaro's 2015.12 snapshot of GCC5) has a new default that uses
adrp/ldr or adrp/add to address literal pools. When CONFIG_ARM64_ERRATUM_843419
is enabled, modules built with this toolchain fail to load:

  [ 2.156817] module libahci: unsupported RELA relocation: 275

Longterm, this will likely be superseded by -mfix-cortex-a53-843419, which
should disable this optimization in the future.

Cc: stable at vger.kernel.org
Fixes: df057cc7b4fa ("arm64: errata: add module build workaround for erratum #843419")
BugLink: http://bugs.launchpad.net/bugs/1533009
Suggested-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index cd822d8..08e794d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -43,6 +43,7 @@ CHECKFLAGS	+= -D__aarch64__
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
 KBUILD_CFLAGS_MODULE	+= -mcmodel=large
+KBUILD_CFLAGS_MODULE	+= $(call cc-option, -mpc-relative-literal-loads)
 endif
 
 # Default value
-- 
2.7.0
