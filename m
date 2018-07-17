From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Jul 2018 17:27:51 +0530
Subject: [PATCH] i2c: davinci: Avoid zero value of CLKH
In-Reply-To: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
Message-ID: <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2018 08:50 PM, Alexander Sverdlin wrote:
> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
> and stretch the clock in this case.

This must be by observation since specification does not seem to state
this.

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

In any case, the patch is fine.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

> ---
>  drivers/i2c/busses/i2c-davinci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 75d6ab177055..7379043711df 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -237,12 +237,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>  	/*
>  	 * It's not always possible to have 1 to 2 ratio when d=7, so fall back
>  	 * to minimal possible clkh in this case.
> +	 *
> +	 * Note:
> +	 * CLKH is not allowed to be 0, in this case I2C clock is not generated
> +	 * at all
>  	 */
> -	if (clk >= clkl + d) {
> +	if (clk > clkl + d) {
>  		clkh = clk - clkl - d;
>  		clkl -= d;
>  	} else {
> -		clkh = 0;
> +		clkh = 1;
>  		clkl = clk - (d << 1);
>  	}
>  
> -- 
> 2.18.0
> 
