From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 31 Jul 2017 22:16:29 +0200
Subject: [PATCHv5 3/3] i2c: altera: Add Altera I2C Controller driver
In-Reply-To: <305220e7-4ae2-ed44-e4ec-2abf9b3c38f0@linux.intel.com>
References: <1500309314-18464-1-git-send-email-thor.thayer@linux.intel.com>
 <1500309314-18464-4-git-send-email-thor.thayer@linux.intel.com>
 <20170731133124.smwztpkul2qjy26p@ninjato>
 <305220e7-4ae2-ed44-e4ec-2abf9b3c38f0@linux.intel.com>
Message-ID: <20170731201629.GC1542@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >>+	writel(ALTR_I2C_TFR_CMD_STA | ALTR_I2C_TFR_CMD_STO,
> >>+	       idev->base + ALTR_I2C_TFR_CMD);
> >>+	altr_i2c_reset(idev);
> >
> >Why the second reset?
> >
> 
> I wanted to start from a known clean condition. The first reset would reset
> the hardware. The 2nd would ensure the hardware is ready after clearing the
> bus. Maybe I'm being overly cautious but I don't have a way to check the
> status of the SDA line.

Well, it looks like the function will go for now anyhow...

> >>+		altr_i2c_recover(idev);
> >
> >And no need to reset the bus! Only if SDA is stuck low.
> >
> 
> OK. Unfortunately, we can't check the state of the SDA line so I was being
> extra cautious. I will remove it.

Thanks. Bus recovery really needs a testcase to be checked against.

> >>+static u32 altr_i2c_func(struct i2c_adapter *adap)
> >>+{
> >>+	return I2C_FUNC_I2C;
> >>+}
> >
> >No emulated SMBUS?
> >
> 
> I was focusing on I2C and wasn't sure about SMBus (particularly the minimum
> clock speed). SMBus could be added later but would require some IP changes.

I meant you can add I2C_FUNC_SMBUS_EMUL which makes the I2C core emulate
SMBus-style transactions via I2C messages for you. A lot of drivers
won't work if you don't have this.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/5d927e81/attachment.sig>
