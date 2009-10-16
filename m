From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:32 -0700
Subject: [PATCH 28/46] davinci: DA8xx: OHCI platform device
In-Reply-To: <1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Add the function to register the OHCI platform device, given the root hub
related platform data passed from the board  specific code.  The platfrom
data provide for overriding the OHCI port power and over-current bits at
the board level.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 arch/arm/mach-davinci/include/mach/usb.h   |   20 +++++++++++++++
 arch/arm/mach-davinci/usb.c                |   37 +++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index abb8a5b..3b75273 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -19,6 +19,7 @@
 #include <mach/emac.h>
 #include <mach/asp.h>
 #include <mach/mmc.h>
+#include <mach/usb.h>
 
 extern void __iomem *da8xx_syscfg_base;
 
@@ -78,6 +79,7 @@ void __init da850_init(void);
 int da8xx_register_edma(void);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_watchdog(void);
+int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
diff --git a/arch/arm/mach-davinci/include/mach/usb.h b/arch/arm/mach-davinci/include/mach/usb.h
index d0fb412..435f228 100644
--- a/arch/arm/mach-davinci/include/mach/usb.h
+++ b/arch/arm/mach-davinci/include/mach/usb.h
@@ -34,4 +34,24 @@
 #define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
 #define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
 
+struct	da8xx_ohci_root_hub;
+
+typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
+				     unsigned port);
+
+/* Passed as the platform data to the OHCI driver */
+struct	da8xx_ohci_root_hub {
+	/* Switch the port power on/off */
+	int	(*set_power)(unsigned port, int on);
+	/* Read the port power status */
+	int	(*get_power)(unsigned port);
+	/* Read the port over-current indicator */
+	int	(*get_oci)(unsigned port);
+	/* Over-current indicator change notification (pass NULL to disable) */
+	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
+
+	/* Time from power on to power good (in 2 ms units) */
+	u8	potpgt;
+};
+
 #endif	/* ifndef __ASM_ARCH_USB_H */
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index 06f5593..2fff9a6 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -14,8 +14,10 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
+#include <mach/usb.h>
 
-#define DAVINCI_USB_OTG_BASE 0x01C64000
+#define DAVINCI_USB_OTG_BASE	0x01c64000
+#define DA8XX_USB1_BASE 	0x01e25000
 
 #if defined(CONFIG_USB_MUSB_HDRC) || defined(CONFIG_USB_MUSB_HDRC_MODULE)
 static struct musb_hdrc_eps_bits musb_eps[] = {
@@ -108,3 +110,36 @@ void __init setup_usb(unsigned mA, unsigned potpgt_msec)
 
 #endif  /* CONFIG_USB_MUSB_HDRC */
 
+#ifdef	CONFIG_ARCH_DAVINCI_DA8XX
+static struct resource da8xx_usb11_resources[] = {
+	[0] = {
+		.start	= DA8XX_USB1_BASE,
+		.end	= DA8XX_USB1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_IRQN,
+		.end	= IRQ_DA8XX_IRQN,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 da8xx_usb11_dma_mask = DMA_BIT_MASK(32);
+
+static struct platform_device da8xx_usb11_device = {
+	.name		= "ohci",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &da8xx_usb11_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(da8xx_usb11_resources),
+	.resource	= da8xx_usb11_resources,
+};
+
+int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
+{
+	da8xx_usb11_device.dev.platform_data = pdata;
+	return platform_device_register(&da8xx_usb11_device);
+}
+#endif	/* CONFIG_DAVINCI_DA8XX */
-- 
1.6.4.3
