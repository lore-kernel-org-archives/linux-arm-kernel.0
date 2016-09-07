From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 7 Sep 2016 10:33:01 +0200
Subject: [PATCH] ARM: imx: use IS_ENABLED() instead of checking for
 built-in or module
In-Reply-To: <20160906064206.7mme3s2pu2s7y465@pengutronix.de>
References: <1472463131-29899-1-git-send-email-javier@dowhile0.org>
 <20160906064206.7mme3s2pu2s7y465@pengutronix.de>
Message-ID: <cb884769-6752-9bf6-59f4-280ee4773c80@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe,

Thanks for your feedback.

On 09/06/2016 08:42 AM, Uwe Kleine-K?nig wrote:
> Hello Javier,
> 
> On Mon, Aug 29, 2016 at 11:32:11AM +0200, Javier Martinez Canillas wrote:
>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
>> built-in or as a module, use that macro instead of open coding the same.
>>
>> Using the macro makes the code more readable by helping abstract away some
>> of the Kconfig built-in and module enable details.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> The following patch should do the same (untested though) and the source
> looks still better:
>

Yes, your patch looks good to me. But is doing two things at once (using the
IS_ENABLED macro and getting rid of the stub functions / ifdefery) so I would
split it in two different patches.

In any case, $SUBJECT was picked by Shawn already so you could post the other
change on top of it if you want.

> diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
> index 31df4361996f..48f794dbf293 100644
> --- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
> +++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
> @@ -63,7 +63,6 @@
>   */
>  #define KZM_ARM11_16550		(MX31_CS4_BASE_ADDR + 0x1050)
>  
> -#if defined(CONFIG_SERIAL_8250) || defined(CONFIG_SERIAL_8250_MODULE)
>  /*
>   * KZM-ARM11-01 has an external UART on FPGA
>   */
> @@ -106,37 +105,35 @@ static struct platform_device serial_device = {
>  
>  static int __init kzm_init_ext_uart(void)
>  {
> -	u8 tmp;
> -
> -	/*
> -	 * GPIO 1-1: external UART interrupt line
> -	 */
> -	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO));
> -	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "ext-uart-int");
> -	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> -
> -	/*
> -	 * Unmask UART interrupt
> -	 */
> -	tmp = __raw_readb(KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
> -	tmp |= 0x2;
> -	__raw_writeb(tmp, KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
> -
> -	serial_platform_data[0].irq =
> -			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> -	serial8250_resources[1].start =
> -			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> -	serial8250_resources[1].end =
> -			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> -
> -	return platform_device_register(&serial_device);
> +	if (IS_ENABLED(CONFIG_SERIAL_8250)) {
> +		u8 tmp;
> +
> +		/*
> +		 * GPIO 1-1: external UART interrupt line
> +		 */
> +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO));
> +		gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1), "ext-uart-int");
> +		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> +
> +		/*
> +		 * Unmask UART interrupt
> +		 */
> +		tmp = __raw_readb(KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
> +		tmp |= 0x2;
> +		__raw_writeb(tmp, KZM_ARM11_IO_ADDRESS(KZM_ARM11_CTL1));
> +
> +		serial_platform_data[0].irq =
> +				gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> +		serial8250_resources[1].start =
> +				gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> +		serial8250_resources[1].end =
> +				gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_1));
> +
> +		return platform_device_register(&serial_device);
> +	} else {
> +		return 0;
> +	}
>  }
> -#else
> -static inline int kzm_init_ext_uart(void)
> -{
> -	return 0;
> -}
> -#endif
>  
>  /*
>   * SMSC LAN9118
> @@ -178,44 +175,39 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>  
>  static int __init kzm_init_smsc9118(void)
>  {
> -	/*
> -	 * GPIO 1-2: SMSC9118 interrupt line
> -	 */
> -	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
> -	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
> -	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> -
> -	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
> -
> -	kzm_smsc9118_resources[1].start =
> -			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> -	kzm_smsc9118_resources[1].end =
> -			gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> -
> -	return platform_device_register(&kzm_smsc9118_device);
> +	if (IS_ENABLED(CONFIG_SMSC911X)) {
> +		/*
> +		 * GPIO 1-2: SMSC9118 interrupt line
> +		 */
> +		mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
> +		gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
> +		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> +
> +		regulator_register_fixed(0, dummy_supplies,
> +					 ARRAY_SIZE(dummy_supplies));
> +
> +		kzm_smsc9118_resources[1].start =
> +				gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> +		kzm_smsc9118_resources[1].end =
> +				gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
> +
> +		return platform_device_register(&kzm_smsc9118_device);
> +	} else {
> +		return 0;
> +	}
>  }
> -#else
> -static inline int kzm_init_smsc9118(void)
> -{
> -	return 0;
> -}
> -#endif
>  
> -#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
>  static const struct imxuart_platform_data uart_pdata __initconst = {
>  	.flags = IMXUART_HAVE_RTSCTS,
>  };
>  
>  static void __init kzm_init_imx_uart(void)
>  {
> -	imx31_add_imx_uart0(&uart_pdata);
> -	imx31_add_imx_uart1(&uart_pdata);
> -}
> -#else
> -static inline void kzm_init_imx_uart(void)
> -{
> +	if (IS_ENABLED(CONFIG_SERIAL_IMX)) {
> +		imx31_add_imx_uart0(&uart_pdata);
> +		imx31_add_imx_uart1(&uart_pdata);
> +	}
>  }
> -#endif
>  
>  static int kzm_pins[] __initdata = {
>  	MX31_PIN_CTS1__CTS1,
> 
> Having said that, just dropping the #ifdefs and registering the devices
> even without the matching driver is fine for me, too.
> 
> Best regards
> Uwe
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
