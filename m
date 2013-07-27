From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 27 Jul 2013 16:35:39 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBpbXg6IHBsbHYxOiBGaXggUExMIGNhbGN1bGF0?=
 =?UTF-8?B?aW9uIGZvciBpLk1YMjc=?=
In-Reply-To: <1374896500-21862-1-git-send-email-shc_work@mail.ru>
References: <1374896500-21862-1-git-send-email-shc_work@mail.ru>
Message-ID: <1374928539.407887609@f303.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Incorrect. Please forget about this patch.

> MFN bit 9 on i.MX27 has a different meaning than in other SOCs. This
> is a just sign bit. This patch makes different calculation for i.MX27.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-pllv1.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
> index c1eaee3..e76d601 100644
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
> +			mfn_abs = mfn & 0x200;
> +		else
> +			mfn_abs = 0x400 - mfn;
> +	}
>  
>  	rate = parent_rate * 2;
>  	rate /= pd + 1;
> @@ -70,7 +80,7 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
>  
>  	do_div(ll, mfd + 1);
>  
> -	if (!cpu_is_mx1() && !cpu_is_mx21() && mfn >= 0x200)
> +	if (allow_signed_mfn() && (mfn & 0x200))
>  		ll = -ll;
>  
>  	ll = (rate * mfi) + ll;
> -- 

---
