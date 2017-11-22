From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Nov 2017 11:58:28 -0700
Subject: [PATCH v2 1/4] coresight: Support panic dump functionality
In-Reply-To: <1511233724-11867-2-git-send-email-leo.yan@linaro.org>
References: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
 <1511233724-11867-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20171122185828.GA17705@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 11:08:41AM +0800, Leo Yan wrote:
> After kernel panic happens, coresight has many useful info can be used
> for analysis.  For example, the trace info from ETB RAM can be used to
> check the CPU execution flows before crash.  So we can save the tracing
> data from sink devices, and rely on kdump to extract them from vmcore
> file.
> 
> This patch is to add a simple framework to support panic dump
> functionality; it registers panic notifier, and provide the general APIs
> {coresight_dump_add|coresight_dump_del} as helper functions so any
> coresight device can add itself into dump list or delete as needed;
> these two functions can be used when coresight device registration or
> unregistration.
> 
> At late initcall phase and kernel panic happens, the notifier iterates
> dump list and calls callback function to dump device specific info.  The
> late initcall is mainly used to dump device meta data due there have
> per-CPU data so cannot wait to dump until panic happen due the panic CPU
> might cannot handle IPI anymore.  The panic dump is mainly used to dump
> trace data so we can get to know the execution flow before the panic
> happens.  This driver provides helper function coresight_dump_update()
> to update the dump buffer info.

