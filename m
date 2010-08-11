From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:50 +0200
Subject: [PATCH 1/9] ARM: Samsung: add device-table core functions
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-table framework core functions. The device-table framework
standarizes the way the Samsung platform devices are being defined and
registered. It also a first step to redesign Samsung platform in a way
that it would be possible to build a single kernel image for more than
one SoC version. The device-table framework has been initially developed
by Ben Dooks. This version has been redesigned and extended to support
platform data handling and more flexible way of rewriting device
resources (removed the limitation of only base address and irq pairs).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Makefile                |    1 +
 arch/arm/plat-samsung/dev.c                   |  304 +++++++++++++++++++++++++
 arch/arm/plat-samsung/dev_templates.c         |   57 +++++
 arch/arm/plat-samsung/include/plat/dev-core.h |  116 ++++++++++
 arch/arm/plat-samsung/include/plat/devs.h     |  118 ++++++++++
 5 files changed, 596 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev.c
 create mode 100644 arch/arm/plat-samsung/dev_templates.c
 create mode 100644 arch/arm/plat-samsung/include/plat/dev-core.h

diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4d8ff92..a14f443 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 
 obj-y				+= init.o
 obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
+obj-y				+= dev.o dev_templates.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
diff --git a/arch/arm/plat-samsung/dev.c b/arch/arm/plat-samsung/dev.c
new file mode 100644
index 0000000..4c32c82
--- /dev/null
+++ b/arch/arm/plat-samsung/dev.c
@@ -0,0 +1,304 @@
+/* linux/arch/arm/plat-s3c/dev.c
+ *
+ * Copyright 2009 Ben Dooks <ben-linux@fluff.org>
+ * Copyright 2010 Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * S3C series device creation code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/bootmem.h>
+#include <linux/platform_device.h>
+
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+#include <plat/cpu.h>
+
+/* state data */
+static struct s3c_pdev_table *pdev_table;
+static unsigned int pdev_tsize;
+
+/**
+ * s3c_device_lookup() - lookup a pdev table entry from name and index
+ * @type: The device type to find.
+ * @index: The index for the device.
+ *
+ * Find the relevant device table entry for the given @name and @index
+ * value, or return NULL if the table does not contain such an entry.
+ */
+static struct s3c_pdev_table __init *s3c_device_lookup(enum s3c_dev_type type,
+						       int index)
+{
+	struct s3c_pdev_table *table = pdev_table;
+	int nr = pdev_tsize;
+
+	for (; nr > 0; nr--, table++) {
+		if (table->type == type && table->index == index)
+			return table;
+	}
+
+	return NULL; /* not found */
+}
+
+/**
+ * s3c_device_rename - rename a device type in the device table
+ * @type: The device type to rename
+ * @name: The new name to give it
+ */
+void __init s3c_device_rename(enum s3c_dev_type type, char *name)
+{
+	struct s3c_pdev_table *ptr = pdev_table;
+	int nr = pdev_tsize;
+
+	for (; nr > 0; nr--, ptr++) {
+		if (ptr->type == type)
+			ptr->name = name;
+	}
+}
+
+void s3c_device_set_platdata(enum s3c_dev_type type, unsigned int index,
+			     void *pdata)
+{
+	struct s3c_pdev_table *pdev_tab;
+
+	pdev_tab = s3c_device_lookup(type, index);
+	if (!pdev_tab) {
+		printk(KERN_ERR "%s: no entry for type %d index %d\n",
+		       __func__, type, index);
+	} else
+		pdev_tab->defpdata = pdata;
+}
+
+void __init *s3c_device_get_defplatdata(enum s3c_dev_type type,
+					unsigned int index)
+{
+	struct s3c_pdev_table *pdev_tab = s3c_device_lookup(type, index);
+	if (!pdev_tab) {
+		printk(KERN_ERR "%s: no entry for type %d index %d\n",
+		       __func__, type, index);
+		return NULL;
+	}
+	return pdev_tab->defpdata;
+}
+
+/**
+ * s3c_device_create() - create a new platform device
+ * @type: The type of device to create.
+ * @index: The index of the device being created.
+ * @pdata: The platform data to add to the new device.
+ *
+ * Create and register a new platform device from the given template
+ * and platform data. Calls platform_device_register().
+ */
+struct platform_device  __init *s3c_device_create(enum s3c_dev_type type,
+						 unsigned int index,
+						 void *pdata)
+{
+	struct s3c_pdev_template *template;
+	struct s3c_pdev_table *pdev_tab;
+	struct platform_device *pdev;
+	struct resource *res_src, *res_dest;
+	unsigned int *res_remap;
+	const char *name;
+	u64 *dma_mask;
+	void *defpdata;
+	int nr_res;
+	int pdata_size;
+	int size;
+	int res;
+
+	pdev_tab = s3c_device_lookup(type, index);
+	if (!pdev_tab) {
+		printk(KERN_ERR "%s: no entry for type %d index %d\n",
+		       __func__, type, index);
+		return NULL;
+	}
+
+	if (pdev_tab->dev)
+		return pdev_tab->dev;
+
+	template = pdev_tab->template;
+	if (!template)
+		template = s3c_device_find_template(type);
+	if (!template) {
+		printk(KERN_ERR "%s: no template for device type %d\n",
+		       __func__, type);
+		return NULL;
+	}
+
+	nr_res = template->nr_res;
+	pdata_size = template->pdata_size;
+	dma_mask = template->dma;
+
+	name = pdev_tab->name;
+	res_remap = pdev_tab->res;
+
+	printk(KERN_INFO "%s: device %s.%d, template %p, #res %d\n",
+	       __func__, name, index, template, nr_res);
+
+	/* allocate memory for the device */
+
+	size = sizeof(struct platform_device);
+	size += nr_res * sizeof(struct resource);
+
+	if (type != SAMSUNG_DEVICE_UART) {
+		pdev = kzalloc(size, GFP_KERNEL);
+		if (!pdev) {
+			printk(KERN_ERR "%s: no memory to create %s.%d\n",
+			       __func__, name, index);
+			return NULL;
+		}
+	} else {
+		/* we cannot allocate memory for the UARTs in the part of
+		 * the initialisation sequence we are in, so we use the
+		 * alloc_bootmem call instead.
+		 */
+
+		pdev = alloc_bootmem(size);
+		if (!pdev)
+			panic("failed to create uart device");
+	}
+
+	/* setup the basic platform device */
+
+	pdev->name = name;
+	pdev->id = index;
+	pdev->num_resources = nr_res;
+
+	/* start modifying the resources we got */
+
+	res_src = template->resources;
+	res_dest = (struct resource *)(pdev + 1);
+	pdev->resource = res_dest;
+
+	/* copy everything by default before modifying as needed */
+	memcpy(res_dest, res_src, nr_res * sizeof(struct resource));
+
+	for (res = 0; pdev_tab->res && res < nr_res; res++, res_dest++) {
+		/* process any changes. */
+		res_dest->start += res_remap[res];
+		res_dest->end += res_remap[res];
+
+		printk(KERN_INFO "%s: %s res %d => ", __func__, name, res);
+		printk("%p = %08lx %08lx..%08lx\n",
+		       res_dest, res_dest->flags,
+		       (unsigned long)res_dest->start,
+		       (unsigned long)res_dest->end);
+	}
+
+	/* check if we have any dma capability for this device and if so
+	 * declare we have both types of dma memory for it. */
+
+	if (dma_mask) {
+		printk(KERN_INFO "%s: %s dma mask => ", __func__, name);
+		printk("%llx\n", *dma_mask);
+
+		pdev->dev.coherent_dma_mask = *dma_mask;
+		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	}
+
+	/* set user pdata (will be duplicated in the next step) */
+
+	if (pdata) {
+		if (template->pdata_set)
+			template->pdata_set(pdata, index);
+		else
+			s3c_device_set_platdata(type, index, pdata);
+	}
+
+	/* setup (default) platform data */
+
+	defpdata = pdev_tab->defpdata;
+
+	if (defpdata) {
+		void *npd = kmemdup(defpdata, pdata_size, GFP_KERNEL);
+		if (!npd)
+			printk(KERN_ERR "%s: no memory for platform data\n",
+			       __func__);
+
+		printk(KERN_INFO "%s: %s pdata => ", __func__, name);
+		printk("%p (%d bytes)\n", npd, pdata_size);
+
+		pdev->dev.platform_data = npd;
+	}
+
+	pdev_tab->dev = pdev;
+	return pdev;
+}
+
+void __init samsung_device_setparent(struct device *dev,
+				     enum s3c_dev_type type, int index)
+{
+	struct s3c_pdev_table *pdev_tab;
+
+	pdev_tab = s3c_device_lookup(type, index);
+	if (!pdev_tab) {
+		printk(KERN_ERR "%s: device does not exist\n", __func__);
+		return;
+	}
+
+	if (pdev_tab->dev == NULL) {
+		printk(KERN_ERR "%s: device not created yet\n", __func__);
+		return;
+	}
+
+	dev->parent = &pdev_tab->dev->dev;
+}
+
+/**
+ * s3c_device_register() - create a new platform device from the template.
+ * @type: The type of device to create.
+ * @index: The index of the device being created.
+ *
+ * Create and register a new platform device from the given template
+ * and platform data. Calls platform_device_register().
+ */
+int __init s3c_device_register(enum s3c_dev_type type,
+			       unsigned int index, void *pdata)
+{
+	struct platform_device *pdev = s3c_device_create(type, index, pdata);
+	int res;
+
+	/* s3c_device_create() printed the relevant error messages */
+	if (!pdev)
+		return -EINVAL;
+
+	/* register the device now we've created it */
+	res = platform_device_register(pdev);
+	if (res) {
+		printk(KERN_ERR "%s: failed to register device %s.%d: %d\n",
+		       __func__, pdev->name, index, res);
+	}
+
+	return res;
+}
+
+int __init samsung_add_devices(struct s3c_devtable *table, int nr_entries)
+{
+	int count = 0;
+
+	printk(KERN_INFO "%s: table %p, %d\n", __func__, table, nr_entries);
+
+	for (; nr_entries > 0; nr_entries--, table++)
+		s3c_device_register(table->type, table->index, table->pdata);
+
+	return count;
+}
+
+void __init s3c_device_register_table(struct s3c_pdev_table *table,
+				      unsigned int nr_ent)
+{
+	/* note, we do not copy this even though we expect that the table
+	 * itself is marked __initdata as the device creation process should
+	 * be over by the time the __initdata section is discarded.
+	 */
+
+	pdev_table = table;
+	pdev_tsize = nr_ent;
+}
diff --git a/arch/arm/plat-samsung/dev_templates.c b/arch/arm/plat-samsung/dev_templates.c
new file mode 100644
index 0000000..6783bec
--- /dev/null
+++ b/arch/arm/plat-samsung/dev_templates.c
@@ -0,0 +1,57 @@
+
+/* linux/arch/arm/plat-s3c/dev_templates.c
+ *
+ * Copyright 2009 Ben Dooks <ben-linux@fluff.org>
+ * Copyright 2010 Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * S3C series device creation code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/bootmem.h>
+#include <linux/platform_device.h>
+
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+#include <plat/cpu.h>
+
+#define TEMPLATE_ENTRY(_type, _res) \
+{	.type = (_type), \
+	.resources = (_res), \
+	.nr_res = ARRAY_SIZE(_res), \
+}
+
+/* most common template */
+struct resource s3c_std_resources_4k[] __initdata = {
+	[0] = {
+		.end = SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct s3c_pdev_template *templates[] __initdata = {
+};
+
+u64 samsung_std_dma_mask = 0xffffffffUL;
+
+struct s3c_pdev_template *s3c_device_find_template(enum s3c_dev_type type)
+{
+	int i, nr = ARRAY_SIZE(templates);
+
+	for (i = 0; i < nr; i++) {
+		struct s3c_pdev_template *ptr = templates[i];
+		if (ptr && ptr->type == type)
+			return ptr;
+	}
+
+	return NULL;
+}
diff --git a/arch/arm/plat-samsung/include/plat/dev-core.h b/arch/arm/plat-samsung/include/plat/dev-core.h
new file mode 100644
index 0000000..d3b5a88
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/dev-core.h
@@ -0,0 +1,116 @@
+/* linux/include/asm-arm/plat-s3c24xx/dev-core.h
+ *
+ * Copyright (c) 2009 Ben Dooks <ben-linux@fluff.org>
+ * Copyright (c) 2010 Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Header file for core handling of (platform) devices.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/**
+ * struct s3c_pdev_template - template for device creation
+ * @type: The device type
+ * @resources: The resources array to use as a template.
+ * @nr_res: The size of the resources array pointed to by @resources.
+ * @dma: The pointer to device dma mask (if required by device)
+ * @pdata_size: The size of platform data structure used by the device.
+ * @pdata_set: The function to set platform data from the user specified one.
+ */
+struct s3c_pdev_template {
+	enum s3c_dev_type type;
+	struct resource	*resources;
+	unsigned int	 nr_res;
+	u64		*dma;
+	unsigned int	 pdata_size;
+	void		(*pdata_set)(void *pdata, int id);
+};
+
+/**
+ * s3c_device_find_template - find the template for the gived device type
+ * @type: The type value, from SAMSUNG_DEVICE_
+ */
+struct s3c_pdev_template *s3c_device_find_template(enum s3c_dev_type type);
+
+/* The most common resource definition */
+extern struct resource s3c_std_resources_4k[];
+
+/* standard DMA mask for 32bit DMA capability. */
+extern u64 samsung_std_dma_mask;
+
+
+/**
+ * S3C_MAX_RESOURCES - maximum nuimber of the resources used by devicec
+ * created by device table method.
+ */
+#define S3C_MAX_RESOURCES (6)
+
+/**
+ * struct s3c_pdev_table - per-core platform device definition table
+ * @type: The type value, from SAMSUNG_DEVICE_
+ * @name: The name of the device.
+ * @index: The index of the device, as for platform.index.
+ * @res: The resources used by the device.
+ * @defpdata: The platform data associated with this device.
+ * @template: A replacement template to use, for complicated devices.
+ * @dev: The device we created, in case it is needed again.
+ *
+ * This table is registered by the core SoC code after the detection
+ * process has been performed. It defines the various parameters that
+ * may change between SoCs, such as the base address, the IRQ and DMA
+ * channel numbers. Also SoC specific platform data can be provided
+ * this way.
+ *
+ * The purpose of this is to allow the system to be built for many
+ * different devices without the need to try and switch in different
+ * headers depending on the build process and to allow the future
+ * support of many different SoCs in the same kernel.
+ *
+ * The board code does not need to see most of this process as it
+ * should be between the core SoC detection and the device creation
+ * process.
+ *
+ * The values specific for each SoC in the resources are handled by
+ * res array. The order is important and should be the same as the
+ * order of resources entries in the pdev_template.
+ *
+ * The default platform data should be placed in __initdata to save
+ * kernel memory. Machine setup code should modify the default platform
+ * data 'in place'. The platform data is duplicated (kmemdup) once
+ * device has been created.
+ *
+ * The @template field specifies an alternate template to use if the device
+ * requires very specific resources or cannot use any of the standard
+ * templates available. If this field is used, the same process as the
+ * standard templates is used, so this field can point to __initdata.
+ */
+struct s3c_pdev_table {
+	enum s3c_dev_type type;
+	const char		*name;
+	unsigned int		 index;
+	unsigned int		 res[S3C_MAX_RESOURCES];
+	void			*defpdata;
+	struct s3c_pdev_template *template;
+	struct platform_device	*dev;
+};
+
+/**
+ * s3c_device_register_table - registers a device table in the system
+ * @table: an array of pdev_table entries with device definitions
+ * @rn_ent: number of entries to register
+ */
+extern void s3c_device_register_table(struct s3c_pdev_table *table,
+				      unsigned int nr_ent);
+
+/**
+ * s3c_device_rename - rename specified device
+ * @type: The type value, from SAMSUNG_DEVICE_
+ * @name: The new name for the device
+ *
+ * This function is usefull for machines that need to set different
+ * name for particular device, despite the default name provided
+ * by SoC device table.
+ */
+extern void s3c_device_rename(enum s3c_dev_type type, char *name);
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 85f6f23..79e7564 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -9,8 +9,126 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
+
 #include <linux/platform_device.h>
 
+/**
+ * enum s3c_dev_type - samsung platform device identifier.
+ *
+ * One define per type of device supported, to indicate the type when
+ * looking through various tables. If there is the possibility of more
+ * than one of each of these, then this is handled elsewhere.
+ */
+enum s3c_dev_type {
+	SAMSUNG_DEVICE_FB,	/* newer style framebuffer S3C2443+ */
+	SAMSUNG_DEVICE_TS,
+	SAMSUNG_DEVICE_ADC,
+	SAMSUNG_DEVICE_I2C,
+	SAMSUNG_DEVICE_IIS,
+	SAMSUNG_DEVICE_LCD,
+	SAMSUNG_DEVICE_MCI,	/* s3c24xx style sd/mmc block */
+	SAMSUNG_DEVICE_RTC,
+	SAMSUNG_DEVICE_SPI,	/* s3c24xx style SPI block */
+	SAMSUNG_DEVICE_AC97,
+	SAMSUNG_DEVICE_HSPI,
+	SAMSUNG_DEVICE_OHCI,
+	SAMSUNG_DEVICE_NAND,
+	SAMSUNG_DEVICE_UART,
+	SAMSUNG_DEVICE_CAMIF,
+	SAMSUNG_DEVICE_SDHCI,
+	SAMSUNG_DEVICE_HWMON,
+	SAMSUNG_DEVICE_TIMER,	/* pwm timer block */
+	SAMSUNG_DEVICE_CAMERA,
+	SAMSUNG_DEVICE_WATCHDOG,
+	SAMSUNG_DEVICE_USBGADGET,
+	SAMSUNG_DEVICE_USB_HSOTG,
+	SAMSUNG_DEVICE_SPI_S3C64XX,
+	SAMSUNG_DEVICE_ONENAND,
+};
+
+#define SAMSUNG_DEVICE_WDT SAMSUNG_DEVICE_WATCHDOG
+#define SAMSUNG_DEVICE_SDI SAMSUNG_DEVICE_MCI
+
+/**
+ * struct s3c_devtable - device table entry for Samsung platform device
+ * @type: The type of device that is being added
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ * @pdata: Default platform data for the new device
+ */
+struct s3c_devtable {
+	enum s3c_dev_type	 type;
+	int			 index;
+	void			*pdata;
+};
+
+/**
+ * s3c_device_create - creates a new instance of the device.
+ * @type: The type of device that is being changed
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ * @pdata: New platform data for the device
+ *
+ * This call returns the pointer to the newly created instance of the
+ * device specified by the type and index pair.
+ */
+extern struct platform_device *s3c_device_create(enum s3c_dev_type type,
+						 unsigned int index,
+						 void *pdata);
+
+/**
+ * s3c_device_register - creates a new instance of the device.
+ * @type: The type of device that is being changed
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ * @pdata: New platform data for the device
+ *
+ * This call creates a new instance of the device specified by the type
+ * and index pair. Then it registers it to the platform bus.
+ */
+extern int s3c_device_register(enum s3c_dev_type type,
+			       unsigned int index, void *pdata);
+
+/**
+ * s3c_device_set_platdata - set platform data for specified device.
+ * @type: The type of device that is being changed
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ * @pdata: New platform data for the device
+ */
+extern void s3c_device_set_platdata(enum s3c_dev_type type,
+				    unsigned int index,
+				    void *pdata);
+
+/**
+ * s3c_device_get_defplatdata - get a pointer to the default platform data.
+ * @type: The type of device that is being examined
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ *
+ * This call returns a pointer to the device's default platform data. All
+ * required changes should be done 'in place', on the original platform
+ * data. Each device instance has its own default platform data. The
+ * platform data will be copied to memory on the device registration.
+ */
+extern void *s3c_device_get_defplatdata(enum s3c_dev_type type,
+				    unsigned int index);
+
+/**
+ * samsung_devices_add - add devices from the given device table.
+ * @devs: The device table to add devices from.
+ * @nr_devs: The number of table entries in @devs.
+ */
+extern int samsung_add_devices(struct s3c_devtable *devs, int nr_devs);
+
+/**
+ * samsung_device_setparent - set device's parent from given device
+ * @dev: The device to set the parent of.
+ * @type: The device type
+ * @index: -1 if there is only one, otherwise the index of the block 0..n
+ *
+ * Set the given device's parent to the platform device that was created
+ * during the initialisation process (since we do not have direct pointers
+ * to the platform device structures anymore).
+ */
+extern void samsung_device_setparent(struct device *dev,
+				     enum s3c_dev_type type, int index);
+
 struct s3c24xx_uart_resources {
 	struct resource		*resources;
 	unsigned long		 nr_resources;
-- 
1.7.1.569.g6f426
