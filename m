From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 20 Dec 2011 19:15:47 +0000
Subject: [PATCH v6 05/11] ARM: davinci: create new common platform
 header for davinci
In-Reply-To: <1323951120-15876-6-git-send-email-manjunath.hadli@ti.com>
References: <1323951120-15876-1-git-send-email-manjunath.hadli@ti.com>
 <1323951120-15876-6-git-send-email-manjunath.hadli@ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6051001@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manju,

On Thu, Dec 15, 2011 at 17:41:54, Hadli, Manjunath wrote:
> remove the code from individual platform header files for

Not just the code, the files themselves are being removed.

> dm365, dm355, dm644x and dm646x and consolidate it into a
> single and common header file davinci.h.

.. placed in arch/arm/mach-davinci/

> 
> This reduces the pollution in the include/mach and is consistent
> with Russel's suggestions as part of his "pet peaves" mail.
> 
> The further patches in the series take  advantage of this consolidation
> for easy implementation of IO_ADDRESS elimination.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> ---

[...]

> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index 4e0e707..7ae0d15 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -26,7 +26,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> -#include <mach/dm355.h>
> +#include "davinci.h"
>  #include <mach/i2c.h>

Local headers should typically be the last ones
included. Can you please revisit the header file
inclusion order throughout this patch? The headers
in linux/ need to be added first followed by asm/
mach/ and then the private headers.

Also, like headers need to be grouped together using
empty lines. You can look at arch/arm/mach-davinci/board-dm644x-evm.c
as an example of how existing code looks.

[...]

> diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h

> +/* DM355 function declarations */
> +struct spi_board_info;
> +
> +void __init dm355_init(void);
> +void dm355_init_spi0(unsigned chipselect_mask,
> +		struct spi_board_info *info, unsigned len);
> +void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata);
> +void dm355_set_vpfe_config(struct vpfe_config *cfg);
> +
> +/* DM365 function declarations */
> +void __init dm365_init(void);
> +void __init dm365_init_asp(struct snd_platform_data *pdata);
> +void __init dm365_init_vc(struct snd_platform_data *pdata);
> +void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
> +void __init dm365_init_rtc(void);
> +void dm365_init_spi0(unsigned chipselect_mask,
> +			struct spi_board_info *info, unsigned len);
> +

You can drop the empty line here...

> +void dm365_set_vpfe_config(struct vpfe_config *cfg);
> +
> +/* DM644x function declarations */
> +void __init dm644x_init(void);
> +void __init dm644x_init_asp(struct snd_platform_data *pdata);
> +void dm644x_set_vpfe_config(struct vpfe_config *cfg);
> +
> +/* DM646x function declarations */
> +void __init dm646x_init(void);
> +void __init dm646x_init_mcasp0(struct snd_platform_data *pdata);
> +void __init dm646x_init_mcasp1(struct snd_platform_data *pdata);
> +int __init dm646x_init_edma(struct edma_rsv_info *rsv);
> +
> +void dm646x_video_init(void);
> +
> +void dm646x_setup_vpif(struct vpif_display_config *,
> +		       struct vpif_capture_config *);

.. and these two as well.

I have merged 2/11, 3/11 and 4/11 of this series into
my master branch. Can you please respin 1/11 and 5/11
of this series based on my new master and with my
comments fixed?

Based on your patch 1/11, I guess you have grepped the
driver sources to make sure none of them are including
any of the files you are deleting. Want to double check.

Thanks,
Sekhar
