From: w@1wt.eu (Willy Tarreau)
Date: Sat, 6 Apr 2013 21:29:57 +0200
Subject: [PATCH] ARM: makefile: add tuning options for Armada 370/XP
Message-ID: <20130406192957.GQ11459@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A patch from Marvell was merged in GCC 4.8 to add support for their
PJ4 CPU core used in Armada370 and XP. I noticed a steady 2% network
performance increase using -mcpu=marvell-pj4 and around 1% when using
-mtune=xscale instead. I have no idea whether it provides anything to
the Dove platform and I don't have one to test, so I didn't touch it.

Now that 4.8 is released, it would be nice to have this option used
when supported.

Regards,
Willy

>From b5b34f87e753fbd756f3c23536e731bb1aa6bf7f Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 3 Mar 2013 23:26:41 +0100
Subject: [PATCH] ARM: makefile: add tuning options for Armada 370/XP

Let's pass -mcpu=marvell-pj4 and fall back to -mtune=xscale for Armada370
and ArmadaXP. Both settings have shown an improvement over the default
setting on these chips using gcc-4.7 with and without the Marvell patch
(typically 2% on network traffic).

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 15747d9..7dd5418 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -93,6 +93,7 @@ tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -
 tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
 tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
+tune-$(CONFIG_MACH_ARMADA_370_XP)	:=$(call cc-option,-mcpu=marvell-pj4,-mtune=xscale)
 
 ifeq ($(CONFIG_AEABI),y)
 CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork
-- 
1.7.12.2.21.g234cd45.dirty
