From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 20 Nov 2012 14:46:04 +0100
Subject: [PATCH 1/3] can: c_can: Add d_can raminit support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA771E9@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-2-git-send-email-anilkumar@ti.com>
 <50AB6081.9060701@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA771E9@DBDE01.ent.ti.com>
Message-ID: <50AB899C.3040701@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 02:05 PM, AnilKumar, Chimata wrote:
[...]

>>>  static struct platform_device_id c_can_id_table[] = {
>>>  	[BOSCH_C_CAN_PLATFORM] = {
>>>  		.name = KBUILD_MODNAME,
>>> @@ -99,7 +119,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  	const struct of_device_id *match;
>>>  	const struct platform_device_id *id;
>>>  	struct pinctrl *pinctrl;
>>> -	struct resource *mem;
>>> +	struct resource *mem, *res;
>>>  	int irq;
>>>  	struct clk *clk;
>>>  
>>> @@ -178,6 +198,18 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>>>  		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>>>  		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
>>> +
>>> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +		priv->raminit_ctrlreg =
>>> +				devm_request_and_ioremap(&pdev->dev, res);
>>
>> What happens if there isn't a second IORESOURCE_MEM region? devm_request
>> will print an error in this case and any other error, too [1]. Do we
>> need streamlining here?
>>
>> [1] http://lxr.free-electrons.com/source/drivers/base/platform.c#L59
> 
> I did not get what the point is.
> 
> In most of the cases above two API's returns NULL. Even res is NULL
> nothing to worry, first condition in devm_request_and_ioremap() is
> NULL pointer check of res. If "res" is NULL then devm_xx will return
> NULL which result into printing of below warning.
> 
>>
>>> +		if (!priv->raminit_ctrlreg)
>>> +			dev_warn(&pdev->dev, "failed to obtain control memory\n");
> 
> I will change this warning to info
> 
> if (!priv->raminit_ctrlreg)
> 	dev_info(&pdev->dev, "control memory is not used for raminit\n");

That's more descriptive, good.

Marc


-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/3669f037/attachment.sig>
