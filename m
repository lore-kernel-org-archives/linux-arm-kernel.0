From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 15 Feb 2011 17:16:52 +0200
Subject: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
In-Reply-To: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
References: <1297756738-2696-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <20110215171652.601c9c68.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Feb 2011 13:28:58 +0530
Shweta Gulati <shweta.gulati@ti.com> wrote:

> This patch is based on LO PM Branch and Smartreflex has been
> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
> OMAP2430 SDP.
> 
I saw this was working on N900 (kind of special instrumentation
setup) after enabling /sys/kernel/debug/voltage/[vdd_core |
vdd_mpu]/smartreflex/autocomp. Few comments below.

> @@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
>  		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
>  	}
...
> +	if (!twl_sr_enable_autoinit)
> +		omap3_twl_set_sr_bit(true);
...
> +int __init omap3_twl_set_sr_bit(bool enable)
> +{
> +	u8 temp;
> +	int ret;
> +	if (twl_sr_enable_autoinit)
> +		pr_warning("%s: unexpected multiple calls\n", __func__);
> +
> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +					TWL4030_DCDC_GLOBAL_CFG);
> +	if (ret)
> +		goto err;
> +
> +	if (enable)
> +		temp |= SMARTREFLEX_ENABLE;
> +	else
> +		temp &= ~SMARTREFLEX_ENABLE;
> +
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +				TWL4030_DCDC_GLOBAL_CFG);

Would it make more sense to set only the flag here and do the register
writes when omap3_twl_init is executing? Then it's not so strict when
the board code calls this function.

> +	if (!ret) {
> +		twl_sr_enable_autoinit = true;
> +		return 0;

Should this be twl_sr_enable_autoinit = enable (if going to do
register write here)?

-- 
Jarkko
