From: jochen@scram.de (Jochen Friedrich)
Date: Sat, 23 Apr 2011 20:58:52 +0200
Subject: [RFC] ARM: sa11x0: Implement autoloading of codec and codec pdata for
	mcp bus.
Message-ID: <1303585132-4086-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-sa1100/assabet.c          |    1 +
 arch/arm/mach-sa1100/cerf.c             |    1 +
 arch/arm/mach-sa1100/collie.c           |    8 ++++-
 arch/arm/mach-sa1100/include/mach/mcp.h |    2 +
 arch/arm/mach-sa1100/lart.c             |    1 +
 arch/arm/mach-sa1100/shannon.c          |    1 +
 arch/arm/mach-sa1100/simpad.c           |    8 ++++-
 drivers/mfd/mcp-core.c                  |   22 +++++++++++++-
 drivers/mfd/mcp-sa11x0.c                |    3 +-
 drivers/mfd/ucb1x00-core.c              |   47 +++++++++++++++++++++++-------
 include/linux/mfd/mcp.h                 |    7 +++-
 include/linux/mfd/ucb1x00.h             |    5 ++-
 include/linux/mod_devicetable.h         |   11 +++++++
 scripts/mod/file2alias.c                |   13 ++++++++
 14 files changed, 111 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 5778274..b3eded1 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -202,6 +202,7 @@ static struct irda_platform_data assabet_irda_data = {
 static struct mcp_plat_data assabet_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.codec		= "ucb1x00",
 };
 
 static void __init assabet_init(void)
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 7f3da4b..b7db7cd 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -124,6 +124,7 @@ static void __init cerf_map_io(void)
 static struct mcp_plat_data cerf_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.codec		= "ucb1x00",
 };
 
 static void __init cerf_init(void)
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index bd3e1bf..d607026 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -27,6 +27,7 @@
 #include <linux/timer.h>
 #include <linux/gpio.h>
 #include <linux/pda_power.h>
+#include <linux/mfd/ucb1x00.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -84,10 +85,15 @@ static struct scoop_pcmcia_config collie_pcmcia_config = {
 	.num_devs	= 1,
 };
 
