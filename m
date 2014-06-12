From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 16:05:32 +0200
Subject: [PATCH] drm: imx: use GENERIC_IRQ_CHIP
Message-ID: <7367559.qEUUbIia3C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver defines its own irqchip using the generic chip
infrastructure, and hence needs the GENERIC_IRQ_CHIP Kconfig
symbol enabled, or get this build error:

drivers/built-in.o: In function `ipu_probe':
:(.text+0x49ea4c): undefined reference to `irq_generic_chip_ops'
:(.text+0x49ea5c): undefined reference to `irq_alloc_domain_generic_chips'
:(.text+0x49ea60): undefined reference to `irq_get_domain_generic_chip'
:(.text+0x49ea64): undefined reference to `irq_gc_ack_set_bit'
:(.text+0x49ea6c): undefined reference to `irq_gc_mask_clr_bit'
:(.text+0x49ea70): undefined reference to `irq_gc_mask_set_bit'

Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel at lists.freedesktop.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
index 2f228a2..01864a5 100644
--- a/drivers/gpu/ipu-v3/Kconfig
+++ b/drivers/gpu/ipu-v3/Kconfig
@@ -2,6 +2,7 @@ config IMX_IPUV3_CORE
 	tristate "IPUv3 core support"
 	depends on SOC_IMX5 || SOC_IMX6Q || SOC_IMX6SL || ARCH_MULTIPLATFORM
 	depends on RESET_CONTROLLER
+	select GENERIC_IRQ_CHIP
 	help
 	  Choose this if you have a i.MX5/6 system and want to use the Image
 	  Processing Unit. This option only enables IPU base support.
