From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 17:23:35 -0600
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggdjMgMi8yXSBpMmM6IGlteDogQWRkIFY=?=
 =?UTF-8?B?eWJyaWQgVkY2MTAgSTJDIGNvbnRyb2xsZXIgc3VwcG9ydA==?=
In-Reply-To: <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
Message-ID: <52096E77.4040003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 10:43 AM, Mark Rutland wrote:
> [Adding other devicetree maintainers to Cc]
> 
> On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
>>
>> ________________________________________
>>> ???: Mark Rutland [mark.rutland at arm.com]
>>> ????: 2013?8?10? 22:08
>>> ???: Lu Jingchang-B35083
>>> ??: wsa at the-dreams.de; Estevam Fabio-R49496; Li Xiaochun-B41219; s.hauer at pengutronix.de; linux-i2c at vger.kernel.org; Jin Zhengxiong-R64188; shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
>>> ??: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
>>
>>> On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>>>>   Add Freescale Vybrid VF610 I2C controller support to
>>>> imx I2C driver framework.
>>>>   Some operation is different from imx I2C controller.
>>>> The register offset, the i2c clock divider value table,
>>>> the module enabling(I2CR_IEN) which is just invert with imx,
>>>> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
>>>> but w0c on imx.

>>>>  static const struct of_device_id i2c_imx_dt_ids[] = {
>>>>         { .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
>>>>         { .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
>>>> +       { .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
>>>
>>> That string doesn't seem to be documented anywhere (from a quick grep of
>>> Documentation/devicetree), and there's no binding update included
>>> here. It would be nice for that to be fixed :)
>>
>> [Lu Jingchang]
>> The binding string for i2c-imx driver in Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard format
>> of "- compatible : Should be "fsl,<chip>-i2c" " for device using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
>> is described in the binding document. So I just leave the vf610 i2c compatible with this. 
> 
> I'm not a big fan on wildcards in bindings, as it leaves people free to
> put anything in and claim it's a documented binding, and makes it far
> harder for an os to actually implement drivers for said binding, as
> there's no canonical reference for the set of valid variations.
> 
> Obviously there is some precedent, but I'm not sure it's something we
> want to stick with, and we can prevent it my updating the documentation
> now.
> 
> Does anyone else have an opinion?

I suppose technically we should list out every exact string in the
binding, but it's a little annoying to have to update the binding doc
every time a new chip comes out (and I expect that'll happen more and
more!) just to add a new compatible value since all the differences are
known internally to the driver and don't impact the binding...

Kumar's idea could be a reasonable compromise, although I guess it
doesn't technically cover the case of there being 10 chips, each of
which has *some* new/different IP block, yet some IP blocks not changing
in every chip, and hence drivers might only directly binding to 5 of the
10 possible compatible values in some cases...
