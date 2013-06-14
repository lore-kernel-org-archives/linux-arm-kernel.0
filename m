From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Jun 2013 15:58:59 +0200
Subject: [PATCH v2] i2c: vt8500: Add support for I2C bus on Wondermedia
 SoCs
In-Reply-To: <1371023785-3132-1-git-send-email-linux@prisktech.co.nz>
References: <1371023785-3132-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130614135857.GA2929@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 07:56:25PM +1200, Tony Prisk wrote:
> This patch adds support for the I2C bus controllers found on Wondermedia
> 8xxx-series SoCs. Only master-mode is supported.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---

Please describe here what changed since the last version. It's a lot
easier and faster to review then.

> +static int wmt_i2c_xfer(struct i2c_adapter *adap,
> +			struct i2c_msg msgs[],
> +			int num)
> +{
> +	struct i2c_msg *pmsg;
> +	int i, is_last, no_start;
> +	int ret = 0;
> +
> +	for (i = 0; ret >= 0 && i < num; i++) {
> +		is_last = ((i + 1) == num);
> +		no_start = (i != 0);

(i != 0) is a restart condition (start instead of stop)...

> +
> +		pmsg = &msgs[i];
> +		if (pmsg->flags & I2C_M_NOSTART)
> +			no_start = 1;

...and this is a no_start (concatenating messages). I do have the
impression you are mixing those two?

> +		if (pmsg->flags & I2C_M_RD)
> +			ret = wmt_i2c_read(adap, pmsg, no_start, is_last);
> +		else
> +			ret = wmt_i2c_write(adap, pmsg, no_start, is_last);
> +	}
> +
> +	return (ret < 0) ? ret : i;
> +}
> +	adap = &i2c_dev->adapter;
> +	i2c_set_adapdata(adap, i2c_dev);
> +	strlcpy(adap->name, "WMT I2C adapter", sizeof(adap->name));
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &wmt_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->dev.of_node = pdev->dev.of_node;
> +	adap->nr = of_alias_get_id(pdev->dev.of_node, "i2c");

Drop this line...

> +
> +	init_completion(&i2c_dev->complete);
> +
> +	err = wmt_i2c_reset_hardware(i2c_dev);
> +	if (err) {
> +		dev_err(&pdev->dev, "error initializing hardware\n");
> +		return err;
> +	}
> +
> +	err = i2c_add_numbered_adapter(adap);

... and use i2c_add_adpter here. Since recently the core checks the
ofnode for an alias. Sorry, forgot to mention this last time.

> +	if (err) {
> +		dev_err(&pdev->dev, "failed to add adapter\n");
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	of_i2c_register_devices(adap);
> +
> +	return 0;
> +}
> +
> +module_platform_driver(wmt_i2c_driver);
> +
> +MODULE_DESCRIPTION("Wondermedia I2C master-mode bus adapter");
> +MODULE_AUTHOR("Tony Prisk <linux@prisktech.co.nz>");
> +MODULE_LICENSE("GPL and additional rights");

I see no additional rights mentioned. According to the header "GPL"
should do, but you know the original sources better.

> +MODULE_DEVICE_TABLE(of, wmt_i2c_dt_ids);
> -- 
> 1.7.9.5
> 

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/36622107/attachment.sig>
