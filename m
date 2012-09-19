From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 19 Sep 2012 14:37:35 +0400
Subject: [RFC PATCH 08/10] ARM:davinci - migrating to use
 davinci_common_clk_init
In-Reply-To: <1347993342-6099-9-git-send-email-m-karicheri2@ti.com>
References: <1347993342-6099-1-git-send-email-m-karicheri2@ti.com>
 <1347993342-6099-9-git-send-email-m-karicheri2@ti.com>
Message-ID: <5059A06F.4050402@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-09-2012 22:35, Murali Karicheri wrote:

> The common clk code uses a new function davinci_common_clk_init()
> defined in drivers/clk/davinci/davinci-clock.c to initialize the
> clk drivers. This function is now invoked in time.c as part of
> davinci_timer_init(). Currently davinci_clk_init() is called from
> davinci_common_init() which is too early to initialize common clk
> drivers. Also include pll.h instead of clock.h in some of the source
> files.

> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

> diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
> index 64b0f65..f854296 100644
> --- a/arch/arm/mach-davinci/common.c
> +++ b/arch/arm/mach-davinci/common.c
[...]
> @@ -106,7 +108,9 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
>   		goto err;
>
>   	if (davinci_soc_info.cpu_clks) {
> +#ifndef CONFIG_COMMON_CLK

    Shouldn't you enclose in theis #ifndef the whole *if* statement?

>   		ret = davinci_clk_init(davinci_soc_info.cpu_clks);
> +#endif
>
>   		if (ret != 0)
>   			goto err;
[...]
> diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
> index d4e9316..5c04a7c 100644
> --- a/arch/arm/mach-davinci/sleep.S
> +++ b/arch/arm/mach-davinci/sleep.S
> @@ -183,6 +187,7 @@ ENDPROC(davinci_cpu_suspend)
>    * 	r1: contains virtual base for DDR2 Power and Sleep controller (PSC)
>    * 	r2: contains PSC number for DDR2
>    */
> +

    Unrelated/unnecessary change?

>   ENTRY(davinci_ddr_psc_config)
>   	/* Set next state in mdctl for DDR2 */
>   	mov	r6, #MDCTL

WBR, Sergei
