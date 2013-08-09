From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 09 Aug 2013 14:55:34 -0700
Subject: [PATCH 1/2] power: Add APM X-Gene system reboot driver
In-Reply-To: <20130809212849.GD12638@lizard.sbx05730.santaca.wayport.net>
References: <1372797539-13111-1-git-send-email-lho@apm.com>
 <1372797539-13111-2-git-send-email-lho@apm.com>
 <20130809212849.GD12638@lizard.sbx05730.santaca.wayport.net>
Message-ID: <52056556.7060005@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/13 14:28, Anton Vorontsov wrote:
> On Tue, Jul 02, 2013 at 02:38:58PM -0600, Loc Ho wrote:
>> + *
>> + * Copyright (c) 2013, Applied Micro Circuits Corporation
>> + * Author: Feng Kan <fkan@apm.com>
>> + * Author: Loc Ho <lho@apm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
>> + * MA 02111-1307 USA
>> + *
>> + * This driver provides system reboot functionality for APM X-Gene SoC.
>> + * For system shutdown, this is board specify. If a board designer
>> + * implements GPIO shutdown, use the gpio-poweroff.c driver.
>> + *
>> + */
>> +#include <linux/io.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/stat.h>
>> +#include <linux/slab.h>
>> +#include <asm/system_misc.h>
>> +
>> +struct xgene_reboot_context {
>> +	struct platform_device *pdev;
>> +	void *csr;

__iomem. Please run sparse.

>> +	u32 mask;
>> +};
>> +
>> +static struct xgene_reboot_context *xgene_restart_ctx;
>> +
>> +static void xgene_restart(char str, const char *cmd)
>> +{
>> +	struct xgene_reboot_context *ctx = xgene_restart_ctx;
>> +	unsigned long timeout;
>> +
>> +	/* Issue the reboot */
>> +	if (ctx)
>> +		writel(ctx->mask, ctx->csr);
>> +
>> +	timeout = jiffies + HZ;
>> +	while (time_before(jiffies, timeout))
>> +		cpu_relax();

Maybe this should go into the arm64 layer. It doesn't seem that xgene
specific.

>> +
>> +	dev_emerg(&ctx->pdev->dev, "Unable to restart system\n");

If ctx is NULL here this will blow up so why check for ctx before the
writel?

>> +}
>> +
>> +static int xgene_reboot_probe(struct platform_device *pdev)
>> +{
>> +	struct xgene_reboot_context *ctx;
>> +
>> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (ctx == NULL) {
> !ctx is shorter
>
>> +		dev_err(&pdev->dev, "out of memory for context\n");

kmalloc prints an error on failure so this print is unnecessary.

>> +		return -ENODEV;
>> +	}
>> +	ctx->csr = of_iomap(pdev->dev.of_node, 0);

You should use platform functions instead of of_*() functions.

>> +	if (ctx->csr == NULL) {
>> +		devm_kfree(&pdev->dev, ctx);

This isn't necessary.

>> +		dev_err(&pdev->dev, "can not map resource\n");
>> +		return -ENODEV;
>> +	}
>> +	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
>> +		ctx->mask = 0xFFFFFFFF;
>> +	ctx->pdev = pdev;
>> +	arm_pm_restart = xgene_restart;
>> +	xgene_restart_ctx = ctx;

Although it's unlikely, this exposes a race condition where the
arm_pm_restart is assigned before ctx and if a restart happens in
between we won't actually restart. The two should probably be swapped.

>> +
>> +	return 0;
>> +}
>> +
>> +static struct of_device_id xgene_reboot_of_match[] = {

const?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
