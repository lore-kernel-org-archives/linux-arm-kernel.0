From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Feb 2016 17:27:48 +0100
Subject: [PATCH] ARM: prima2: always enable reset controller
Message-ID: <1456417673-2115511-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atlas7 clock controller driver registers a reset controller
for itself, which causes a link error when the subsystem is
disabled:

drivers/built-in.o: In function `atlas7_clk_init':
drivers/clk/sirf/clk-atlas7.c:1681: undefined reference to `reset_controller_register'

As the clk driver does not have a Kconfig symbol for itself
but it always built-in when the platform is enabled, we have
to ensure that the reset controller subsystem is also built-in
in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 301c5d29402e ("clk: sirf: add CSR atlas7 clk and reset support")
---
 arch/arm/mach-prima2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 59cafaf097c0..86b7c859784f 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -2,6 +2,7 @@ menuconfig ARCH_SIRF
 	bool "CSR SiRF"
 	depends on ARCH_MULTI_V6_V7
 	select ARCH_HAS_RESET_CONTROLLER
+	select RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
-- 
2.7.0
