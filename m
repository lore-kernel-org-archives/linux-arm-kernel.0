From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 18 Mar 2013 14:11:10 +0530
Subject: [PATCH v5 1/2] ARM: davinci: dm355: add support for v4l2 video
 display
In-Reply-To: <1363429052-1081-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1363429052-1081-1-git-send-email-prabhakar.csengg@gmail.com>
 <1363429052-1081-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <5146D326.4080905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2013 3:47 PM, Prabhakar lad wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> Create platform devices for various video modules like venc,osd,
> vpbe and v4l2 driver for dm355.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Comments on the DM365 series apply to this one too. In addition:

> +static int dm355_vpbe_setup_pinmux(enum v4l2_mbus_pixelcode if_type,
> +			    int field)
>  {
> -	vpfe_capture_dev.dev.platform_data = cfg;
> +	switch (if_type) {
> +	case V4L2_MBUS_FMT_SGRBG8_1X8:
> +		davinci_cfg_reg(DM355_VOUT_FIELD_G70);
> +		break;
> +
> +	case V4L2_MBUS_FMT_YUYV10_1X20:
> +		/*
> +		 * This was VPBE_DIGITAL_IF_YCC16. Replace the enum

"was VPBE_DIGITAL_IF_YCC16" when? This is the first time this code is
getting in.

> +		 * accordingly when the right one gets into open source

What is the "right one"? And "open source" == kernel? Then may be just
call it that.

> +		 */
> +		if (field)
> +			davinci_cfg_reg(DM355_VOUT_FIELD);
> +		else
> +			davinci_cfg_reg(DM355_VOUT_FIELD_G70);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	davinci_cfg_reg(DM355_VOUT_COUTL_EN);
> +	davinci_cfg_reg(DM355_VOUT_COUTH_EN);
> +
> +	return 0;
>  }
>  
> +static inline u32 dm355_reg_modify(void *reg, u32 val, u32 mask)
> +{
> +	u32 new_val = (readl(reg) & ~mask) | (val & mask);
> +
> +	writel(new_val, reg);
> +
> +	return new_val;
> +}

This function needs to be removed.

Thanks,
Sekhar
