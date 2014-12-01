From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 1 Dec 2014 22:01:12 +0100 (CET)
Subject: [PATCH 2/2] rockchip: efuse: add efuse driver for rk3288 efuse
In-Reply-To: <1417419281-9243-3-git-send-email-jay.xu@rock-chips.com>
References: <1417419281-9243-1-git-send-email-jay.xu@rock-chips.com>
 <1417419281-9243-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1479569208.4563.1417467672633.JavaMail.open-xchange@oxbaltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianqun,

> Jianqun Xu <jay.xu@rock-chips.com> hat am 1. Dezember 2014 um 08:34
> geschrieben:
>
>
> Add driver for efuse found on rk3288 board based on rk3288 SoC.
> Driver will read fuse information of chip at the boot stage of
> kernel, this information new is for further usage.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> arch/arm/mach-rockchip/efuse.c | 165 +++++++++++++++++++++++++++++++++++++++++
> arch/arm/mach-rockchip/efuse.h | 15 ++++
> 2 files changed, 180 insertions(+)
> create mode 100644 arch/arm/mach-rockchip/efuse.c
> create mode 100644 arch/arm/mach-rockchip/efuse.h
>
> diff --git a/arch/arm/mach-rockchip/efuse.c b/arch/arm/mach-rockchip/efuse.c
> new file mode 100644
> index 0000000..326d81e
> --- /dev/null
> +++ b/arch/arm/mach-rockchip/efuse.c
> @@ -0,0 +1,165 @@
> +/* mach-rockchip/efuse.c
> + *
> + * Copyright (c) 2014 Rockchip Electronics Co. Ltd.
> + * Author: Jianqun Xu <jay.xu@rock-chips.com>
> + *
> + * Tmis program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * Tmis program is distributed in the hope that it will be useful, but
> WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> with
> + * tmis program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA

as far as i know this address is outdated and should be removed.

> + *
> + * Tme full GNU General Public License is included in this distribution in
> the
> + * file called LICENSE.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/io.h>

Please order the includes alphabetical.

> +
> +#include "efuse.h"
> +
> +#define EFUSE_BUF_SIZE (32)
> +#define EFUSE_BUF_LKG_CPU (23)
> +#define EFUSE_BUF_LKG_GPU (24)
> +#define EFUSE_BUF_LKG_LOG (25)
> +
> +struct rk_efuse_info {
> + /* Platform device */
> + struct device *dev;

I think it's not really necessary to store this in the driver data. Better call
the relevant functions with struct platform_device as parameter and get your
driver data from their.

> +
> + /* Hardware resources */
> + void __iomem *regs;
> +
> + /* buffer to store registers' values */
> + unsigned int buf[EFUSE_BUF_SIZE];

The variable name buf isn't very helpful.

> +};
> +
> +static void efuse_writel(struct rk_efuse_info *efuse,
> + unsigned int value,
> + unsigned int offset)
> +{
> + writel_relaxed(value, efuse->regs + offset);
> +}
> +
> +static unsigned int efuse_readl(struct rk_efuse_info *efuse,
> + unsigned int offset)
> +{
> + return readl_relaxed(efuse->regs + offset);
> +}
> +
> +static unsigned int rockchip_efuse_leakage(struct rk_efuse_info *efuse,
> + int channel)
> +{
> + switch (channel) {
> + case EFUSE_BUF_LKG_CPU:
> + case EFUSE_BUF_LKG_GPU:
> + case EFUSE_BUF_LKG_LOG:
> + return efuse->buf[channel];
> + default:
> + dev_err(efuse->dev, "unknown channel\n");
> + return -EINVAL;

Returning a negative value in a function with unsigned return type isn't good.

Printing only "unknown channel" isn't optimal, it would be more helpful to print
also the invalid value.

> + }
> +
> + return 0;

Looks like unreachable code, maybe you could move the default case above down.

Thanks

Stefan
