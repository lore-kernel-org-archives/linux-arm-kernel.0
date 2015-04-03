From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 21:46:26 +0200
Subject: [PATCH v2 1/4] i2c: tegra: implement slave mode
In-Reply-To: <1427745615-5428-2-git-send-email-danindrey@mail.ru>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <1427745615-5428-2-git-send-email-danindrey@mail.ru>
Message-ID: <20150403194626.GB2016@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static void tegra_i2c_slave_write(struct tegra_i2c_dev *i2c_dev, u32 val)
> +{
> +	i2c_writel(i2c_dev, val, I2C_SL_RCVD);
> +
> +	/*
> +	 * TODO: A correct fix needs to be found for this.
> +	 *
> +	 * We experience less incomplete messages with this delay than without
> +	 * it, but we don't know why. Help is appreciated.
> +	 */

Uh oh. So I assume this is another reason for staging?

> +	if (!i2c_dev->slave || !i2c_dev->slave->slave_cb)
> +		return -EINVAL;

The core checks for slave_cb being valid.

> +		i2c_slave_event(i2c_dev->slave, I2C_SLAVE_STOP, &dummy);

You could use value here, too, or?

> +	if (!tegra_i2c_slave_isr(irq, i2c_dev))
> +		return IRQ_HANDLED;

Minor nit: I'd prefer == 0 here, since it reads "if not slave_isr return
handled".

> +	if (slave->addr > 0x7F)
> +		addr2 = (slave->addr >> 7) | I2C_SL_ADDR2_TEN_BIT_MODE;

Nope. There are 10 bit encodings of addresses 0x000-0x07f, too. So, you
need to check for the flag (slave->flags & I2C_CLIENT_TEN).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/560a4959/attachment.sig>
