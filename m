From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 28 May 2012 14:42:25 +0300
Subject: [RFC PATCH 05/11] mfd: omap: control: core system control driver
In-Reply-To: <CAMQu2gy_rgLidHWy7xxZBiVD4wfFuTvA+wC7joogrcFptwsx8w@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-6-git-send-email-eduardo.valentin@ti.com>
 <CAMQu2gy_rgLidHWy7xxZBiVD4wfFuTvA+wC7joogrcFptwsx8w@mail.gmail.com>
Message-ID: <20120528114225.GH3923@besouro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 28, 2012 at 03:24:01PM +0530, Shilimkar, Santosh wrote:
> On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > This patch introduces a MFD core device driver for
> > OMAP system control module.
> >
> > The control module allows software control of
> > various static modes supported by the device. It is
> > composed of two control submodules: general control
> > module and device (padconfiguration) control
> > module.
> >
> > In this patch, the children defined are for:
> > . USB-phy pin control
> > . Bangap temperature sensor
> >
> > Device driver is probed with postcore_initcall.
> > However, as some of the APIs exposed by this driver
> > may be needed in very early init phase, an early init
> > class is also available: "early_omap_control".
> >
> > Signed-off-by: J Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> 
> [..]
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index ad95c7a..222dbad 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -5,6 +5,9 @@ menu "TI OMAP Common Features"
> > ?config ARCH_OMAP_OTG
> > ? ? ? ?bool
> >
> > +config ARCH_HAS_CONTROL_MODULE
> > + ? ? ? bool
> > +
> Thanks for getting rid of OMAP CONFIG here.

OK. ARCH_HAS_CONTROL_MODULE is a bit too generic though..

> 
> > ?choice
> > ? ? ? ?prompt "OMAP System Type"
> > ? ? ? ?default ARCH_OMAP2PLUS
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 11e4438..25a66d8 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -795,6 +795,15 @@ config MFD_WL1273_CORE
> > ? ? ? ? ?driver connects the radio-wl1273 V4L2 module and the wl1273
> > ? ? ? ? ?audio codec.
> >
> > +config MFD_OMAP_CONTROL
> > + ? ? ? bool "Texas Instruments OMAP System control module"
> > + ? ? ? depends on ARCH_HAS_CONTROL_MODULE
> > + ? ? ? help
> > + ? ? ? ? This is the core driver for system control module. This driver
> > + ? ? ? ? is responsible for creating the control module mfd child,
> > + ? ? ? ? like USB-pin control, pin muxing, MMC-pbias and DDR IO dynamic
> > + ? ? ? ? change for off mode.
> > +
> > ?config MFD_OMAP_USB_HOST
> > ? ? ? ?bool "Support OMAP USBHS core driver"
> > ? ? ? ?depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 05fa538..00f99d6 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -106,6 +106,7 @@ obj-$(CONFIG_MFD_TPS6586X) ?+= tps6586x.o
> > ?obj-$(CONFIG_MFD_VX855) ? ? ? ? ? ? ? ?+= vx855.o
> > ?obj-$(CONFIG_MFD_WL1273_CORE) ?+= wl1273-core.o
> > ?obj-$(CONFIG_MFD_CS5535) ? ? ? += cs5535-mfd.o
> > +obj-$(CONFIG_MFD_OMAP_CONTROL) += omap-control-core.o
> > ?obj-$(CONFIG_MFD_OMAP_USB_HOST) ? ? ? ?+= omap-usb-host.o
> > ?obj-$(CONFIG_MFD_PM8921_CORE) ?+= pm8921-core.o
> > ?obj-$(CONFIG_MFD_PM8XXX_IRQ) ? += pm8xxx-irq.o
> > diff --git a/drivers/mfd/omap-control-core.c b/drivers/mfd/omap-control-core.c
> > new file mode 100644
> > index 0000000..7d8d408
> > --- /dev/null
> > +++ b/drivers/mfd/omap-control-core.c
> > @@ -0,0 +1,211 @@
> > +/*
> > + * OMAP system control module driver file
> > + *
> > + * Copyright (C) 2011-2012 Texas Instruments Incorporated - http://www.ti.com/
> > + * Contacts:
> > + * Based on original code written by:
> > + * ? ?J Keerthy <j-keerthy@ti.com>
> > + * ? ?Moiz Sonasath <m-sonasath@ti.com>
> > + * MFD clean up and re-factoring:
> > + * ? ?Eduardo Valentin <eduardo.valentin@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the GNU
> > + * General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/export.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/omap_control.h>
> > +
> > +static struct omap_control *omap_control_module;
> > +
> > +/**
> > + * omap_control_readl: Read a single omap control module register.
> > + *
> > + * @dev: device to read from.
> > + * @reg: register to read.
> > + * @val: output with register value.
> > + *
> > + * returns 0 on success or -EINVAL in case struct device is invalid.
> > + */
> > +int omap_control_readl(struct device *dev, u32 reg, u32 *val)
> > +{
> > + ? ? ? struct omap_control *omap_control = dev_get_drvdata(dev);
> > +
> > + ? ? ? if (!omap_control)
> > + ? ? ? ? ? ? ? return -EINVAL;
> > +
> > + ? ? ? *val = readl(omap_control->base + reg);
> > +
> > + ? ? ? return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_control_readl);
> > +
> I might have missed in the last scan, but can you let
> function return the register value.

Why?

> 
> I am guessing, you did this for error case handling. You might
> want to stick to read API semantic and just have WARN_ON()
> to take care of error case.

Yeah, that was for error handling and to do not confuse register
values with error values.