+static struct ucb1x00_plat_data collie_ucb1x00_data = {
+	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
+};
+
 static struct mcp_plat_data collie_mcp_data = {
 	.mccr0		= MCCR0_ADM | MCCR0_ExtClk,
 	.sclk_rate	= 9216000,
-	.gpio_base	= COLLIE_TC35143_GPIO_BASE,
+	.codec		= "ucb1x00",
+	.codec_data	= &collie_ucb1x00_data;
 };
 
 /*
diff --git a/arch/arm/mach-sa1100/include/mach/mcp.h b/arch/arm/mach-sa1100/include/mach/mcp.h
index ed1a331..b42fbd7 100644
--- a/arch/arm/mach-sa1100/include/mach/mcp.h
+++ b/arch/arm/mach-sa1100/include/mach/mcp.h
@@ -17,6 +17,8 @@ struct mcp_plat_data {
 	u32 mccr1;
 	unsigned int sclk_rate;
 	int gpio_base;
+	const char *codec;
+	void *codec_data;
 };
 
 #endif
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 7b9556b..97be52c 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -24,6 +24,7 @@
 static struct mcp_plat_data lart_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.codec		= "ucb1x00",
 };
 
 static void __init lart_init(void)
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 7917b24..9ffa70f 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -55,6 +55,7 @@ static struct resource shannon_flash_resource = {
 static struct mcp_plat_data shannon_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
+	.codec		= "ucb1x00",
 };
 
 static void __init shannon_init(void)
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index cf3a68a..e1357d3 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/mfd/ucb1x00.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
@@ -187,10 +188,15 @@ static struct resource simpad_flash_resources [] = {
 	}
 };
 
+static struct ucb1x00_plat_data simpad_ucb1x00_data = {
+	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
+};
+
 static struct mcp_plat_data simpad_mcp_data = {
 	.mccr0		= MCCR0_ADM,
 	.sclk_rate	= 11981000,
-	.gpio_base	= SIMPAD_UCB1X00_GPIO_BASE,
+	.codec		= "ucb1300",
+	.codec_data	= &simpad_ucb1x00_data,
 };
 
 
diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 84815f9..4f05a87 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -26,9 +26,26 @@
 #define to_mcp(d)		container_of(d, struct mcp, attached_device)
 #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
 
+static const struct mcp_device_id *mcp_match_id(const struct mcp_device_id *id,
+						const char *codec)
+{
+	while (id->name[0]) {
+		if (strcmp(codec, id->name) == 0)
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
 static int mcp_bus_match(struct device *dev, struct device_driver *drv)
 {
-	return 1;
+	struct mcp *mcp = to_mcp(dev);
+	struct mcp_driver *driver = to_mcp_driver(drv);
+
+	if (driver->id_table)
+		return mcp_match_id(driver->id_table, mcp->codec) != NULL;
+
+	return 0;
 }
 
 static int mcp_bus_probe(struct device *dev)
@@ -36,7 +53,7 @@ static int mcp_bus_probe(struct device *dev)
 	struct mcp *mcp = to_mcp(dev);
 	struct mcp_driver *drv = to_mcp_driver(dev->driver);
 
-	return drv->probe(mcp);
+	return drv->probe(mcp, mcp_match_id(drv->id_table, mcp->codec));
 }
 
 static int mcp_bus_remove(struct device *dev)
@@ -215,6 +232,7 @@ EXPORT_SYMBOL(mcp_host_alloc);
 int mcp_host_register(struct mcp *mcp)
 {
 	dev_set_name(&mcp->attached_device, "mcp0");
+	request_module("%s%s", MCP_MODULE_PREFIX, mcp->codec);
 	return device_register(&mcp->attached_device);
 }
 EXPORT_SYMBOL(mcp_host_register);
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 2dab02d..a0e0da2 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -162,7 +162,8 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	mcp->dma_audio_wr	= DMA_Ser4MCP0Wr;
 	mcp->dma_telco_rd	= DMA_Ser4MCP1Rd;
 	mcp->dma_telco_wr	= DMA_Ser4MCP1Wr;
-	mcp->gpio_base		= data->gpio_base;
+	mcp->codec		= data->codec;
+	mcp->codec_data		= data->codec_data;
 
 	platform_set_drvdata(pdev, mcp);
 
diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index b281217..efb3f61 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -36,6 +36,15 @@ static DEFINE_MUTEX(ucb1x00_mutex);
 static LIST_HEAD(ucb1x00_drivers);
 static LIST_HEAD(ucb1x00_devices);
 
+static struct mcp_device_id ucb1x00_id[] = {
+	{ "ucb1x00", 0 },  /* auto-detection */
+	{ "ucb1200", UCB_ID_1200 },
+	{ "ucb1300", UCB_ID_1300 },
+	{ "tc35143", UCB_ID_TC35143 },
+	{ }
+};
+MODULE_DEVICE_TABLE(mcp, ucb1x00_id);
+
 /**
  *	ucb1x00_io_set_dir - set IO direction
  *	@ucb: UCB1x00 structure describing chip
@@ -525,10 +534,11 @@ static struct class ucb1x00_class = {
 	.dev_release	= ucb1x00_release,
 };
 
-static int ucb1x00_probe(struct mcp *mcp)
+static int ucb1x00_probe(struct mcp *mcp, const struct mcp_device_id *mid)
 {
 	struct ucb1x00 *ucb;
 	struct ucb1x00_driver *drv;
+	struct ucb1x00_plat_data *pdata;
 	unsigned int id;
 	int ret = -ENODEV;
 	int temp;
@@ -536,8 +546,21 @@ static int ucb1x00_probe(struct mcp *mcp)
 	mcp_enable(mcp);
 	id = mcp_reg_read(mcp, UCB_ID);
 
-	if (id != UCB_ID_1200 && id != UCB_ID_1300 && id != UCB_ID_TC35143) {
-		printk(KERN_WARNING "UCB1x00 ID not found: %04x\n", id);
+	if (mid->driver_data) {
+		if (id != mid->driver_data) {
+			printk(KERN_WARNING "%s wrong ID %04x found: %04x\n",
+				mid->name, (unsigned int) mid->driver_data, id);
+			goto err_disable;
+		}
+	} else {
+		mid = &ucb1x00_id[1];
+		while (mid->driver_data) {
+			if (id == mid->driver_data)
+				break;
+			mid++;
+		}
+		printk(KERN_WARNING "%s ID not found: %04x\n",
+			ucb1x00_id[0].name, id);
 		goto err_disable;
 	}
 
@@ -547,27 +570,28 @@ static int ucb1x00_probe(struct mcp *mcp)
 		goto err_disable;
 
 
+	pdata = mcp->codec_data;
 	ucb->dev.class = &ucb1x00_class;
 	ucb->dev.parent = &mcp->attached_device;
-	dev_set_name(&ucb->dev, "ucb1x00");
+	dev_set_name(&ucb->dev, mid->name);
 
 	spin_lock_init(&ucb->lock);
 	spin_lock_init(&ucb->io_lock);
 	sema_init(&ucb->adc_sem, 1);
 
-	ucb->id  = id;
+	ucb->id  = mid;
 	ucb->mcp = mcp;
 	ucb->irq = ucb1x00_detect_irq(ucb);
 	if (ucb->irq == NO_IRQ) {
-		printk(KERN_ERR "UCB1x00: IRQ probe failed\n");
+		printk(KERN_ERR "%s: IRQ probe failed\n", mid->name);
 		ret = -ENODEV;
 		goto err_free;
 	}
 
 	ucb->gpio.base = -1;
-	if (mcp->gpio_base != 0) {
+	if (pdata && (pdata->gpio_base >= 0)) {
 		ucb->gpio.label = dev_name(&ucb->dev);
-		ucb->gpio.base = mcp->gpio_base;
+		ucb->gpio.base = pdata->gpio_base;
 		ucb->gpio.ngpio = 10;
 		ucb->gpio.set = ucb1x00_gpio_set;
 		ucb->gpio.get = ucb1x00_gpio_get;
@@ -580,10 +604,10 @@ static int ucb1x00_probe(struct mcp *mcp)
 		dev_info(&ucb->dev, "gpio_base not set so no gpiolib support");
 
 	ret = request_irq(ucb->irq, ucb1x00_irq, IRQF_TRIGGER_RISING,
-			  "UCB1x00", ucb);
+			  mid->name, ucb);
 	if (ret) {
-		printk(KERN_ERR "ucb1x00: unable to grab irq%d: %d\n",
-			ucb->irq, ret);
+		printk(KERN_ERR "%s: unable to grab irq%d: %d\n",
+			mid->name, ucb->irq, ret);
 		goto err_gpio;
 	}
 
@@ -705,6 +729,7 @@ static struct mcp_driver ucb1x00_driver = {
 	.remove		= ucb1x00_remove,
 	.suspend	= ucb1x00_suspend,
 	.resume		= ucb1x00_resume,
+	.id_table	= ucb1x00_id,
 };
 
 static int __init ucb1x00_init(void)
diff --git a/include/linux/mfd/mcp.h b/include/linux/mfd/mcp.h
index ee496708..7578e24 100644
--- a/include/linux/mfd/mcp.h
+++ b/include/linux/mfd/mcp.h
@@ -10,6 +10,7 @@
 #ifndef MCP_H
 #define MCP_H
 
+#include <linux/mod_devicetable.h>
 #include <mach/dma.h>
 
 struct mcp_ops;
@@ -26,7 +27,8 @@ struct mcp {
 	dma_device_t	dma_telco_rd;
 	dma_device_t	dma_telco_wr;
 	struct device	attached_device;
-	int		gpio_base;
+	const char	*codec;
+	void		*codec_data;
 };
 
 struct mcp_ops {
@@ -52,10 +54,11 @@ void mcp_host_unregister(struct mcp *);
 
 struct mcp_driver {
 	struct device_driver drv;
-	int (*probe)(struct mcp *);
+	int (*probe)(struct mcp *, const struct mcp_device_id *);
 	void (*remove)(struct mcp *);
 	int (*suspend)(struct mcp *, pm_message_t);
 	int (*resume)(struct mcp *);
+	const struct mcp_device_id *id_table;
 };
 
 int mcp_driver_register(struct mcp_driver *);
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 4321f04..bc19e5f 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -104,6 +104,9 @@
 #define UCB_MODE_DYN_VFLAG_ENA	(1 << 12)
 #define UCB_MODE_AUD_OFF_CAN	(1 << 13)
 
+struct ucb1x00_plat_data {
+	int		gpio_base;
+};
 
 struct ucb1x00_irq {
 	void *devid;
@@ -116,7 +119,7 @@ struct ucb1x00 {
 	unsigned int		irq;
 	struct semaphore	adc_sem;
 	spinlock_t		io_lock;
-	u16			id;
+	const struct mcp_device_id *id;
 	u16			io_dir;
 	u16			io_out;
 	u16			adc_cr;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 48c007d..df8c8e6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -410,6 +410,17 @@ struct spi_device_id {
 			__attribute__((aligned(sizeof(kernel_ulong_t))));
 };
 
+/* mcp */
+
+#define MCP_NAME_SIZE	20
+#define MCP_MODULE_PREFIX "mcp:"
+
+struct mcp_device_id {
+	char name[MCP_NAME_SIZE];
+	kernel_ulong_t driver_data	/* Data private to the driver */
+			__attribute__((aligned(sizeof(kernel_ulong_t))));
+};
+
 /* dmi */
 enum dmi_field {
 	DMI_NONE,
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 88f3f07..1f2c971 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -735,6 +735,15 @@ static int do_spi_entry(const char *filename, struct spi_device_id *id,
 	return 1;
 }
 
+/* Looks like: mcp:S */
+static int do_mcp_entry(const char *filename, struct mcp_device_id *id,
+			char *alias)
+{
+	sprintf(alias, MCP_MODULE_PREFIX "%s", id->name);
+
+	return 1;
+}
+
 static const struct dmifield {
 	const char *prefix;
 	int field;
@@ -980,6 +989,10 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		do_table(symval, sym->st_size,
 			 sizeof(struct spi_device_id), "spi",
 			 do_spi_entry, mod);
+	else if (sym_is(symname, "__mod_mcp_device_table"))
+		do_table(symval, sym->st_size,
+			 sizeof(struct mcp_device_id), "mcp",
+			 do_mcp_entry, mod);
 	else if (sym_is(symname, "__mod_dmi_device_table"))
 		do_table(symval, sym->st_size,
 			 sizeof(struct dmi_system_id), "dmi",
-- 
1.7.5.rc3