Hi Leo,

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/hwtracing/coresight/Kconfig                |   9 +
>  drivers/hwtracing/coresight/Makefile               |   1 +
>  drivers/hwtracing/coresight/coresight-panic-dump.c | 211 +++++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-priv.h       |  17 ++
>  include/linux/coresight.h                          |   7 +
>  5 files changed, 245 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-panic-dump.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ef9cb3c..6745a43 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -103,4 +103,13 @@ config CORESIGHT_CPU_DEBUG
>  	  properly, please refer Documentation/trace/coresight-cpu-debug.txt
>  	  for detailed description and the example for usage.
>  
> +config CORESIGHT_PANIC_DUMP
> +	bool "CoreSight Panic Dump driver"
> +	depends on ARM || ARM64
> +	help
> +	  This driver provides panic dump functionality for CoreSight
> +	  devices.  When a kernel panic happen a device supplied callback function
> +	  is used to save trace data to memory. From there we rely on kdump to extract
> +	  the trace data from kernel dump file.
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 5bae90ce..04dd600 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
>  obj-$(CONFIG_CORESIGHT_DYNAMIC_REPLICATOR) += coresight-dynamic-replicator.o
>  obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
>  obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
> +obj-$(CONFIG_CORESIGHT_PANIC_DUMP) += coresight-panic-dump.o
> diff --git a/drivers/hwtracing/coresight/coresight-panic-dump.c b/drivers/hwtracing/coresight/coresight-panic-dump.c
> new file mode 100644
> index 0000000..966336a
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-panic-dump.c
> @@ -0,0 +1,211 @@
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
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/perf_event.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "coresight-priv.h"
> +
> +typedef void (*coresight_cb_t)(void *data);
> +
> +/**
> + * struct coresight_dump_node - Node information for dump
> + * @cpu:	The cpu this node is affined to.
> + * @type:	Dump type for pre or post panic dump.
> + * @csdev:	Handler for coresight device.
> + * @buf:	Pointer for dump buffer.
> + * @buf_size:	Length of dump buffer.
> + * @list:	Hook to the list.
> + */
> +struct coresight_dump_node {
> +	int cpu;
> +	int type;
> +	struct coresight_device *csdev;
> +	char *buf;
> +	unsigned int buf_size;
> +	struct list_head list;
> +};
> +
> +static DEFINE_MUTEX(coresight_dump_lock);
> +static LIST_HEAD(coresight_dump_list);
> +static struct notifier_block coresight_dump_nb;
> +
> +static coresight_cb_t
> +coresight_dump_get_cb(struct coresight_device *csdev)
> +{
> +	coresight_cb_t cb = NULL;
> +
> +	switch (csdev->type) {
> +	case CORESIGHT_DEV_TYPE_SINK:
> +	case CORESIGHT_DEV_TYPE_LINKSINK:
> +		cb = sink_ops(csdev)->panic_cb;
> +		break;
> +	case CORESIGHT_DEV_TYPE_SOURCE:
> +		cb = source_ops(csdev)->panic_cb;
> +		break;
> +	case CORESIGHT_DEV_TYPE_LINK:
> +		cb = link_ops(csdev)->panic_cb;
> +		break;
> +	default:
> +		dev_info(&csdev->dev, "Unsupport panic dump\n");
> +		break;
> +	}
> +
> +	return cb;
> +}
> +
> +/**
> + * coresight_dump - Invoke dump callbacks, this is the main function
> + * to fulfill the panic dump.  It distinguishs to two types: one is
> + * pre panic dump so it need send IPI to ask CPUs to dump CPU
> + * dedicated info, this is mainly used to dump meta data; another is
> + * post panic dump so directly invoke callback on alive CPU.
> + *
> + * @dump_type:	Dump type for pre/post panic
> + *
> + * Returns: 0 on success.
> + */
> +static int coresight_dump(unsigned int dump_type)
> +{
> +	struct coresight_dump_node *node;
> +	struct coresight_device *csdev;
> +	coresight_cb_t cb;
> +
> +	mutex_lock(&coresight_dump_lock);
> +
> +	list_for_each_entry(node, &coresight_dump_list, list) {
> +		csdev = node->csdev;
> +
> +		if (node->type != dump_type)
> +			continue;
> +
> +		dev_info(&csdev->dev, "Invoke panic dump...\n");
> +
> +		cb = coresight_dump_get_cb(csdev);
> +		if (node->type == CORESIGHT_DUMP_TYPE_PRE_PANIC)
> +			smp_call_function_single(node->cpu, cb, csdev, 1);
> +		else
> +			cb(csdev);
> +	}
> +
> +	mutex_unlock(&coresight_dump_lock);
> +	return 0;
> +}
> +
> +int coresight_dump_update(struct coresight_device *csdev, char *buf,
> +			  unsigned int buf_size)
> +{
> +	struct coresight_dump_node *node = csdev->dump_node;
> +
> +	if (!node) {
> +		dev_err(&csdev->dev, "Failed to update dump node.\n");
> +		return -EINVAL;
> +	}
> +
> +	node->buf = buf;
> +	node->buf_size = buf_size;

How and where does this buffer get communicated to the kdump mechanic?

> +	return 0;
> +}
> +
> +int coresight_dump_add(struct coresight_device *csdev, int cpu)
> +{
> +	struct coresight_dump_node *node;
> +	coresight_cb_t cb;
> +	unsigned int type;

Filter on source or sink here, return for anything else.  That way we don't need
to clog the link structure with a callpack function that will never be used.
Doing so make sure we properly deal with the LINK_SINK type (based how I did
things in coresight.c it *may* be OK).  

> +
> +	/* Bail out when callback is NULL */
> +	cb = coresight_dump_get_cb(csdev);
> +	if (!cb)
> +		return 0;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Since source devices are used to save meta data, these devices
> +	 * usually are per-CPU device and after panic happen there has risk
> +	 * for the panic CPU cannot handle IPI and dump log anymore; so
> +	 * register these devices as PRE_PANIC type and their callback are
> +	 * called at late_initcall phase.
> +	 */
> +	type = (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) ?
> +		CORESIGHT_DUMP_TYPE_PRE_PANIC :
> +		CORESIGHT_DUMP_TYPE_PANIC;
> +
> +	csdev->dump_node = (void *)node;
> +	node->cpu = cpu;
> +	node->type = type;
> +	node->csdev = csdev;
> +
> +	mutex_lock(&coresight_dump_lock);
> +	list_add_tail(&node->list, &coresight_dump_list);
> +	mutex_unlock(&coresight_dump_lock);
> +	return 0;
> +}
> +
> +void coresight_dump_del(struct coresight_device *csdev)
> +{
> +	struct coresight_dump_node *node;
> +	coresight_cb_t cb;
> +
> +	/* Bail out when callback is NULL */
> +	cb = coresight_dump_get_cb(csdev);
> +	if (!cb)
> +		return;
> +
> +	mutex_lock(&coresight_dump_lock);
> +	list_for_each_entry(node, &coresight_dump_list, list) {

list_for_each_entry_safe()

> +		if (node->csdev == csdev) {
> +			list_del(&node->list);
> +			kfree(node);

Just add a 'break' here and remove the error message as it serves little
purpose.

> +			mutex_unlock(&coresight_dump_lock);
> +			return;
> +		}
> +	}
> +	mutex_unlock(&coresight_dump_lock);
> +
> +	dev_err(&csdev->dev, "Failed to find dump node.\n");
> +}

