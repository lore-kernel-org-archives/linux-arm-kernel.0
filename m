From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 24 Mar 2014 08:28:45 +0100
Subject: [PATCH] ARM: determine zreladdr for no-MMU machines automatically
In-Reply-To: <20140323113205.GI23076@pengutronix.de>
References: <20140323113205.GI23076@pengutronix.de>
Message-ID: <1395646125-8479-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

zreladdr must be virt_to_phys(PAGE_OFFSET + TEXT_OFFSET). For no-MMU
machines virt_to_phys is the identity mapping so zreladdr can be defined
to just PAGE_OFFSET + TEXT_OFFSET for no-MMU machines.

This fixes one of the problems when trying to compile a zImage for efm32
because this platform doesn't define zreladdr.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I tested this patch on top of Arnd's randconfig branch[1], it allowed to
drop db5fbcd0d71e (ARM: efm32: select AUTO_ZRELADDR) from it with zImage
still being compilable. When checking at91x40 (i.e. the other no-MMU
platform with a defconfig file), this patch would introduce a change
because arch/arm/mach-at91/Makefile.boot defines

	zreladdr-y += 0x20008000

but CONFIG_PAGE_OFFSET=0x01000000. I think that's a bug and my patch
does the right thing. Note that the at91x40 case isn't fixed though.

Best regards
Uwe

[1] http://git.kernel.org/cgit/linux/kernel/git/arnd/playground.git/?h=randconfig, commit:e65d61db588a057b5cbc3ba9bc8110819e05d748

 arch/arm/boot/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index ec2f8065f955..2d935dd098e5 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -15,6 +15,10 @@ ifneq ($(MACHINE),)
 include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
+ifeq ($(zreladdr-y)$(CONFIG_MMU),)
+zreladdr-y := $(CONFIG_PAGE_OFFSET)+$(TEXT_OFFSET)
+endif
+
 # Note: the following conditions must always be true:
 #   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
-- 
1.9.0
