From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Nov 2012 13:53:27 -0800
Subject: [PATCH v4 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121109215327.GT6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

One more comment on this one..

* Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:21]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1009,6 +1186,46 @@ static int __devinit pcs_probe(struct platform_device *pdev)
>  	pcs->bits_per_mux = of_property_read_bool(np,
>  						  "pinctrl-single,bit-per-mux");
>  
> +	if (conf->nconfs) {
> +		pcs_pinconf_ops.is_generic = true;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,power-source-mask",
> +				&pcs->psmask);
> +		if (ret) {
> +			pcs->psmask = PCS_OFF_DISABLED;
> +			pcs->psshift = PCS_OFF_DISABLED;
> +		} else
> +			pcs->psshift = ffs(pcs->psmask) - 1;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,bias-mask", &pcs->bmask);
> +		if (ret) {
> +			pcs->bmask = PCS_OFF_DISABLED;
> +			pcs->bshift = PCS_OFF_DISABLED;
> +		} else
> +			pcs->bshift = ffs(pcs->bmask) - 1;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,bias-disable", &pcs->bdis);
> +		if (ret)
> +			pcs->bdis = PCS_OFF_DISABLED;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,bias-pull-up", &pcs->bpullup);
> +		if (ret)
> +			pcs->bpullup = PCS_OFF_DISABLED;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,bias-pull-down",
> +				&pcs->bpulldown);
> +		if (ret)
> +			pcs->bpulldown = PCS_OFF_DISABLED;
> +		ret = of_property_read_u32(np,
> +				"pinctrl-single,input-schmitt-mask",
> +				&pcs->ismask);
> +		if (ret) {
> +			pcs->ismask = PCS_OFF_DISABLED;
> +			pcs->isshift = PCS_OFF_DISABLED;
> +		} else
> +			pcs->isshift = ffs(pcs->ismask) - 1;
> +	}
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(pcs->dev, "could not get resource\n");

I tried to make pinconf work with the omap CONTROL_PBIASLITE
register, but noticed that we need to change the binding to make
pinctrl-single,bits type controllers work.

Basically we need to move the pinconf properties to be defined
under pinctrl-single,pins and pinctrl-single,bits rather than being
pinmux controller instance specific properties.

In the pinctrl-single,bits case we have multiple pinconf masks
for a single register, like in the omap CONTROL_PBIASLITE example
we discussed earlier.

Then let's just have a single pinctrl driver instance specific
property  pinctrl-single,pinconf that we can use to optimize out
the pinconf parsing for ranges that don't support pinconf.

Other than that, I think I'm finally done with my comments for
this patch, sorry it took so long and took so many emails.

Regards,

Tony
