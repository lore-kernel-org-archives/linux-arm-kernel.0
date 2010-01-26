From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Jan 2010 10:14:24 +0000
Subject: [PATCH] ARM: Always generate the IT instruction when compiling for
	Thumb-2
Message-ID: <20100126101424.14567.70480.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current behaviour is to generate the IT instruction only for Thumb-2
code. However, the kernel helpers in entry-armv.S are compiled to ARM in
a unified syntax file (if THUMB2_KERNEL). Recent compilers warn about
missing IT instruction in unified assembly syntax files. The patch
changes the "-mimplicit-it" gas option to "always".

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9e75825..356d702 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -94,7 +94,7 @@ CFLAGS_ABI	+=-funwind-tables
 endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
-AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=thumb,-Wa$(comma)-mauto-it)
+AFLAGS_AUTOIT	:=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 CFLAGS_THUMB2	:=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
 AFLAGS_THUMB2	:=$(CFLAGS_THUMB2) -Wa$(comma)-mthumb
