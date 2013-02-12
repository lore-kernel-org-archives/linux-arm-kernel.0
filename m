From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Feb 2013 08:49:11 -0800
Subject: [PATCH] ARM: omap: board-h4: remove warning for is_gpmc_muxed
In-Reply-To: <1360640836-18792-1-git-send-email-olof@lixom.net>
References: <1360640836-18792-1-git-send-email-olof@lixom.net>
Message-ID: <20130212164910.GF4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130211 19:51]:
> If the ethernet driver is not selected, you otherwise get:
> 
> arch/arm/mach-omap2/board-h4.c:237:12: warning: 'is_gpmc_muxed' defined but not used [-Wunused-function]
> 
> I guess it could be argued that the device setup should/could always
> be done even if the driver isn't enabled, but hopefully the board files
> will all go away some day so let's stick to the smaller delta.

Looks right to me. The only thing stopping us from removing board-h4.c
is the GPMC + smc91x DT binding for NFS root. I doubt anybody is using
H4 for anything else.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-omap2/board-h4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
> index 812c829..e34541d 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -229,6 +229,8 @@ static u32 get_sysboot_value(void)
>  		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
>  }
>  
> +#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
> +
>  /* H4-2420's always used muxed mode, H4-2422's always use non-muxed
>   *
>   * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap2423
> @@ -246,8 +248,6 @@ static u32 is_gpmc_muxed(void)
>  		return 0;
>  }
>  
> -#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
> -
>  static struct omap_smc91x_platform_data board_smc91x_data = {
>  	.cs		= 1,
>  	.gpio_irq	= 92,
> -- 
> 1.8.1.192.gc4361b8
> 
