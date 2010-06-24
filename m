From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Jun 2010 15:26:44 +0100
Subject: [PATCH 3/6] U6715 gpio platform driver This driver is U6
	platform generic (V2)
In-Reply-To: <1274948852-9179-4-git-send-email-philippe.langlais@stericsson.com>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
	<1274948852-9179-4-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <20100624142644.GD6523@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:27:29AM +0200, Philippe Langlais wrote:
> Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
> ---
>  arch/arm/mach-u67xx/board_u67xx_wavex.c |  469 ++++++++++++++++++++
>  arch/arm/mach-u67xx/devices.c           |   12 +-
>  arch/arm/plat-u6xxx/Makefile            |    2 +-
>  arch/arm/plat-u6xxx/gpio.c              |  716 +++++++++++++++++++++++++++++++
>  arch/arm/plat-u6xxx/include/mach/gpio.h |  396 +++++++++++++++++
>  5 files changed, 1588 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/plat-u6xxx/gpio.c
>  create mode 100644 arch/arm/plat-u6xxx/include/mach/gpio.h
> 
> diff --git a/arch/arm/mach-u67xx/board_u67xx_wavex.c b/arch/arm/mach-u67xx/board_u67xx_wavex.c
> index 2a806e7..a21e465 100644
> --- a/arch/arm/mach-u67xx/board_u67xx_wavex.c
> +++ b/arch/arm/mach-u67xx/board_u67xx_wavex.c
> @@ -24,6 +24,474 @@
>  #include <asm/mach/arch.h>
>  #include <mach/irqs.h>
>  #include <mach/timer.h>
> +#include <mach/gpio.h>

linux/gpio.h

