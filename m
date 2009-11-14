From: maz@misterjones.org (Marc Zyngier)
Date: Sat, 14 Nov 2009 16:26:19 +0100
Subject: [PATCH 2/3] Make Viper pcmcia support more generic to support Zeus
	as well
In-Reply-To: <20091114162041.5cbbb58e@taxman.wild-wind.fr.eu.org>
References: <20091114162041.5cbbb58e@taxman.wild-wind.fr.eu.org>
Message-ID: <20091114162619.29382037@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Arcom Zeus CF slot requires the same kind of support as the Viper.
To avoid code duplication, introduce a platform device that abstracts
the differences.

This also allows for the removal of the ugly export of viper_cf_rst().

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/Kconfig                     |    7 ++
 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h |   11 +++
 arch/arm/mach-pxa/include/mach/viper.h        |    2 -
 arch/arm/mach-pxa/viper.c                     |   20 ++++-
 arch/arm/mach-pxa/zeus.c                      |   29 ++++++
 drivers/pcmcia/Kconfig                        |    2 +-
 drivers/pcmcia/Makefile                       |    2 +-
 drivers/pcmcia/pxa2xx_base.c                  |    3 +-
 drivers/pcmcia/pxa2xx_viper.c                 |  119 ++++++++++++++++++-------
 9 files changed, 155 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/arcom-pcmcia.h

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index a2fff7e..a67663e 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -177,6 +177,7 @@ config ARCH_VIPER
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 	select PXA_HAVE_ISA_IRQS
+	select ARCOM_PCMCIA
 
 config MACH_ARCOM_ZEUS
 	bool "Arcom/Eurotech ZEUS SBC"
@@ -184,6 +185,7 @@ config MACH_ARCOM_ZEUS
 	select ISA
 	select PXA_HAVE_BOARD_IRQS
 	select PXA_HAVE_ISA_IRQS
+	select ARCOM_PCMCIA
 
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
@@ -276,6 +278,11 @@ config MACH_TRIZEPS_ANY
 
 endchoice
 
+config ARCOM_PCMCIA
+	bool
+	help
+	  Generic option for Arcom Viper/Zeus PCMCIA
+
 config TRIZEPS_PCMCIA
 	bool
 	help
diff --git a/arch/arm/mach-pxa/include/mach/arcom-pcmcia.h b/arch/arm/mach-pxa/include/mach/arcom-pcmcia.h
new file mode 100644
index 0000000..d428be4
--- /dev/null
+++ b/arch/arm/mach-pxa/include/mach/arcom-pcmcia.h
@@ -0,0 +1,11 @@
+#ifndef __ARCOM_PCMCIA_H
+#define __ARCOM_PCMCIA_H
+
+struct arcom_pcmcia_pdata {
+	int	cd_gpio;
+	int	rdy_gpio;
+	int	pwr_gpio;
+	void	(*reset)(int state);
+};
+
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/viper.h b/arch/arm/mach-pxa/include/mach/viper.h
index 10988c2..5f5fbf1 100644
--- a/arch/arm/mach-pxa/include/mach/viper.h
+++ b/arch/arm/mach-pxa/include/mach/viper.h
@@ -85,8 +85,6 @@
 /* Interrupt and Configuration Register (VIPER_ICR) */
 /* This is a write only register. Only CF_RST is used under Linux */
 
-extern void viper_cf_rst(int state);
-
 #define VIPER_ICR_RETRIG	(1 << 0)
 #define VIPER_ICR_AUTO_CLR	(1 << 1)
 #define VIPER_ICR_R_DIS		(1 << 2)
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index df168b9..edd420f 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -47,6 +47,7 @@
 #include <mach/pxafb.h>
 #include <plat/i2c.h>
 #include <mach/regs-uart.h>
+#include <mach/arcom-pcmcia.h>
 #include <mach/viper.h>
 
 #include <asm/setup.h>
@@ -76,14 +77,28 @@ static void viper_icr_clear_bit(unsigned int bit)
 }
 
 /* This function is used from the pcmcia module to reset the CF */
-void viper_cf_rst(int state)
+static void viper_cf_reset(int state)
 {
 	if (state)
 		viper_icr_set_bit(VIPER_ICR_CF_RST);
 	else
 		viper_icr_clear_bit(VIPER_ICR_CF_RST);
 }
