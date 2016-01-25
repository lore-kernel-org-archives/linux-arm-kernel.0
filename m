From: dann.frazier@canonical.com (dann frazier)
Date: Mon, 25 Jan 2016 16:52:16 -0700
Subject: [PATCH v2] arm64: errata: Add -mpc-relative-literal-loads to build
 flags
Message-ID: <20160125235216.GA10738@fluid.dannf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GCC6 (and Linaro's 2015.12 snapshot of GCC5) has a new default that uses
adrp/ldr or adrp/add to address literal pools. When CONFIG_ARM64_ERRATUM_843419
is enabled, modules built with this toolchain fail to load:

  [ 2.156817] module libahci: unsupported RELA relocation: 275

Longterm, this will likely be superseded by -mfix-cortex-a53-843419, which
should disable this optimization in the future.

v2: Unconditionally use flag for both kernel and modules, as Ard notes we have
no requirement for supporting literals >1 MB away.

Cc: stable at vger.kernel.org
Fixes: df057cc7b4fa ("arm64: errata: add module build workaround for erratum #843419")
BugLink: http://bugs.launchpad.net/bugs/1533009
Suggested-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: dann frazier <dann.frazier@canonical.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index cd822d8..b6c90e5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -27,6 +27,7 @@ $(warning LSE atomics not supported by binutils)
 endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr)
+KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 KBUILD_AFLAGS	+= $(lseinstr)
 
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
-- 
2.7.0
