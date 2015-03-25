From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 26 Mar 2015 03:58:50 +0530
Subject: [PATCH v1 3/3] phy: cygnus-usbphy: Add Broadcom Cygnus USB phy
 driver
In-Reply-To: <1426886727-537-4-git-send-email-arun.ramamurthy@broadcom.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426886727-537-4-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <551336A2.1050704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
> This driver adds support for USB 2.0 host and device phy for
> Broadcom's Cygnus chipset. The host controller is connected to
> three separate phys and one of the phys (port 2) is connected to
> the device controller
> 
> 
one blank line should suffice..
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  drivers/phy/Kconfig              |  12 +
>  drivers/phy/Makefile             |   1 +
>  drivers/phy/phy-bcm-cygnus-usb.c | 499 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 drivers/phy/phy-bcm-cygnus-usb.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 2962de2..0aa62dc 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -291,4 +291,16 @@ config PHY_QCOM_UFS
>  	help
>  	  Support for UFS PHY on QCOM chipsets.
>  
> +config PHY_BCM_CYGNUS_USB
> +	tristate "Broadcom Cygnus USB PHY support"
> +	depends on OF
> +	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
> +	select GENERIC_PHY
> +	default ARCH_BCM_CYGNUS
> +	help
> +	  Enable this to support the USB PHY in Broadcom's Cygnus chip.
> +	  The phys are capable of supporting host mode for all ports
> +	  and device mode for port 2. The host or device configuration is
> +	  read from the device tree.
> +
>  endmenu
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f080e1b..47a37fa 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>  obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
>  obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
>  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
> +obj-$(CONFIG_PHY_BCM_CYGNUS_USB)	+= phy-bcm-cygnus-usb.o
>  obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
> diff --git a/drivers/phy/phy-bcm-cygnus-usb.c b/drivers/phy/phy-bcm-cygnus-usb.c
> new file mode 100644
> index 0000000..c12918e
> --- /dev/null
> +++ b/drivers/phy/phy-bcm-cygnus-usb.c
> @@ -0,0 +1,499 @@
> +/*
> + * Copyright (C) 2015 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/phy/phy.h>
> +#include <linux/delay.h>
> +
> +#define CDRU_USBPHY_CLK_RST_SEL_OFFSET			0x11b4
> +#define CDRU_USBPHY2_HOST_DEV_SEL_OFFSET		0x11b8
> +#define CDRU_SPARE_REG_0_OFFSET				0x1238
> +#define CRMU_USB_PHY_AON_CTRL_OFFSET			0x00028
> +#define CDRU_USB_DEV_SUSPEND_RESUME_CTRL_OFFSET		0x1210
> +#define CDRU_USBPHY_P0_STATUS_OFFSET			0x11D0
> +#define CDRU_USBPHY_P1_STATUS_OFFSET			0x11E8
> +#define CDRU_USBPHY_P2_STATUS_OFFSET			0x1200
> +#define CDRU_USBPHY_USBPHY_ILDO_ON_FLAG			1
> +#define CDRU_USBPHY_USBPHY_PLL_LOCK			0
> +#define CDRU_USB_DEV_SUSPEND_RESUME_CTRL_DISABLE	0
> +#define PHY2_DEV_HOST_CTRL_SEL_HOST			1
> +
> +#define CRMU_USBPHY_P0_AFE_CORERDY_VDDC			1
> +#define CRMU_USBPHY_P0_RESETB				2
> +#define CRMU_USBPHY_P1_AFE_CORERDY_VDDC			9
> +#define CRMU_USBPHY_P1_RESETB				10
> +#define CRMU_USBPHY_P2_AFE_CORERDY_VDDC			17
> +#define CRMU_USBPHY_P2_RESETB				18
> +
> +#define USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET		0x0408
> +#define USB2_IDM_IDM_IO_CONTROL_DIRECT__clk_enable	0
> +#define USB2_IDM_IDM_RESET_CONTROL_OFFSET		0x0800
> +#define USB2_IDM_IDM_RESET_CONTROL__RESET		0
> +
> +#define PLL_LOCK_RETRY_COUNT	1000
> +#define MAX_PHY_PORTS		3
> +
> +static int power_bit[] = {CRMU_USBPHY_P0_AFE_CORERDY_VDDC,
> +				CRMU_USBPHY_P1_AFE_CORERDY_VDDC,
> +				CRMU_USBPHY_P2_AFE_CORERDY_VDDC};
> +static int reset_bit[] = {CRMU_USBPHY_P0_RESETB,
> +				CRMU_USBPHY_P1_RESETB,
> +				CRMU_USBPHY_P2_RESETB};
> +static int status_reg[] = {CDRU_USBPHY_P0_STATUS_OFFSET,
> +				CDRU_USBPHY_P1_STATUS_OFFSET,
> +				CDRU_USBPHY_P2_STATUS_OFFSET};
> +
> +struct bcm_phy_instance;

just declare bcm_phy_instance here..
> +
> +struct bcm_phy_driver {
> +	void __iomem *usbphy_regs;
> +	void __iomem *usb2h_idm_regs;
> +	void __iomem *usb2d_idm_regs;
> +	struct bcm_phy_instance *ports[MAX_PHY_PORTS];

er.. can't we allocate this dynamically?
> +	spinlock_t lock;
> +	bool idm_host_enabled;
> +};
> +
> +struct bcm_phy_instance {
> +	struct bcm_phy_driver *driver;
> +	struct phy *generic_phy;
> +	int port_no;
> +	bool host_mode; /* true - Host, false - device */
> +	bool power;
> +};
> +
> +static inline int cdru_usbphy_status_wait(u32 usb_reg, int reg_bit,
> +					  struct bcm_phy_driver *phy_driver)

