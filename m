From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 9 Jan 2018 11:09:55 +0800
Subject: [RFC PATCH] drivers: soc: xilinx: Add ZynqMP PM driver
In-Reply-To: <1515449444-5274-1-git-send-email-jollys@xilinx.com>
References: <1515449444-5274-1-git-send-email-jollys@xilinx.com>
Message-ID: <1515467395.31546.11.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-01-08 at 14:10 -0800, Jolly Shah wrote:
> Add ZynqMP PM driver. PM driver provides power management
> support for ZynqMP.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../bindings/soc/xilinx/xlnx,zynqmp-pm.txt         |  15 ++


The patch should be split into two: one is for dt-bindings part and the
other is for driver part. Where dt-binding part should require
additionally to send to Rob and Cc. devicetree at vger.kernel.org.

>  drivers/soc/Kconfig                                |   1 +
>  drivers/soc/Makefile                               |   1 +
>  drivers/soc/xilinx/Kconfig                         |   4 +
>  drivers/soc/xilinx/Makefile                        |   4 +
>  drivers/soc/xilinx/zynqmp/Kconfig                  |  15 ++
>  drivers/soc/xilinx/zynqmp/Makefile                 |   1 +
>  drivers/soc/xilinx/zynqmp/pm.c                     | 265 +++++++++++++++++++++
>  8 files changed, 306 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
>  create mode 100644 drivers/soc/xilinx/Kconfig
>  create mode 100644 drivers/soc/xilinx/Makefile
>  create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
>  create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
>  create mode 100644 drivers/soc/xilinx/zynqmp/pm.c
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
> new file mode 100644
> index 0000000..9cfb40d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xlnx,zynqmp-pm.txt
> @@ -0,0 +1,15 @@
> +Xilinx Zynq MPSoC Power Management Device Tree Bindings
> +
> +The zynqmp-pm node describes the power management configurations.
> +
> +Required properties:
> + - compatible		: Must contain:  "xlnx,zynqmp-pm"
> + - interrupt-parent	: Interrupt controller the interrupt is routed through
> + - interrupts		: Interrupt specifier
> +
> +Examples:
> +	zynqmp-firmware {
> +		compatible = "xlnx,zynqmp-pm";
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 35 4>;
> +	};
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index fc9e980..c07b4a8 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -16,6 +16,7 @@ source "drivers/soc/tegra/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/ux500/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
> +source "drivers/soc/xilinx/Kconfig"
>  source "drivers/soc/zte/Kconfig"
>  
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index deecb16..abb019a 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> +obj-$(CONFIG_ARCH_ZYNQMP)	+= xilinx/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_ARCH_U8500)	+= ux500/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> new file mode 100644
> index 0000000..190add7
> --- /dev/null
> +++ b/drivers/soc/xilinx/Kconfig
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Kconfig for Xilinx SoCs
> +
> +source "drivers/soc/xilinx/zynqmp/Kconfig"
> diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
> new file mode 100644
> index 0000000..bc9d560
> --- /dev/null
> +++ b/drivers/soc/xilinx/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Makefile for Xilinx SoCs
> +
> +obj-$(CONFIG_ARCH_ZYNQMP) += zynqmp/
> diff --git a/drivers/soc/xilinx/zynqmp/Kconfig b/drivers/soc/xilinx/zynqmp/Kconfig
> new file mode 100644
> index 0000000..d3c784d
> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +# Kconfig for Xilinx zynqmp SoC
> +#
> +menu "Zynq MPSoC SoC Drivers"
> +	depends on ARCH_ZYNQMP
> +
> +
> +config ZYNQMP_PM
> +	bool "Enable Xilinx Zynq MPSoC Power Management"
> +	depends on PM
> +	help
> +	  Say yes to enable power management support for
> +	  ZyqnMP SoC. In doubt, say N.
> +
> +endmenu
> diff --git a/drivers/soc/xilinx/zynqmp/Makefile b/drivers/soc/xilinx/zynqmp/Makefile
> new file mode 100644
> index 0000000..98034f7
> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ZYNQMP_PM) += pm.o
> diff --git a/drivers/soc/xilinx/zynqmp/pm.c b/drivers/soc/xilinx/zynqmp/pm.c
> new file mode 100644
> index 0000000..7178fb5
> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/pm.c
> @@ -0,0 +1,265 @@
> +/*
> + * Xilinx Zynq MPSoC Power Management
> + *
> + *  Copyright (C) 2014-2017 Xilinx, Inc.

should include 2018 ?

> + *
> + *  Davorin Mista <davorin.mista@aggios.com>
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + *
> + * SPDX-License-Identifier:	GPL-2.0+
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/uaccess.h>
> +#include <linux/platform_device.h>
> +#include <linux/debugfs.h>
> +#include <linux/reboot.h>
> +#include <linux/suspend.h>
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> +
> +#define DRIVER_NAME	"zynqmp_pm"
> +
> +/**
> + * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
> + * @callback_work:	Work structure
> + * @args:		Callback arguments
> + */
> +struct zynqmp_pm_work_struct {
> +	struct work_struct callback_work;
> +	u32 args[CB_ARG_CNT];
> +};
> +
> +static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
> +
> +enum pm_suspend_mode {
> +	PM_SUSPEND_MODE_STD,
> +	PM_SUSPEND_MODE_POWER_OFF,
> +};
> +
> +#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
> +
> +static const char *const suspend_modes[] = {
> +	[PM_SUSPEND_MODE_STD] = "standard",
> +	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
> +};
> +
> +static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
> +
> +enum pm_api_cb_id {
> +	PM_INIT_SUSPEND_CB = 30,
> +	PM_ACKNOWLEDGE_CB,
> +	PM_NOTIFY_CB,
> +};
> +
> +static irqreturn_t zynqmp_pm_isr(int irq, void *data)
> +{
> +	u32 payload[CB_PAYLOAD_SIZE];
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_callback_data)
> +		return IRQ_NONE;
> +
> +	eemi_ops->get_callback_data(payload);
> +
> +	if (!payload[0])
> +		return IRQ_NONE;
> +
> +	/* First element is callback API ID, others are callback arguments */
> +	if (payload[0] == PM_INIT_SUSPEND_CB) {
> +		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
> +			goto done;
> +
> +		/* Copy callback arguments into work's structure */
> +		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
> +		       sizeof(zynqmp_pm_init_suspend_work->args));
> +
> +		queue_work(system_unbound_wq,
> +			   &zynqmp_pm_init_suspend_work->callback_work);
> +	}
> +
> +done:
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id pm_of_match[] = {
> +	{ .compatible = "xlnx,zynqmp-pm", },
> +	{ /* end of table */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, pm_of_match);
> +
> +/**
> + * zynqmp_pm_init_suspend_work_fn - Initialize suspend
> + * @work:	Pointer to work_struct
> + *
> + * Bottom-half of PM callback IRQ handler.
> + */
> +static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
> +{
> +	struct zynqmp_pm_work_struct *pm_work =
> +		container_of(work, struct zynqmp_pm_work_struct, callback_work);
> +
> +	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
> +		orderly_poweroff(true);
> +	} else if (pm_work->args[0] ==
> +		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
> +		pm_suspend(PM_SUSPEND_MEM);
> +	} else {
> +		pr_err("%s Unsupported InitSuspendCb reason code %d.\n"
> +		       , __func__, pm_work->args[0]);
> +	}
> +}
> +
> +static ssize_t suspend_mode_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	char *s = buf;
> +	int md;
> +
> +	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
> +		if (suspend_modes[md]) {
> +			if (md == suspend_mode)
> +				s += sprintf(s, "[%s] ", suspend_modes[md]);
> +			else
> +				s += sprintf(s, "%s ", suspend_modes[md]);
> +		}
> +
> +	/* Convert last space to newline */
> +	if (s != buf)
> +		*(s - 1) = '\n';
> +	return (s - buf);
> +}
> +
> +static ssize_t suspend_mode_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	int md, ret = -EINVAL;
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->set_suspend_mode)
> +		return ret;
> +
> +	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
> +		if (suspend_modes[md] &&
> +		    sysfs_streq(suspend_modes[md], buf)) {
> +			ret = 0;
> +			break;
> +		}
> +
> +	if (!ret && md != suspend_mode) {
> +		ret = eemi_ops->set_suspend_mode(md);
> +		if (likely(!ret))
> +			suspend_mode = md;
> +	}
> +
> +	return ret ? ret : count;
> +}
> +
> +static DEVICE_ATTR_RW(suspend_mode);
> +
> +/**
> + * zynqmp_pm_sysfs_init - Initialize PM driver sysfs interface
> + * @dev:	Pointer to device structure
> + *
> + * Return:	0 on success, negative error code otherwise
> + */
> +static int zynqmp_pm_sysfs_init(struct device *dev)
> +{
> +	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
> +}
> +
> +/**
> + * zynqmp_pm_probe - Probe existence of the PMU Firmware
> + *			and initialize debugfs interface
> + *
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * Return:	Returns 0 on success
> + *		Negative error code otherwise
> + */
> +static int zynqmp_pm_probe(struct platform_device *pdev)
> +{
> +	int ret, irq;
> +	u32 pm_api_version;
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_api_version)
> +		return -ENXIO;
> +
> +	eemi_ops->get_api_version(&pm_api_version);
> +
> +	/* Check PM API version number */
> +	if (pm_api_version != ZYNQMP_PM_VERSION)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return -ENXIO;
> +
> +	ret = request_irq(irq, zynqmp_pm_isr, IRQF_SHARED, DRIVER_NAME, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
> +			irq, ret);
> +		return ret;
> +	}


