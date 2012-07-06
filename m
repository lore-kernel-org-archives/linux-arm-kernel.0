From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jul 2012 01:53:58 -0700
Subject: [PATCH] ARM: OMAP2: twl-common: fix compiler warnings
In-Reply-To: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
References: <1340880592-21700-1-git-send-email-t-kristo@ti.com>
Message-ID: <20120706085357.GS1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [120628 03:54]:
> OMAP2 does not use the external voltage controller code for TWL, and
> thus OMAP2 only compilation generates following warnings:

Hmm well omap2420 does not have twl, but 2430 usually has. So do you
mean that 2430 does not use the external voltage controller code?

> arch/arm/mach-omap2/twl-common.c:51: warning: 'twl_set_voltage' defined but not used
> arch/arm/mach-omap2/twl-common.c:57: warning: 'twl_get_voltage' defined but not used
> 
> This patch moves the code in question behind ARCH specific flags and
> eliminates these warnings.
...

> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -48,6 +48,7 @@ static struct i2c_board_info __initdata omap4_i2c1_board_info[] = {
>  	},
>  };
>  
> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>  static int twl_set_voltage(void *data, int target_uV)
>  {
>  	struct voltagedomain *voltdm = (struct voltagedomain *)data;
> @@ -59,6 +60,7 @@ static int twl_get_voltage(void *data)
>  	struct voltagedomain *voltdm = (struct voltagedomain *)data;
>  	return voltdm_get_voltage(voltdm);
>  }
> +#endif

To avoid patching this piece of code for new SoCs, can we make it
ifndef CONFIG_ARCH_OMAP2? Also in the makefile we should not even
build twl-common.o for 2420 only builds..

Regards,

Tony
