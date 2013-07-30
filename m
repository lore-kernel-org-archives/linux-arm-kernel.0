From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 30 Jul 2013 08:37:05 +0200
Subject: [PATCH v2] ARM: imx: pllv1: Fix PLL calculation for i.MX27
In-Reply-To: <1375112243-1557-1-git-send-email-shc_work@mail.ru>
References: <1375112243-1557-1-git-send-email-shc_work@mail.ru>
Message-ID: <20983.24337.582506.529947@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Alexander Shiyan writes:
> MFN bit 9 on i.MX27 has a different meaning than in other SOCs. This
> is a just sign bit. This patch makes different calculation for i.MX27.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-pllv1.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
> index c1eaee3..a289ccd 100644
> --- a/arch/arm/mach-imx/clk-pllv1.c
> +++ b/arch/arm/mach-imx/clk-pllv1.c
> @@ -25,6 +25,11 @@ struct clk_pllv1 {
>  
>  #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
>  
> +static inline bool allow_signed_mfn(void)
> +{
> +	return !cpu_is_mx1() && !cpu_is_mx21();
> +}
> +
>  static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
>  		unsigned long parent_rate)
>  {
> @@ -59,9 +64,14 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
>  	/*
>  	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
>  	 * 2's complements number
> +	 * On i.MX27 the bit 9 is the sign bit.
>  	 */
> -	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
> -		mfn_abs = 0x400 - mfn;
> +	if (allow_signed_mfn() && (mfn & 0x200)) {
> +		if (cpu_is_mx27())
> +			mfn_abs = mfn & 0x1ff;
> +		else
> +			mfn_abs = 0x400 - mfn;
> +	}
>  
Please don't hardcode magic numbers. Even more when using variants of
the same number like 0x200 and 0x1ff (0x200 - 1) in multiple places.
If someone copies the code and wants to adapt it, they will have to
change lots of different but related numbers in different places which
is horribly error prone.

#define MFN_BITS 10
#define MFN_SIGN (1 << (MFN_BITS - 1))
#define MFN_MASK (MFN_SIGN - 1)
With these defines you can derive all the numbers you need in a
consistent way and need to change only ONE place to adapt the code.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
