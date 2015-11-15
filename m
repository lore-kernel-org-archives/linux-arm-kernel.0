From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 Nov 2015 15:22:57 -0500
Subject: [PATCH V4 2/4] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <CAHp75VddB0ZjL82ftaJODjTy5w3SmnYhn3YW2Q2POBqJ2bWZsQ@mail.gmail.com>
References: <1447310481-25463-1-git-send-email-okaya@codeaurora.org>
 <1447310481-25463-3-git-send-email-okaya@codeaurora.org>
 <CAHp75VddB0ZjL82ftaJODjTy5w3SmnYhn3YW2Q2POBqJ2bWZsQ@mail.gmail.com>
Message-ID: <5648E9A1.40708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2015 4:53 AM, Andy Shevchenko wrote:
> On Thu, Nov 12, 2015 at 8:41 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The Qualcomm Technologies HIDMA device has been designed
>> to support virtualization technology. The driver has been
>> divided into two to follow the hardware design.
>>
>> 1. HIDMA Management driver
>> 2. HIDMA Channel driver
>>
>> Each HIDMA HW consists of multiple channels. These channels
>> share some set of common parameters. These parameters are
>> initialized by the management driver during power up.
>> Same management driver is used for monitoring the execution
>> of the channels. Management driver can change the performance
>> behavior dynamically such as bandwidth allocation and
>> prioritization.
>>
>> The management driver is executed in hypervisor context and
>> is the main management entity for all channels provided by
>> the device.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++++
>>  drivers/dma/qcom/Kconfig                           |  11 +
>>  drivers/dma/qcom/Makefile                          |   1 +
>>  drivers/dma/qcom/hidma_mgmt.c                      | 312 +++++++++++++++++++++
>>  drivers/dma/qcom/hidma_mgmt.h                      |  38 +++
>>  drivers/dma/qcom/hidma_mgmt_sys.c                  | 231 +++++++++++++++
>>  6 files changed, 654 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
>>  create mode 100644 drivers/dma/qcom/hidma_mgmt.c
>>  create mode 100644 drivers/dma/qcom/hidma_mgmt.h
>>  create mode 100644 drivers/dma/qcom/hidma_mgmt_sys.c
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
>> new file mode 100644
>> index 0000000..eb053b9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
>> @@ -0,0 +1,61 @@
>> +Qualcomm Technologies HIDMA Management interface
>> +
>> +The Qualcomm Technologies HIDMA device has been designed
>> +to support virtualization technology. The driver has been
>> +divided into two to follow the hardware design. The management
>> +driver is executed in hypervisor context and is the main
>> +management entity for all channels provided by the device.
>> +
>> +Each HIDMA HW consists of multiple channels. These channels
>> +share some set of common parameters. These parameters are
>> +initialized by the management driver during power up.
>> +Same management driver is used for monitoring the execution
>> +of the channels. Management driver can change the performance
>> +behavior dynamically such as bandwidth allocation and
>> +prioritization.
>> +
>> +All channel devices get probed in the hypervisor
>> +context during power up. They show up as DMA engine
>> +DMA channels. Then, before starting the virtualization; each
>> +channel device is unbound from the hypervisor by VFIO
>> +and assign to the guest machine for control.
>> +
>> +This management driver will  be used by the system
>> +admin to monitor/reset the execution state of the DMA
>> +channels. This will be the management interface.
>> +
>> +
>> +Required properties:
>> +- compatible: "qcom,hidma-mgmt-1.0";
>> +- reg: Address range for DMA device
>> +- dma-channels: Number of channels supported by this DMA controller.
>> +- max-write-burst-bytes: Maximum write burst in bytes. A memcpy requested is
>> +  fragmented to multiples of this amount.
>> +- max-read-burst-bytes: Maximum read burst in bytes. A memcpy request is
>> +  fragmented to multiples of this amount.
>> +- max-write-transactions: Maximum write transactions to perform in a burst
>> +- max-read-transactions: Maximum read transactions to perform in a burst
>> +- channel-reset-timeout-cycles: Channel reset timeout in cycles for this SOC.
>> +- channel-priority: Priority of the channel.
>> +  Each dma channel share the same HW bandwidth with other dma channels.
>> +  If two requests reach to the HW at the same time from a low priority and
>> +  high priority channel, high priority channel will claim the bus.
>> +  0=low priority, 1=high priority
>> +- channel-weight: Round robin weight of the channel
>> +  Since there are only two priority levels supported, scheduling among
>> +  the equal priority channels is done via weights.
>> +
>> +Example:
>> +
>> +       hidma-mgmt at f9984000 = {
>> +               compatible = "qcom,hidma-mgmt-1.0";
>> +               reg = <0xf9984000 0x15000>;
>> +               dma-channels = 6;
>> +               max-write-burst-bytes = 1024;
>> +               max-read-burst-bytes = 1024;
>> +               max-write-transactions = 31;
>> +               max-read-transactions = 31;
>> +               channel-reset-timeout-cycles = 0x500;
>> +               channel-priority = < 1 1 0 0 0 0>;
>> +               channel-weight = < 1 13 10 3 4 5>;
>> +       };
>> diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
>> index 17545df..f3e2d4c 100644
>> --- a/drivers/dma/qcom/Kconfig
>> +++ b/drivers/dma/qcom/Kconfig
>> @@ -7,3 +7,14 @@ config QCOM_BAM_DMA
>>           Enable support for the QCOM BAM DMA controller.  This controller
>>           provides DMA capabilities for a variety of on-chip devices.
>>
>> +config QCOM_HIDMA_MGMT
>> +       tristate "Qualcomm Technologies HIDMA Management support"
>> +       select DMA_ENGINE
>> +       help
>> +         Enable support for the Qualcomm Technologies HIDMA Management.
>> +         Each DMA device requires one management interface driver
>> +         for basic initialization before QCOM_HIDMA channel driver can
>> +         start managing the channels. In a virtualized environment,
>> +         the guest OS would run QCOM_HIDMA channel driver and the
>> +         hypervisor would run the QCOM_HIDMA_MGMT management driver.
>> +
>> diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
>> index f612ae3..1a5a96d 100644
>> --- a/drivers/dma/qcom/Makefile
>> +++ b/drivers/dma/qcom/Makefile
>> @@ -1 +1,2 @@
>>  obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
>> +obj-$(CONFIG_QCOM_HIDMA_MGMT) += hidma_mgmt.o hidma_mgmt_sys.o
>> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
>> new file mode 100644
>> index 0000000..8c3d059
>> --- /dev/null
>> +++ b/drivers/dma/qcom/hidma_mgmt.c
>> @@ -0,0 +1,312 @@
>> +/*
>> + * Qualcomm Technologies HIDMA DMA engine Management interface
>> + *
>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/dmaengine.h>
>> +#include <linux/acpi.h>
>> +#include <linux/of.h>
>> +#include <linux/property.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/slab.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +#include "hidma_mgmt.h"
>> +
>> +#define QOS_N_OFFSET                   0x300
>> +#define CFG_OFFSET                     0x400
>> +#define MAX_BUS_REQ_LEN_OFFSET         0x41C
>> +#define MAX_XACTIONS_OFFSET            0x420
>> +#define HW_VERSION_OFFSET              0x424
>> +#define CHRESET_TIMEOUT_OFFSET         0x418
>> +
>> +#define MAX_WR_XACTIONS_MASK           0x1F
>> +#define MAX_RD_XACTIONS_MASK           0x1F
>> +#define WEIGHT_MASK                    0x7F
>> +#define MAX_BUS_REQ_LEN_MASK           0xFFFF
>> +#define CHRESET_TIMEOUUT_MASK          0xFFFFF
>> +
>> +#define MAX_WR_XACTIONS_BIT_POS        16
>> +#define MAX_BUS_WR_REQ_BIT_POS         16
>> +#define WRR_BIT_POS                    8
>> +#define PRIORITY_BIT_POS               15
>> +
>> +#define AUTOSUSPEND_TIMEOUT            2000
>> +#define MAX_CHANNEL_WEIGHT             15
>> +
>> +int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
>> +{
>> +       unsigned int i;
>> +       u32 val;
>> +
>> +       if (!is_power_of_2(mgmtdev->max_write_request) ||
>> +               (mgmtdev->max_write_request < 128) ||
>> +               (mgmtdev->max_write_request > 1024)) {
>> +               dev_err(&mgmtdev->pdev->dev, "invalid write request %d\n",
>> +                       mgmtdev->max_write_request);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!is_power_of_2(mgmtdev->max_read_request) ||
>> +               (mgmtdev->max_read_request < 128) ||
>> +               (mgmtdev->max_read_request > 1024)) {
>> +               dev_err(&mgmtdev->pdev->dev, "invalid read request %d\n",
>> +                       mgmtdev->max_read_request);
>> +               return  -EINVAL;
>> +       }
>> +
>> +       if (mgmtdev->max_wr_xactions > MAX_WR_XACTIONS_MASK) {
>> +               dev_err(&mgmtdev->pdev->dev,
>> +                       "max_wr_xactions cannot be bigger than %d\n",
>> +                       MAX_WR_XACTIONS_MASK);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (mgmtdev->max_rd_xactions > MAX_RD_XACTIONS_MASK) {
>> +               dev_err(&mgmtdev->pdev->dev,
>> +                       "max_rd_xactions cannot be bigger than %d\n",
>> +                       MAX_RD_XACTIONS_MASK);
>> +               return -EINVAL;
>> +       }
>> +
>> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
>> +               if (mgmtdev->priority[i] > 1) {
>> +                       dev_err(&mgmtdev->pdev->dev, "priority can be 0 or 1\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               if (mgmtdev->weight[i] > MAX_CHANNEL_WEIGHT) {
>> +                       dev_err(&mgmtdev->pdev->dev,
>> +                               "max value of weight can be %d.\n",
>> +                               MAX_CHANNEL_WEIGHT);
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* weight needs to be at least one */
>> +               if (mgmtdev->weight[i] == 0)
>> +                       mgmtdev->weight[i] = 1;
>> +       }
>> +
>> +       pm_runtime_get_sync(&mgmtdev->pdev->dev);
>> +       val = readl(mgmtdev->dev_virtaddr + MAX_BUS_REQ_LEN_OFFSET);
>> +       val &= ~(MAX_BUS_REQ_LEN_MASK << MAX_BUS_WR_REQ_BIT_POS);
>> +       val |= (mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS);
>> +       val &= ~(MAX_BUS_REQ_LEN_MASK);
>> +       val |= (mgmtdev->max_read_request);
>> +       writel(val, mgmtdev->dev_virtaddr + MAX_BUS_REQ_LEN_OFFSET);
>> +
>> +       val = readl(mgmtdev->dev_virtaddr + MAX_XACTIONS_OFFSET);
>> +       val &= ~(MAX_WR_XACTIONS_MASK << MAX_WR_XACTIONS_BIT_POS);
>> +       val |= (mgmtdev->max_wr_xactions << MAX_WR_XACTIONS_BIT_POS);
>> +       val &= ~(MAX_RD_XACTIONS_MASK);
>> +       val |= (mgmtdev->max_rd_xactions);
>> +       writel(val, mgmtdev->dev_virtaddr + MAX_XACTIONS_OFFSET);
>> +
>> +       mgmtdev->hw_version = readl(mgmtdev->dev_virtaddr + HW_VERSION_OFFSET);
>> +       mgmtdev->hw_version_major = (mgmtdev->hw_version >> 28) & 0xF;
>> +       mgmtdev->hw_version_minor = (mgmtdev->hw_version >> 16) & 0xF;
>> +
>> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
>> +               val = readl(mgmtdev->dev_virtaddr + QOS_N_OFFSET + (4 * i));
>> +               val &= ~(1 << PRIORITY_BIT_POS);
>> +               val |= ((mgmtdev->priority[i] & 0x1) << PRIORITY_BIT_POS);
>> +               val &= ~(WEIGHT_MASK << WRR_BIT_POS);
>> +               val |= ((mgmtdev->weight[i] & WEIGHT_MASK) << WRR_BIT_POS);
>> +               writel(val, mgmtdev->dev_virtaddr + QOS_N_OFFSET + (4 * i));
>> +       }
>> +
>> +       val = readl(mgmtdev->dev_virtaddr + CHRESET_TIMEOUT_OFFSET);
>> +       val &= ~CHRESET_TIMEOUUT_MASK;
>> +       val |= (mgmtdev->chreset_timeout_cycles & CHRESET_TIMEOUUT_MASK);
>> +       writel(val, mgmtdev->dev_virtaddr + CHRESET_TIMEOUT_OFFSET);
>> +
>> +       pm_runtime_mark_last_busy(&mgmtdev->pdev->dev);
>> +       pm_runtime_put_autosuspend(&mgmtdev->pdev->dev);
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(hidma_mgmt_setup);
>> +
>> +static int hidma_mgmt_probe(struct platform_device *pdev)
>> +{
>> +       struct hidma_mgmt_dev *mgmtdev;
>> +       struct resource *dma_resource;
> 
> Just a nitpick (seems you like verbose names for variables): since
> it's probe and you usually use the variable in a small scope no need
> to prefix it. And you might reuse same variable later if needed.

I'll take a look...

I like to be able to read the code in plain English and understand what
a variable does rather than using 3 or 4 letter acronyms and guessing
its meaning.

> 
>> +       void *dev_virtaddr;
>> +       int irq;
>> +       int rc;
>> +       u32 val;
>> +
>> +       pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>> +       pm_runtime_use_autosuspend(&pdev->dev);
>> +       pm_runtime_set_active(&pdev->dev);
>> +       pm_runtime_enable(&pdev->dev);
>> +       pm_runtime_get_sync(&pdev->dev);
>> +       dma_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
> 
>> +       if (!dma_resource) {
>> +               dev_err(&pdev->dev, "No memory resources found\n");
>> +               rc = -ENODEV;
>> +               goto out;
>> +       }
> 
> You forget to remove above piece.

done

> 
>> +       dev_virtaddr = devm_ioremap_resource(&pdev->dev, dma_resource);
>> +       if (IS_ERR(dev_virtaddr)) {
>> +               dev_err(&pdev->dev, "can't map i/o memory\n");
> 
> This message is redundant. There is already one in core.
> 
OK
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>> +               dev_err(&pdev->dev, "irq resources not found\n");
>> +               rc = -ENODEV;
> 
> rc = irq; ?

OK

> 
>> +               goto out;
>> +       }
>> +
>> +       mgmtdev = devm_kzalloc(&pdev->dev, sizeof(*mgmtdev), GFP_KERNEL);
>> +       if (!mgmtdev) {
>> +               rc = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       mgmtdev->pdev = pdev;
>> +
>> +       mgmtdev->dev_addrsize = resource_size(dma_resource);
>> +       mgmtdev->dev_virtaddr = dev_virtaddr;
>> +
>> +       if (device_property_read_u32(&pdev->dev, "dma-channels",
>> +               &mgmtdev->dma_channels)) {
>> +               dev_err(&pdev->dev, "number of channels missing\n");
>> +               rc = -EINVAL;
> 
> Ditto, propagate error code. And below the similar.

OK

> 
>> +               goto out;
>> +       }
>> +


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
