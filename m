From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 9 Oct 2009 13:30:12 -0400
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4ACF6EB9.1010509@techworks.ie>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>	<4AC3B748.5060904@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>	<20091001145939.GA28044@n2100.arm.linux.org.uk><BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>
	<4ACE598E.1090908@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7CDE@mi8nycmail19.Mi8.com>
	<4ACE7261.1030302@techworks.ie>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7CE4@mi8nycmail19.Mi8.com>
	<4ACF6EB9.1010509@techworks.ie>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7D97@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 09, 2009 10:11 AM, Christian Gagneraud wrote:
> I've noticed as well that there's missing bits from Matthieu's 
> 0024-ep93xx_pwm.patch, that's almost nothing, but I guess that was the 
> main reason Matthieu added PWM support to EP93XX:
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 086d069..ee7baeb 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -303,6 +303,9 @@ static void __init ts72xx_init_machine(void)
>          spi_register_board_info(ts72xx_spi_bus, 
> ARRAY_SIZE(ts72xx_spi_bus));
>          #endif
> 
> +       /* PWM1 is DIO_6 on TS-72xx header */
> +       ep93xx_register_pwm(1, 1);
> +
>          ep93xx_register_eth(&ts72xx_eth_data, 1);
>   }

Matthieu must have rebased his yahoo patches recently.  The copy I have
registered his old driver as:

+	// DIO_6 on TS-72xx header
+	#if defined(CONFIG_EP93XX_PWM) || defined(CONFIG_EP93XX_PWM_MODULE)
+	(void) platform_device_register_simple("ep93xx-pwm", 1, NULL, 0);
+	#endif 

When I submitted the updated pwm driver I didn't add the code to register
the pwm peripheral in any of the platform init's.

If you want to use the pwm signals just add the ep93xx_register_pwm() call
to your init_machine().

Regards,
Hartley
