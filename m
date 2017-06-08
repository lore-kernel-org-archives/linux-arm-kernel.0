From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 8 Jun 2017 12:13:01 -0600
Subject: [PATCH v1 1/4] coresight: support panic dump functionality
In-Reply-To: <1496500976-18362-2-git-send-email-leo.yan@linaro.org>
References: <1496500976-18362-1-git-send-email-leo.yan@linaro.org>
 <1496500976-18362-2-git-send-email-leo.yan@linaro.org>
Message-ID: <CANLsYkzAe5zvKfgZG4UTQXmXBwxDR8u_9cQhNS_UBx85NKL5AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 June 2017 at 08:42, Leo Yan <leo.yan@linaro.org> wrote:
> After kernel panic happens, coresight has many useful info can be used
> for analysis. For example, the trace info from ETB RAM can be used to
> check the CPU execution flows before crash. So we can save the tracing
> data from sink devices, and rely on kdump to extract them from vmcore
> file.
>
> This patch is to add a simple framework to support panic dump
> functionality; it registers panic notifier, and provide the general APIs
> {coresight_add_panic_cb|coresight_del_panic_cb} as helper functions so
> any coresight device can add itself into dump list or delete as needed;
> usually these two functions can be used when a session is started or
> when it ends. When kernel panic happened, the panic notifier iterates
> dump list and calls every node for the device callback function to dump
> device specific info. Generally all the panic dump specific stuff are
> related to the sinks devices, so this initial version code it only
> supports sink devices.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Hi Leo,

> ---
>  drivers/hwtracing/coresight/Kconfig                |  10 ++
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  drivers/hwtracing/coresight/coresight-panic-dump.c | 130 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-priv.h       |  10 ++
>  include/linux/coresight.h                          |   2 +
>  5 files changed, 153 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-panic-dump.c
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 8d55d6d..8890023 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -103,4 +103,14 @@ config CORESIGHT_CPU_DEBUG
>           properly, please refer Documentation/trace/coresight-cpu-debug.txt
>           for detailed description and the example for usage.
>
> +config CORESIGHT_PANIC_DUMP
> +       bool "CoreSight Panic Dump driver"
> +       depends on ARM || ARM64
> +       depends on CORESIGHT_LINKS_AND_SINKS
> +       help
> +         This driver provides panic dump functionality for coresight
> +         devices; when kernel panic happens, we can use callback functions
> +         to save trace data to memory. Finally can rely on kdump to extract
> +         out these trace data from kernel dump file.

This driver provides panic dump functionality for CoreSight
devices.  When a kernel panic happen a device supplied callback function
is used to save trace data to memory. From there we rely on kdump to extract
the trace data from kernel dump file.



> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 433d590..0ac3216 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>  obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> +obj-$(CONFIG_CORESIGHT_PANIC_DUMP) += coresight-panic-dump.o
> diff --git a/drivers/hwtracing/coresight/coresight-panic-dump.c b/drivers/hwtracing/coresight/coresight-panic-dump.c
> new file mode 100644
> index 0000000..23869ff
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-panic-dump.c
> @@ -0,0 +1,130 @@
> +/*
> + * Copyright(C) 2017 Linaro Limited. All rights reserved.
> + * Author: Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/coresight.h>
> +#include <linux/coresight-pmu.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/init.h>

Alphabetical order if possible.

> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/workqueue.h>
> +
> +static DEFINE_MUTEX(coresight_panic_lock);
> +static struct list_head coresight_panic_list;
> +static struct notifier_block coresight_panic_nb;
> +
> +struct coresight_panic_node {
> +       char *name;

There is no need for another copy of the device name as it is already
available in csdev->dev.

> +       struct coresight_device *csdev;
> +       struct list_head list;
> +};
> +
> +static int coresight_panic_notify(struct notifier_block *nb,
> +                                 unsigned long mode, void *_unused)
> +{
> +       int ret = 0, err;
> +       struct coresight_panic_node *node;
> +       struct coresight_device *csdev;
> +       u32 type;
> +
> +       mutex_lock(&coresight_panic_lock);
> +
> +       list_for_each_entry(node, &coresight_panic_list, list) {
> +               csdev = node->csdev;
> +               type = csdev->type;
> +
> +               dev_info(&csdev->dev, "invoke panic dump...\n");
> +
> +               switch (type) {
> +               case CORESIGHT_DEV_TYPE_SINK:
> +               case CORESIGHT_DEV_TYPE_LINKSINK:
> +                       err = sink_ops(csdev)->panic_cb(csdev);
> +                       if (err)
> +                               ret = err;
> +                       break;
> +               default:
> +                       dev_err(&csdev->dev,
> +                               "Unsupported type for panic dump\n");
> +                       break;
> +               }
> +       }
> +
> +       mutex_unlock(&coresight_panic_lock);
> +       return ret;
> +}

This should be called in coresight_register() if a csdev has a  panic
callback.  I'm backing Suzuki's suggestion of executing the callbacks
only if a device has been enabled.  That way the only thing CS devices
have to do is provide a panic_cb function.

> +
> +int coresight_add_panic_cb(struct coresight_device *csdev)
> +{
> +       struct coresight_panic_node *node;
> +
> +       node = kzalloc(sizeof(struct coresight_panic_node), GFP_KERNEL);

The trend in the kernel is so use "sizeof(*node)"

> +       if (!node)
> +               return -ENOMEM;
> +
> +       node->name = kstrndup(dev_name(&csdev->dev), 16, GFP_KERNEL);
> +       if (!node->name) {
> +               kfree(node);
> +               return -ENOMEM;
> +       }
> +       node->csdev = csdev;
> +
> +       mutex_lock(&coresight_panic_lock);
> +       list_add_tail(&node->list, &coresight_panic_list);
> +       mutex_unlock(&coresight_panic_lock);
> +
> +       return 0;
> +}

Same as above.

> +
> +void coresight_del_panic_cb(struct coresight_device *csdev)
> +{
> +       struct coresight_panic_node *node;
> +
> +       mutex_lock(&coresight_panic_lock);
> +
> +       list_for_each_entry(node, &coresight_panic_list, list) {
> +               if (node->csdev == csdev) {
> +                       list_del(&node->list);
> +                       kfree(node->name);
> +                       kfree(node);
> +                       mutex_unlock(&coresight_panic_lock);
> +                       return;
> +               }
> +       }
> +
> +       dev_err(&csdev->dev, "Failed to find panic node.\n");
> +       mutex_unlock(&coresight_panic_lock);
> +}
> +
> +static int __init coresight_panic_init(void)
> +{

This function should go in function coresight_init().

> +       int ret;
> +
> +       INIT_LIST_HEAD(&coresight_panic_list);
> +
> +       coresight_panic_nb.notifier_call = coresight_panic_notify;
> +       ret = atomic_notifier_chain_register(&panic_notifier_list,
> +                                            &coresight_panic_nb);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +subsys_initcall(coresight_panic_init);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 5f662d8..e6ed3e9 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -122,4 +122,14 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
>  static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
>  #endif
>
> +#ifdef CONFIG_CORESIGHT_PANIC_DUMP
> +extern int coresight_add_panic_cb(struct coresight_device *csdev);
> +extern void coresight_del_panic_cb(struct coresight_device *csdev);
> +#else
> +static inline int coresight_add_panic_cb(struct coresight_device *csdev)
> +{ return 0; }
> +static inline void coresight_del_panic_cb(struct coresight_device *csdev)
> +{ return; }
> +#endif
> +
>  #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d950dad..31fcaeb 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -189,6 +189,7 @@ struct coresight_device {
>   * @set_buffer:                initialises buffer mechanic before a trace session.
>   * @reset_buffer:      finalises buffer mechanic after a trace session.
>   * @update_buffer:     update buffer pointers after a trace session.
> + * @panic_cb:          hooks callback function for panic notifier.

"hook function for panic notifier"

Thanks,
Mathieu

>   */
>  struct coresight_ops_sink {
>         int (*enable)(struct coresight_device *csdev, u32 mode);
> @@ -205,6 +206,7 @@ struct coresight_ops_sink {
>         void (*update_buffer)(struct coresight_device *csdev,
>                               struct perf_output_handle *handle,
>                               void *sink_config);
> +       int (*panic_cb)(struct coresight_device *csdev);
>  };
>
>  /**
> --
> 2.7.4
>
