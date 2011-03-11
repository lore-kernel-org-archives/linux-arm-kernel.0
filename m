From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 11 Mar 2011 17:16:18 +0100
Subject: [PATCH] ARM: mxs/tx28: fix up LCD pads
In-Reply-To: <1299342440-30620-1-git-send-email-shawn.guo@freescale.com>
References: <1299342440-30620-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <19834.19154.967544.735547@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> * In any case, LCD only needs one group of VSYNC, HSYNC, and DOTCLK.
>   So remove the redundant and useless one.
> * LCD_ENABLE pad should not work as a GPIO for LCD, and there must be
>   one pad for ENABLE function.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Hi Lothar, Uwe,
> 
> I do not have the schematics of TX28 board, and I'm guessing the fix.
> So it really needs your comments here.
> 
> Regards,
> Shawn
> 
>  arch/arm/mach-mxs/mach-tx28.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> index b65e371..16a0059 100644
> --- a/arch/arm/mach-mxs/mach-tx28.c
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -61,11 +61,7 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
>  	MX28_PAD_LCD_RD_E__LCD_VSYNC | LCD_MODE,
>  	MX28_PAD_LCD_WR_RWN__LCD_HSYNC | LCD_MODE,
>  	MX28_PAD_LCD_RS__LCD_DOTCLK | LCD_MODE,
> -	MX28_PAD_LCD_CS__LCD_CS | LCD_MODE,
>
This one is correct as it stands (i.e. the suggested change is wrong).

> -	MX28_PAD_LCD_VSYNC__LCD_VSYNC | LCD_MODE,
> -	MX28_PAD_LCD_HSYNC__LCD_HSYNC | LCD_MODE,
> -	MX28_PAD_LCD_DOTCLK__LCD_DOTCLK | LCD_MODE,
>
These should be removed from the pin list, as suggested.

> -	MX28_PAD_LCD_ENABLE__GPIO_1_31 | LCD_MODE,
> +	MX28_PAD_LCD_CS__LCD_ENABLE | LCD_MODE,
>
This change is also wrong. The pad is used as a (power) enable pin for
a certain family of LCDs that we recommend for use with our
modules. It should be configured as GPIO and pulled high/low whenever
the LCD is activated/deactivated (just like the LCD_RESET pad below).

>  	MX28_PAD_LCD_RESET__GPIO_3_30 | LCD_MODE,
>  	MX28_PAD_PWM0__PWM_0 | LCD_MODE,
>  

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
