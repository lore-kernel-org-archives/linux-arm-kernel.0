From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 16:56:05 +0100
Subject: [PATCH 08/62] ARM: davinci: use explicit 'select' for DA850_EVM
In-Reply-To: <532AE351.9000503@ti.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-9-git-send-email-arnd@arndb.de> <532AE351.9000503@ti.com>
Message-ID: <201403211656.06007.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014, Sekhar Nori wrote:
> On Thursday 20 March 2014 12:59 AM, Arnd Bergmann wrote:
> > The DAVINCI_DA850_EVM board uses an unusual method to
> > enable the GPIO_PCA953X and KEYBOARD_GPIO_POLLED symbols,
> > which leads to the dependencies on these symbols being
> > ignored. As GPIO_PCA953X actually requires I2C, that
> > can lead to build failures when I2C is disabled.
> > 
> > This patch removes the duplicate symbol definitions
> 
> I am okay with this..
> 
> > and instead adds equivalent 'select' statements that
> > are conditional on the underlying dependencies.
> 
> .. but not sure this is needed. The PCA953X was defaulted to y mainly
> because the IO expander was used to detect presence of daughter cards.
> Even then, I don't think there is any need to force its selection.
> 
> > 
> > A different question whether we actually want to automatically
> > enable them at all or rather put them into defconfig,
> > but that should be a separate patch.
> 
> It can be enabled through defconfig as you said. I agree that can be a
> separate patch. For now, just dropping the replicated Kconfig symbols
> should be okay.

Ok, even better then. I was trying to change the behavior as little
as possible, but not selecting the drivers is certainly the correct
approach. I've put the two symbols into the defconfig now so the builds
are unchanged.

	Arnd

8<----

>From 5eaf7fdfe7c831d3aa24428a6e8d4509ac160db6 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Feb 2014 12:23:19 +0100
Subject: [PATCH] ARM: davinci: use explicit 'select' for DA850_EVM

The DAVINCI_DA850_EVM board uses an unusual method to
enable the GPIO_PCA953X and KEYBOARD_GPIO_POLLED symbols,
which leads to the dependencies on these symbols being
ignored. As GPIO_PCA953X actually requires I2C, that
can lead to build failures when I2C is disabled.

This patch removes the duplicate symbol definitions
and instead enables them from the davinci_all_defconfig
file.

A different question whether we actually want to automatically
enable them at all or rather put them into defconfig,
but that should be a separate patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: davinci-linux-open-source at linux.davincidsp.com

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index fff4eb6..16bdfab 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -218,3 +218,5 @@ CONFIG_DEBUG_ERRORS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
 CONFIG_CRC_T10DIF=m
+CONFIG_GPIO_PCA953X=y
+CONFIG_KEYBOARD_GPIO_POLLED=y
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 3b98e34..db18ef8 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -209,11 +209,6 @@ config DA850_WL12XX
 	  Say Y if you want to use a wl1271 expansion card connected to the
 	  AM18x EVM.
 
-config GPIO_PCA953X
-	default MACH_DAVINCI_DA850_EVM
-
-config KEYBOARD_GPIO_POLLED
-	default MACH_DAVINCI_DA850_EVM
 
 config MACH_MITYOMAPL138
 	bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
