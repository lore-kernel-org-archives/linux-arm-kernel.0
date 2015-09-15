From: hillf.zj@alibaba-inc.com (Hillf Danton)
Date: Tue, 15 Sep 2015 16:43:12 +0800
Subject: [PATCH 3/3] remoteproc: add CSRatlas7 remoteproc driver
In-Reply-To: <018b01d0ef8e$f8670540$e9350fc0$@alibaba-inc.com>
References: <018b01d0ef8e$f8670540$e9350fc0$@alibaba-inc.com>
Message-ID: <019301d0ef92$8e6f8000$ab4e8000$@alibaba-inc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> In CSRaltas7, Cortex-A7 uses this proc to communicate with Cortex-M3.
> But M3 doesn't have to be a slave, it can boot indenpently or depend
> on Linux to load firmware for it.
> 
> we reserve a memory for data and resource descriptors in DRAM.
> 
> Signed-off-by: Wei Chen <Wei.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  .../bindings/remoteproc/sirf,remoteproc.txt        |  33 ++
>  drivers/remoteproc/Kconfig                         |  13 +
>  drivers/remoteproc/Makefile                        |   1 +
>  drivers/remoteproc/sirf_remoteproc.c               | 467 +++++++++++++++++++++
>  4 files changed, 514 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/sirf,remoteproc.txt
>  create mode 100644 drivers/remoteproc/sirf_remoteproc.c
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/sirf,remoteproc.txt
> b/Documentation/devicetree/bindings/remoteproc/sirf,remoteproc.txt
> new file mode 100644
> index 0000000..409fb40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/sirf,remoteproc.txt

s/,/-/ ?
> @@ -0,0 +1,33 @@
> +SIRF Atlas7 Remote processor Device Binding
> +------------------------------------------------
> +1) Main node
> +	Required properties :
> +
> +	- compatible : "sirf,atlas7-rproc"
> +
> +	- reg : register address of remoteproc device
> +
> +	- interrupts: the irq number this rproc need to handle.
> +
> +	- hwlocks: the hwlocks this rproc to used to protect data

s/to used/uses/ ?
> +	  between two processors.
> +
> +	- memory-region: the memory region, which is used to store virtual
> +	  device info, fifo buffers and share memory between two processors.
> +
> +	- firmware: the firmware file that will be loaded to remote processor.
> +
> +Please refer to ../reserved-memory/reserved-memory.txt for details of the
> +memory-region bindings.
> +Please refer to ../hwlock/hwlock.txt for details of the hwlock bindings.
> +
> +2) Example:
> +			ns_m3_rproc at 0 {
> +				compatible = "sirf,atlas7-rproc";
> +				reg = <0x13240108 0x4>,
> +					<0x13240208 0x4>;
> +				interrupts = <0 123 0>;
> +				hwlocks = <&hwlock 0>, <&hwlock 1>;
> +				memory-region = <&ipc_mem0>;
> +				firmware = "RTOSDemo.bin";
> +			};
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 28c711f..aeabbfa 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -77,4 +77,17 @@ config DA8XX_REMOTEPROC
>  	  It's safe to say n here if you're not interested in multimedia
>  	  offloading.
> 
> +config SIRF_REMOTEPROC
> +	tristate "CSR atals7 remoteproc support"
> +	depends on ARCH_ATLAS7
> +	select REMOTEPROC
> +	select RPMSG
> +	default y
> +	help
> +	  Say y or m here to support CSR Atlas7 Inter-Processors
> +	  Communication driver via remote processor framework.
> +
> +	  This can be either built-in or a loadable module.
> +	  If unsure say N.
> +
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 81b04d1..8cc4790 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_STE_MODEM_RPROC)	 	+= ste_modem_rproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> +obj-$(CONFIG_SIRF_REMOTEPROC)	+= sirf_remoteproc.o
> diff --git a/drivers/remoteproc/sirf_remoteproc.c b/drivers/remoteproc/sirf_remoteproc.c
> new file mode 100644
> index 0000000..cb7568d
> --- /dev/null
> +++ b/drivers/remoteproc/sirf_remoteproc.c
> @@ -0,0 +1,467 @@
> +/*
> + * SIRF Remote processor machine-specific module
> + *
> + * Copyright (c) 2014 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/hwspinlock.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_device.h>
> +#include <linux/remoteproc.h>
> +
> +#include "remoteproc_internal.h"
> +
> +struct fifo_buffer {
> +	struct hwspinlock *lock;
> +	unsigned char *buffer;
> +	u32 w_pos;
> +	u32 r_pos;
> +	u32 size;
> +	u32 *count; /* pointer to shared memory */
> +};
> +
> +static int fifo_write(struct fifo_buffer *fifo,
> +		const void *data, u32 len)
> +{
> +	int err;
> +	u32 overflow, count;
> +	ulong flags;
> +
> +	err = hwspin_lock_timeout_irqsave(fifo->lock, 100, &flags);
> +	if (err) {
> +		pr_err("%s, Get hwspinlock failed!err= %d\n",
> +			__func__, err);

s/,// ?
s/!err=/! err/ ?
> +		WARN_ON(err);

Given pr_err, add a comment for WARN_ON please if it
is really needed.
> +		return -EBUSY;
> +	}
> +
> +	if (len > fifo->size) {
> +		err = -EFBIG;

release fifo->lock ?
> +		goto err_exit;
> +	}
> +
> +	count = *fifo->count;
> +	overflow = len > (fifo->size - count);
> +	if (overflow) {
> +		/* previous data hasn't been read, FIFO busy */
> +		err = -EBUSY;

ditto
> +		goto err_exit;
> +	}
> +
> +	/* copy data to fifo buffer */
> +	memcpy(fifo->buffer + fifo->w_pos, data, len);
> +	/* update fifo position */
> +	fifo->w_pos = (fifo->w_pos + len) % fifo->size;
> +	*fifo->count = count + len;
> +
> +	hwspin_unlock_irqrestore(fifo->lock, &flags);
> +	err = 0;
> +
> +err_exit:
> +	return err;
> +}
> +
