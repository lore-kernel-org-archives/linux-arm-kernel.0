From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 May 2011 12:16:48 +0100
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
Message-ID: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer versions of gcc generate unaligned accesses by default, causing
kernel panics when CONFIG_ALIGNMENT_TRAP is enabled. This patch adds the
-mno-unaligned-access option to gcc.

Reported-by: Ali Saidi <ali.saidi@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c7d321a..1c383d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -101,6 +101,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
 CFLAGS_ABI	+=-funwind-tables
 endif
 
+ifeq ($(CONFIG_ALIGNMENT_TRAP),y)
+CFLAGS_ABI	+=$(call cc-option,-mno-unaligned-access,)
+endif
+
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
