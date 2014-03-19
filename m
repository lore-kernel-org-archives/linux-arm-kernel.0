From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:15 +0100
Subject: [PATCH 18/62] ARM: ks8695/og: make PCI setup conditional
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-19-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'og' machine tries to always initialized the PCI code, but that
may be disabled in Kconfig, leading to a build error.

This patch changes the code to use the same Kconfig symbol to decide
about calling the ks8695_init_pci function at build time that we
use to decide about building the ks8695 PCI support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-ks8695/board-og.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
index 002bc61..f265816 100644
--- a/arch/arm/mach-ks8695/board-og.c
+++ b/arch/arm/mach-ks8695/board-og.c
@@ -44,7 +44,8 @@ static void __init og_register_pci(void)
 	if (machine_is_im4004())
 		ks8695_gpio_interrupt(KS8695_GPIO_1, IRQ_TYPE_LEVEL_LOW);
 
-	ks8695_init_pci(&og_pci);
+	if (IS_ENABLED(CONFIG_PCI))
+		ks8695_init_pci(&og_pci);
 }
 
 /*
-- 
1.8.3.2
