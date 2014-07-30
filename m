From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Jul 2014 11:22:36 +0200
Subject: [PATCH] pinctrl: rockchip: fix rk3288 gpio0 pull up configuration
In-Reply-To: <1406690465-11081-1-git-send-email-sonnyrao@chromium.org>
References: <1406690465-11081-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <1543632.JNPYWq24Lp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sonny,

Am Dienstag, 29. Juli 2014, 20:21:05 schrieb Sonny Rao:
> On rk3288, for gpio bank 0, the registers which configure pull-ups
> don't implement the enable bits in the upper half of the register,
> unlike the other gpio configuration registers, and so the kernel
> must perform a read-modify-write of the register to update a
> particular gpio's pull up settings in that bank.
> 
> The current code is actually clobbering the contents of the register,
> so this fixes it by using regmap_update_bits and masking out only the
> bits which require updating.  In the case of gpio0 on rk3288 the upper
> enable bits will just get ignored, and the other configurations won't
> get clobbered.

I have a similar fix, I had slightly forgotten about, in [0]. But I like
your approach a lot better, so could you expand your fix to also
handle the muxing and drive strength settings, which suffer from
the same handling difference on the rk3288?


Thanks
Heiko


[0] https://github.com/mmind/linux-rockchip/commit/c79d2a687c81b99fb566ef17b1c33ad45458e0be


> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c
> b/drivers/pinctrl/pinctrl-rockchip.c index 5e8b2e0..bd00ae9 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -722,7 +722,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, int reg, ret;
>  	unsigned long flags;
>  	u8 bit;
> -	u32 data;
> +	u32 data, mask;
> 
>  	dev_dbg(info->dev, "setting pull of GPIO%d-%d to %d\n",
>  		 bank->bank_num, pin_num, pull);
> @@ -751,6 +751,14 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, /* enable the write to the equivalent lower bits */
>  		data = ((1 << RK3188_PULL_BITS_PER_PIN) - 1) << (bit + 16);
> 
> +		/*
> +		 * on rk3288, gpio bank 0 doesn't support the write enable, and
> +		 * upper 16 bit are always zero, so we create a mask which will
> +		 * only update the bits we want in the lower 16, while still
> +		 * preserving write enable bits in upper 16.
> +		 */
> +		mask = data | (data >> 16);
> +
>  		switch (pull) {
>  		case PIN_CONFIG_BIAS_DISABLE:
>  			break;
> @@ -770,7 +778,7 @@ static int rockchip_set_pull(struct rockchip_pin_bank
> *bank, return -EINVAL;
>  		}
> 
> -		ret = regmap_write(regmap, reg, data);
> +		ret = regmap_update_bits(regmap, reg, mask, data);
> 
>  		spin_unlock_irqrestore(&bank->slock, flags);
>  		break;
