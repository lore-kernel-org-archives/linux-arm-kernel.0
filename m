From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Jul 2011 01:59:15 +0900
Subject: [PATCH v3 2/6] Exynos4 NURI: configure regulators and PMIC
	(MAX8997)
In-Reply-To: <1309421729-11172-3-git-send-email-myungjoo.ham@samsung.com>
References: <1309421729-11172-1-git-send-email-myungjoo.ham@samsung.com>
	<1309421729-11172-3-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <06c401cc46fe$5e9348d0$1bb9da70$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

(snip)

> +#include <linux/mfd/max8997.h>

(snip)

> 
> +static void __init nuri_power_init(void)
> +{
> +	int gpio;
> +	int irq_base = IRQ_GPIO_END + 1;
> +
> +	nuri_max8997_pdata.irq_base = irq_base;
> +	irq_base += MAX8997_IRQ_NR;

Oops :(

arch/arm/mach-exynos4/mach-nuri.c: In function 'nuri_power_init':
arch/arm/mach-exynos4/mach-nuri.c:1051: error: 'MAX8997_IRQ_NR' undeclared
(first use in this function)
arch/arm/mach-exynos4/mach-nuri.c:1051: error: (Each undeclared identifier
is reported only once
arch/arm/mach-exynos4/mach-nuri.c:1051: error: for each function it appears
in.)
make[2]: *** [arch/arm/mach-exynos4/mach-nuri.o] Error 1

So need to add inclusion of <linux/mfd/max8997-private.h> on this file.

I fixed it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> +
> +	gpio = EXYNOS4_GPX0(7);
> +	gpio_request(gpio, "AP_PMIC_IRQ");
> +	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> +	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +}
> +
>  /* USB EHCI */
>  static struct s5p_ehci_platdata nuri_ehci_pdata;
> 
> @@ -361,6 +980,7 @@ static void __init nuri_ehci_init(void)
> 
>  static struct platform_device *nuri_devices[] __initdata = {
>  	/* Samsung Platform Devices */
> +	&s3c_device_i2c5, /* PMIC should initialize first */
>  	&emmc_fixed_voltage,
>  	&s3c_device_hsmmc0,
>  	&s3c_device_hsmmc2,
> @@ -387,10 +1007,13 @@ static void __init nuri_machine_init(void)
>  {
>  	nuri_sdhci_init();
>  	nuri_tsp_init();
> +	nuri_power_init();
> 
>  	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
>  	s3c_i2c3_set_platdata(&i2c3_data);
>  	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
> +	s3c_i2c5_set_platdata(NULL);
> +	i2c5_devs[I2C5_MAX8997].irq = gpio_to_irq(EXYNOS4_GPX0(7));
>  	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
> 
>  	nuri_ehci_init();
> --
> 1.7.4.1
