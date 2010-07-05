From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  5 Jul 2010 16:15:27 +0200
Subject: [PATCH 09/11] ARM: uImage: require passing a LOADADDR when building
	with RUNTIME_PHYSOFFSET
In-Reply-To: <20100705141344.GA25407@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
Message-ID: <1278339329-23739-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the default load address (in the CONFIG_ZBOOT_ROM=n case) is ZRELADDR
which (apart from being a stupid load address for the
RUNTIME_PHYSOFFSET=n case) might not be a valid read/write memory on the
target machine at all.  So require passing a LOADADDR on the command
line.  This obiously makes the uImage more machine dependant than the
zImage.

Note RUNTIME_PHYSOFFSET doesn't exist yet, but is about to come soon.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 4a590f4..264dccf 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -64,11 +64,13 @@ quiet_cmd_uimage = UIMAGE  $@
 		   -C none -a $(LOADADDR) -e $(STARTADDR) \
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@
 
+ifeq ($(CONFIG_RUNTIME_PHYS_OFFSET),)
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
 $(obj)/uImage: LOADADDR=$(ZRELADDR)
 endif
+endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 # Set bit 0 to 1 so that "mov pc, rx" switches to Thumb-2 mode
@@ -77,7 +79,9 @@ else
 $(obj)/uImage: STARTADDR=$(LOADADDR)
 endif
 
-$(obj)/uImage:	$(obj)/zImage FORCE
+$(obj)/uImage: $(obj)/zImage FORCE
+	@test -n "$(LOADADDR)" || \
+	(echo "You must specify a load address (i.e. make uImage LOADADDR=0x...)"; exit 1)
 	$(call if_changed,uimage)
 	@echo '  Image $@ is ready'
 
-- 
1.7.1