how about use devm_request_irq to simplify error path?

> +
> +	zynqmp_pm_init_suspend_work =
> +		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
> +			     GFP_KERNEL);
> +	if (!zynqmp_pm_init_suspend_work) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
> +		  zynqmp_pm_init_suspend_work_fn);
> +
> +	ret = zynqmp_pm_sysfs_init(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
> +		goto error;
> +	}
> +
> +	dev_info(&pdev->dev, "Power management API v%d.%d\n",
> +		 ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR);
> +
> +	return 0;
> +
> +error:
> +	free_irq(irq, 0);
> +	return ret;
> +}
> +
> +static struct platform_driver zynqmp_pm_platform_driver = {
> +	.probe   = zynqmp_pm_probe,
> +	.driver  = {
> +			.name             = DRIVER_NAME,
> +			.of_match_table   = pm_of_match,
> +		   },
> +};
> +builtin_platform_driver(zynqmp_pm_platform_driver);
> +
> +/**
> + * zynqmp_pm_init - Notify PM firmware that initialization is completed
> + *
> + * Return:	Status returned from the PM firmware
> + */
> +static int __init zynqmp_pm_init(void)
> +{
> +	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->init_finalize)
> +		return -ENXIO;
> +
> +	return eemi_ops->init_finalize();
> +}
> +
> +late_initcall_sync(zynqmp_pm_init);
