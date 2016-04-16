From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 21:59:16 +0200
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
In-Reply-To: <20160413191108.GF14441@codeaurora.org>
References: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
 <20160413184134.GJ19945@localhost> <20160413191108.GF14441@codeaurora.org>
Message-ID: <6572897.TrNljr4Es3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 12:11:08 Stephen Boyd wrote:
> 
> Honestly, I view these clocksource selects as the only blocker in
> the effort to get rid of machine type Kconfigs. Maybe that isn't
> a good goal though.

I agree with you, it would be nice if we could just make them
all configurable and not need any machine type Kconfigs (though
a lot of platforms will continue using them for other reasons).

A patch like the one below (as I think you suggested) would be
nice too, but requires people to update their defconfig files.
In the mainline kernel, we have four defconfig files that
enable CONFIG_HAVE_ARM_ARCH_TIMER manually, so those all need
to be changed along with the Kconfig files, and everyone that
has their own out of tree defconfig file (not a full .config)
runs into the same issue.

It's probably still worth doing the change, but it's not obvious.

	Arnd


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 62c209504c0a..0daad62cfce5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1296,7 +1296,6 @@ config HAVE_ARM_SCU
 	  This option enables support for the ARM system coherency unit
 
 config HAVE_ARM_ARCH_TIMER
-	bool "Architected timer support"
 	depends on CPU_V7
 	select ARM_ARCH_TIMER
 	select GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c346be650892..0314778c992f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -187,7 +187,7 @@ config CLKSRC_STM32
 	select CLKSRC_MMIO
 
 config ARM_ARCH_TIMER
-	bool
+	bool "Architected timer support"
 	select CLKSRC_OF if OF
 	select CLKSRC_ACPI if ACPI
 
