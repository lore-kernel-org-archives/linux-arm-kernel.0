From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 12:51:20 -0700
Subject: [PATCH v2 5/9] ARM: mediatek: enable gpt6 on boot up to make
 arch timer working
In-Reply-To: <1431763110-443-6-git-send-email-yingjoe.chen@mediatek.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-6-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <555B9438.9020404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/15 00:58, Yingjoe Chen wrote:
> diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
> index a954900..6b38d67 100644
> --- a/arch/arm/mach-mediatek/mediatek.c
> +++ b/arch/arm/mach-mediatek/mediatek.c
> @@ -16,6 +16,34 @@
>   */
>  #include <linux/init.h>
>  #include <asm/mach/arch.h>
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clocksource.h>
> +
> +
> +#define GPT6_CON_MT65xx 0x10008060
> +#define GPT_ENABLE      0x31
> +
> +static void __init mediatek_timer_init(void)
> +{
> +	void __iomem *gpt_base = 0;

 = NULL ?

> +
> +	if (of_machine_is_compatible("mediatek,mt6589") ||
> +	    of_machine_is_compatible("mediatek,mt8135") ||
> +	    of_machine_is_compatible("mediatek,mt8127")) {
> +		/* turn on GPT6 which ungates arch timer clocks */
> +		gpt_base = ioremap(GPT6_CON_MT65xx, 0x04);
> +	}
> +
> +	/* enabel clock and set to free-run */

s/enabel/enable/

> +	if (gpt_base) {
> +		writel(GPT_ENABLE, gpt_base);
> +		iounmap(gpt_base);
> +	}
> +

Why not join the two conditions together?

> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +};
>  
>  static const char * const mediatek_board_dt_compat[] = {
>  	"mediatek,mt6589",
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
