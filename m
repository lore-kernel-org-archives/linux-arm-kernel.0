From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Oct 2014 16:20:44 +0200
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141024142044.GB3142@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 01:59:25PM +0200, Thomas Petazzoni wrote:
> On the Armada XP GP platform, entering suspend to RAM state is
> triggering by talking to an external PIC micro-controller connected to
> the SoC using 3 GPIOs. There is then a small magic sequence of GPIO
> toggling that needs to be used to tell the PIC to turn off the SoC.

Hi Thomas

Does Marvell mandate this PIC and gpio interface? Or is a board
designer free to implement it some other way? It seems to me, this
should be considered specific to the Marvell reference design.

I'm wondering if this code should be a power driver, living in
drivers/power/reset/.

A few kirkwood boards have a PIC controlling the power. QNAP devices
use a serial port to talk to it. Others use a single gpio line. Is
there something to stop a designer doing this for XP?

It seems like you would have a more generic solution by allowing DT to
specify a power off driver to use.

	Andrew

> 
> The code uses the Device Tree to find out which GPIOs are used to
> connect to the PIC micro-controller, and then registers its
> mvebu_armada_xp_gp_pm_enter() callback to the SoC-level PM code. The
> SoC PM code will call back into this registered function at the very
> end of the suspend procedure.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Makefile   |   2 +-
>  arch/arm/mach-mvebu/pm-board.c | 134 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-mvebu/pm-board.c
> 
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index e2bd96f..b4f0149 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -7,7 +7,7 @@ CFLAGS_pmsu.o			:= -march=armv7-a
>  obj-$(CONFIG_MACH_MVEBU_ANY)	 += system-controller.o mvebu-soc-id.o
>  
>  ifeq ($(CONFIG_MACH_MVEBU_V7),y)
> -obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o pm.o
> +obj-y				 += cpu-reset.o board-v7.o coherency.o coherency_ll.o pmsu.o pmsu_ll.o pm.o pm-board.o
>  obj-$(CONFIG_SMP)		 += platsmp.o headsmp.o platsmp-a9.o headsmp-a9.o
>  endif
>  
> diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
> new file mode 100644
> index 0000000..e1a9792
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/pm-board.c
> @@ -0,0 +1,134 @@
> +/*
> + * Board-level suspend/resume support.
> + *
> + * Copyright (C) 2014 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/slab.h>
> +#include "common.h"
> +
> +#define ARMADA_XP_GP_PIC_NR_GPIOS 3
> +
> +static void __iomem *gpio_ctrl;
> +static int pic_gpios[ARMADA_XP_GP_PIC_NR_GPIOS];
> +static int pic_raw_gpios[ARMADA_XP_GP_PIC_NR_GPIOS];
> +
> +static void mvebu_armada_xp_gp_pm_enter(void __iomem *sdram_reg, u32 srcmd)
> +{
> +	u32 reg, ackcmd;
> +	int i;
> +
> +	/* Put 001 as value on the GPIOs */
> +	reg = readl(gpio_ctrl);
> +	for (i = 0; i < ARMADA_XP_GP_PIC_NR_GPIOS; i++)
> +		reg &= ~BIT(pic_raw_gpios[i]);
> +	reg |= BIT(pic_raw_gpios[0]);
> +	writel(reg, gpio_ctrl);
> +
> +	/* Prepare writing 111 to the GPIOs */
> +	ackcmd = readl(gpio_ctrl);
> +	for (i = 0; i < ARMADA_XP_GP_PIC_NR_GPIOS; i++)
> +		ackcmd |= BIT(pic_raw_gpios[i]);
> +
> +	/* Wait a while */
> +	mdelay(250);
> +
> +	asm volatile (
> +		/* Align to a cache line */
> +		".balign 32\n\t"
> +
> +		/* Enter self refresh */
> +		"str %[srcmd], [%[sdram_reg]]\n\t"
> +
> +		/* Wait 100 cycles for DDR to enter self refresh */
> +		"1: subs r1, r1, #1\n\t"
> +		"bne 1b\n\t"
> +
> +		/* Issue the command ACK */
> +		"str %[ackcmd], [%[gpio_ctrl]]\n\t"
> +
> +		/* Trap the processor */
> +		"b .\n\t"
> +		: : [srcmd] "r" (srcmd), [sdram_reg] "r" (sdram_reg),
> +		  [ackcmd] "r" (ackcmd), [gpio_ctrl] "r" (gpio_ctrl) : "r1");
> +}
> +
> +static int mvebu_armada_xp_gp_pm_init(void)
> +{
> +	struct device_node *np;
> +	struct device_node *gpio_ctrl_np;
> +	int ret = 0, i;
> +
> +	if (!of_machine_is_compatible("marvell,axp-gp"))
> +		return -ENODEV;
> +
> +	np = of_find_node_by_name(NULL, "pm_pic");
> +	if (!np)
> +		return -ENODEV;
> +
> +	for (i = 0; i < ARMADA_XP_GP_PIC_NR_GPIOS; i++) {
> +		char *name;
> +		struct of_phandle_args args;
> +
> +		pic_gpios[i] = of_get_named_gpio(np, "ctrl-gpios", i);
> +		if (pic_gpios[i] < 0) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		name = kasprintf(GFP_KERNEL, "pic-pin%d", i);
> +		if (!name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = gpio_request(pic_gpios[i], name);
> +		if (ret < 0) {
> +			kfree(name);
> +			goto out;
> +		}
> +
> +		ret = gpio_direction_output(pic_gpios[i], 0);
> +		if (ret < 0) {
> +			gpio_free(pic_gpios[i]);
> +			kfree(name);
> +			goto out;
> +		}
> +
> +		ret = of_parse_phandle_with_fixed_args(np, "ctrl-gpios", 2,
> +						       i, &args);
> +		if (ret < 0) {
> +			gpio_free(pic_gpios[i]);
> +			kfree(name);
> +			goto out;
> +		}
> +
> +		gpio_ctrl_np = args.np;
> +		pic_raw_gpios[i] = args.args[0];
> +	}
> +
> +	gpio_ctrl = of_iomap(gpio_ctrl_np, 0);
> +	if (!gpio_ctrl)
> +		return -ENOMEM;
> +
> +	mvebu_pm_init(mvebu_armada_xp_gp_pm_enter);
> +
> +out:
> +	of_node_put(np);
> +	return ret;
> +}
> +
> +late_initcall(mvebu_armada_xp_gp_pm_init);
> -- 
> 2.0.0
> 
