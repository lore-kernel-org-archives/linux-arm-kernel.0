From: xuejiancheng@huawei.com (xuejiancheng)
Date: Tue, 5 Jan 2016 20:39:55 +0800
Subject: [PATCH v4 1/6] clk: hisilicon: add CRG driver for hi3519 soc
In-Reply-To: <568B6EEB.8030602@huawei.com>
References: <1451439832-13927-1-git-send-email-xuejiancheng@huawei.com>
 <1451439832-13927-2-git-send-email-xuejiancheng@huawei.com>
 <20151231002323.19557.50218@quark.deferred.io> <568B6EEB.8030602@huawei.com>
Message-ID: <568BB99B.7090102@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike?
   I am sorry. I have to correct my answer about using CLK_OF_DECLARE.   	

On 2016/1/5 15:21, xuejiancheng wrote:
> Hi Mike,
>    Happy new year to you!
>    Thank you for taking time to reply.
> 
> On 2015/12/31 8:23, Michael Turquette wrote:
>> Hello Jiancheng Xue,
>>
>> Quoting Jiancheng Xue (2015-12-29 17:43:47)
>>> The CRG(Clock and Reset Generator) block provides clock
>>> and reset signals for other modules in hi3519 soc.
>>>
>>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>>> ---
>>>  .../devicetree/bindings/clock/hi3519-crg.txt       |  46 +++++++
>>>  drivers/clk/hisilicon/Kconfig                      |   7 +
>>>  drivers/clk/hisilicon/Makefile                     |   2 +
>>>  drivers/clk/hisilicon/clk-hi3519.c                 | 103 ++++++++++++++
>>>  drivers/clk/hisilicon/reset.c                      | 149 +++++++++++++++++++++
>>>  drivers/clk/hisilicon/reset.h                      |  32 +++++
>>>  include/dt-bindings/clock/hi3519-clock.h           |  43 ++++++
>>>  7 files changed, 382 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/hi3519-crg.txt
>>>  create mode 100644 drivers/clk/hisilicon/clk-hi3519.c
>>>  create mode 100644 drivers/clk/hisilicon/reset.c
>>>  create mode 100644 drivers/clk/hisilicon/reset.h
>>>  create mode 100644 include/dt-bindings/clock/hi3519-clock.h
>>
>> Please keep Philipp Zabel Cc'd for reset-related patches. I've added
>> him to Cc.
>>
> OK.
> 
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/hi3519-crg.txt b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
>>> new file mode 100644
>>> index 0000000..2d23950
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/hi3519-crg.txt
>>> @@ -0,0 +1,46 @@
>>> +* Hisilicon Hi3519 Clock and Reset Generator(CRG)
>>> +
>>> +The Hi3519 CRG module provides clock and reset signals to various
>>> +controllers within the SoC.
>>> +
>>> +This binding uses the following bindings:
>>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>>> +    Documentation/devicetree/bindings/reset/reset.txt
>>> +
>>> +Required Properties:
>>> +
>>> +- compatible: should be one of the following.
>>> +  - "hisilicon,hi3519-crg" - controller compatible with Hi3519 SoC.
>>> +
>>> +- reg: physical base address of the controller and length of memory mapped
>>> +  region.
>>> +
>>> +- #clock-cells: should be 1.
>>> +
>>> +Each clock is assigned an identifier and client nodes use this identifier
>>> +to specify the clock which they consume.
>>> +
>>> +All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
>>> +
>>> +- #reset-cells: should be 2.
>>> +
>>> +A reset signal can be controlled by writing a bit register in the CRG module.
>>> +The reset specifier consists of two cells. The first cell represents the
>>> +register offset relative to the base address. The second cell represents the
>>> +bit index in the register.
>>> +
>>> +Example: CRG nodes
>>> +CRG: clock-reset-controller at 12010000 {
>>> +       compatible = "hisilicon,hi3519-crg";
>>> +        reg = <0x12010000 0x10000>;
>>> +        #clock-cells = <1>;
>>> +        #reset-cells = <2>;
>>> +};
>>> +
>>> +Example: consumer nodes
>>> +i2c0: i2c at 12110000 {
>>> +       compatible = "hisilicon,hi3519-i2c";
>>> +        reg = <0x12110000 0x1000>;
>>> +        clocks = <&CRG HI3519_I2C0_RST>;*/
>>> +        resets = <&CRG 0xe4 0>;
>>> +};
>>> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
>>> index e434854..b6baebf 100644
>>> --- a/drivers/clk/hisilicon/Kconfig
>>> +++ b/drivers/clk/hisilicon/Kconfig
>>> @@ -1,3 +1,10 @@
>>> +config COMMON_CLK_HI3519
>>> +       tristate "Clock Driver for Hi3519"
>>> +       depends on ARCH_HISI
>>> +       default y
>>> +       help
>>> +         Build the clock driver for hi3519.
>>> +
>>>  config COMMON_CLK_HI6220
>>>         bool "Hi6220 Clock Driver"
>>>         depends on ARCH_HISI || COMPILE_TEST
>>> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
>>> index 74dba31..3f57b09 100644
>>> --- a/drivers/clk/hisilicon/Makefile
>>> +++ b/drivers/clk/hisilicon/Makefile
>>> @@ -4,8 +4,10 @@
>>>  
>>>  obj-y  += clk.o clkgate-separated.o clkdivider-hi6220.o
>>>  
>>> +obj-$(CONFIG_RESET_CONTROLLER) += reset.o
>>>  obj-$(CONFIG_ARCH_HI3xxx)      += clk-hi3620.o
>>>  obj-$(CONFIG_ARCH_HIP04)       += clk-hip04.o
>>>  obj-$(CONFIG_ARCH_HIX5HD2)     += clk-hix5hd2.o
>>>  obj-$(CONFIG_COMMON_CLK_HI6220)        += clk-hi6220.o
>>>  obj-$(CONFIG_STUB_CLK_HI6220)  += clk-hi6220-stub.o
>>> +obj-$(CONFIG_COMMON_CLK_HI3519)        += clk-hi3519.o
>>> diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
>>> new file mode 100644
>>> index 0000000..e220234
>>> --- /dev/null
>>> +++ b/drivers/clk/hisilicon/clk-hi3519.c
>>> @@ -0,0 +1,103 @@
>>> +/*
>>> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/of_address.h>
>>> +#include <dt-bindings/clock/hi3519-clock.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/delay.h>
>>> +#include "clk.h"
>>> +#include "reset.h"
>>> +
>>> +#define HI3519_FIXED_24M       (HI3519_EXT_CLKS + 1)
>>> +#define HI3519_FIXED_50M       (HI3519_EXT_CLKS + 2)
>>> +#define HI3519_FIXED_75M       (HI3519_EXT_CLKS + 3)
>>> +#define HI3519_FIXED_125M      (HI3519_EXT_CLKS + 4)
>>> +#define HI3519_FIXED_150M      (HI3519_EXT_CLKS + 5)
>>> +#define HI3519_FIXED_200M      (HI3519_EXT_CLKS + 6)
>>> +#define HI3519_FIXED_250M      (HI3519_EXT_CLKS + 7)
>>> +#define HI3519_FIXED_300M      (HI3519_EXT_CLKS + 8)
>>> +#define HI3519_FIXED_400M      (HI3519_EXT_CLKS + 9)
>>> +#define HI3519_FMC_MUX         (HI3519_EXT_CLKS + 10)
>>> +
>>> +#define HI3519_NR_CLKS 128
>>> +#define HI3519_NR_RSTS 128
>>> +
>>> +static struct hisi_fixed_rate_clock hi3519_fixed_rate_clks[] __initdata = {
>>> +       { HI3519_FIXED_3M, "3m", NULL, CLK_IS_ROOT, 3000000, },
>>> +       { HI3519_FIXED_24M, "24m", NULL, CLK_IS_ROOT, 24000000, },
>>> +       { HI3519_FIXED_50M, "50m", NULL, CLK_IS_ROOT, 50000000, },
>>> +       { HI3519_FIXED_75M, "75m", NULL, CLK_IS_ROOT, 75000000, },
>>> +       { HI3519_FIXED_125M, "125m", NULL, CLK_IS_ROOT, 125000000, },
>>> +       { HI3519_FIXED_150M, "150m", NULL, CLK_IS_ROOT, 150000000, },
>>> +       { HI3519_FIXED_200M, "200m", NULL, CLK_IS_ROOT, 200000000, },
>>> +       { HI3519_FIXED_250M, "250m", NULL, CLK_IS_ROOT, 250000000, },
>>> +       { HI3519_FIXED_300M, "300m", NULL, CLK_IS_ROOT, 300000000, },
>>> +       { HI3519_FIXED_400M, "400m", NULL, CLK_IS_ROOT, 400000000, },
>>> +};
>>> +
>>> +static const char *fmc_mux_p[] __initconst = {
>>> +               "24m", "75m", "125m", "150m", "200m", "250m", "300m", "400m", };
>>> +static u32 fmc_mux_table[] = {0, 1, 2, 3, 4, 5, 6, 7};
>>> +
>>> +static struct hisi_mux_clock hi3519_mux_clks[] __initdata = {
>>> +       { HI3519_FMC_MUX, "fmc_mux", fmc_mux_p, ARRAY_SIZE(fmc_mux_p),
>>> +               CLK_SET_RATE_PARENT, 0xc0, 2, 3, 0, fmc_mux_table, },
>>> +};
>>> +
>>> +static struct hisi_gate_clock hi3519_gate_clks[] __initdata = {
>>> +       /* fmc */
>>> +       { HI3519_FMC_CLK, "clk_fmc", "fmc_mux",
>>> +               CLK_SET_RATE_PARENT, 0xc0, 1, 0, },
>>> +       /* uart */
>>> +       { HI3519_UART0_CLK, "clk_uart0", "24m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 20, 0, },
>>> +       { HI3519_UART1_CLK, "clk_uart1", "24m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 21, 0, },
>>> +       { HI3519_UART2_CLK, "clk_uart2", "24m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 22, 0, },
>>> +       { HI3519_UART3_CLK, "clk_uart3", "24m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 23, 0, },
>>> +       { HI3519_UART4_CLK, "clk_uart4", "24m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 24, 0, },
>>> +       { HI3519_SPI0_CLK, "clk_spi0", "50m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 16, 0, },
>>> +       { HI3519_SPI1_CLK, "clk_spi1", "50m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 17, 0, },
>>> +       { HI3519_SPI2_CLK, "clk_spi2", "50m",
>>> +               CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
>>> +};
>>> +
>>> +static void __init hi3519_clk_init(struct device_node *np)
>>> +{
>>> +       struct hisi_clock_data *clk_data;
>>> +
>>> +       clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
>>> +       if (!clk_data)
>>> +               return;
>>> +
>>> +       hisi_reset_init(np, HI3519_NR_RSTS);
>>> +
>>> +       hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
>>> +                                    ARRAY_SIZE(hi3519_fixed_rate_clks),
>>> +                                    clk_data);
>>> +       hisi_clk_register_mux(hi3519_mux_clks, ARRAY_SIZE(hi3519_mux_clks),
>>> +                                       clk_data);
>>> +       hisi_clk_register_gate(hi3519_gate_clks,
>>> +                       ARRAY_SIZE(hi3519_gate_clks), clk_data);
>>> +}
>>> +
>>> +CLK_OF_DECLARE(hi3519_clk, "hisilicon,hi3519-crg", hi3519_clk_init);
>>
>> Is CLK_OF_DECLARE required here? Why do you need to register these
>> clocks so early?
>>
>> Can this be a real platform driver instead? See,
>>
>> grep platform_driver drivers/clk/qcom/*.c
>>
>> Regards,
>> Mike
>>
> 
> It's OK to realize this as a real platform driver. I'll modify it in next version.

Sorry. CLK_OF_DECLARE is required. Because the timer clock is needed
when clocksource_probe() called in time_init.

time_init->clocksource_probe->sp804_of_init

> 
> More comments will be appreciated.
> Thank you.
> 
> Jiancheng
> 
>>> diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
>>> new file mode 100644
>>> index 0000000..cf5c32a
>>> --- /dev/null
>>> +++ b/drivers/clk/hisilicon/reset.c
>>> @@ -0,0 +1,149 @@
>>> +/*
>>> + * Hisilicon Reset Controller driver
>>> + *
>>> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/reset-controller.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/spinlock.h>
>>> +#include <linux/types.h>
>>> +
>>> +#define        HISI_RESET_BIT_SHIFT    0
>>> +#define        HISI_RESET_BIT_WIDTH    16
>>> +#define        HISI_RESET_OFFSET_SHIFT 16
>>> +#define        HISI_RESET_OFFSET_WIDTH 16
>>> +
>>> +struct hisi_reset_controller {
>>> +       spinlock_t      lock;
>>> +       void __iomem    *membase;
>>> +       struct reset_controller_dev     rcdev;
>>> +};
>>> +
>>> +
>>> +#define to_hisi_reset_controller(rcdev)  \
>>> +       container_of(rcdev, struct hisi_reset_controller, rcdev)
>>> +
>>> +/*31                        16                         0
>>> + * |---reset_spec->args[0]---|---reset_spec->args[1]---|
>>> + * |-------reg_offset--------|--------reg_bit----------|
>>> + */
>>> +static int hisi_reset_of_xlate(struct reset_controller_dev *rcdev,
>>> +                       const struct of_phandle_args *reset_spec)
>>> +{
>>> +       unsigned int offset, bit, id;
>>> +       const __be32 *addr;
>>> +       u64 size;
>>> +
>>> +       if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
>>> +               return -EINVAL;
>>> +
>>> +       addr = of_get_address(rcdev->of_node, 0, &size, NULL);
>>> +       if (!addr)
>>> +               return -EINVAL;
>>> +
>>> +       if (reset_spec->args[1] >= 32
>>> +               || reset_spec->args[0] + reset_spec->args[1] / 8 > size)
>>> +               return -EINVAL;
>>> +
>>> +       offset = reset_spec->args[0] & (BIT(HISI_RESET_OFFSET_WIDTH) - 1);
>>> +       bit = (reset_spec->args[1] & (BIT(HISI_RESET_BIT_WIDTH) - 1));
>>> +       id = offset << HISI_RESET_OFFSET_SHIFT | bit;
>>> +
>>> +       return id;
>>> +}
>>> +
>>> +static int hisi_reset_assert(struct reset_controller_dev *rcdev,
>>> +                             unsigned long id)
>>> +{
>>> +       struct hisi_reset_controller *rstc = to_hisi_reset_controller(rcdev);
>>> +       unsigned int offset, bit;
>>> +       unsigned long flags;
>>> +       u32 reg;
>>> +
>>> +       offset = id >> HISI_RESET_OFFSET_SHIFT;
>>> +       offset &= (BIT(HISI_RESET_OFFSET_WIDTH) - 1);
>>> +       bit = id & (BIT(HISI_RESET_BIT_WIDTH) - 1);
>>> +
>>> +       spin_lock_irqsave(&rstc->lock, flags);
>>> +
>>> +       reg = readl(rstc->membase + offset);
>>> +       writel(reg | BIT(bit), rstc->membase + offset);
>>> +
>>> +       spin_unlock_irqrestore(&rstc->lock, flags);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int hisi_reset_deassert(struct reset_controller_dev *rcdev,
>>> +                               unsigned long id)
>>> +{
>>> +       struct hisi_reset_controller *rstc = to_hisi_reset_controller(rcdev);
>>> +       unsigned int offset, bit;
>>> +       unsigned long flags;
>>> +       u32 reg;
>>> +
>>> +       offset = id >> HISI_RESET_OFFSET_SHIFT;
>>> +       offset &= (BIT(HISI_RESET_OFFSET_WIDTH) - 1);
>>> +       bit = id & (BIT(HISI_RESET_BIT_WIDTH) - 1);
>>> +
>>> +       spin_lock_irqsave(&rstc->lock, flags);
>>> +
>>> +       reg = readl(rstc->membase + offset);
>>> +       writel(reg & ~BIT(bit), rstc->membase + offset);
>>> +
>>> +       spin_unlock_irqrestore(&rstc->lock, flags);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static struct reset_control_ops hisi_reset_ops = {
>>> +       .assert         = hisi_reset_assert,
>>> +       .deassert       = hisi_reset_deassert,
>>> +};
>>> +
>>> +int __init hisi_reset_init(struct device_node *np,
>>> +                                            int nr_rsts)
>>> +{
>>> +       struct hisi_reset_controller *rstc;
>>> +
>>> +       rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
>>> +       if (!rstc)
>>> +               return -ENOMEM;
>>> +
>>> +       rstc->membase = of_iomap(np, 0);
>>> +       if (!rstc->membase)
>>> +               return -EINVAL;
>>> +
>>> +       spin_lock_init(&rstc->lock);
>>> +
>>> +       rstc->rcdev.owner = THIS_MODULE;
>>> +       rstc->rcdev.nr_resets = nr_rsts;
>>> +       rstc->rcdev.ops = &hisi_reset_ops;
>>> +       rstc->rcdev.of_node = np;
>>> +       rstc->rcdev.of_reset_n_cells = 2;
>>> +       rstc->rcdev.of_xlate = hisi_reset_of_xlate;
>>> +
>>> +       return reset_controller_register(&rstc->rcdev);
>>> +}
>>> +
>>> diff --git a/drivers/clk/hisilicon/reset.h b/drivers/clk/hisilicon/reset.h
>>> new file mode 100644
>>> index 0000000..b04796f
>>> --- /dev/null
>>> +++ b/drivers/clk/hisilicon/reset.h
>>> @@ -0,0 +1,32 @@
>>> +/*
>>> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef        __HISI_RESET_H
>>> +#define        __HISI_RESET_H
>>> +
>>> +#include <linux/of.h>
>>> +
>>> +#ifdef CONFIG_RESET_CONTROLLER
>>> +int __init hisi_reset_init(struct device_node *np, int nr_rsts);
>>> +#else
>>> +static inline int __init hisi_reset_init(struct device_node *np, int nr_rsts)
>>> +{
>>> +       return 0;
>>> +}
>>> +#endif
>>> +
>>> +#endif /* __HISI_RESET_H */
>>> diff --git a/include/dt-bindings/clock/hi3519-clock.h b/include/dt-bindings/clock/hi3519-clock.h
>>> new file mode 100644
>>> index 0000000..1e4a3c1
>>> --- /dev/null
>>> +++ b/include/dt-bindings/clock/hi3519-clock.h
>>> @@ -0,0 +1,43 @@
>>> +/*
>>> + * Copyright (c) 2015 HiSilicon Technologies Co., Ltd.
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#ifndef __DTS_HI3519_CLOCK_H
>>> +#define __DTS_HI3519_CLOCK_H
>>> +
>>> +#define HI3519_FIXED_3M                        1
>>> +#define HI3519_FMC_CLK                 2
>>> +#define HI3519_USB2_BUS_CLK            3
>>> +#define HI3519_USB2_PORT_CLK           4
>>> +#define HI3519_USB3_CLK                        5
>>> +#define HI3519_ETH_PHY_CLK             6
>>> +#define HI3519_ETH_MAC_CLK             7
>>> +#define HI3519_ETH_MACIF_CLK           8
>>> +#define HI3519_PWM_CLK                 9
>>> +#define HI3519_DMA_CLK                 10
>>> +#define HI3519_SPI0_CLK                        11
>>> +#define HI3519_SPI1_CLK                        12
>>> +#define HI3519_SPI2_CLK                        13
>>> +#define HI3519_IR_CLK                  14
>>> +#define HI3519_UART0_CLK               15
>>> +#define HI3519_UART1_CLK               16
>>> +#define HI3519_UART2_CLK               17
>>> +#define HI3519_UART3_CLK               18
>>> +#define HI3519_UART4_CLK               19
>>> +
>>> +#define HI3519_EXT_CLKS                        19
>>> +
>>> +#endif /* __DTS_HI3519_CLOCK_H */
>>> -- 
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> .
>>
