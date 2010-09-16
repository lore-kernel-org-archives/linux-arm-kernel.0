From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Thu, 16 Sep 2010 09:23:03 +0200
Subject: [PATCH] ARM: New option for generating uncompressed uImage.
Message-ID: <1284621783-8196-1-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems do boot faster with an uncompressed kernel.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/Kconfig       |    7 +++++++
 arch/arm/boot/Makefile |    4 ++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0b52271..7570be5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1591,6 +1591,13 @@ config AUTO_ZRELADDR
 	  0xf8000000. This assumes the zImage being placed in the first 128MB
 	  from start of memory.
 
+config UNCOMPRESSED_UIMAGE
+	bool "Uncompressed uImage"
+	help
+	  Some systems do boot faster if an uncompressed kernel is used.
+	  This is depending on your bootloader's flash/mmc read speed
+	  and your CPU speed.
+
 endmenu
 
 menu "CPU Power Management"
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..dca3163 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -77,7 +77,11 @@ else
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 endif
 
+ifeq ($(CONFIG_UNCOMPRESSED_UIMAGE),y)
+$(obj)/uImage:	$(obj)/Image FORCE
+else
 $(obj)/uImage:	$(obj)/zImage FORCE
+endif
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
-- 
1.6.3.3
