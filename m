From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 15:56:27 +0000
Subject: [RFC PATCHv2 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <1342113976-27140-3-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-3-git-send-email-dinguyen@altera.com>
Message-ID: <201207171556.28314.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 July 2012, dinguyen at altera.com wrote:

> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> new file mode 100644
> index 0000000..133fc89
> --- /dev/null
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -0,0 +1,7 @@
> +config MACH_SOCFPGA_CYCLONE5
> +       bool "SOCFPGA Cyclone5 platform"
> +       select COMMON_CLK
> +       select HAVE_SMP
> +       select PLAT_SOCFPGA_ETH
> +       help
> +         Include support for the Altera(R) Cyclone5 development platform.

Ah, so you actually select COMMON_CLK already. I wonder why that works,
since you are also defining your own "struct clk" that gets passed into
the clk_lookup table. I guess there is a bug somewhere.

> diff --git a/arch/arm/mach-socfpga/common.h b/arch/arm/mach-socfpga/common.h
> index e66587f..ba90e7a 100644
> --- a/arch/arm/mach-socfpga/common.h
> +++ b/arch/arm/mach-socfpga/common.h
> @@ -18,6 +18,6 @@
>  #ifndef __MACH_SOCFPGA_COMMON_H
>  #define __MACH_SOCFPGA_COMMON_H
>  
> -extern struct sys_timer socfpga_timer;
> +extern struct sys_timer dw_apb_timer;
>  
>  #endif

This should get folded into the first patch.

> +static const char *altera_dt_match[] = {
> +	"altr,socfpga-cyclone5",
> +	NULL
> +};
> +
> +DT_MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
> +	.init_irq	= gic_init_irq,
> +	.handle_irq     = gic_handle_irq,
> +	.timer		= &dw_apb_timer,
> +	.init_machine	= socfpga_cyclone5_init,
> +	.restart	= socfpga_cyclone5_restart,
> +	.dt_compat	= altera_dt_match,
> +MACHINE_END

I think you should not require more than one such file per platform,
so I would either name the entire platform cyclone5 instead of socfpga,
or if you expect this to all stay compatible with future products,
remove the cyclone5 name here and just call it all socfpga. The dt_match
array can still list multiple compatible strings, one for each family
or so.

	Arnd
