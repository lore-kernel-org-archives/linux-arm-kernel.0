From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:30 +0100
Subject: [PATCH 2/8] ARM: pxa/lubbock: remove lubbock_set_misc_wr() from
 global view
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmM-0007I4-PK@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are now no users of lubbock_set_misc_wr() outside lubbock.c, so
make this function static.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-pxa/include/mach/lubbock.h | 4 ----
 arch/arm/mach-pxa/lubbock.c              | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/include/mach/lubbock.h
index 1eecf794acd2..9926a5d741f7 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/include/mach/lubbock.h
@@ -50,7 +50,3 @@
 #define LUBBOCK_LAST_IRQ	LUBBOCK_IRQ(6)
 
 #define LUBBOCK_SA1111_IRQ_BASE	(LUBBOCK_NR_IRQS + 32)
-
-#ifndef __ASSEMBLY__
-extern void lubbock_set_misc_wr(unsigned int mask, unsigned int set);
-#endif
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 8686c5d0dc3b..ffbab27cb581 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -119,12 +119,11 @@ void lubbock_set_hexled(uint32_t value)
 
 static struct gpio_chip *lubbock_misc_wr_gc;
 
-void lubbock_set_misc_wr(unsigned int mask, unsigned int set)
+static void lubbock_set_misc_wr(unsigned int mask, unsigned int set)
 {
 	unsigned long m = mask, v = set;
 	lubbock_misc_wr_gc->set_multiple(lubbock_misc_wr_gc, &m, &v);
 }
-EXPORT_SYMBOL(lubbock_set_misc_wr);
 
 static int lubbock_udc_is_connected(void)
 {
-- 
2.1.0
