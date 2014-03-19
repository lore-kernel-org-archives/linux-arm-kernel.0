From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:24 +0100
Subject: [PATCH 27/62] ARM: orion5x: make dns323 independent of PHY support
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-28-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The D-Link DNS-323 machine tries to unconditionally select CONFIG_PHYLIB,
but that has other dependencies that might not necessarily be enabled,
causing random build errors.

To work around this, this patch removes the 'select' statement and
instead uses a compile-time check to skip the phy_register_fixup_for_uid()
call if PHYLIB is not available in the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-orion5x/Kconfig        | 1 -
 arch/arm/mach-orion5x/dns323-setup.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 2cb2f06..14f2cae 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -33,7 +33,6 @@ config MACH_KUROBOX_PRO
 config MACH_DNS323
 	bool "D-Link DNS-323"
 	select I2C_BOARDINFO
-	select PHYLIB
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  D-Link DNS-323 platform.
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
index 7097473..56edeab 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion5x/dns323-setup.c
@@ -642,6 +642,8 @@ static void __init dns323_init(void)
 		platform_device_register_simple("dns323c-fan", 0, NULL, 0);
 
 		/* Register fixup for the PHY LEDs */
+		if (!IS_BUILTIN(CONFIG_PHYLIB))
+			break;
 		phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1118,
 					   MARVELL_PHY_ID_MASK,
 					   dns323c_phy_fixup);
-- 
1.8.3.2