-EXPORT_SYMBOL(viper_cf_rst);
+
+static struct arcom_pcmcia_pdata viper_pcmcia_info = {
+	.cd_gpio	= VIPER_CF_CD_GPIO,
+	.rdy_gpio	= VIPER_CF_RDY_GPIO,
+	.pwr_gpio	= VIPER_CF_POWER_GPIO,
+	.reset		= viper_cf_reset,
+};
+
+static struct platform_device viper_pcmcia_device = {
+	.name		= "viper-pcmcia",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &viper_pcmcia_info,
+	},
+};
 
 /*
  * The CPLD version register was not present on VIPER boards prior to
@@ -685,6 +700,7 @@ static struct platform_device *viper_devs[] __initdata = {
 	&viper_mtd_devices[0],
 	&viper_mtd_devices[1],
 	&viper_backlight_device,
+	&viper_pcmcia_device,
 };
 
 static mfp_cfg_t viper_pin_config[] __initdata = {
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index d8c217e..1962c15 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -43,6 +43,7 @@
 #include <mach/mfp-pxa27x.h>
 #include <mach/pm.h>
 #include <mach/audio.h>
+#include <mach/arcom-pcmcia.h>
 #include <mach/zeus.h>
 
 #include "generic.h"
@@ -428,6 +429,33 @@ static struct platform_device zeus_leds_device = {
         }
 };
 
+static void zeus_cf_reset(int state)
+{
+	u16 cpld_state = __raw_readw(ZEUS_CPLD_CONTROL);
+
+	if (state)
+		cpld_state |= ZEUS_CPLD_CONTROL_CF_RST;
+	else
+		cpld_state &= ~ZEUS_CPLD_CONTROL_CF_RST;
+
+	__raw_writew(cpld_state, ZEUS_CPLD_CONTROL);
+}
+
+static struct arcom_pcmcia_pdata zeus_pcmcia_info = {
+	.cd_gpio	= ZEUS_CF_CD_GPIO,
+	.rdy_gpio	= ZEUS_CF_RDY_GPIO,
+	.pwr_gpio	= ZEUS_CF_PWEN_GPIO,
+	.reset		= zeus_cf_reset,
+};
+
+static struct platform_device zeus_pcmcia_device = {
+	.name		= "zeus-pcmcia",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &zeus_pcmcia_info,
+	},
+};
+
 static struct platform_device *zeus_devices[] __initdata = {
 	&zeus_serial_device,
 	&zeus_mtd_devices[0],
@@ -436,6 +464,7 @@ static struct platform_device *zeus_devices[] __initdata = {
 	&zeus_sram_device,
 	&pxa2xx_spi_ssp3_device,
 	&zeus_leds_device,
+	&zeus_pcmcia_device,
 };
 
 /* AC'97 */
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 17f38a7..f684001 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -221,7 +221,7 @@ config PCMCIA_PXA2XX
 	depends on ARM && ARCH_PXA && PCMCIA
 	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
 		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
-		    || ARCH_VIPER || ARCH_PXA_ESERIES || MACH_STARGATE2)
+		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2)
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
 
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index a03a38a..e02edfd 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -69,7 +69,7 @@ pxa2xx-obj-$(CONFIG_ARCH_LUBBOCK)		+= pxa2xx_lubbock_cs.o
 pxa2xx-obj-$(CONFIG_MACH_MAINSTONE)		+= pxa2xx_mainstone.o
 pxa2xx-obj-$(CONFIG_PXA_SHARPSL)		+= pxa2xx_sharpsl.o
 pxa2xx-obj-$(CONFIG_MACH_ARMCORE)		+= pxa2xx_cm_x2xx_cs.o
-pxa2xx-obj-$(CONFIG_ARCH_VIPER)			+= pxa2xx_viper.o
+pxa2xx-obj-$(CONFIG_ARCOM_PCMCIA)		+= pxa2xx_viper.o
 pxa2xx-obj-$(CONFIG_TRIZEPS_PCMCIA)		+= pxa2xx_trizeps4.o
 pxa2xx-obj-$(CONFIG_MACH_PALMTX)		+= pxa2xx_palmtx.o
 pxa2xx-obj-$(CONFIG_MACH_PALMTC)		+= pxa2xx_palmtc.o
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 0e35acb..cb7b4ca 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -214,7 +214,8 @@ static void pxa2xx_configure_sockets(struct device *dev)
 	MECR |= MECR_CIT;
 
 	/* Set MECR:NOS (Number Of Sockets) */
