From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 23 Nov 2015 20:06:28 +0200
Subject: [PATCH V7 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75VdjKSsdrz57M-XxCsh2i3441Zf3xBAOc1Aa7YigMdvkPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 4:28 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The Qualcomm Technologies HIDMA device has been designed
> to support virtualization technology. The driver has been
> divided into two to follow the hardware design.
>
> 1. HIDMA Management driver
> 2. HIDMA Channel driver
>
> Each HIDMA HW consists of multiple channels. These channels
> share some set of common parameters. These parameters are
> initialized by the management driver during power up.
> Same management driver is used for monitoring the execution
> of the channels. Management driver can change the performance
> behavior dynamically such as bandwidth allocation and
> prioritization.
>
> The management driver is executed in hypervisor context and
> is the main management entity for all channels provided by
> the device.
>

Thanks for an update!

Looks cool! Though still few errors spelling and style nitpicks (you
may ignore them if you wish) below.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++++++
>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++++
>  drivers/dma/qcom/Kconfig                           |  11 +
>  drivers/dma/qcom/Makefile                          |   1 +
>  drivers/dma/qcom/hidma_mgmt.c                      | 308 +++++++++++++++++++++
>  drivers/dma/qcom/hidma_mgmt.h                      |  39 +++
>  drivers/dma/qcom/hidma_mgmt_sys.c                  | 299 ++++++++++++++++++++
>  7 files changed, 816 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma-mgmt
>  create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
>  create mode 100644 drivers/dma/qcom/hidma_mgmt.c
>  create mode 100644 drivers/dma/qcom/hidma_mgmt.h
>  create mode 100644 drivers/dma/qcom/hidma_mgmt_sys.c
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-hidma-mgmt b/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
> new file mode 100644
> index 0000000..4fc6876
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
> @@ -0,0 +1,97 @@
> +What:          /sys/devices/platform/hidma-mgmt*/chan*/priority
> +               /sys/devices/platform/QCOM8060:*/chan*/priority
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains either 0 or 1 and indicates if the DMA channel is a
> +               low priority (0) or high priority (1) channel.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/chan*/weight
> +               /sys/devices/platform/QCOM8060:*/chan*/weight
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains 0..15 and indicates the weight of the channel among
> +               equal priority channels during round robin scheduling.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/chreset_timeout_cycles
> +               /sys/devices/platform/QCOM8060:*/chreset_timeout_cycles
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains the platform specific cycle value to wait after a
> +               reset command is issued. If the value is chosen too short,
> +               then the HW will issue a reset failure interrupt. The value
> +               is platform specific and should not be changed without
> +               consultance.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/dma_channels
> +               /sys/devices/platform/QCOM8060:*/dma_channels
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains the number of dma channels supported by one instance
> +               of HIDMA hardware. The value may change from chip to chip.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/hw_version_major
> +               /sys/devices/platform/QCOM8060:*/hw_version_major
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Version number major for the hardware.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/hw_version_minor
> +               /sys/devices/platform/QCOM8060:*/hw_version_minor
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Version number minor for the hardware.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/max_rd_xactions
> +               /sys/devices/platform/QCOM8060:*/max_rd_xactions
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains a value between 0 and 31. Maximum number of
> +               read transactions that can be issued back to back.
> +               Choosing a higher number gives better performance but
> +               can also cause performance reduction to other peripherals
> +               sharing the same bus.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/max_read_request
> +               /sys/devices/platform/QCOM8060:*/max_read_request
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Size of each read request. The value needs to be a power
> +               of two and can be between 128 and 1024.
> +
> +What:          /sys/devices/platform/hidma-mgmt*/max_wr_xactions
> +               /sys/devices/platform/QCOM8060:*/max_wr_xactions
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Contains a value between 0 and 31. Maximum number of
> +               write transactions that can be issued back to back.
> +               Choosing a higher number gives better performance but
> +               can also cause performance reduction to other peripherals
> +               sharing the same bus.
> +
> +
> +What:          /sys/devices/platform/hidma-mgmt*/max_write_request
> +               /sys/devices/platform/QCOM8060:*/max_write_request
> +Date:          Nov 2015
> +KernelVersion: 4.4
> +Contact:       "Sinan Kaya <okaya@cudeaurora.org>"
> +Description:
> +               Size of each write request. The value needs to be a power
> +               of two and can be between 128 and 1024.
> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> new file mode 100644
> index 0000000..eb053b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
> @@ -0,0 +1,61 @@
> +Qualcomm Technologies HIDMA Management interface
> +
> +The Qualcomm Technologies HIDMA device has been designed
> +to support virtualization technology. The driver has been
> +divided into two to follow the hardware design. The management
> +driver is executed in hypervisor context and is the main
> +management entity for all channels provided by the device.
> +
> +Each HIDMA HW consists of multiple channels. These channels
> +share some set of common parameters. These parameters are
> +initialized by the management driver during power up.
> +Same management driver is used for monitoring the execution
> +of the channels. Management driver can change the performance
> +behavior dynamically such as bandwidth allocation and
> +prioritization.
> +
> +All channel devices get probed in the hypervisor
> +context during power up. They show up as DMA engine
> +DMA channels. Then, before starting the virtualization; each
> +channel device is unbound from the hypervisor by VFIO
> +and assign to the guest machine for control.
> +
> +This management driver will  be used by the system
> +admin to monitor/reset the execution state of the DMA
> +channels. This will be the management interface.
> +
> +
> +Required properties:
> +- compatible: "qcom,hidma-mgmt-1.0";
> +- reg: Address range for DMA device
> +- dma-channels: Number of channels supported by this DMA controller.
> +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
> +  fragmented to multiples of this amount.
> +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
> +  fragmented to multiples of this amount.
> +- max-write-transactions: Maximum write transactions to perform in a burst
> +- max-read-transactions: Maximum read transactions to perform in a burst
> +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
> +- channel-priority: Priority of the channel.
> +  Each dma channel share the same HW bandwidth with other dma channels.
> +  If two requests reach to the HW at the same time from a low priority and
> +  high priority channel, high priority channel will claim the bus.
> +  0=low priority, 1=high priority
> +- channel-weight: Round robin weight of the channel
> +  Since there are only two priority levels supported, scheduling among
> +  the equal priority channels is done via weights.
> +
> +Example:
> +
> +       hidma-mgmt at f9984000 = {
> +               compatible = "qcom,hidma-mgmt-1.0";
> +               reg = <0xf9984000 0x15000>;
> +               dma-channels = 6;
> +               max-write-burst-bytes = 1024;
> +               max-read-burst-bytes = 1024;
> +               max-write-transactions = 31;
> +               max-read-transactions = 31;
> +               channel-reset-timeout-cycles = 0x500;

> +               channel-priority = < 1 1 0 0 0 0>;
> +               channel-weight = < 1 13 10 3 4 5>;

I don't know if it's okay, but I saw format of arrays like <X Y Z> (no
head space).

> +       };
> diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> index f17c272..ebe5b8c 100644
> --- a/drivers/dma/qcom/Kconfig
> +++ b/drivers/dma/qcom/Kconfig
> @@ -6,3 +6,14 @@ config QCOM_BAM_DMA
>         ---help---
>           Enable support for the QCOM BAM DMA controller.  This controller
>           provides DMA capabilities for a variety of on-chip devices.
> +
> +config QCOM_HIDMA_MGMT
> +       tristate "Qualcomm Technologies HIDMA Management support"
> +       select DMA_ENGINE
> +       help
> +         Enable support for the Qualcomm Technologies HIDMA Management.
> +         Each DMA device requires one management interface driver
> +         for basic initialization before QCOM_HIDMA channel driver can
> +         start managing the channels. In a virtualized environment,
> +         the guest OS would run QCOM_HIDMA channel driver and the
> +         hypervisor would run the QCOM_HIDMA_MGMT management driver.
> diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
> index f612ae3..1a5a96d 100644
> --- a/drivers/dma/qcom/Makefile
> +++ b/drivers/dma/qcom/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
> +obj-$(CONFIG_QCOM_HIDMA_MGMT) += hidma_mgmt.o hidma_mgmt_sys.o
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> new file mode 100644
> index 0000000..ea78a4d
> --- /dev/null
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -0,0 +1,308 @@
> +/*
> + * Qualcomm Technologies HIDMA DMA engine Management interface
> + *
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/dmaengine.h>
> +#include <linux/acpi.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/bitops.h>
> +
> +#include "hidma_mgmt.h"
> +
> +#define QOS_N_OFFSET                   0x300
> +#define CFG_OFFSET                     0x400
> +#define MAX_BUS_REQ_LEN_OFFSET         0x41C
> +#define MAX_XACTIONS_OFFSET            0x420
> +#define HW_VERSION_OFFSET              0x424
> +#define CHRESET_TIMEOUT_OFFSET         0x418
> +
> +#define MAX_WR_XACTIONS_MASK           GENMASK(4, 0)
> +#define MAX_RD_XACTIONS_MASK           GENMASK(4, 0)
> +#define WEIGHT_MASK                    GENMASK(6, 0)
> +#define MAX_BUS_REQ_LEN_MASK           GENMASK(15, 0)
> +#define CHRESET_TIMEOUUT_MASK          GENMASK(19, 0)

Spelling?

> +
> +#define MAX_WR_XACTIONS_BIT_POS        16
> +#define MAX_BUS_WR_REQ_BIT_POS         16
> +#define WRR_BIT_POS                    8
> +#define PRIORITY_BIT_POS               15
> +
> +#define AUTOSUSPEND_TIMEOUT            2000
> +#define MAX_CHANNEL_WEIGHT             15
> +
> +int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
> +{
> +       unsigned int i;
> +       u32 val;
> +
> +       if (!is_power_of_2(mgmtdev->max_write_request) ||
> +               (mgmtdev->max_write_request < 128) ||
> +               (mgmtdev->max_write_request > 1024)) {
> +               dev_err(&mgmtdev->pdev->dev, "invalid write request %d\n",
> +                       mgmtdev->max_write_request);
> +               return -EINVAL;
> +       }
> +
> +       if (!is_power_of_2(mgmtdev->max_read_request) ||
> +               (mgmtdev->max_read_request < 128) ||
> +               (mgmtdev->max_read_request > 1024)) {
> +               dev_err(&mgmtdev->pdev->dev, "invalid read request %d\n",
> +                       mgmtdev->max_read_request);
> +               return  -EINVAL;
> +       }
> +
> +       if (mgmtdev->max_wr_xactions > MAX_WR_XACTIONS_MASK) {
> +               dev_err(&mgmtdev->pdev->dev,
> +                       "max_wr_xactions cannot be bigger than %ld\n",
> +                       MAX_WR_XACTIONS_MASK);
> +               return -EINVAL;
> +       }
> +
> +       if (mgmtdev->max_rd_xactions > MAX_RD_XACTIONS_MASK) {
> +               dev_err(&mgmtdev->pdev->dev,
> +                       "max_rd_xactions cannot be bigger than %ld\n",
> +                       MAX_RD_XACTIONS_MASK);
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
> +               if (mgmtdev->priority[i] > 1) {
> +                       dev_err(&mgmtdev->pdev->dev,
> +                               "priority can be 0 or 1\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (mgmtdev->weight[i] > MAX_CHANNEL_WEIGHT) {
> +                       dev_err(&mgmtdev->pdev->dev,
> +                               "max value of weight can be %d.\n",
> +                               MAX_CHANNEL_WEIGHT);
> +                       return -EINVAL;
> +               }
> +
> +               /* weight needs to be at least one */
> +               if (mgmtdev->weight[i] == 0)
> +                       mgmtdev->weight[i] = 1;
> +       }
> +
> +       pm_runtime_get_sync(&mgmtdev->pdev->dev);
> +       val = readl(mgmtdev->virtaddr + MAX_BUS_REQ_LEN_OFFSET);
> +       val &= ~(MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS);
> +       val |= mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS;
> +       val &= ~MAX_BUS_REQ_LEN_MASK;
> +       val |= mgmtdev->max_read_request;
> +       writel(val, mgmtdev->virtaddr + MAX_BUS_REQ_LEN_OFFSET);
> +
> +       val = readl(mgmtdev->virtaddr + MAX_XACTIONS_OFFSET);
> +       val &= ~(MAX_WR_XACTIONS_MASK << MAX_WR_XACTIONS_BIT_POS);
> +       val |= mgmtdev->max_wr_xactions << MAX_WR_XACTIONS_BIT_POS;
> +       val &= ~MAX_RD_XACTIONS_MASK;
> +       val |= mgmtdev->max_rd_xactions;
> +       writel(val, mgmtdev->virtaddr + MAX_XACTIONS_OFFSET);
> +
> +       mgmtdev->hw_version = readl(mgmtdev->virtaddr + HW_VERSION_OFFSET);
> +       mgmtdev->hw_version_major = (mgmtdev->hw_version >> 28) & 0xF;
> +       mgmtdev->hw_version_minor = (mgmtdev->hw_version >> 16) & 0xF;
> +
> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
> +               val = readl(mgmtdev->virtaddr + QOS_N_OFFSET + (4 * i));
> +               val &= ~(1 << PRIORITY_BIT_POS);
> +               val |= (mgmtdev->priority[i] & 0x1) << PRIORITY_BIT_POS;
> +               val &= ~(WEIGHT_MASK << WRR_BIT_POS);
> +               val |= (mgmtdev->weight[i] & WEIGHT_MASK) << WRR_BIT_POS;
> +               writel(val, mgmtdev->virtaddr + QOS_N_OFFSET + (4 * i));
> +       }
> +
> +       val = readl(mgmtdev->virtaddr + CHRESET_TIMEOUT_OFFSET);
> +       val &= ~CHRESET_TIMEOUUT_MASK;

