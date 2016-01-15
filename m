From: leoli@freescale.com (Li Yang)
Date: Fri, 15 Jan 2016 16:46:06 +0800
Subject: [PATCH v3] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <20160115075356.GI24441@pengutronix.de>
References: <1452842844-16256-1-git-send-email-leoyang.li@nxp.com>
 <20160115075356.GI24441@pengutronix.de>
Message-ID: <CADRPPNT=+amxRcea=N7m96=wKgdbRmU8R5cBACvTn7XffKofzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 3:53 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello,
>
> On Fri, Jan 15, 2016 at 01:27:24AM -0600, Li Yang wrote:
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index a2b132c..1239bfa 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -1081,8 +1081,11 @@ static int i2c_imx_probe(struct platform_device *pdev)
>>               return ret;
>>       }
>>
>> +     /* optional bus recovery feature through pinctrl */
>>       i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
>> -     if (IS_ERR(i2c_imx->pinctrl)) {
>> +     /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
>> +     if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
>> +                     PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {
>>               ret = PTR_ERR(i2c_imx->pinctrl);
>>               goto clk_disable;
>>       }
>> @@ -1125,7 +1128,10 @@ static int i2c_imx_probe(struct platform_device *pdev)
>>                       i2c_imx, IMX_I2C_I2CR);
>>       imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2SR);
>>
>> -     i2c_imx_init_recovery_info(i2c_imx, pdev);
>> +     if (IS_ERR_OR_NULL(i2c_imx->pinctrl))
>
> I'd prefer to set i2c_imx->pinctrl to NULL if it's not used and then use
>
>         if (!i2c_imx->pinctrl)
>
> here. (Or maybe make i2c_imx_init_recovery_info aware of this situation
> to keep the caller simple?)

Setting not used pointer to NULL might be a good coding practice
generally.  But in this case neither the driver nor gpio framework
checks if the pinctrl is NULL before accessing it.  We still need the
driver to make sure pinctrl is not used in this situation.  The
benefit of the proposed change seems to be pretty limited.  :)

Regards,
Leo
