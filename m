From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 01 Aug 2014 11:24:56 +0200
Subject: [PATCH v2] pinctrl: rockchip: fix rk3288 gpio0 configuration
In-Reply-To: <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
References: <1543632.JNPYWq24Lp@diego>
 <1406872680-14641-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <1610557.3nVa59E5gW@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. Juli 2014, 22:58:00 schrieb Sonny Rao:
> On rk3288, for gpio bank 0, the registers which configure pull-up,
> iomux, and drive strength don't implement the enable bits in the upper
> half of the register, unlike the other gpio configuration registers,
> and so the kernel must perform a read-modify-write of the register to
> update a particular gpio in that bank.
> 
> The current code is actually clobbering the contents of the register,
> so this fixes it by using regmap_update_bits and masking out only the
> bits which require updating.  In the case of bank0 on rk3288 the upper
> enable bits will just get ignored, and the other configurations won't
> get clobbered.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


thanks for this fix
Heiko

> ---
> v2: rebase onto latest pinctrl with drive strength and fix this bug on
>   iomux and drive strength as well.
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index c15f7f9..4ff5dc3 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -438,7 +438,7 @@ static int rockchip_set_mux(struct rockchip_pin_bank
> *bank, int pin, int mux) int reg, ret, mask;
>  	unsigned long flags;
>  	u8 bit;
> -	u32 data;
> +	u32 data, rmask;
> 
>  	if (iomux_num > 3)
>  		return -EINVAL;
> @@ -478,8 +478,9 @@ static int rockchip_set_mux(struct rockchip_pin_bank
> *bank, int pin, int mux) spin_lock_irqsave(&bank->slock, flags);
> 
>  	data = (mask << (bit + 16));
> +	rmask = data | (data >> 16);
>  	data |= (mux & mask) << bit;
> -	ret = regmap_write(regmap, reg, data);
> +	ret = regmap_update_bits(regmap, reg, rmask, data);
> 
>  	spin_unlock_irqrestore(&bank->slock, flags);
> 
> @@ -634,7 +635,7 @@ static int rk3288_set_drive(struct rockchip_pin_bank
> *bank, int pin_num, struct regmap *regmap;
>  	unsigned long flags;
>  	int reg, ret, i;
> -	u32 data;
> +	u32 data, rmask;
>  	u8 bit;
> 
>  	rk3288_calc_drv_reg_and_bit(bank, pin_num, &regmap, &reg, &bit);
> @@ -657,9 +658,10 @@ static int rk3288_set_drive(struct rockchip_pin_bank
> *bank, int pin_num,
> 
>  	/* enable the write to the equivalent lower bits */
>  	data = ((1 << RK3288_DRV_BITS_PER_PIN) - 1) << (bit + 16);
> +	rmask = data | (data >> 16);
>  	data |= (ret << bit);
> 
> -	ret = regmap_write(regmap, reg, data);
> +	ret = regmap_update_bits(regmap, reg, rmask, data);
>  	spin_unlock_irqrestore(&bank->slock, flags);
> 
>  	return ret;
> @@ -722,7 +724,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, int reg, ret;
>  	unsigned long flags;
>  	u8 bit;
> -	u32 data;
> +	u32 data, rmask;
> 
>  	dev_dbg(info->dev, "setting pull of GPIO%d-%d to %d\n",
>  		 bank->bank_num, pin_num, pull);
> @@ -750,6 +752,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank,
> 
>  		/* enable the write to the equivalent lower bits */
>  		data = ((1 << RK3188_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> +		rmask = data | (data >> 16);
> 
>  		switch (pull) {
>  		case PIN_CONFIG_BIAS_DISABLE:
> @@ -770,7 +773,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, return -EINVAL;
>  		}
> 
> -		ret = regmap_write(regmap, reg, data);
> +		ret = regmap_update_bits(regmap, reg, rmask, data);
> 
>  		spin_unlock_irqrestore(&bank->slock, flags);
>  		break;