-	if ((ops->first + ops->nr) > 1 || machine_is_viper())
+	if ((ops->first + ops->nr) > 1 ||
+	    machine_is_viper() || machine_is_arcom_zeus())
 		MECR |= MECR_NOS;
 	else
 		MECR &= ~MECR_NOS;
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index 1787136..7a16ae9 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -1,9 +1,8 @@
 /*
- * VIPER PCMCIA support
+ * Viper/Zeus PCMCIA support
  *   Copyright 2004 Arcom Control Systems
  *
  * Maintained by Marc Zyngier <maz@misterjones.org>
- * 			      <marc.zyngier@altran.com>
  *
  * Based on:
  *   iPAQ h2200 PCMCIA support
@@ -26,37 +25,47 @@
 
 #include <asm/irq.h>
 
-#include <mach/viper.h>
-#include <asm/mach-types.h>
+#include <mach/arcom-pcmcia.h>
 
 #include "soc_common.h"
 #include "pxa2xx_base.h"
 
+static struct platform_device *arcom_pcmcia_dev;
+
 static struct pcmcia_irqs irqs[] = {
-	{ 0, gpio_to_irq(VIPER_CF_CD_GPIO),  "PCMCIA_CD" }
+	{
+		.sock	= 0,
+		.str	= "PCMCIA_CD",
+	},
 };
 
+static inline struct arcom_pcmcia_pdata *viper_get_pdata(void)
+{
+	return arcom_pcmcia_dev->dev.platform_data;
+}
+
 static int viper_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
+	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
 	unsigned long flags;
 
-	skt->irq = gpio_to_irq(VIPER_CF_RDY_GPIO);
+	skt->irq = gpio_to_irq(pdata->rdy_gpio);
+	irqs[0].irq = gpio_to_irq(pdata->cd_gpio);
 
-	if (gpio_request(VIPER_CF_CD_GPIO, "CF detect"))
+	if (gpio_request(pdata->cd_gpio, "CF detect"))
 		goto err_request_cd;
 
-	if (gpio_request(VIPER_CF_RDY_GPIO, "CF ready"))
+	if (gpio_request(pdata->rdy_gpio, "CF ready"))
 		goto err_request_rdy;
 
-	if (gpio_request(VIPER_CF_POWER_GPIO, "CF power"))
+	if (gpio_request(pdata->pwr_gpio, "CF power"))
 		goto err_request_pwr;
 
 	local_irq_save(flags);
 
-	/* GPIO 82 is the CF power enable line. initially off */
-	if (gpio_direction_output(VIPER_CF_POWER_GPIO, 0) ||
-	    gpio_direction_input(VIPER_CF_CD_GPIO) ||
-	    gpio_direction_input(VIPER_CF_RDY_GPIO)) {
+	if (gpio_direction_output(pdata->pwr_gpio, 0) ||
+	    gpio_direction_input(pdata->cd_gpio) ||
+	    gpio_direction_input(pdata->rdy_gpio)) {
 		local_irq_restore(flags);
 		goto err_dir;
 	}
@@ -66,13 +75,13 @@ static int viper_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 
 err_dir:
-	gpio_free(VIPER_CF_POWER_GPIO);
+	gpio_free(pdata->pwr_gpio);
 err_request_pwr:
-	gpio_free(VIPER_CF_RDY_GPIO);
+	gpio_free(pdata->rdy_gpio);
 err_request_rdy:
-	gpio_free(VIPER_CF_CD_GPIO);
+	gpio_free(pdata->cd_gpio);
 err_request_cd:
-	printk(KERN_ERR "viper: Failed to setup PCMCIA GPIOs\n");
+	dev_err(&arcom_pcmcia_dev->dev, "Failed to setup PCMCIA GPIOs\n");
 	return -1;
 }
 
@@ -81,17 +90,21 @@ err_request_cd:
  */
 static void viper_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
+	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
+
 	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
