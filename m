From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:28:59 +0100
Subject: [PATCH 02/62] ARM: at91: don't provide dt init code for at91x40
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91x40 has no support for device tree, but Kconfig allows
us to enable CONFIG_OF anyway, causing a link error in the
at91 reset controller initialization.

The easiest fix is to adapt the existing #ifdef to omit
the broken code on at91x40 where it is never called anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index f7ca97b..f7a07a5 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -351,7 +351,7 @@ void __init at91_ioremap_matrix(u32 base_addr)
 		panic("Impossible to ioremap at91_matrix_base\n");
 }
 
-#if defined(CONFIG_OF)
+#if defined(CONFIG_OF) && !defined(CONFIG_ARCH_AT91X40)
 static struct of_device_id rstc_ids[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9_alt_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
-- 
1.8.3.2
