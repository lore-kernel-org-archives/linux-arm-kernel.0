From: robh@kernel.org (Rob Herring)
Date: Sat, 9 Jan 2016 09:33:22 -0600
Subject: [PATCH v5 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <1452219400-32478-2-git-send-email-xuejiancheng@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160109153322.GA19311@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:16:35AM +0800, Jiancheng Xue wrote:
> The CRG(Clock and Reset Generator) block provides clock
> and reset signals for other modules in hi3519 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>

[...]

> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
> new file mode 100644
> index 0000000..72d3a7b0
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3519.c
> @@ -0,0 +1,105 @@
> +/*
> + * Hi3519 Clock Driver
> + *
> + * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <dt-bindings/clock/hi3519-clock.h>
> +#include <linux/delay.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include "clk.h"
> +#include "reset.h"
> +
> +#define HI3519_FIXED_24M	(HI3519_EXT_CLKS + 1)

This is fragile because HI3519_EXT_CLKS will change every time you 
add a clock to DT and means you have to keep the kernel and DT in sync. 

I'd be less worried if your clock definitions were more complete, but 
I'm guess the SOC has more than 19 clocks coming out of the clock 
controller.

> +#define HI3519_FIXED_50M	(HI3519_EXT_CLKS + 2)
> +#define HI3519_FIXED_75M	(HI3519_EXT_CLKS + 3)
> +#define HI3519_FIXED_125M	(HI3519_EXT_CLKS + 4)
> +#define HI3519_FIXED_150M	(HI3519_EXT_CLKS + 5)
> +#define HI3519_FIXED_200M	(HI3519_EXT_CLKS + 6)
> +#define HI3519_FIXED_250M	(HI3519_EXT_CLKS + 7)
> +#define HI3519_FIXED_300M	(HI3519_EXT_CLKS + 8)
> +#define HI3519_FIXED_400M	(HI3519_EXT_CLKS + 9)
> +#define HI3519_FMC_MUX		(HI3519_EXT_CLKS + 10)
> +
> +#define HI3519_NR_CLKS	128

You only have 29 clocks defined.


> +#ifndef __DTS_HI3519_CLOCK_H
> +#define __DTS_HI3519_CLOCK_H
> +
> +#define HI3519_FIXED_3M			1
> +#define HI3519_FMC_CLK			2
> +#define HI3519_USB2_BUS_CLK		3
> +#define HI3519_USB2_PORT_CLK		4
> +#define HI3519_USB3_CLK			5
> +#define HI3519_ETH_PHY_CLK		6
> +#define HI3519_ETH_MAC_CLK		7
> +#define HI3519_ETH_MACIF_CLK		8
> +#define HI3519_PWM_CLK			9
> +#define HI3519_DMA_CLK			10
> +#define HI3519_SPI0_CLK			11
> +#define HI3519_SPI1_CLK			12
> +#define HI3519_SPI2_CLK			13
> +#define HI3519_IR_CLK			14
> +#define HI3519_UART0_CLK		15
> +#define HI3519_UART1_CLK		16
> +#define HI3519_UART2_CLK		17
> +#define HI3519_UART3_CLK		18
> +#define HI3519_UART4_CLK		19
> +
> +#define HI3519_EXT_CLKS			19
> +
> +#endif	/* __DTS_HI3519_CLOCK_H */
