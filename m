From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Aug 2016 14:25:04 +0200
Subject: [PATCH 2/2] soc: nxp: Add a RCPM driver
In-Reply-To: <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
References: <1470044943-3814-1-git-send-email-chenhui.zhao@nxp.com>
 <1470044943-3814-2-git-send-email-chenhui.zhao@nxp.com>
Message-ID: <2024386.Ra8uvttlE9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 1, 2016 5:49:03 PM CEST Chenhui Zhao wrote:
> The NXP's QorIQ Processors based on ARM Core have a RCPM module
> (Run Control and Power Management), which performs all device-level
> tasks associated with power management.
> 
> This patch mainly implements the wakeup sources configuration before
> entering LPM20, a low power state of device-level. The devices can be
> waked up by specified sources, such as Flextimer, GPIO and so on.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>

Adding irqchip maintainers to cc, as this wakeup handling is normally
part of the irq controller.

> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/suspend.h>
> +
> +/* So far there are not more than two registers */
> +#define RCPM_IPPDEXPCR0		0x140
> +#define RCPM_IPPDEXPCR1		0x144
> +#define RCPM_IPPDEXPCR(x)	(RCPM_IPPDEXPCR0 + 4 * x)
> +#define RCPM_WAKEUP_CELL_MAX_SIZE	2
> +
> +/* it reprents the number of the registers RCPM_IPPDEXPCR */
> +static unsigned int rcpm_wakeup_cells;
> +static void __iomem *rcpm_reg_base;
> +static u32 ippdexpcr[RCPM_WAKEUP_CELL_MAX_SIZE];

Can you make these local to the context of whoever
calls into the driver?


> +static void rcpm_wakeup_fixup(struct device *dev, void *data)
> +{
> +	struct device_node *node = dev ? dev->of_node : NULL;
> +	u32 value[RCPM_WAKEUP_CELL_MAX_SIZE + 1];
> +	int ret;
> +	int i;
> +
> +	if (!dev || !node || !device_may_wakeup(dev))
> +		return;
> +
> +	/*
> +	 * Get the values in the "rcpm-wakeup" property.
> +	 * Refer to Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +	 */
> +	ret = of_property_read_u32_array(node, "rcpm-wakeup",
> +					 value, rcpm_wakeup_cells + 1);

My first impression is that you are trying to do something
in a platform specific way that should be handled by common
code here.

You are parsing rcpm_wakeup_cells once for the global node,
but you don't check whether the device that has the rcpm-wakeup
node actually refers to this instance, and that would require
an incompatible change if we ever get an implementation that
has multiple such nodes.

	Arnd
