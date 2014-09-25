From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 25 Sep 2014 09:58:59 +0000
Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c driver
In-Reply-To: <6a2c63ad3a60461a830a00281c9d0b3c@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1411632689-31531-1-git-send-email-yao.yuan@freescale.com>
 <1411632689-31531-2-git-send-email-yao.yuan@freescale.com>
 <6a2c63ad3a60461a830a00281c9d0b3c@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <0f491b0c56264ee09a09f94b718536f4@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Duan Fugang-B38611
> Sent: Thursday, September 25, 2014 5:25 PM
> To: Yuan Yao-B46683; wsa at the-dreams.de; marex at denx.de
> Cc: LW at KARO-electronics.de; mark.rutland at arm.com; shawn.guo at linaro.org;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-i2c at vger.kernel.org
> Subject: RE: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> driver
> 
> From: Yuan Yao <yao.yuan@freescale.com> Sent: Thursday, September 25,
> 2014 4:11 PM
> >To: wsa at the-dreams.de; marex at denx.de
> >Cc: LW at KARO-electronics.de; mark.rutland at arm.com; Duan Fugang-B38611;
> >shawn.guo at linaro.org; linux-kernel at vger.kernel.org; linux-arm-
> >kernel at lists.infradead.org; linux-i2c at vger.kernel.org
> >Subject: [PATCH v8 1/2] i2c: imx: add DMA support for freescale i2c
> >driver
> >
> >Add dma support for i2c. This function depend on DMA driver.
> >You can turn on it by write both the dmas and dma-name properties in
> >dts node.
> >DMA is optional, even DMA request unsuccessfully, i2c can also work well.
> >
> >Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> >---
> > drivers/i2c/busses/i2c-imx.c | 352
> >+++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 342 insertions(+), 10 deletions(-)
> >
> >diff --git a/drivers/i2c/busses/i2c-imx.c
> >b/drivers/i2c/busses/i2c-imx.c index 613069b..c643756 100644
> >--- a/drivers/i2c/busses/i2c-imx.c
> >+++ b/drivers/i2c/busses/i2c-imx.c
> >@@ -37,22 +37,27 @@
> >+	 */
> >+	imx_i2c_write_reg(msgs->addr << 1, i2c_imx, IMX_I2C_I2DR);
> >+	reinit_completion(&i2c_imx->dma->cmd_complete);
> >+	result = wait_for_completion_interruptible_timeout(
> >+				&i2c_imx->dma->cmd_complete,
> >+				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));
> >+	if (result <= 0) {
> >+		dmaengine_terminate_all(dma->chan_using);
> >+		if (result)
> >+			return result;
> >+		else
> >+			return -ETIMEDOUT;
> >+	}
> >+
> >+	/* Waiting for Transfer complete. */
> >+	while (1) {
> >+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >+		if (temp & I2SR_ICF)
> Why not wait for IIF ?

[Yuan Yao] 
IIF is often used. But IIF cannot indicate transfer completely in DMA mode. 
So TCF(I2SR_ICF) is the only choice.

> >+			break;
> >+		if (time_after(jiffies, orig_jiffies +
> >+				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT))) {
> >+			dev_dbg(dev, "<%s> Timeout\n", __func__);
> >+			return -ETIMEDOUT;
> >+		}
> >+		schedule();
> >+	}

Thanks & Best regards,
Yuan Yao
