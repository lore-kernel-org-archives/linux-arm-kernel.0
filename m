From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 May 2014 10:17:42 +0200
Subject: [PATCH v7 2/3] [media] rc: add sunxi-ir driver
In-Reply-To: <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
References: <1400104602-16431-1-git-send-email-bay@hackerdom.ru>
 <1400104602-16431-3-git-send-email-bay@hackerdom.ru>
Message-ID: <20140519081742.GC29466@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I missed a few things in my first review.

On Thu, May 15, 2014 at 03:56:41AM +0600, Alexander Bersenev wrote:
> This patch adds driver for sunxi IR controller.
> It is based on Alexsey Shestacov's work based on the original driver
> supplied by Allwinner.
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
> ---
>  drivers/media/rc/Kconfig     |  10 ++
>  drivers/media/rc/Makefile    |   1 +
>  drivers/media/rc/sunxi-cir.c | 334 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 drivers/media/rc/sunxi-cir.c
> 
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index 8fbd377..9427fad 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -343,4 +343,14 @@ config RC_ST
>  
>  	 If you're not sure, select N here.
>  
> +config IR_SUNXI
> +    tristate "SUNXI IR remote control"
> +    depends on RC_CORE
> +    depends on ARCH_SUNXI
> +    ---help---
> +      Say Y if you want to use sunXi internal IR Controller
> +
> +      To compile this driver as a module, choose M here: the module will
> +      be called sunxi-ir.
> +
>  endif #RC_DEVICES
> diff --git a/drivers/media/rc/Makefile b/drivers/media/rc/Makefile
> index f8b54ff..9ee9ee7 100644
> --- a/drivers/media/rc/Makefile
> +++ b/drivers/media/rc/Makefile
> @@ -32,4 +32,5 @@ obj-$(CONFIG_IR_GPIO_CIR) += gpio-ir-recv.o
>  obj-$(CONFIG_IR_IGUANA) += iguanair.o
>  obj-$(CONFIG_IR_TTUSBIR) += ttusbir.o
>  obj-$(CONFIG_RC_ST) += st_rc.o
> +obj-$(CONFIG_IR_SUNXI) += sunxi-cir.o
>  obj-$(CONFIG_IR_IMG) += img-ir/
> diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
> new file mode 100644
> index 0000000..25eb175
> --- /dev/null
> +++ b/drivers/media/rc/sunxi-cir.c
> @@ -0,0 +1,334 @@
> +/*
> + * Driver for Allwinner sunXi IR controller
> + *
> + * Copyright (C) 2014 Alexsey Shestacov <wingrime@linux-sunxi.org>
> + * Copyright (C) 2014 Alexander Bersenev <bay@hackerdom.ru>
> + *
> + * Based on sun5i-ir.c:
> + * Copyright (C) 2007-2012 Daniel Wang
> + * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <media/rc-core.h>
> +
> +#define SUNXI_IR_DEV "sunxi-ir"
> +
> +/* Registers */
> +/* IR Control */
> +#define SUNXI_IR_CTL_REG      0x00
> +/* Rx Config */
> +#define SUNXI_IR_RXCTL_REG    0x10
> +/* Rx Data */
> +#define SUNXI_IR_RXFIFO_REG   0x20
> +/* Rx Interrupt Enable */
> +#define SUNXI_IR_RXINT_REG    0x2C
> +/* Rx Interrupt Status */
> +#define SUNXI_IR_RXSTA_REG    0x30
> +/* IR Sample Config */
> +#define SUNXI_IR_CIR_REG      0x34
> +
> +/* Global Enable for IR_CTL Register */
> +#define REG_CTL_GEN           BIT(0)
> +/* RX block enable for IR_CTL Register */
> +#define REG_CTL_RXEN          BIT(1)
> +/* CIR mode for IR_CTL Register */
> +#define REG_CTL_MD            (BIT(4)|BIT(5))

I usually prefer to have the bits definition declared just below the
defininition of the register itself, something like:

#define SUNXI_CTRL_REG		0x00
#define SUNXI_CTRL_EN			BIT(0)
#define SUNXI_CTRL_RXEN			BIT(1)

etc...

It's easier to read and avoids the comments to say in which register
each bit belongs.

> +/* IR_RXCTL_REG Register Receiver Pulse Polarity Invert flag */
> +#define REG_RXCTL_RPPI        BIT(2)
> +
> +/* IR_RXINT_REG Register fields */
> +#define REG_RXINT_ROI_EN      BIT(0) /* Rx FIFO Overflow */
> +#define REG_RXINT_RPEI_EN     BIT(1) /* Rx Packet End */
> +#define REG_RXINT_RAI_EN      BIT(4) /* Rx FIFO Data Available */
> +/* Rx FIFO available byte level */
> +#define REG_RXINT_RAL__MASK   (BIT(8)|BIT(9)|BIT(10)|BIT(11))
> +#define REG_RXINT_RAL__SHIFT  8
> +static inline uint32_t REG_RXINT_RAL(uint16_t val)
> +{
> +	return (val << REG_RXINT_RAL__SHIFT) & REG_RXINT_RAL__MASK;
> +}

This should be turned either in a macro if you want to keep the upper
case name, or have a lower case name if you want to keep it as a
function.

In both cases, you don't want your function to be declared in the
middle of your defines.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140519/cce96c86/attachment.sig>
