From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Apr 2016 08:43:29 -0700
Subject: [PATCH] pinctrl: pinctrl-single: Fix
 pcs_parse_bits_in_pinctrl_entry to use __ffs than ffs
In-Reply-To: <1460530865-29085-1-git-send-email-j-keerthy@ti.com>
References: <1460530865-29085-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20160413154328.GR5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [160413 00:03]:
> pcs_parse_bits_in_pinctrl_entry uses ffs which gives bit indices
> ranging from 1 to MAX. This leads to a corner case where we try to request
> the pin number = MAX and fails.
> 
> bit_pos value is being calculted using ffs. pin_num_from_lsb uses
> bit_pos value. pins array is populated with:
> 
> pin + pin_num_from_lsb.
> 
> The above is 1 more than usual bit indices as bit_pos uses ffs to compute
> first set bit. Hence the last of the pins array is populated with the MAX
> value and not MAX - 1 which causes error when we call pin_request.

Hmm that sounds like a bug to me, just one comment below.

> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1323,9 +1323,9 @@ static int pcs_parse_bits_in_pinctrl_entry(struct pcs_device *pcs,
>  
>  		/* Parse pins in each row from LSB */
>  		while (mask) {
> -			bit_pos = ffs(mask);
> +			bit_pos = __ffs(mask);
>  			pin_num_from_lsb = bit_pos / pcs->bits_per_pin;
> -			mask_pos = ((pcs->fmask) << (bit_pos - 1));
> +			mask_pos = ((pcs->fmask) << bit_pos);
>  			val_pos = val & mask_pos;
>  			submask = mask & mask_pos;

Can you please also change the pcs->fshift = ffs(pcs->fmask) - 1 to
use __ffs to avoid confusion?

Regards,

Tony
