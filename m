From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 11 Aug 2010 16:33:45 +0200
Subject: [PATCH] ARM: COLIBRI PXA320: fix UCB1400 irq autoprobing
In-Reply-To: <AANLkTinxeEbZqwdB=bzC=ZZFqk1iR28yv=ECYRFNeUE=@mail.gmail.com>
References: <AANLkTinxeEbZqwdB=bzC=ZZFqk1iR28yv=ECYRFNeUE=@mail.gmail.com>
Message-ID: <20100811143345.GU17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuri,

thanks for the patch.

On Wed, Aug 11, 2010 at 04:54:13PM +0400, Yuri Ludkevich wrote:
> Ads properly initialization to GPIO4 ( alt. fn. #1, nCS3; because GPIO4 and
> GPIO4_2 cannot be
> configured as GPIO simultaneously ) so GPIO4_2 which used as irq line from
> UCB1400 may be
> detected while irq autoprobing routine.

This looks fine to me, but Marek wanted to rework the board support in
order to unify the GPIO configs for better readability. Marek, is there
any tree which contains your changes already?


Thanks,
Daniel


> 
> Signed-off by: Yuri Ludkevich <urx.forever@gmail.com>
> ---
> 
> --- linux-next/arch/arm/mach-pxa/colibri-pxa320.c.orig  2010-08-11
> 16:01:46.000000000 +0400
> +++ linux-next/arch/arm/mach-pxa/colibri-pxa320.c       2010-08-11
> 16:23:30.000000000 +0400
> @@ -236,6 +236,19 @@ static void __init colibri_pxa320_init_u
>         pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_uart_pin_config));
>  }
> 
> +
> +static mfp_cfg_t colibri_pxa320_cpld_pin_config[] __initdata = {
> +       /* init GPIO4 as nCS3 (AF1). If GPIO4 stay as GPIO
> +          touchscreen irq (GPIO4_2 pin) autoprobing will not work.
> +          See Marvell PXA320 datasheet for more details */
> +       GPIO4_nCS3,
> +};
> +
> +static void __init colibri_pxa320_init_cpld(void)
> +{
> +       pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa320_cpld_pin_config));
> +}
> +
>  void __init colibri_pxa320_init(void)
>  {
>         pxa_set_ffuart_info(NULL);
> @@ -252,6 +265,7 @@ void __init colibri_pxa320_init(void)
>                                 mfp_to_gpio(MFP_PIN_GPIO28));
>         colibri_pxa320_init_uart();
>         colibri_pxa320_init_udc();
> +       colibri_pxa320_init_cpld();
>  }
> 
>  MACHINE_START(COLIBRI320, "Toradex Colibri PXA320")