Ditto. _TIMEOUT_?

> +       val |= mgmtdev->chreset_timeout_cycles & CHRESET_TIMEOUUT_MASK;

Ditto.

> +       writel(val, mgmtdev->virtaddr + CHRESET_TIMEOUT_OFFSET);
> +
> +       pm_runtime_mark_last_busy(&mgmtdev->pdev->dev);
> +       pm_runtime_put_autosuspend(&mgmtdev->pdev->dev);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(hidma_mgmt_setup);
> +
> +static int hidma_mgmt_probe(struct platform_device *pdev)
> +{
> +       struct hidma_mgmt_dev *mgmtdev;
> +       struct resource *res;
> +       void __iomem *virtaddr;
> +       int irq;
> +       int rc;
> +       u32 val;
> +
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_get_sync(&pdev->dev);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       virtaddr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(virtaddr)) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "irq resources not found\n");
> +               rc = irq;
> +               goto out;
> +       }
> +
> +       mgmtdev = devm_kzalloc(&pdev->dev, sizeof(*mgmtdev), GFP_KERNEL);
> +       if (!mgmtdev) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       mgmtdev->pdev = pdev;
> +       mgmtdev->addrsize = resource_size(res);
> +       mgmtdev->virtaddr = virtaddr;
> +
> +       rc = device_property_read_u32(&pdev->dev, "dma-channels",
> +                               &mgmtdev->dma_channels);
> +       if (rc) {
> +               dev_err(&pdev->dev, "number of channels missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32(&pdev->dev,
> +                               "channel-reset-timeout-cycles",
> +                               &mgmtdev->chreset_timeout_cycles);
> +       if (rc) {
> +               dev_err(&pdev->dev, "channel reset timeout missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32(&pdev->dev, "max-write-burst-bytes",
> +                               &mgmtdev->max_write_request);
> +       if (rc) {
> +               dev_err(&pdev->dev, "max-write-burst-bytes missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32(&pdev->dev, "max-read-burst-bytes",
> +                               &mgmtdev->max_read_request);
> +       if (rc) {
> +               dev_err(&pdev->dev, "max-read-burst-bytes missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32(&pdev->dev, "max-write-transactions",
> +                               &mgmtdev->max_wr_xactions);
> +       if (rc) {
> +               dev_err(&pdev->dev, "max-write-transactions missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32(&pdev->dev, "max-read-transactions",
> +                               &mgmtdev->max_rd_xactions);
> +       if (rc) {
> +               dev_err(&pdev->dev, "max-read-transactions missing\n");
> +               goto out;
> +       }
> +
> +       mgmtdev->priority = devm_kcalloc(&pdev->dev,
> +               mgmtdev->dma_channels, sizeof(*mgmtdev->priority), GFP_KERNEL);
> +       if (!mgmtdev->priority) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       mgmtdev->weight = devm_kcalloc(&pdev->dev,
> +               mgmtdev->dma_channels, sizeof(*mgmtdev->weight), GFP_KERNEL);
> +       if (!mgmtdev->weight) {
> +               rc = -ENOMEM;
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32_array(&pdev->dev, "channel-priority",
> +                               mgmtdev->priority, mgmtdev->dma_channels);
> +       if (rc) {
> +               dev_err(&pdev->dev, "channel-priority missing\n");
> +               goto out;
> +       }
> +
> +       rc = device_property_read_u32_array(&pdev->dev, "channel-weight",
> +                               mgmtdev->weight, mgmtdev->dma_channels);
> +       if (rc) {
> +               dev_err(&pdev->dev, "channel-weight missing\n");
> +               goto out;
> +       }
> +
> +       rc = hidma_mgmt_setup(mgmtdev);
> +       if (rc) {
> +               dev_err(&pdev->dev, "setup failed\n");
> +               goto out;
> +       }
> +
> +       /* start the HW */
> +       val = readl(mgmtdev->virtaddr + CFG_OFFSET);
> +       val |= 1;
> +       writel(val, mgmtdev->virtaddr + CFG_OFFSET);
> +
> +       rc = hidma_mgmt_init_sys(mgmtdev);
> +       if (rc) {
> +               dev_err(&pdev->dev, "sysfs setup failed\n");
> +               goto out;
> +       }
> +
> +       dev_info(&pdev->dev,
> +                "HW rev: %d.%d @ %pa with %d physical channels\n",
> +                mgmtdev->hw_version_major, mgmtdev->hw_version_minor,
> +                &res->start, mgmtdev->dma_channels);
> +
> +       platform_set_drvdata(pdev, mgmtdev);
> +       pm_runtime_mark_last_busy(&pdev->dev);
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +       return 0;
> +out:
> +       pm_runtime_put_sync_suspend(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       return rc;
> +}
> +
> +#if IS_ENABLED(CONFIG_ACPI)
> +static const struct acpi_device_id hidma_mgmt_acpi_ids[] = {
> +       {"QCOM8060"},
> +       {},
> +};
> +#endif
> +
> +static const struct of_device_id hidma_mgmt_match[] = {
> +       { .compatible = "qcom,hidma-mgmt-1.0", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, hidma_mgmt_match);
> +
> +static struct platform_driver hidma_mgmt_driver = {
> +       .probe = hidma_mgmt_probe,
> +       .driver = {
> +               .name = "hidma-mgmt",
> +               .of_match_table = hidma_mgmt_match,
> +               .acpi_match_table = ACPI_PTR(hidma_mgmt_acpi_ids),
> +       },
> +};
> +module_platform_driver(hidma_mgmt_driver);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/qcom/hidma_mgmt.h b/drivers/dma/qcom/hidma_mgmt.h
> new file mode 100644
> index 0000000..f7daf33
> --- /dev/null
> +++ b/drivers/dma/qcom/hidma_mgmt.h
> @@ -0,0 +1,39 @@
> +/*
> + * Qualcomm Technologies HIDMA Management common header
> + *
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +struct hidma_mgmt_dev {
> +       u8 hw_version_major;
> +       u8 hw_version_minor;
> +
> +       u32 max_wr_xactions;
> +       u32 max_rd_xactions;
> +       u32 max_write_request;
> +       u32 max_read_request;
> +       u32 dma_channels;
> +       u32 chreset_timeout_cycles;
> +       u32 hw_version;
> +       u32 *priority;
> +       u32 *weight;
> +
> +       /* Hardware device constants */
> +       void __iomem *virtaddr;
> +       resource_size_t addrsize;
> +
> +       struct kobject **chroots;
> +       struct platform_device *pdev;
> +};
> +
> +int hidma_mgmt_init_sys(struct hidma_mgmt_dev *dev);
> +int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev);
> diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_mgmt_sys.c
> new file mode 100644
> index 0000000..a4a6414
> --- /dev/null
> +++ b/drivers/dma/qcom/hidma_mgmt_sys.c
> @@ -0,0 +1,299 @@
> +/*
> + * Qualcomm Technologies HIDMA Management SYS interface
> + *
> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/sysfs.h>
> +#include <linux/platform_device.h>
> +
> +#include "hidma_mgmt.h"
> +
> +struct hidma_chan_attr {
> +       struct hidma_mgmt_dev *mdev;
> +       int index;
> +       struct kobj_attribute attr;
> +};
> +
> +struct hidma_mgmt_fileinfo {
> +       char *name;
> +       int mode;
> +       int (*get)(struct hidma_mgmt_dev *mdev);
> +       int (*set)(struct hidma_mgmt_dev *mdev, u64 val);
> +};
> +
> +#define IMPLEMENT_GETSET(name)                                 \
> +static int get_##name(struct hidma_mgmt_dev *mdev)             \
> +{                                                              \
> +       return mdev->name;                                      \
> +}                                                              \
> +static int set_##name(struct hidma_mgmt_dev *mdev, u64 val)    \
> +{                                                              \
> +       u64 tmp;                                                \
> +       int rc;                                                 \
> +                                                               \
> +       tmp = mdev->name;                                       \
> +       mdev->name = val;                                       \
> +       rc = hidma_mgmt_setup(mdev);                            \
> +       if (rc)                                                 \
> +               mdev->name = tmp;                               \
> +       return rc;                                              \
> +}
> +
> +#define DECLARE_ATTRIBUTE(name, mode)                          \
> +       {#name, mode, get_##name, set_##name}
> +
> +IMPLEMENT_GETSET(hw_version_major)
> +IMPLEMENT_GETSET(hw_version_minor)
> +IMPLEMENT_GETSET(max_wr_xactions)
> +IMPLEMENT_GETSET(max_rd_xactions)
> +IMPLEMENT_GETSET(max_write_request)
> +IMPLEMENT_GETSET(max_read_request)
> +IMPLEMENT_GETSET(dma_channels)
> +IMPLEMENT_GETSET(chreset_timeout_cycles)
> +
> +static int set_priority(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
> +{
> +       u64 tmp;
> +       int rc;
> +
> +       if (i > mdev->dma_channels)
> +               return -EINVAL;
> +
> +       tmp = mdev->priority[i];
> +       mdev->priority[i] = val;
> +       rc = hidma_mgmt_setup(mdev);
> +       if (rc)
> +               mdev->priority[i] = tmp;
> +       return rc;
> +}
> +
> +static int set_weight(struct hidma_mgmt_dev *mdev, unsigned int i, u64 val)
> +{
> +       u64 tmp;
> +       int rc;
> +
> +       if (i > mdev->dma_channels)
> +               return -EINVAL;
> +
> +       tmp = mdev->weight[i];
> +       mdev->weight[i] = val;
> +       rc = hidma_mgmt_setup(mdev);
> +       if (rc)
> +               mdev->weight[i] = tmp;
> +       return rc;
> +}
> +
> +static struct hidma_mgmt_fileinfo hidma_mgmt_files[] = {
> +       DECLARE_ATTRIBUTE(hw_version_major, S_IRUGO),
> +       DECLARE_ATTRIBUTE(hw_version_minor, S_IRUGO),
> +       DECLARE_ATTRIBUTE(dma_channels, S_IRUGO),
> +       DECLARE_ATTRIBUTE(chreset_timeout_cycles, S_IRUGO),
> +       DECLARE_ATTRIBUTE(max_wr_xactions, (S_IRUGO|S_IWUGO)),
> +       DECLARE_ATTRIBUTE(max_rd_xactions, (S_IRUGO|S_IWUGO)),
> +       DECLARE_ATTRIBUTE(max_write_request, (S_IRUGO|S_IWUGO)),
> +       DECLARE_ATTRIBUTE(max_read_request, (S_IRUGO|S_IWUGO)),
> +};
> +
> +static ssize_t show_values(struct device *dev, struct device_attribute *attr,
> +                               char *buf)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct hidma_mgmt_dev *mdev = platform_get_drvdata(pdev);
> +       unsigned int i;
> +
> +       buf[0] = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(hidma_mgmt_files); i++) {
> +               if (strcmp(attr->attr.name, hidma_mgmt_files[i].name) == 0) {
> +                       sprintf(buf, "%d\n", hidma_mgmt_files[i].get(mdev));
> +                       goto done;

break; ?

> +               }
> +       }
> +done:
> +       return strlen(buf);
> +}
> +
> +static ssize_t set_values(struct device *dev, struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct hidma_mgmt_dev *mdev = platform_get_drvdata(pdev);
> +       unsigned long tmp;
> +       unsigned int i;
> +       int rc;
> +
> +       rc = kstrtoul(buf, 0, &tmp);
> +       if (rc)
> +               return rc;
> +
> +       for (i = 0; i < ARRAY_SIZE(hidma_mgmt_files); i++) {
> +               if (strcmp(attr->attr.name, hidma_mgmt_files[i].name) == 0) {
> +                       rc = hidma_mgmt_files[i].set(mdev, tmp);
> +                       if (rc)
> +                               return rc;
> +
> +                       goto done;

Ditto.

> +               }
> +       }
> +done:
> +       return count;
> +}
> +
> +static ssize_t show_values_channel(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       struct hidma_chan_attr *chattr;
> +       struct hidma_mgmt_dev *mdev;
> +
> +       buf[0] = 0;
> +       chattr =  container_of(attr, struct hidma_chan_attr, attr);
> +       mdev =  chattr->mdev;
> +       if (strcmp(attr->attr.name, "priority") == 0) {
> +               sprintf(buf, "%d\n", mdev->priority[chattr->index]);
> +               goto done;
> +       }
> +
> +       if (strcmp(attr->attr.name, "weight") == 0) {
> +               sprintf(buf, "%d\n", mdev->weight[chattr->index]);
> +               goto done;
> +       }
> +
> +done:
> +       return strlen(buf);
> +}
> +
> +static ssize_t set_values_channel(struct kobject *kobj,
> +               struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +       struct hidma_chan_attr *chattr;
> +       struct hidma_mgmt_dev *mdev;
> +       unsigned long tmp;
> +       int rc;
> +
> +       chattr =  container_of(attr, struct hidma_chan_attr, attr);
> +       mdev =  chattr->mdev;
> +
> +       rc = kstrtoul(buf, 0, &tmp);
> +       if (rc)
> +               return rc;
> +
> +       if (strcmp(attr->attr.name, "priority") == 0) {
> +               rc = set_priority(mdev, chattr->index, tmp);
> +               if (rc)
> +                       return rc;
> +               goto done;
> +       }
> +
> +       if (strcmp(attr->attr.name, "weight") == 0) {
> +               rc = set_weight(mdev, chattr->index, tmp);
> +               if (rc)
> +                       return rc;
> +       }
> +done:
> +       return count;
> +}
> +
> +static int create_sysfs_entry(struct hidma_mgmt_dev *dev, char *name, int mode)
> +{
> +       struct device_attribute *attrs;
> +       char *name_copy;
> +
> +       attrs = devm_kmalloc(&dev->pdev->dev,
> +                       sizeof(struct device_attribute), GFP_KERNEL);
> +       if (!attrs)
> +               return -ENOMEM;
> +
> +       name_copy = devm_kstrdup(&dev->pdev->dev, name, GFP_KERNEL);
> +       if (!name_copy)
> +               return -ENOMEM;
> +
> +       attrs->attr.name = name_copy;
> +       attrs->attr.mode = mode;
> +       attrs->show      = show_values;
> +       attrs->store     = set_values;
> +       sysfs_attr_init(&attrs->attr);
> +
> +       return device_create_file(&dev->pdev->dev, attrs);
> +}
> +
> +static int create_sysfs_entry_channel(struct hidma_mgmt_dev *mdev, char *name,
> +                               int mode, int index, struct kobject *parent)
> +{
> +       struct hidma_chan_attr *chattr;
> +       char *name_copy;
> +
> +       chattr = devm_kmalloc(&mdev->pdev->dev, sizeof(*chattr), GFP_KERNEL);
> +       if (!chattr)
> +               return -ENOMEM;
> +
> +       name_copy = devm_kstrdup(&mdev->pdev->dev, name, GFP_KERNEL);
> +       if (!name_copy)
> +               return -ENOMEM;
> +
> +       chattr->mdev = mdev;
> +       chattr->index = index;
> +       chattr->attr.attr.name = name_copy;
> +       chattr->attr.attr.mode = mode;
> +       chattr->attr.show = show_values_channel;
> +       chattr->attr.store = set_values_channel;
> +       sysfs_attr_init(&chattr->attr.attr);
> +
> +       return sysfs_create_file(parent, &chattr->attr.attr);
> +}
> +
> +int hidma_mgmt_init_sys(struct hidma_mgmt_dev *mdev)
> +{
> +       unsigned int i;
> +       int rc;
> +       int required;
> +
> +       required = sizeof(*mdev->chroots) * mdev->dma_channels;
> +       mdev->chroots = devm_kmalloc(&mdev->pdev->dev, required, GFP_KERNEL);
> +       if (!mdev->chroots)
> +               return -ENOMEM;
> +
> +       /* create each channel directory here */
> +       for (i = 0; i < mdev->dma_channels; i++) {
> +               char name[10];
> +
> +               snprintf(name, sizeof(name), "chan%d", i);
> +               mdev->chroots[i] = kobject_create_and_add(name,
> +                                               &mdev->pdev->dev.kobj);
> +               if (!mdev->chroots[i])
> +                       return -ENOMEM;
> +       }
> +
> +       /* populate common parameters */
> +       for (i = 0; i < ARRAY_SIZE(hidma_mgmt_files); i++) {
> +               rc = create_sysfs_entry(mdev, hidma_mgmt_files[i].name,
> +                                       hidma_mgmt_files[i].mode);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       /* populate parameters that are per channel */
> +       for (i = 0; i < mdev->dma_channels; i++) {
> +               rc = create_sysfs_entry_channel(mdev, "priority",
> +                               (S_IRUGO|S_IWUGO), i, mdev->chroots[i]);
> +               if (rc)
> +                       return rc;
> +
> +               rc = create_sysfs_entry_channel(mdev, "weight",
> +                               (S_IRUGO|S_IWUGO), i, mdev->chroots[i]);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(hidma_mgmt_init_sys);
> --
> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
