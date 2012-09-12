From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 19:49:48 +0000
Subject: [PATCH 11/12] ARM: initial multiplatform support
In-Reply-To: <1346962375-26163-12-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-12-git-send-email-robherring2@gmail.com>
Message-ID: <201209121949.49109.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 September 2012, Rob Herring wrote:

> +machine-$(CONFIG_ARCH_EXYNOS4)         += exynos
> +machine-$(CONFIG_ARCH_EXYNOS5)         += exynos

> +machine-$(CONFIG_MACH_SPEAR1310)       += spear13xx
> +machine-$(CONFIG_MACH_SPEAR1340)       += spear13xx

> +machine-$(CONFIG_MACH_SPEAR300)                += spear3xx
> +machine-$(CONFIG_MACH_SPEAR310)                += spear3xx

> +machine-$(CONFIG_MACH_SPEAR320)                += spear3xx
> +machine-$(CONFIG_MACH_SPEAR600)                += spear6xx

I did a little bit of testing and got this message:

/home/arnd/linux-arm/Makefile:774: target `arch/arm/mach-spear13xx' given more than once in the same rule.
arch/arm/mach-spear13xx/built-in.o:(.init.data+0x0): multiple definition of `spear13xx_smp_ops'
arch/arm/mach-spear13xx/built-in.o:(.init.data+0x0): first defined here

The patch below ensures that each machine is only listed once.
Please fold this into your patch.

	Arnd

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 32a6485..ff5fb29 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -233,7 +233,7 @@ ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 MACHINE  :=
 endif
 
-machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
+machdirs := $(sort $(patsubst %,arch/arm/mach-%/,$(machine-y)))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
 ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
