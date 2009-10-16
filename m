From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:33 -0700
Subject: [PATCH 29/46] davinci: DA830 EVM: OHCI platform code
In-Reply-To: <1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
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
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

On this board the OHCI port's power control and over-current signals from
TPS2065 power switch are connected via GPIO1[15] and GPIO2[1] respectively,
so we can implement the DA8xx OHCI glue layer's hooks for overriding the
root hub port's power and over-current status bits.

We also have to properly set up the clocking mode in the CFGCHIP2 register,
so that internal 24 MHz reference clock is fed to the USB 2.0 (MUSB) PHY and
its output is used to clock the USB 1.1 (OHCI) PHY...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/board-da830-evm.c |  125 +++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index fb76721..f41b1de 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pcf857x.h>
@@ -28,6 +29,7 @@
 #include <mach/gpio.h>
 #include <mach/da8xx.h>
 #include <mach/asp.h>
+#include <mach/usb.h>
 
 #define DA830_EVM_PHY_MASK		0x0
 #define DA830_EVM_MDIO_FREQUENCY	2200000	/* PHY bus frequency */
@@ -84,6 +86,127 @@ static struct davinci_i2c_platform_data da830_evm_i2c_0_pdata = {
 	.bus_delay	= 0,	/* usec */
 };
 
+/*
+ * USB1 VBUS is controlled by GPIO1[15], over-current is reported on GPIO2[4].
+ */
+#define ON_BD_USB_DRV	GPIO_TO_PIN(1, 15)
+#define ON_BD_USB_OVC	GPIO_TO_PIN(2, 4)
+
+static const short da830_evm_usb11_pins[] = {
+	DA830_GPIO1_15, DA830_GPIO2_4,
+	-1
+};
+
+static da8xx_ocic_handler_t da830_evm_usb_ocic_handler;
+
+static int da830_evm_usb_set_power(unsigned port, int on)
+{
+	gpio_set_value(ON_BD_USB_DRV, on);
+	return 0;
+}
+
+static int da830_evm_usb_get_power(unsigned port)
+{
+	return gpio_get_value(ON_BD_USB_DRV);
+}
+
+static int da830_evm_usb_get_oci(unsigned port)
+{
+	return !gpio_get_value(ON_BD_USB_OVC);
+}
+
+static irqreturn_t da830_evm_usb_ocic_irq(int, void *);
+
+static int da830_evm_usb_ocic_notify(da8xx_ocic_handler_t handler)
+{
+	int irq 	= gpio_to_irq(ON_BD_USB_OVC);
+	int error	= 0;
+
+	if (handler != NULL) {
+		da830_evm_usb_ocic_handler = handler;
+
+		error = request_irq(irq, da830_evm_usb_ocic_irq, IRQF_DISABLED |
+				    IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				    "OHCI over-current indicator", NULL);
+		if (error)
+			printk(KERN_ERR "%s: could not request IRQ to watch "
+			       "over-current indicator changes\n", __func__);
+	} else
+		free_irq(irq, NULL);
+
+	return error;
+}
+
+static struct da8xx_ohci_root_hub da830_evm_usb11_pdata = {
+	.set_power	= da830_evm_usb_set_power,
+	.get_power	= da830_evm_usb_get_power,
+	.get_oci	= da830_evm_usb_get_oci,
+	.ocic_notify	= da830_evm_usb_ocic_notify,
+
+	/* TPS2065 switch @ 5V */
+	.potpgt		= (3 + 1) / 2,	/* 3 ms max */
+};
+
+static irqreturn_t da830_evm_usb_ocic_irq(int irq, void *dev_id)
+{
+	da830_evm_usb_ocic_handler(&da830_evm_usb11_pdata, 1);
+	return IRQ_HANDLED;
+}
+
+static __init void da830_evm_usb_init(void)
+{
+	u32 cfgchip2;
+	int ret;
+
+	/*
+	 * Set up USB clock/mode in the CFGCHIP2 register.
+	 * FYI:  CFGCHIP2 is 0x0000ef00 initially.
+	 */
+	cfgchip2 = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP2_REG));
+
+	/* USB2.0 PHY reference clock is 24 MHz */
+	cfgchip2 &= ~CFGCHIP2_REFFREQ;
+	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
+
+	/*
+	 * Select internal reference clock for USB 2.0 PHY
+	 * and use it as a clock source for USB 1.1 PHY
+	 * (this is the default setting anyway).
+	 */
+	cfgchip2 &= ~CFGCHIP2_USB1PHYCLKMUX;
+	cfgchip2 |=  CFGCHIP2_USB2PHYCLKMUX;
+
+	__raw_writel(cfgchip2, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP2_REG));
+
+	ret = da8xx_pinmux_setup(da830_evm_usb11_pins);
+	if (ret) {
+		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
+			   __func__, ret);
+		return;
+	}
+
+	ret = gpio_request(ON_BD_USB_DRV, "ON_BD_USB_DRV");
+	if (ret) {
+		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+		       "power control: %d\n", __func__, ret);
+		return;
+	}
+	gpio_direction_output(ON_BD_USB_DRV, 0);
+
+	ret = gpio_request(ON_BD_USB_OVC, "ON_BD_USB_OVC");
+	if (ret) {
+		printk(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+		       "over-current indicator: %d\n", __func__, ret);
+		return;
+	}
+	gpio_direction_input(ON_BD_USB_OVC);
+
+	ret = da8xx_register_usb11(&da830_evm_usb11_pdata);
+	if (ret)
+		pr_warning("%s: USB 1.1 registration failed: %d\n",
+			   __func__, ret);
+}
+
 static struct davinci_uart_config da830_evm_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
@@ -167,6 +290,8 @@ static __init void da830_evm_init(void)
 		pr_warning("da830_evm_init: i2c0 registration failed: %d\n",
 				ret);
 
+	da830_evm_usb_init();
+
 	soc_info->emac_pdata->phy_mask = DA830_EVM_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = DA830_EVM_MDIO_FREQUENCY;
 	soc_info->emac_pdata->rmii_en = 1;
-- 
1.6.4.3
