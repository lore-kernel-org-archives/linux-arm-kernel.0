From: zonque@gmail.com (Daniel Mack)
Date: Mon, 29 Oct 2012 10:49:21 +0100
Subject: [PATCH] ARM: AM33xx: add support for reboot
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB50073@DBDE01.ent.ti.com>
References: <1351448275-23509-1-git-send-email-zonque@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EB50073@DBDE01.ent.ti.com>
Message-ID: <508E5121.9020304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.10.2012 05:31, Hiremath, Vaibhav wrote:
> On Sun, Oct 28, 2012 at 23:47:55, Daniel Mack wrote:
>> This patch adds the ability to reboot am33xx-based systems.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  arch/arm/mach-omap2/board-generic.c | 1 +
>>  arch/arm/mach-omap2/prcm.c          | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
>> index 601ecdf..6a69ceb 100644
>> --- a/arch/arm/mach-omap2/board-generic.c
>> +++ b/arch/arm/mach-omap2/board-generic.c
>> @@ -114,6 +114,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>>  	.init_machine	= omap_generic_init,
>>  	.timer		= &omap3_am33xx_timer,
>>  	.dt_compat	= am33xx_boards_compat,
>> +	.restart	= omap_prcm_restart,
>>  MACHINE_END
>>  #endif
>>  
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index 0f51e03..8a3068a 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -32,6 +32,7 @@
>>  #include "clock2xxx.h"
>>  #include "cm2xxx_3xxx.h"
>>  #include "prm2xxx_3xxx.h"
>> +#include "prm33xx.h"
>>  #include "prm44xx.h"
>>  #include "prminst44xx.h"
>>  #include "cminst44xx.h"
>> @@ -72,6 +73,11 @@ void omap_prcm_restart(char mode, const char *cmd)
>>  		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
>>  	} else if (cpu_is_omap44xx()) {
>>  		omap4_prminst_global_warm_sw_reset(); /* never returns */
>> +	} else if (soc_is_am33xx()) {
>> +		prcm_offs = AM33XX_PRM_DEVICE_MOD;
>> +		omap2_prm_set_mod_reg_bits(OMAP4430_RST_GLOBAL_COLD_SW_MASK,
>> +					   prcm_offs,
>> +					   AM33XX_PRM_RSTCTRL_OFFSET);
> 
> This is not clean way of handling it, we should have something similar to 
> omap4. Also we should use warm-reset here instead of cold.
> 
> I have quickly created patch, can you please review and test is?
> I have tested it on AM335x EVM and Bone platform.

Works for me as well, thanks!

You can take my

  Tested-by: Daniel Mack <zonque@gmail.com>

if you wish ...


> 
> 
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 601ecdf..6a69ceb 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -114,6 +114,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
>         .init_machine   = omap_generic_init,
>         .timer          = &omap3_am33xx_timer,
>         .dt_compat      = am33xx_boards_compat,
> +       .restart        = omap_prcm_restart,
>  MACHINE_END
>  #endif
> 
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 0f51e03..490f8f6 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -33,6 +33,7 @@
>  #include "cm2xxx_3xxx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm44xx.h"
> +#include "prm33xx.h"
>  #include "prminst44xx.h"
>  #include "cminst44xx.h"
>  #include "prm-regbits-24xx.h"
> @@ -72,6 +73,8 @@ void omap_prcm_restart(char mode, const char *cmd)
>                 omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
>         } else if (cpu_is_omap44xx()) {
>                 omap4_prminst_global_warm_sw_reset(); /* never returns */
> +       } else if (soc_is_am33xx()) {
> +               am33xx_prm_global_warm_sw_reset();      /* never returns */
>         } else {
>                 WARN_ON(1);
>         }
> diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
> index e7dbb6c..505219d 100644
> --- a/arch/arm/mach-omap2/prm33xx.c
> +++ b/arch/arm/mach-omap2/prm33xx.c
> @@ -133,3 +133,18 @@ int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
> 
>         return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
>  }
> +
> +void am33xx_prm_global_warm_sw_reset(void)
> +{
> +       u32 v;
> +
> +       v = am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
> +                                   AM33XX_PRM_RSTCTRL_OFFSET);
> +       v |= AM33XX_GLOBAL_WARM_SW_RST_MASK;
> +       am33xx_prm_write_reg(v, AM33XX_PRM_DEVICE_MOD,
> +                                AM33XX_PRM_RSTCTRL_OFFSET);
> +
> +       /* OCP barrier */
> +       v = am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
> +                                   AM33XX_PRM_RSTCTRL_OFFSET);
> +}
> diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
> index 3f25c56..cdfc694 100644
> --- a/arch/arm/mach-omap2/prm33xx.h
> +++ b/arch/arm/mach-omap2/prm33xx.h
> @@ -126,4 +126,5 @@ extern int am33xx_prm_is_hardreset_asserted(u8 shift, s16 inst,
>  extern int am33xx_prm_assert_hardreset(u8 shift, s16 inst, u16 rstctrl_offs);
>  extern int am33xx_prm_deassert_hardreset(u8 shift, s16 inst,
>                 u16 rstctrl_offs, u16 rstst_offs);
> +extern void am33xx_prm_global_warm_sw_reset(void);
> 
> 
> Thanks,
> Vaibhav
> 
