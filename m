From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 17:09:25 +0100
Subject: [PATCH 00/10] ARM: debug-ll fixes
In-Reply-To: <20151217105020.GH8644@n2100.arm.linux.org.uk>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
 <20151217105020.GH8644@n2100.arm.linux.org.uk>
Message-ID: <5578564.K6FPRZSZVM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 10:50:20 Russell King - ARM Linux wrote:
> On Fri, Dec 04, 2015 at 11:30:32PM +0100, Arnd Bergmann wrote:
> > Hi everyone,
> > 
> > I've carried most of these patches for a very long time in
> > my randconfig tree, and they follow up on work that Daniel
> > Thompson did last year. Most of the changes are really trivial,
> > and I'd like to put them into my next/randconfig branch in
> > arm-soc for merging in 4.5.
> 
> Given the amount of breakage that we're now seeing, I'd say that this
> is not true.  I don't believe it's been properly tested: it may have
> been tested against some old kernel version, but certainly not against
> current kernels.
> 
> It's very obvious that it's broken: running 'make defconfig' and then
> trying to build the resulting configuration causes errors.

I've found out what happened now, and added a fix on top to get linux-next
to build again. Do you agree with the change?

I'm still trying to figure out how to change my build test setup to
avoid running into this error (or similar ones) again. I generally
tend to build everything with my randconfig series applied on top,
to avoid running into known bugs, but this time I got bitten by this
because one of my workarounds prevented the compiler from producing
the correct error message.

I'd prefer to not fold the patch into the series now, because that
would require redoing a number of merges I've done on top, but
I can do that if necessary.

	Arnd

>From e45a1e18a57ccc2457429f3bd42d93330c0fee3c Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Dec 2015 16:35:20 +0100
Subject: [PATCH] ARM: defconfig: use correct debug_ll settings

The debug-ll infrastructure can be configured in two ways, either
by selecting a platform specific debug option, or by picking one
of the generic options (8250 or pl01x typically). For compatibility
with multiplatform kernels, we have changed a couple of platforms
to use the former method now when they used to use the latter.

Unfortunately, this broke the defconfigs because now they still
enable CONFIG_DEBUG_LL_UART_PL01X or CONFIG_DEBUG_LL_UART_8250,
and we no longer configure the correct register addresses
automatically.

Embarrassingly, this was only found in linux-next when the
defconfig builds turned up errors for multiple people, and I
had not caught those in my own tests, which were done using
the randconfig fixes patchset on top, and that has a workaround
to avoid a build error when the addresses are not configured.

The error was something like:

.config:2010:warning: symbol value '' invalid for DEBUG_UART_PHYS
.config:2011:warning: symbol value '' invalid for DEBUG_UART_VIRT

This patch avoids the problem by removing the respective
statements from the defconfig files. Any out of tree defconfig
files on the platforms I have changed will have to do the same
change or run into the build error above. Any users that have
a full .config already set the correct DEBUG_UART_PHYS/VIRT
addresses and do not need to change anything.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4db22c1 ("ARM: debug-ll: rework integrator/versatile handling")
Fixes: f06455f ("ARM: debug-ll: rework ep93xx handling")
Fixes: c047f52 ("ARM: debug-ll: reorganize mvebu debug uart config")
Fixes: 59bd4c3 ("ARM: debug-ll: rework lpc32xx handling")

diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index a7846d6..158dde8 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -132,6 +132,5 @@ CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_PL01X=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_LIBCRC32C=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index c100b7d..9f56ca3 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -204,7 +204,6 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
 # CONFIG_ARM_UNWIND is not set
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index fcdffa7..a0345e1 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -135,7 +135,6 @@ CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_ERRORS=y
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 6ddca88..5876ce7 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -162,7 +162,6 @@ CONFIG_LATENCYTOP=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_8250=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 01f402d..64bef977 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -82,6 +82,5 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
-CONFIG_DEBUG_LL_UART_PL01X=y
 CONFIG_FONTS=y
 CONFIG_FONT_ACORN_8x8=y