-	gpio_free(VIPER_CF_POWER_GPIO);
-	gpio_free(VIPER_CF_RDY_GPIO);
-	gpio_free(VIPER_CF_CD_GPIO);
+	gpio_free(pdata->pwr_gpio);
+	gpio_free(pdata->rdy_gpio);
+	gpio_free(pdata->cd_gpio);
 }
 
 static void viper_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				      struct pcmcia_state *state)
 {
-	state->detect = gpio_get_value(VIPER_CF_CD_GPIO) ? 0 : 1;
-	state->ready  = gpio_get_value(VIPER_CF_RDY_GPIO) ? 1 : 0;
+	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
+
+	state->detect = !gpio_get_value(pdata->cd_gpio);
+	state->ready  = !!gpio_get_value(pdata->rdy_gpio);
 	state->bvd1   = 1;
 	state->bvd2   = 1;
 	state->wrprot = 0;
@@ -102,20 +115,21 @@ static void viper_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 static int viper_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 					 const socket_state_t *state)
 {
+	struct arcom_pcmcia_pdata *pdata = viper_get_pdata();
+
 	/* Silently ignore Vpp, output enable, speaker enable. */
-	viper_cf_rst(state->flags & SS_RESET);
+	pdata->reset(state->flags & SS_RESET);
 
 	/* Apply socket voltage */
 	switch (state->Vcc) {
 	case 0:
-		gpio_set_value(VIPER_CF_POWER_GPIO, 0);
+		gpio_set_value(pdata->pwr_gpio, 0);
 		break;
 	case 33:
-		gpio_set_value(VIPER_CF_POWER_GPIO, 1);
+		gpio_set_value(pdata->pwr_gpio, 1);
 		break;
 	default:
-		printk(KERN_ERR "%s: Unsupported Vcc:%d\n",
-		       __func__, state->Vcc);
+		dev_err(&arcom_pcmcia_dev->dev, "Unsupported Vcc:%d\n", state->Vcc);
 		return -1;
 	}
 
@@ -130,7 +144,7 @@ static void viper_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
 }
 
-static struct pcmcia_low_level viper_pcmcia_ops __initdata = {
+static struct pcmcia_low_level viper_pcmcia_ops = {
 	.owner          	= THIS_MODULE,
 	.hw_init        	= viper_pcmcia_hw_init,
 	.hw_shutdown		= viper_pcmcia_hw_shutdown,
@@ -143,17 +157,25 @@ static struct pcmcia_low_level viper_pcmcia_ops __initdata = {
 
 static struct platform_device *viper_pcmcia_device;
 
-static int __init viper_pcmcia_init(void)
+static int viper_pcmcia_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (!machine_is_viper())
-		return -ENODEV;
+	/* I can't imagine more than one device, but you never know... */
+	if (arcom_pcmcia_dev)
+		return -EEXIST;
+
+	if (!pdev->dev.platform_data)
+		return -EINVAL;
 
 	viper_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
 	if (!viper_pcmcia_device)
 		return -ENOMEM;
 
+	arcom_pcmcia_dev = pdev;
+
+	viper_pcmcia_device->dev.parent = &pdev->dev;
+
 	ret = platform_device_add_data(viper_pcmcia_device,
 				       &viper_pcmcia_ops,
 				       sizeof(viper_pcmcia_ops));
@@ -161,18 +183,49 @@ static int __init viper_pcmcia_init(void)
 	if (!ret)
 		ret = platform_device_add(viper_pcmcia_device);
 
-	if (ret)
+	if (ret) {
 		platform_device_put(viper_pcmcia_device);
+		arcom_pcmcia_dev = NULL;
+	}
 
 	return ret;
 }
 
-static void __exit viper_pcmcia_exit(void)
+static int viper_pcmcia_remove(struct platform_device *pdev)
 {
 	platform_device_unregister(viper_pcmcia_device);
+	arcom_pcmcia_dev = NULL;
+	return 0;
+}
+
+static struct platform_device_id viper_pcmcia_id_table[] = {
+	{ .name = "viper-pcmcia", },
+	{ .name = "zeus-pcmcia",  },
+	{ },
+};
+
+static struct platform_driver viper_pcmcia_driver = {
+	.probe		= viper_pcmcia_probe,
+	.remove		= viper_pcmcia_remove,
+	.driver		= {
+		.name	= "arcom-pcmcia",
+		.owner	= THIS_MODULE,
+	},
+	.id_table	= viper_pcmcia_id_table,
+};
+
+static int __init viper_pcmcia_init(void)
+{
+	return platform_driver_register(&viper_pcmcia_driver);
+}
+
+static void __exit viper_pcmcia_exit(void)
+{
+	return platform_driver_unregister(&viper_pcmcia_driver);
 }
 
 module_init(viper_pcmcia_init);
 module_exit(viper_pcmcia_exit);
 
+MODULE_DEVICE_TABLE(platform, viper_pcmcia_id_table);
 MODULE_LICENSE("GPL");
-- 
1.6.0.4



-- 
I'm the slime oozin' out from your TV set...