> 
> > +/**
> > + * omap_control_writel: Write a single omap control module register.
> > + *
> > + * @dev: device to read from.
> > + * @val: value to write.
> > + * @reg: register to write to.
> > + *
> > + * returns 0 on success or -EINVAL in case struct device is invalid.
> > + */
> > +int omap_control_writel(struct device *dev, u32 val, u32 reg)
> > +{
> > + ? ? ? struct omap_control *omap_control = dev_get_drvdata(dev);
> > + ? ? ? unsigned long flags;
> > +
> > + ? ? ? if (!omap_control)
> > + ? ? ? ? ? ? ? return -EINVAL;
> > +
> > + ? ? ? spin_lock_irqsave(&omap_control->reg_lock, flags);
> > + ? ? ? writel(val, omap_control->base + reg);
> > + ? ? ? spin_unlock_irqrestore(&omap_control->reg_lock, flags);
> > +
> > + ? ? ? return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_control_writel);
> > +
> > +/**
> > + * omap_control_get: returns the control module device pinter
> > + *
> > + * The modules which has to use control module API's to read or write should
> > + * call this API to get the control module device pointer.
> > + */
> > +struct device *omap_control_get(void)
> > +{
> > + ? ? ? unsigned long flags;
> > +
> > + ? ? ? if (!omap_control_module)
> > + ? ? ? ? ? ? ? return ERR_PTR(-ENODEV);
> > +
> > + ? ? ? spin_lock_irqsave(&omap_control_module->reg_lock, flags);
> > + ? ? ? omap_control_module->use_count++;
> > + ? ? ? spin_unlock_irqrestore(&omap_control_module->reg_lock, flags);
> > +
> > + ? ? ? return omap_control_module->dev;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_control_get);
> > +
> > +/**
> > + * omap_control_put: returns the control module device pinter
> > + *
> > + * The modules which has to use control module API's to read or write should
> > + * call this API to get the control module device pointer.
> > + */
> > +void omap_control_put(struct device *dev)
> > +{
> > + ? ? ? struct omap_control *omap_control = dev_get_drvdata(dev);
> > + ? ? ? unsigned long flags;
> > +
> > + ? ? ? if (!omap_control)
> > + ? ? ? ? ? ? ? return;
> > +
> > + ? ? ? spin_lock_irqsave(&omap_control->reg_lock, flags);
> > + ? ? ? omap_control->use_count--;
> > + ? ? ? spin_unlock_irqrestore(&omap_control_module->reg_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(omap_control_put);
> > +
> > +static const struct of_device_id of_omap_control_match[] = {
> > + ? ? ? { .compatible = "ti,omap3-control", },
> > + ? ? ? { .compatible = "ti,omap4-control", },
> > + ? ? ? { .compatible = "ti,omap5-control", },
> > + ? ? ? { },
> > +};
> > +
> > +static int __devinit omap_control_probe(struct platform_device *pdev)
> > +{
> > + ? ? ? struct resource *res;
> > + ? ? ? void __iomem *base;
> > + ? ? ? struct device *dev = &pdev->dev;
> > + ? ? ? struct device_node *np = dev->of_node;
> > + ? ? ? struct omap_control *omap_control;
> > +
> > + ? ? ? omap_control = devm_kzalloc(dev, sizeof(*omap_control), GFP_KERNEL);
> > + ? ? ? if (!omap_control) {
> > + ? ? ? ? ? ? ? dev_err(dev, "not enough memory for omap_control\n");
> > + ? ? ? ? ? ? ? return -ENOMEM;
> > + ? ? ? }
> > +
> > + ? ? ? res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + ? ? ? if (!res) {
> > + ? ? ? ? ? ? ? dev_err(dev, "missing memory base resource\n");
> > + ? ? ? ? ? ? ? return -EINVAL;
> > + ? ? ? }
> > +
> > + ? ? ? base = devm_request_and_ioremap(dev, res);
> > + ? ? ? if (!base) {
> > + ? ? ? ? ? ? ? dev_err(dev, "ioremap failed\n");
> > + ? ? ? ? ? ? ? return -EADDRNOTAVAIL;
> > + ? ? ? }
> > +
> > + ? ? ? omap_control->base = base;
> > + ? ? ? omap_control->dev = dev;
> > + ? ? ? spin_lock_init(&omap_control->reg_lock);
> > +
> > + ? ? ? platform_set_drvdata(pdev, omap_control);
> > + ? ? ? omap_control_module = omap_control;
> > +
> > + ? ? ? return of_platform_populate(np, of_omap_control_match, NULL, dev);
> > +}
> > +
> 
> Will the probe get called on multiple devices and race ?

It depends. If we decide to have an early device for scm, then the probe will
be called more than once. If not, then only once.

> 
> > +static int __devexit omap_control_remove(struct platform_device *pdev)
> > +{
> > + ? ? ? struct omap_control *omap_control = platform_get_drvdata(pdev);
> > +
> > + ? ? ? spin_lock(&omap_control->reg_lock);
> > + ? ? ? if (omap_control->use_count > 0) {
> > + ? ? ? ? ? ? ? spin_unlock(&omap_control->reg_lock);
> > + ? ? ? ? ? ? ? dev_err(&pdev->dev, "device removed while still being used\n");
> > + ? ? ? ? ? ? ? return -EBUSY;
> > + ? ? ? }
> > + ? ? ? spin_unlock(&omap_control->reg_lock);
> > +
> Do you really need above lock where you are just doing the
> register read. smp_rmb(), should be enough, I guess.

It is locking the use counter not a register..

> 
> Regards
> Santosh
