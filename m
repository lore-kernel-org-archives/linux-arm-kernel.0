From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 12:24:19 +0000
Subject: [PATCHv5,RESEND] rtc: Add support for Intersil ISL12057 I2C RTC
 chip
In-Reply-To: <28bfd1b8cd4725a70fb713a8b6503e7f5db13d71.1387305663.git.arno@natisbad.org>
References: <28bfd1b8cd4725a70fb713a8b6503e7f5db13d71.1387305663.git.arno@natisbad.org>
Message-ID: <20131218122419.GM28455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 08:07:28PM +0100, Arnaud Ebalard wrote:
> 
> Intersil ISL12057 is an I2C RTC chip also supporting two alarms. This
> patch only adds support for basic RTC functionalities (i.e. getting and
> setting time). Tests have been performed on NETGEAR ReadyNAS 102 w/
> startup/shutdown scripts, hwclock, ntpdate and openntpd.

Reviewed-by: Mark Brown <broonie@linaro.org>

but

> +static int isl12057_rtc_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct isl12057_rtc_data *data = dev_get_drvdata(dev);
> +	int reg, ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Status register */
> +	ret = regmap_read(data->regmap, ISL12057_REG_SR, &reg);
> +	if (ret) {
> +		dev_err(dev, "%s: reading SR failed\n", __func__);
> +		goto out;
> +	}
> +
> +	seq_printf(seq, "status_reg\t:%s%s%s (0x%.2x)\n",
> +		   (reg & ISL12057_REG_SR_OSF) ? " OSF" : "",
> +		   (reg & ISL12057_REG_SR_A1F) ? " A1F" : "",
> +		   (reg & ISL12057_REG_SR_A2F) ? " A2F" : "", reg);
> +
> +	/* Control register */
> +	ret = regmap_read(data->regmap, ISL12057_REG_INT, &reg);
> +	if (ret) {
> +		dev_err(dev, "%s: reading INT failed\n", __func__);
> +		goto out;
> +	}
> +
> +	seq_printf(seq, "control_reg\t:%s%s%s%s%s%s (0x%.2x)\n",
> +		   (reg & ISL12057_REG_INT_A1IE) ?  " A1IE"  : "",
> +		   (reg & ISL12057_REG_INT_A2IE) ?  " A2IE"  : "",
> +		   (reg & ISL12057_REG_INT_INTCN) ? " INTCN" : "",
> +		   (reg & ISL12057_REG_INT_RS1) ?   " RS1"   : "",
> +		   (reg & ISL12057_REG_INT_RS2) ?   " RS2"   : "",
> +		   (reg & ISL12057_REG_INT_EOSC) ?  " EOSC"  : "", reg);
> +
> + out:
> +	mutex_unlock(&data->lock);

I'm not sure the lock is achieving anything any more - the only time it
actualy protects more than one operation is the above but since the
status register is volatile anyway it might change between it being read
and the control register being read.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/74207624/attachment-0001.sig>
