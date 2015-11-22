From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 22 Nov 2015 19:14:34 +0200
Subject: [PATCH V6 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1448210257-4768-3-git-send-email-okaya@codeaurora.org>
References: <1448210257-4768-1-git-send-email-okaya@codeaurora.org>
 <1448210257-4768-3-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75Vc72HLbNdPKXzm=RqsFZS1cmAVuH3Nd6yO+TJidLeuExg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 22, 2015 at 6:37 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
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

> +What:          /sys/devices/platform/hidma-mgmt*/channel*_weight
> +               /sys/devices/platform/QCOM8060:*/channel*__weight

Extra _ ?


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

Hmm? Can lines be longer up to 76-78 characters?

> +#define MAX_WR_XACTIONS_MASK           0x1F
> +#define MAX_RD_XACTIONS_MASK           0x1F
> +#define WEIGHT_MASK                    0x7F
> +#define MAX_BUS_REQ_LEN_MASK           0xFFFF
> +#define CHRESET_TIMEOUUT_MASK          0xFFFFF

GENMASK?

> +int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
> +{
> +       unsigned int i;
> +       u32 val;
> +
> +       if (!is_power_of_2(mgmtdev->max_write_request) ||
> +               (mgmtdev->max_write_request < 128) ||

Someone likes parens.
I might agree with these cases, but below in assignments and combined
operations the parens are indeed redundant.

> +               (mgmtdev->max_write_request > 1024)) {
> +               dev_err(&mgmtdev->pdev->dev, "invalid write request %d\n",
> +                       mgmtdev->max_write_request);
> +               return -EINVAL;
> +       }
> +
> +       if (!is_power_of_2(mgmtdev->max_read_request) ||
> +               (mgmtdev->max_read_request < 128) ||
> +               (mgmtdev->max_read_request > 1024)) {

Ditto.

> +               dev_err(&mgmtdev->pdev->dev, "invalid read request %d\n",
> +                       mgmtdev->max_read_request);
> +               return  -EINVAL;
> +       }
> +
> +       if (mgmtdev->max_wr_xactions > MAX_WR_XACTIONS_MASK) {
> +               dev_err(&mgmtdev->pdev->dev,
> +                       "max_wr_xactions cannot be bigger than %d\n",
> +                       MAX_WR_XACTIONS_MASK);
> +               return -EINVAL;
> +       }
> +
> +       if (mgmtdev->max_rd_xactions > MAX_RD_XACTIONS_MASK) {
> +               dev_err(&mgmtdev->pdev->dev,
> +                       "max_rd_xactions cannot be bigger than %d\n",
> +                       MAX_RD_XACTIONS_MASK);
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
> +               if (mgmtdev->priority[i] > 1) {
> +                       dev_err(&mgmtdev->pdev->dev, "priority can be 0 or 1\n");
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

> +       val |= (mgmtdev->max_write_request << MAX_BUS_WR_REQ_BIT_POS);

Ditto.

> +       val &= ~(MAX_BUS_REQ_LEN_MASK);

Ditto.

> +       val |= (mgmtdev->max_read_request);

Ditto.

> +       writel(val, mgmtdev->virtaddr + MAX_BUS_REQ_LEN_OFFSET);
> +
> +       val = readl(mgmtdev->virtaddr + MAX_XACTIONS_OFFSET);
> +       val &= ~(MAX_WR_XACTIONS_MASK << MAX_WR_XACTIONS_BIT_POS);

> +       val |= (mgmtdev->max_wr_xactions << MAX_WR_XACTIONS_BIT_POS);
> +       val &= ~(MAX_RD_XACTIONS_MASK);
> +       val |= (mgmtdev->max_rd_xactions);

Ditto for all 3 above.

> +       writel(val, mgmtdev->virtaddr + MAX_XACTIONS_OFFSET);
> +
> +       mgmtdev->hw_version = readl(mgmtdev->virtaddr + HW_VERSION_OFFSET);
> +       mgmtdev->hw_version_major = (mgmtdev->hw_version >> 28) & 0xF;
> +       mgmtdev->hw_version_minor = (mgmtdev->hw_version >> 16) & 0xF;
> +
> +       for (i = 0; i < mgmtdev->dma_channels; i++) {
> +               val = readl(mgmtdev->virtaddr + QOS_N_OFFSET + (4 * i));

Ditto.

> +               val &= ~(1 << PRIORITY_BIT_POS);
> +               val |= ((mgmtdev->priority[i] & 0x1) << PRIORITY_BIT_POS);
> +               val &= ~(WEIGHT_MASK << WRR_BIT_POS);
> +               val |= ((mgmtdev->weight[i] & WEIGHT_MASK) << WRR_BIT_POS);
> +               writel(val, mgmtdev->virtaddr + QOS_N_OFFSET + (4 * i));

Ditto.

> +       }
> +
> +       val = readl(mgmtdev->virtaddr + CHRESET_TIMEOUT_OFFSET);
> +       val &= ~CHRESET_TIMEOUUT_MASK;

Look here, you use it like it intuitively feels.

> +       val |= (mgmtdev->chreset_timeout_cycles & CHRESET_TIMEOUUT_MASK);

But here?

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

+empty line

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
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_sync_suspend(&pdev->dev);

I'm not sure the sequence is logically correct, though it might work.

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
> index 0000000..04340ff
> --- /dev/null
> +++ b/drivers/dma/qcom/hidma_mgmt.h
> @@ -0,0 +1,38 @@
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
> +       struct platform_device *pdev;
> +};
> +
> +int hidma_mgmt_init_sys(struct hidma_mgmt_dev *dev);
> +int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev);
> diff --git a/drivers/dma/qcom/hidma_mgmt_sys.c b/drivers/dma/qcom/hidma_mgmt_sys.c
> new file mode 100644
> index 0000000..70d324e
> --- /dev/null
> +++ b/drivers/dma/qcom/hidma_mgmt_sys.c
> @@ -0,0 +1,231 @@
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
> +struct fileinfo {
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
> +static struct fileinfo files[] = {

Perhaps hidma_mgmt_files ?

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
> +       for (i = 0; i < ARRAY_SIZE(files); i++) {
> +               if (strcmp(attr->attr.name, files[i].name) == 0) {
> +                       sprintf(buf, "%d\n", files[i].get(mdev));
> +                       goto done;
> +               }
> +       }
> +
> +       for (i = 0; i < mdev->dma_channels; i++) {
> +               char name[30];
> +
> +               sprintf(name, "channel%d_priority", i);
> +               if (strcmp(attr->attr.name, name) == 0) {
> +                       sprintf(buf, "%d\n", mdev->priority[i]);
> +                       goto done;
> +               }
> +
> +               sprintf(name, "channel%d_weight", i);
> +               if (strcmp(attr->attr.name, name) == 0) {
> +                       sprintf(buf, "%d\n", mdev->weight[i]);
> +                       goto done;
> +               }
> +       }
> +
> +done:
> +       return strlen(buf);

buf might be uninitialized here. Have you got any warning from compiler?

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
> +       for (i = 0; i < ARRAY_SIZE(files); i++) {
> +               if (strcmp(attr->attr.name, files[i].name) == 0) {
> +                       rc = files[i].set(mdev, tmp);
> +                       if (rc)
> +                               return rc;
> +
> +                       goto done;
> +               }
> +       }
> +
> +       for (i = 0; i < mdev->dma_channels; i++) {
> +               char name[30];
> +
> +               sprintf(name, "channel%d_priority", i);
> +               if (strcmp(attr->attr.name, name) == 0) {
> +                       rc = set_priority(mdev, i, tmp);
> +                       if (rc)
> +                               return rc;
> +                       goto done;
> +               }
> +
> +               sprintf(name, "channel%d_weight", i);
> +               if (strcmp(attr->attr.name, name) == 0) {
> +                       rc = set_weight(mdev, i, tmp);
> +                       if (rc)
> +                               return rc;
> +               }
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
> +

Extra empty line.

> +int hidma_mgmt_init_sys(struct hidma_mgmt_dev *dev)
> +{
> +       unsigned int i;
> +       int rc;
> +
> +       for (i = 0; i < ARRAY_SIZE(files); i++) {
> +               rc = create_sysfs_entry(dev, files[i].name, files[i].mode);
> +               if (rc)
> +                       return rc;
> +       }
> +

Can it be like

/sys/?/DEVICExx/
 channelYY/
 attr1
 attr2
 ?

?

I think it will be easier to handle in code and from user. (Similar
way DMAEngine API does for slave DMA devices)

> +       for (i = 0; i < dev->dma_channels; i++) {
> +               char name[30];
> +
> +               sprintf(name, "channel%d_priority", i);
> +               rc = create_sysfs_entry(dev, name, (S_IRUGO|S_IWUGO));
> +               if (rc)
> +                       return rc;
> +
> +               sprintf(name, "channel%d_weight", i);
> +               rc = create_sysfs_entry(dev, name, (S_IRUGO|S_IWUGO));
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(hidma_mgmt_init_sys);

-- 
With Best Regards,
Andy Shevchenko