Addition and delition should be done when a session start and ends, so that
only the devices involved in this session are taken into account by the dump
mechanic.  Speaking of which, would it make sense to replace all the
coresight_dump_xyz() with coresight_kdump_xyz()?

> +
> +static int coresight_dump_notify(struct notifier_block *nb,
> +				 unsigned long mode, void *_unused)
> +{
> +	return coresight_dump(CORESIGHT_DUMP_TYPE_PANIC);
> +}
> +
> +static int __init coresight_dump_init(void)
> +{
> +	int ret;
> +
> +	coresight_dump_nb.notifier_call = coresight_dump_notify;
> +	ret = atomic_notifier_chain_register(&panic_notifier_list,
> +					     &coresight_dump_nb);
> +	if (ret)
> +		return ret;
> +
> +	return coresight_dump(CORESIGHT_DUMP_TYPE_PRE_PANIC);

I'm not sure why we need to dump the information at boot time.  All this work
has to be done when a panic happens.  That would also give us the advantage of
not having to carry a 'type'.

> +}
> +late_initcall(coresight_dump_init);
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f1d0e21d..f268dbc 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -151,4 +151,21 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
>  static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
>  #endif
>  
> +#define CORESIGHT_DUMP_TYPE_PRE_PANIC	0
> +#define CORESIGHT_DUMP_TYPE_PANIC	1
> +
> +#ifdef CONFIG_CORESIGHT_PANIC_DUMP
> +extern int coresight_dump_add(struct coresight_device *csdev, int cpu);
> +extern void coresight_dump_del(struct coresight_device *csdev);
> +extern int coresight_dump_update(struct coresight_device *csdev,
> +				 char *buf, unsigned int buf_size);
> +#else
> +static inline int coresight_dump_add(struct coresight_device *csdev, int cpu)
> +{ return 0; }

static inline int
coresight_dump_add(struct coresight_device *csdev, int cpu) { return 0; }

> +static inline void coresight_dump_del(struct coresight_device *csdev)
> +{ return; }

static inline void coresight_dump_del(struct coresight_device *csdev) {}

> +extern int coresight_dump_update(struct coresight_device *csdev,
> +				 char *buf, unsigned int buf_size);
> +#endif
> +
>  #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index d950dad..43e40fa 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -171,6 +171,7 @@ struct coresight_device {
>  	bool orphan;
>  	bool enable;	/* true only if configured as part of a path */
>  	bool activated;	/* true only if a sink is part of a path */
> +	void *dump_node;
>  };
>  
>  #define to_coresight_device(d) container_of(d, struct coresight_device, dev)
> @@ -189,6 +190,7 @@ struct coresight_device {
>   * @set_buffer:		initialises buffer mechanic before a trace session.
>   * @reset_buffer:	finalises buffer mechanic after a trace session.
>   * @update_buffer:	update buffer pointers after a trace session.
> + * @panic_cb:		hook function for panic notifier.
>   */
>  struct coresight_ops_sink {
>  	int (*enable)(struct coresight_device *csdev, u32 mode);
> @@ -205,6 +207,7 @@ struct coresight_ops_sink {
>  	void (*update_buffer)(struct coresight_device *csdev,
>  			      struct perf_output_handle *handle,
>  			      void *sink_config);
> +	void (*panic_cb)(void *data);
>  };
>  
>  /**
> @@ -212,10 +215,12 @@ struct coresight_ops_sink {
>   * Operations available for links.
>   * @enable:	enables flow between iport and oport.
>   * @disable:	disables flow between iport and oport.
> + * @panic_cb:	hook function for panic notifier.
>   */
>  struct coresight_ops_link {
>  	int (*enable)(struct coresight_device *csdev, int iport, int oport);
>  	void (*disable)(struct coresight_device *csdev, int iport, int oport);
> +	void (*panic_cb)(void *data);
>  };
>  
>  /**
> @@ -227,6 +232,7 @@ struct coresight_ops_link {
>   *		to the HW.
>   * @enable:	enables tracing for a source.
>   * @disable:	disables tracing for a source.
> + * @panic_cb:	hook function for panic notifier.
>   */
>  struct coresight_ops_source {
>  	int (*cpu_id)(struct coresight_device *csdev);
> @@ -235,6 +241,7 @@ struct coresight_ops_source {
>  		      struct perf_event *event,  u32 mode);
>  	void (*disable)(struct coresight_device *csdev,
>  			struct perf_event *event);
> +	void (*panic_cb)(void *data);
>  };
>  
>  struct coresight_ops {
> -- 
> 2.7.4
> 
