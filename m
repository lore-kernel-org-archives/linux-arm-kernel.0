From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:43 +0100
Subject: [PATCH 11/11] ARM: mvebu: build armada375-smp code conditionally
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mvebu_armada375_smp_wa_init is only used on armada 375 but is defined
for all mvebu machines. As it calls a function that is only provided
sometimes, this can result in a link error:

arch/arm/mach-mvebu/built-in.o: In function `mvebu_armada375_smp_wa_init':
:(.text+0x228): undefined reference to `mvebu_setup_boot_addr_wa'

To solve this, we can just change the existing #ifdef around the
function to also check for Armada375 SMP platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 305969fb6292 ("ARM: mvebu: use the common function for Armada 375 SMP workaround")
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/system-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index a068cb5c2ce8..c6c132acd7a6 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -126,7 +126,7 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev)
 		return -ENODEV;
 }
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_MACH_MVEBU_V7)
 void mvebu_armada375_smp_wa_init(void)
 {
 	u32 dev, rev;
-- 
2.1.0.rc2
