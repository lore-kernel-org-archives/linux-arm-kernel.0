From: hs@denx.de (Heiko Schocher)
Date: Tue, 29 Jan 2013 09:02:07 +0100
Subject: [PATCH 2/2] ARM: davinci: da850: configure CS2(aemif) for norflash
In-Reply-To: <1359436796-25135-3-git-send-email-anilkumar.v@ti.com>
References: <1359436796-25135-1-git-send-email-anilkumar.v@ti.com>
 <1359436796-25135-3-git-send-email-anilkumar.v@ti.com>
Message-ID: <510781FF.7030400@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kumar,

On 29.01.2013 06:19, Kumar, Anil wrote:
> Configure 16 bit data bus width for CS2(aemif) to use the norflash on
> DA850.
> 
> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>
> ---
> :100644 100644 37c27af... 540e284... M	arch/arm/mach-davinci/da8xx-dt.c
>  arch/arm/mach-davinci/da8xx-dt.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 37c27af..540e284 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -38,12 +38,29 @@ static void __init da8xx_init_irq(void)
>  }
>  
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
> +#define DA8XX_AEMIF_CE2CFG_OFFSET       0x10
> +#define DA8XX_AEMIF_ASIZE_16BIT         0x1

Hmm... I am not really happy with such defines, because different
boards need maybe different settings, and this should be catched
by the device tree ...  Couldn't we add this infos in the
device tree? I tried such an approach here:

First post and some discussion:
https://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/010030.html

Nori suggested here
https://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/011330.html
to move such an driver out of arch/arm and IIRC it was
suggested to move it into the mfd framework. I currently
not know, if there was such a sort of patches, to get this
in the mfd subsystem, but I think, this CS settings should be
done like the pinmux settings ...

My last posted version of this patch:
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-March/013036.html

Maybe it is worth to discuss this again?

> +
> +static void __init da8xx_init_nor(void)
> +{
> +	void __iomem *aemif_addr;
> +
> +	aemif_addr = ioremap(DA8XX_AEMIF_CTL_BASE, SZ_32K);
> +
> +	/* Configure data bus width of CS2 to 16 bit */
> +	writel(readl(aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET) |
> +			DA8XX_AEMIF_ASIZE_16BIT,
> +			aemif_addr + DA8XX_AEMIF_CE2CFG_OFFSET);

I vote for avoiding such board specific code in a generic
approach ...

> +
> +	iounmap(aemif_addr);
> +}
>  
>  static void __init da850_init_machine(void)
>  {
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  
>  	da8xx_uart_clk_enable();
> +	da8xx_init_nor();
>  }
>  
>  static const char *da850_boards_compat[] __initdata = {
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
