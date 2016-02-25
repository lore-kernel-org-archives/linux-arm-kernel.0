From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 16:26:41 -0800
Subject: [PATCH 2/9] ARM: dts: uniphier: rework UniPhier System Bus nodes
In-Reply-To: <1455588911-9827-3-git-send-email-yamada.masahiro@socionext.com>
References: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
 <1455588911-9827-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160225002641.GC10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 16, 2016 at 11:15:04AM +0900, Masahiro Yamada wrote:

> diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
> index e1cfc1d..b53a8d9 100644
> --- a/arch/arm/mach-uniphier/platsmp.c
> +++ b/arch/arm/mach-uniphier/platsmp.c
> @@ -30,7 +30,7 @@
>   * The secondary CPUs check this register from the boot ROM for the jump
>   * destination.  After that, it can be reused as a scratch register.
>   */
> -#define UNIPHIER_SBC_ROM_BOOT_RSV2	0x1208
> +#define UNIPHIER_SMPCTRL_ROM_BOOT_RSV2	0x208
>  
>  static void __iomem *uniphier_smp_rom_boot_rsv2;
>  static unsigned int uniphier_smp_max_cpus;
> @@ -98,15 +98,14 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
>  	phys_addr_t rom_rsv2_phys;
>  	int ret;
>  
> -	np = of_find_compatible_node(NULL, NULL,
> -				"socionext,uniphier-system-bus-controller");
> -	ret = of_address_to_resource(np, 1, &res);
> +	np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
> +	ret = of_address_to_resource(np, 0, &res);
>  	if (ret) {
> -		pr_err("failed to get resource of system-bus-controller\n");
> +		pr_err("failed to get resource of uniphier-smpctrl\n");
>  		return ret;
>  	}
>  
> -	rom_rsv2_phys = res.start + UNIPHIER_SBC_ROM_BOOT_RSV2;
> +	rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_BOOT_RSV2;
>  
>  	ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
>  	if (ret)

The previous binding has already been released. You can update, but your driver
should be able to handle the previous binding.

So, you still need to keep the old code around.

This has the benefit of breaking the dependency between the code change and the
DT change, so you no longer have to change your platform code at the same time
as the DT to avoid regressions.


Please adjust and resend. I'll hold off applying the series until then, so we
don't have a partially applied series.


Thanks!

-Olof
