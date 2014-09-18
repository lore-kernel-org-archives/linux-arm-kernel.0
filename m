From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 18 Sep 2014 18:22:23 +0200
Subject: [PATCH] arm: kbuild: make uImage entry an odd number on ARMv7-M
In-Reply-To: <1411057343-20861-1-git-send-email-manabian@gmail.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
Message-ID: <1411057343-20861-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows U-Boot to branch to the kernel in Thumb mode on ARMv7M
CPUs that doesn't support ARM mode.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
Hi,

Based on old "Make the uImage entry an odd number" e2ed3be7319f2734
patch by Catalin Marinas.

regards
Joachim Eastwood

 arch/arm/boot/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index ec2f8065f955..bb68035e42f2 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -75,6 +75,11 @@ if [ $(words $(UIMAGE_LOADADDR)) -ne 1 ]; then \
 	false; \
 fi
 
+ifeq ($(CONFIG_CPU_V7M),y)
+  # Set bit 0 to 1 so that Thumb mode is used
+  UIMAGE_ENTRYADDR=$(shell echo $(UIMAGE_LOADADDR) | sed -e "s/.$$/1/")
+endif
+
 $(obj)/uImage:	$(obj)/zImage FORCE
 	@$(check_for_multiple_loadaddr)
 	$(call if_changed,uimage)
-- 
1.8.0
