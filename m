From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Thu, 7 Aug 2014 05:28:51 +0000
Subject: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1407232563-10856-1-git-send-email-yao.yuan@freescale.com>
 <1407232563-10856-2-git-send-email-yao.yuan@freescale.com>
 <41705e1e4c604240ba96333a03d5c544@BLUPR03MB373.namprd03.prod.outlook.com>
 <14d042bbcfb04308bfb3a1db18e46bec@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <31f8f5504fc24d999f5af74338602bed@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao-B46683 Data: Wednesday, August 06, 2014 3:07 PM
>To: Duan Fugang-B38611; wsa at the-dreams.de; marex at denx.de
>Cc: LW at KARO-electronics.de; mark.rutland at arm.com; shawn.guo at linaro.org;
>linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
>i2c at vger.kernel.org; Li Frank-B20596
>Subject: RE: [PATCH v6 1/2] i2c: imx: add DMA support for freescale i2c
>driver
>
>Hi Fugang,
>
>Duan Fugang wrote:
>[...]
>>+	dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
>>+	dma_sconfig.dst_maxburst = 1;
>> The maxburst is 1 cause very slow efficiency for DMA copy, which
>> system performance even is slower Than cpu mode.
>
>There is no FIFO for IMX i2c, so the maxburst shoud be 1 for hardware
>request.
>
Understand. Thanks.

>
>> >+	/* Waiting for Transfer complete. */
>> >+	while (timeout--) {
>> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>> >+		if (temp & I2SR_ICF)
>> >+			break;
>> >+		udelay(10);
>> >+	}
>> Whether there have better method like interrupt to avoid dead wait
>> here until timeout ?
>
>Can you give me more suggestion? We have discussed it with our team, It
>seems the short query wait is necessary.
>
At least, you can use schdule_timeout() instead of udelay() ?

>> >+
>> >+	if (!timeout)
>> >+		return -ETIMEDOUT;
>> >+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>> >+	temp &= ~I2CR_DMAEN;
>> >+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
>> >+
>> >+	/* The last data byte must be transferred by the CPU. */
>> >+	imx_i2c_write_reg(msgs->buf[msgs->len-1],
>> >+				i2c_imx, IMX_I2C_I2DR);
>> >+	result = i2c_imx_trx_complete(i2c_imx);
>> >+	if (result)
>> >+		return result;
>> I don't understand why the last data need to be transmited by cpu. I
>> guess you want to get IIF interrupt ?
>
>Yes, we need the interrupt to do some mop-up.
>
>Also follow the hardware request as:
>
>The following flow diagram details exactly the operation for using a DMA
>controller to transmit "n" data bytes to a slave. The first byte (the
>slave calling address) is always transmitted by the CPU. All subsequent
>data bytes (apart from the last data byte) can be transferred by the DMA
>controller. The last data byte must be transferred by the CPU.
>
>> >+
>> >+	result = i2c_imx_acked(i2c_imx);
>> >+	if (result)
>> >+		return result;
>> >+
