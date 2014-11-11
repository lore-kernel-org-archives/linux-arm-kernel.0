From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Nov 2014 19:27:24 +0100
Subject: [PATCH 3/4] ARM: shmobile: rcar-gen2: Add CA7 arch_timer
 initialization for r8a7794
In-Reply-To: <9ce3fa6816c2fb59d128248c9b0509aef1c5dae7.1415058939.git.horms+renesas@verge.net.au>
References: <cover.1415058939.git.horms+renesas@verge.net.au>
 <9ce3fa6816c2fb59d128248c9b0509aef1c5dae7.1415058939.git.horms+renesas@verge.net.au>
Message-ID: <5583214.HuX5EZ5Unx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 November 2014 10:50:08 Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> On E2, the arch timer is hooked up to a different clock, and the CA7's arch
> timer CNTVOFF register must be initialized.
> 
> Based on work by Hisashi Nakamura.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

This is one of the patches that broke allmodconfig in linux-next.

Can you apply the patch below before sending it to arm-soc?

Thanks,

	Arnd

---
>From 8bf0a4cae3137411498ff23ca46f693e4c22a25b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Nov 2014 16:36:50 +0100
Subject: [PATCH] ARM: shmobile: always build rcar setup for armv7

In a combined ARMv6/v7 kernel, the setup-rcar-gen2.c cannot
currently be compiled correctly because it uses the isb
instruction that is not available on ARMv6. Adding the
-march=armv7-a flag lets the compiler know that it is safe
to build this file for ARMv7.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 7d68eba53be3..b55cac0e5b2b 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,6 +35,7 @@ cpu-y				:= platsmp.o headsmp.o
 
 # Shared SoC family objects
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
+CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
 
 # SMP objects
 smp-y				:= $(cpu-y)
