From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 26 Feb 2014 14:20:30 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSHY2XVsgMy81XSB2aWRlbzogbXgzZmI6IEludHJvZHVjZSBy?=
 =?UTF-8?B?ZWd1bGF0b3Igc3VwcG9ydC4=?=
In-Reply-To: <1393408800-8946-3-git-send-email-denis@eukrea.com>
References: <1393408800-8946-1-git-send-email-denis@eukrea.com>
 <1393408800-8946-3-git-send-email-denis@eukrea.com>
Message-ID: <1393410030.488354633@f216.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 26 ??????? 2014, 10:59 +01:00 ?? Denis Carikli <denis@eukrea.com>:
> This commit is based on the following commit by Fabio Estevam:
>   4344429 video: mxsfb: Introduce regulator support
...
> +++ b/drivers/video/mx3fb.c
...
> @@ -1409,6 +1435,9 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  			return -EINVAL;
>  		}
>  
> +		of_property_read_string(display_np, "regulator-name",
> +					&regulator_name);
> +
>  		of_property_read_string(display_np, "interface-pix-fmt",
>  					&ipu_disp_format);
>  		if (!ipu_disp_format) {
> @@ -1526,6 +1555,21 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  	if (ret < 0)
>  		goto esetpar;
>  
> +	/* In dt mode,
> +	 * using devm_regulator_get would require that the proprety referencing
> +	 * the regulator phandle has to be inside the mx3fb node.

What???

> +	 */
> +	if (np) {
> +		if (regulator_name)
> +			mx3fbi->reg_lcd = regulator_get(NULL, regulator_name);
> +
> +		if (IS_ERR(mx3fbi->reg_lcd))
> +			return PTR_ERR(mx3fbi->reg_lcd);
> +	} else {
> +		/* Permit that driver without a regulator in non-dt mode */
> +		mx3fbi->reg_lcd = regulator_get(dev, "lcd");
> +	}

Why you want to use an excess "regulator-name" property?
Just use devm_regulator_get(dev, "lcd") for both dt/non-dt case.