please use a consistent prefix for all the functions in this driver..
> +{
> +	/* Wait for the PLL lock status */
> +	int retry = PLL_LOCK_RETRY_COUNT;
> +	u32 reg_val;
> +
> +	do {
> +		udelay(1);
> +		reg_val = readl(phy_driver->usbphy_regs +
> +				usb_reg);
> +		if (reg_val & (1 << reg_bit))
> +			return 0;
> +	} while (--retry > 0);

dev_err here?
> +
> +	return -EBUSY;
> +
> +}
> +
> +static struct phy *bcm_usb_phy_xlate(struct device *dev,
> +				     struct of_phandle_args *args)
> +{
> +	struct bcm_phy_driver *phy_driver = dev_get_drvdata(dev);
> +	struct bcm_phy_instance *port = NULL;
> +	int i;
> +
> +	if (!phy_driver)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(args->args_count != 1))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(args->args[0] < 0 || args->args[0] > 1))
> +		return ERR_PTR(-EINVAL);
> +
> +	for (i = 0; i < ARRAY_SIZE(phy_driver->ports); i++) {
> +		struct bcm_phy_instance *p = phy_driver->ports[i];
> +
> +		if (p && p->generic_phy->dev.of_node == args->np) {
> +			port = p;
> +			break;
> +		}
> +	}
> +
> +	if (!port) {
> +		dev_err(dev, "Failed to locate phy %s\n", args->np->name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	port->host_mode = args->args[0];
> +
> +	return port->generic_phy;
> +}

The xlate function here shouldn't be needed at all. Use of_phy_simple_xlate
instead.
> +
> +static int bcm_phy_init(struct phy *generic_phy)
> +{
> +	struct bcm_phy_instance *port = phy_get_drvdata(generic_phy);
> +	struct bcm_phy_driver *phy_driver = port->driver;
> +	unsigned long flags;
> +	u32 reg_val;
> +
> +	spin_lock_irqsave(&phy_driver->lock, flags);
> +
> +	/*
> +	 * Only PORT 2 is capable of being device and host
> +	 * Default setting is device, check if it is set to host.
> +	 */
> +	if (port->port_no == 2) {
> +		if (port->host_mode) {
> +			writel(PHY2_DEV_HOST_CTRL_SEL_HOST,
> +				phy_driver->usbphy_regs +
> +				CDRU_USBPHY2_HOST_DEV_SEL_OFFSET);
> +		} else {
> +			/*
> +			 * Disable suspend/resume signals to device controller
> +			 * when a port is in device mode.
> +			 */
> +			reg_val = readl(phy_driver->usbphy_regs +
> +				      CDRU_USB_DEV_SUSPEND_RESUME_CTRL_OFFSET);
> +			reg_val |=
> +				1 << CDRU_USB_DEV_SUSPEND_RESUME_CTRL_DISABLE;
> +			writel(reg_val, phy_driver->usbphy_regs +
> +			       CDRU_USB_DEV_SUSPEND_RESUME_CTRL_OFFSET);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&phy_driver->lock, flags);
> +	return 0;
> +}
> +
> +static int bcm_phy_shutdown(struct phy *generic_phy)
> +{
> +	struct bcm_phy_instance *port = phy_get_drvdata(generic_phy);
> +	struct bcm_phy_driver *phy_driver = port->driver;
> +	unsigned long flags;
> +	int i;
> +	u32 reg_val, powered_on_phy;
> +	bool power_off_flag = true;
> +
> +	spin_lock_irqsave(&phy_driver->lock, flags);
> +
> +	/* power down the phy */
> +	reg_val = readl(phy_driver->usbphy_regs +
> +			CRMU_USB_PHY_AON_CTRL_OFFSET);
> +	reg_val &= ~(1 << power_bit[port->port_no]);
> +	reg_val &= ~(1 << reset_bit[port->port_no]);
> +	writel(reg_val, phy_driver->usbphy_regs +
> +		CRMU_USB_PHY_AON_CTRL_OFFSET);
> +	port->power = false;
> +
> +	/*
> +	 * If a port is configured to device and it is being shutdown,
> +	 * turn off the clocks to the usb device controller.
> +	 */
> +	if (port->port_no == 2 && !port->host_mode) {
> +		reg_val = readl(phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +		reg_val &= ~(1 << USB2_IDM_IDM_IO_CONTROL_DIRECT__clk_enable);
> +		writel(reg_val, phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +
> +		reg_val = readl(phy_driver->usb2d_idm_regs +
> +				 USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +		reg_val |= 1 << USB2_IDM_IDM_RESET_CONTROL__RESET;
> +		writel(reg_val, phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +	} else {
> +		/*
> +		 * If the phy being shutdown provides clock and reset to
> +		 * the host controller, change it do a different powered on phy
> +		 * If all phys are powered off, shut of the host controller
> +		 */
> +		reg_val = readl(phy_driver->usbphy_regs +
> +				CDRU_USBPHY_CLK_RST_SEL_OFFSET);
> +		powered_on_phy = reg_val;
> +		if (reg_val == port->port_no) {
> +			for (i = 0; i < ARRAY_SIZE(phy_driver->ports); i++) {
> +				if (phy_driver->ports[i] &&
> +				    phy_driver->ports[i]->power &&
> +				    phy_driver->ports[i]->host_mode) {
> +					power_off_flag = false;
> +					powered_on_phy = i;
> +				}
> +			}
> +		}
> +
> +		if (power_off_flag) {
> +			/*
> +			 * Put the host controller into reset state and
> +			 * disable clock.
> +			 */
> +			reg_val = readl(phy_driver->usb2h_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +			reg_val &=
> +			  ~(1 << USB2_IDM_IDM_IO_CONTROL_DIRECT__clk_enable);
> +			writel(reg_val, phy_driver->usb2h_idm_regs +
> +					USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +
> +			reg_val = readl(phy_driver->usb2h_idm_regs +
> +					 USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +			reg_val |= (1 << USB2_IDM_IDM_RESET_CONTROL__RESET);
> +			writel(reg_val, phy_driver->usb2h_idm_regs +
> +					USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +			phy_driver->idm_host_enabled = 0;
> +		} else {
> +			writel(powered_on_phy, phy_driver->usbphy_regs +
> +				   CDRU_USBPHY_CLK_RST_SEL_OFFSET);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&phy_driver->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int bcm_phy_poweron(struct phy *generic_phy)
> +{
> +	struct bcm_phy_instance *port = phy_get_drvdata(generic_phy);
> +	struct bcm_phy_driver *phy_driver = port->driver;
> +	unsigned long flags;
> +	int ret;
> +	u32 reg_val;
> +	bool clock_reset_flag = true;
> +
> +	spin_lock_irqsave(&phy_driver->lock, flags);
> +
> +	/* Bring the AFE block out of reset to start powering up the PHY */
> +	reg_val = readl(phy_driver->usbphy_regs + CRMU_USB_PHY_AON_CTRL_OFFSET);
> +	reg_val |= 1 << power_bit[port->port_no];
> +	writel(reg_val, phy_driver->usbphy_regs + CRMU_USB_PHY_AON_CTRL_OFFSET);
> +
> +	/* Check for power on and PLL lock */
> +	ret = cdru_usbphy_status_wait(status_reg[port->port_no],
> +		   CDRU_USBPHY_USBPHY_ILDO_ON_FLAG, phy_driver);
> +	if (ret < 0) {
> +		dev_err(&generic_phy->dev,
> +			"Timed out waiting for USBPHY_ILDO_ON_FLAG on port %d",
> +			port->port_no);
> +		goto err_shutdown;
> +	}
> +	ret = cdru_usbphy_status_wait(status_reg[port->port_no],
> +		CDRU_USBPHY_USBPHY_PLL_LOCK, phy_driver);
> +	if (ret < 0) {
> +		dev_err(&generic_phy->dev,
> +			"Timed out waiting for USBPHY_PLL_LOCK on port %d",
> +			port->port_no);
> +		goto err_shutdown;
> +	}
> +	port->power = true;
> +
> +	/* Check if the port 2 is configured for device */
> +	if (port->port_no == 2 && !port->host_mode) {
> +		/*
> +		 * Enable clock to USB device and get the USB device
> +		 * out of reset.
> +		 */
> +		reg_val = readl(phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +		reg_val |= 1 << USB2_IDM_IDM_IO_CONTROL_DIRECT__clk_enable;
> +		writel(reg_val, phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +
> +		reg_val = readl(phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +		reg_val &= ~(1 << USB2_IDM_IDM_RESET_CONTROL__RESET);
> +		writel(reg_val, phy_driver->usb2d_idm_regs +
> +				USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +
> +	} else {
> +		reg_val = readl(phy_driver->usbphy_regs +
> +				CDRU_USBPHY_CLK_RST_SEL_OFFSET);
> +
> +		/*
> +		 * Check if the phy that is configured to provide clock
> +		 * and reset is powered on.
> +		 */
> +		if (reg_val >= 0 && reg_val < ARRAY_SIZE(phy_driver->ports))
> +			if (phy_driver->ports[reg_val])
> +				if (phy_driver->ports[reg_val]->power)
> +					clock_reset_flag = false;
> +
> +		/* if not set the current phy */
> +		if (clock_reset_flag) {
> +			reg_val = port->port_no;
> +			writel(reg_val, phy_driver->usbphy_regs +
> +			       CDRU_USBPHY_CLK_RST_SEL_OFFSET);
> +		}
> +	}
> +
> +	if (!phy_driver->idm_host_enabled) {
> +		/* Enable clock to USB and get the USB out of reset */
> +		reg_val = readl(phy_driver->usb2h_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +		reg_val |= 1 << USB2_IDM_IDM_IO_CONTROL_DIRECT__clk_enable;
> +		writel(reg_val, phy_driver->usb2h_idm_regs +
> +				USB2_IDM_IDM_IO_CONTROL_DIRECT_OFFSET);
> +
> +		reg_val = readl(phy_driver->usb2h_idm_regs +
> +				USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +		reg_val &= ~(1 << USB2_IDM_IDM_RESET_CONTROL__RESET);
> +		writel(reg_val, phy_driver->usb2h_idm_regs +
> +				USB2_IDM_IDM_RESET_CONTROL_OFFSET);
> +		phy_driver->idm_host_enabled = true;
> +	}
> +
> +	spin_unlock_irqrestore(&phy_driver->lock, flags);
> +	return 0;
> +
> +err_shutdown:
> +	spin_unlock_irqrestore(&phy_driver->lock, flags);
> +	bcm_phy_shutdown(generic_phy);
> +	return ret;
> +}
> +
> +static struct phy_ops ops = {
> +	.init		= bcm_phy_init,
> +	.power_on	= bcm_phy_poweron,
> +	.power_off	= bcm_phy_shutdown,
> +};
> +
> +static const struct of_device_id bcm_phy_dt_ids[] = {
> +	{ .compatible = "brcm,cygnus-usb-phy", },
> +	{ }
> +};
> +
> +static int bcm_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcm_phy_driver *phy_driver;
> +	struct phy_provider *phy_provider;
> +	struct device_node *child;
> +	struct resource res;
> +	int error;
> +	u32 reg_val;
> +
> +	phy_driver = devm_kzalloc(dev, sizeof(struct bcm_phy_driver),
> +				  GFP_KERNEL);
> +	if (!phy_driver)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&phy_driver->lock);
> +
> +	error = of_address_to_resource(dev->of_node, 0, &res);

why not platform_get_resource?
> +	if (error) {
> +		dev_err(dev, "Failed to obtain device tree resource usbphy_regs\n");
> +		return error;
> +	}
> +
> +	phy_driver->usbphy_regs = devm_ioremap_nocache(dev, res.start,
> +						resource_size(&res));
> +	if (!phy_driver->usbphy_regs) {
> +		dev_err(dev, "Failed to remap usbphy_regs\n");
> +		return -ENOMEM;
> +	}
> +
> +	error = of_address_to_resource(dev->of_node, 1, &res);

same here..
> +	if (error) {
> +		dev_err(dev, "Failed to obtain device tree resource usb2h_idm_regs\n");
> +		return error;
> +	}
> +
> +	phy_driver->usb2h_idm_regs = devm_ioremap_nocache(dev, res.start,
> +						  resource_size(&res));
> +	if (!phy_driver->usb2h_idm_regs) {
> +		dev_err(dev, "Failed to remap usb2h_idm_regs\n");
> +		return -ENOMEM;
> +	}
> +
> +	error = of_address_to_resource(dev->of_node, 2, &res);
same here..

Thanks
Kishon
