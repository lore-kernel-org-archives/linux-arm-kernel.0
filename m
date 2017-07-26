From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 26 Jul 2017 10:43:05 +0200
Subject: [PATCH] arm: fix sparse flags for build on 64bit machines
In-Reply-To: <20170726013020.GL2146@codeaurora.org>
References: <20170726013020.GL2146@codeaurora.org>
Message-ID: <20170726084305.38537-1-luc.vanoostenryck@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default sparse uses the characteristics of the build
machine to infer things like the wordsize.
This is fine when doing native builds but for ARM it's,
I suspect, very rarely the case and if the build are done
on a 64bit machine we get a bunch of warnings like:
  'cast truncates bits from constant value (... becomes ...)'

Fix this by adding the -m32 flags for sparse.

Reported-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 65f4e2a4e..121fd65f8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -131,7 +131,7 @@ endif
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
-CHECKFLAGS	+= -D__arm__
+CHECKFLAGS	+= -D__arm__ -m32
 
 #Default value
 head-y		:= arch/arm/kernel/head$(MMUEXT).o
-- 
2.13.2
