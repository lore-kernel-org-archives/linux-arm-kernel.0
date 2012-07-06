From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  6 Jul 2012 08:26:34 +0200
Subject: [PATCH] ARM: imx: select IRQ_DOMAIN
In-Reply-To: <20120614071326.GC31565@S2101-09.ap.freescale.net>
References: <20120614071326.GC31565@S2101-09.ap.freescale.net>
Message-ID: <1341555995-22532-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

      544496a (ARM: imx: move irq_domain_add_legacy call into avic driver)

introduced unconditional calls to irq_find_mapping and
irq_domain_add_legacy, but it's still possible to have a .config without
CONFIG_IRQ_DOMAIN=y resulting in

	  CC      arch/arm/plat-mxc/avic.o
	arch/arm/plat-mxc/avic.c: In function 'avic_handle_irq':
	arch/arm/plat-mxc/avic.c:172: error: implicit declaration of function 'irq_find_mapping'
	arch/arm/plat-mxc/avic.c: In function 'mxc_init_irq':
	arch/arm/plat-mxc/avic.c:207: error: implicit declaration of function 'irq_domain_add_legacy'
	arch/arm/plat-mxc/avic.c:208: error: 'irq_domain_simple_ops' undeclared (first use in this function)
	arch/arm/plat-mxc/avic.c:208: error: (Each undeclared identifier is reported only once
	arch/arm/plat-mxc/avic.c:208: error: for each function it appears in.)
	arch/arm/plat-mxc/avic.c:208: warning: assignment makes pointer from integer without a cast
	make[3]: *** [arch/arm/plat-mxc/avic.o] Error 1
	make[2]: *** [arch/arm/plat-mxc/avic.o] Error 2
	make[1]: *** [sub-make] Error 2
	make: *** [all] Error 2

Fix that by selecting CONFIG_IRQ_DOMAIN for ARCH_MXC.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..38b6b90 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -446,6 +446,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select MULTI_IRQ_HANDLER
+	select IRQ_DOMAIN
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
-- 
1.7.10
