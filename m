From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 18 Mar 2015 21:31:51 +0100
Subject: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
In-Reply-To: <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20150318203151.GA12072@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

so, the bus recovery patches look fine to me in general.

It is only this one question left which I always had with bus recovery.
Maybe you guys can join me thinking about it.

> @@ -376,8 +366,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
>  						      dev->adapter.timeout);
>  	if (r == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		davinci_i2c_recover_bus(dev);
> -		i2c_davinci_init(dev);
> +		i2c_recover_bus(adap);
>  		dev->buf_len = 0;
>  		return -ETIMEDOUT;

The I2C specs say in 3.1.16 that the recovery procedure should be used
when SDA is stuck low. So, I do wonder if we should apply the recovery
after a timeout. Stuck SDA might be one reason for timeout, but there
may be others...

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150318/fe06be70/attachment.sig>
