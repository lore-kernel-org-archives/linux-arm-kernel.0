From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 6 Aug 2014 07:06:41 +0000
Subject: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fugang,

Duan Fugang wrote:
[...]
>+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>+	dma_sconfig.dst_maxburst = 1;
> The maxburst is 1 cause very slow efficiency for DMA copy, which system
> performance even is slower Than cpu mode.

There is no FIFO for IMX i2c, so the maxburst shoud be 1 for hardware request.

[...]

> >+	/* Waiting for Transfer complete. */
> >+	while (timeout--) {
> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >+		if (temp & I2SR_ICF)
> >+			break;
> >+		udelay(10);
> >+	}
> Whether there have better method like interrupt to avoid dead wait here until
> timeout ?

Can you give me more suggestion? We have discussed it with our team, It seems the short query wait is necessary.

> >+
> >+	if (!timeout)
> >+		return -ETIMEDOUT;
> >+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> >+	temp &= ~I2CR_DMAEN;
> >+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> >+
> >+	/* The last data byte must be transferred by the CPU. */
> >+	imx_i2c_write_reg(msgs->buf[msgs->len-1],
> >+				i2c_imx, IMX_I2C_I2DR);
> >+	result = i2c_imx_trx_complete(i2c_imx);
> >+	if (result)
> >+		return result;
> I don't understand why the last data need to be transmited by cpu. I guess you
> want to get IIF interrupt ?

Yes, we need the interrupt to do some mop-up.

Also follow the hardware request as:

The following flow diagram details exactly the operation for using a DMA controller to
transmit "n" data bytes to a slave. The first byte (the slave calling address) is always
transmitted by the CPU. All subsequent data bytes (apart from the last data byte) can be
transferred by the DMA controller. The last data byte must be transferred by the CPU.


> >+
> >+	result = i2c_imx_acked(i2c_imx);
> >+	if (result)
> >+		return result;
> >+