> +
> +#include <mach/scon.h>
> +
> +/**
> + * SCON initial settings
> + * Allows to define the PIN multiplexing for all the platform (Linux and Modem)
> + */
> +struct u6_scon_config u6_scon_init_config[SCON_REGISTER_NB] = {
> + {
> +	(void __iomem *) SCON_SYSMUX0_REG,

IOMEM() to eliminate the cast?

> +/* GPIO def settings to avoid HW issue */
> +struct u6_gpio_config u6_gpio_init_config[] = {
> +	/* GPIO A bank */
> +	{
> +		.gpio = GPIO_A5,
> +		.dir = GPIO_DIR_OUTPUT	,

Unnecessary spaces between 'OUTPUT' and ','

> +		.value = 1,
> +	},
> +	{
> +		.gpio = GPIO_A6,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 1,
> +	},
> +	{
> +		.gpio = GPIO_A7,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A8,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 1,
> +	},
> +	{
> +		.gpio = GPIO_A9,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 1,
> +	},
> +	{
> +		.gpio = GPIO_A13,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A17,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A21,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A23,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A24,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 1,
> +	},
> +	{
> +		.gpio = GPIO_A25,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_A30,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	/* GPIO B bank */
> +	/* GPIO C bank */
> +	/* GPIO D bank */
> +	{
> +		.gpio = GPIO_D0,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_D24,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_D29,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	/* GPIO E bank */
> +	{
> +		.gpio = GPIO_E31,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	/* GPIO F bank */
> +	{
> +		.gpio = GPIO_F0,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_F1,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_F2,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	},
> +	{
> +		.gpio = GPIO_F9,
> +		.dir = GPIO_DIR_OUTPUT	,
> +		.value = 0,
> +	}
> +};
> +
> +u32 gpio_to_configure = ARRAY_SIZE(u6_gpio_init_config);
>  
>  /* List of board specific devices */
>  static struct platform_device *devices[] __initdata = {
> @@ -31,6 +499,7 @@ static struct platform_device *devices[] __initdata = {
>  
>  void __init u67xx_init(void)
>  {
> +	u6_gpio_init();
>  	/* Add specific board devices */
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
> diff --git a/arch/arm/mach-u67xx/devices.c b/arch/arm/mach-u67xx/devices.c
> index 0ead380..8e812fb 100644
> --- a/arch/arm/mach-u67xx/devices.c
> +++ b/arch/arm/mach-u67xx/devices.c
> @@ -48,12 +48,12 @@ unsigned char extint_to_gpio[NR_EXTINT] = {
>  EXPORT_SYMBOL(extint_to_gpio);
>  
>  struct gpio_bank u6_gpio_bank[6] = {
> -	{(void __iomem *)GPIOA_PINS_REG, (void __iomem *)SCON_SYSMUX0_REG},
> -	{(void __iomem *)GPIOB_PINS_REG, (void __iomem *)SCON_SYSMUX2_REG},
> -	{(void __iomem *)GPIOC_PINS_REG, (void __iomem *)SCON_SYSMUX4_REG},
> -	{(void __iomem *)GPIOD_PINS_REG, (void __iomem *)SCON_SYSMUX6_REG},
> -	{(void __iomem *)GPIOE_PINS_REG, (void __iomem *)SCON_SYSMUX8_REG},
> -	{(void __iomem *)GPIOF_PINS_REG, (void __iomem *)SCON_SYSMUX10_REG},
> +	{GPIOA_PINS_REG, SCON_SYSMUX0_REG},
> +	{GPIOB_PINS_REG, SCON_SYSMUX2_REG},
> +	{GPIOC_PINS_REG, SCON_SYSMUX4_REG},
> +	{GPIOD_PINS_REG, SCON_SYSMUX6_REG},
> +	{GPIOE_PINS_REG, SCON_SYSMUX8_REG},
> +	{GPIOF_PINS_REG, SCON_SYSMUX10_REG},
>  };
>  
>  static struct gpio_data u6_gpio_data = {
> diff --git a/arch/arm/plat-u6xxx/Makefile b/arch/arm/plat-u6xxx/Makefile
> index afdf82b..3d6898e 100644
> --- a/arch/arm/plat-u6xxx/Makefile
> +++ b/arch/arm/plat-u6xxx/Makefile
> @@ -3,6 +3,6 @@
>  #
>  
>  # Common support
> -obj-y := io.o irq.o clock.o
> +obj-y := io.o irq.o clock.o gpio.o
>  
>  obj-$(CONFIG_U6_MTU_TIMER) += timer.o
> diff --git a/arch/arm/plat-u6xxx/gpio.c b/arch/arm/plat-u6xxx/gpio.c
> new file mode 100644
> index 0000000..40e25fc
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/gpio.c
> @@ -0,0 +1,716 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/gpio.c
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Loic Pallardy <loic.pallardy@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + * Support functions for GPIO
> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/ptrace.h>
> +#include <linux/sysdev.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/irq.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>
> +#include <asm/mach/irq.h>
> +#include <mach/scon.h>

asm/ before mach/.

> +
> +/*
> + * PN5220 GPIO/MUX registers
> + * defined in asm/arch/registers.h
> + */
> +
> +#define U6_GPIO_PINS_OFFSET	0
> +#define U6_GPIO_OUTPUT_OFFSET	4
> +#define U6_GPIO_DIR_OFFSET	8
> +
> +#define U6_MUX2_OFFSET		4
> +
> +static struct gpio_bank *gpio_bank_desc;
> +static int gpio_bank_count;
> +
> +static inline struct gpio_bank *get_gpio_bank(int gpio)
> +{
> +	/* 32 GPIOs per bank */
> +	return &(gpio_bank_desc[gpio >> 5]);
> +}
> +
> +static inline int get_gpio_index(int gpio)
> +{
> +	return gpio & 0x1f;
> +}
> +
> +static int check_gpio(int gpio)
> +{
> +	int retval = ((unsigned int)gpio) < GPIO_COUNT;
> +	if (unlikely(!retval)) {
> +		printk(KERN_ERR "u6-gpio: invalid GPIO %d\n", gpio);
> +		dump_stack();
> +	}

	return WARN_ON((unsigned int)gpio < GPIO_COUNT);

or use WARN(condition, format) if you want a custom message.

> +static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
> +{
> +	u32 reg = bank->gpio_base;
> +	u32 l;
> +
> +	/* select direction register */
> +	reg += U6_GPIO_DIR_OFFSET;
> +
> +	/* in register 0 = input, 1 = output */
> +	l = inl(reg);

inl/outl are for PCI/ISA based IO accesses/emulation.  I don't think your
GPIO block is a PCI/ISA peripheral, so it should not be using these macros.

> +static int initialized;
> +
> +static int __init u6_gpio_probe(struct platform_device *pdev)
> +{
> +	int i, j;
> +	int gpio = 0;
> +	struct gpio_bank *bank;
> +	struct gpio_data *data = pdev->dev.platform_data;
> +	unsigned long flags;
> +
> +	initialized = 1;

Why is this here when you're really wanting to prevent the platform
driver structure being registered more than once?

> +
> +	printk(KERN_INFO "U6 GPIO\n");
> +	gpio_bank_desc = data->gpio_bank_desc;
> +	gpio_bank_count = data->nb_banks;
> +
> +	for (i = 0; i < gpio_bank_count; i++) {
> +		int gpio_count = 32;	/* 32 GPIO per bank */
> +		bank = &gpio_bank_desc[i];
> +		bank->reserved_map = 0;
> +		spin_lock_init(&bank->lock);
> +
> +		bank->chip.request = u6_gpio_acquire;
> +		bank->chip.free = u6_gpio_release;
> +		bank->chip.direction_input = gpio_input;
> +		bank->chip.get = gpio_get;
> +		bank->chip.direction_output = gpio_output;
> +		bank->chip.set = gpio_set;
> +		bank->chip.to_irq = gpio_2irq;
> +		bank->chip.label = "gpio";
> +		bank->chip.base = gpio;
> +		gpio += gpio_count;
> +
> +		bank->chip.ngpio = gpio_count;
> +
> +		gpiochip_add(&bank->chip);
> +
> +	}
> +
> +	/* for extint */
> +	for (j = IRQ_COUNT; j < IRQ_COUNT + NR_EXTINT; j++) {
> +		set_irq_chip(j, &gpio_irq_chip);
> +		set_irq_handler(j, handle_simple_irq);
> +		set_irq_flags(j, IRQF_VALID);
> +	}
> +
> +	hw_raw_local_irq_save(flags);
> +	/* mask all EXT IRQ sources before registring handler */
> +	/* read status */
> +	j = inl(EXTINT_STATUS_REG) & inl(EXTINT_ENABLE3_REG);
> +	/* clear IRQ source(s) */
> +	outl(j, EXTINT_STATUS_REG);
> +
> +	outl(0, EXTINT_ENABLE3_REG);
> +
> +	/* set irq in low level */
> +	set_irq_type(IRQ_EXTINT3, IRQF_TRIGGER_LOW);
> +
> +	/* chained GPIO-IRQ on EXTINT3 */
> +	set_irq_chained_handler(IRQ_EXTINT3, gpio_irq_handler);
> +	hw_raw_local_irq_restore(flags);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver u6_gpio_driver = {
> +	.probe = u6_gpio_probe,
> +	.remove = NULL,
> +	.suspend = NULL,
> +	.resume = NULL,
> +	.driver = {
> +		   .name = "u6-gpio",
> +		   },
> +};
> +
> +static struct sysdev_class u6_gpio_sysclass = {
> +	.name = "gpio",
> +	.suspend = 0,		/*u6_gpio_suspend, */
> +	.resume = 0,		/*u6_gpio_resume, */
> +};
> +
> +static struct sys_device u6_gpio_device = {
> +	.id = 0,
> +	.cls = &u6_gpio_sysclass,
> +};
> +
> +/*
> + * This may get called early from board specific init
> + * for boards that have interrupts routed via FPGA.
> + */
> +int u6_gpio_init(void)
> +{
> +	if (!initialized)
> +		return platform_driver_register(&u6_gpio_driver);

Shouldn't this set 'initialized' once the platform driver has been
registered to prevent the platform driver being registered again?

> +	else
> +		return 0;
> +}
> +
> +static int __init u6_gpio_sysinit(void)
> +{
> +	int ret = 0;
> +
> +	if (!initialized)
> +		ret = u6_gpio_init();

Why not just call u6_gpio_init(), which handles the special case anyway?

> +
> +	if (ret == 0) {
> +		ret = sysdev_class_register(&u6_gpio_sysclass);
> +		if (ret == 0)
> +			ret = sysdev_register(&u6_gpio_device);
> +	}
> +
> +	return ret;
> +}
> +
> +arch_initcall(u6_gpio_sysinit);
> diff --git a/arch/arm/plat-u6xxx/include/mach/gpio.h b/arch/arm/plat-u6xxx/include/mach/gpio.h
> new file mode 100644
> index 0000000..a205f1c
> --- /dev/null
> +++ b/arch/arm/plat-u6xxx/include/mach/gpio.h
> @@ -0,0 +1,396 @@
> +/*
> + * linux/arch/arm/plat-u6xxx/include/mach/gpio.h
> + *
> + * Copyright (C) ST-Ericsson SA 2010
> + * Author: Loic Pallardy <loic.pallardy@stericsson.com> for ST-Ericsson.
> + * License terms:  GNU General Public License (GPL), version 2
> + * GPIO handling defines and functions
> + */
> +
> +#ifndef __ASM_PLAT_U6_GPIO_H
> +#define __ASM_PLAT_U6_GPIO_H
> +
> +#include <linux/io.h>
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/gpio.h>

Recursive include of mach/gpio.h

> +
> +#include <linux/errno.h>
> +#include <asm-generic/gpio.h>

linux/ includes before asm and mach includes.
