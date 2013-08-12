From: galak@codeaurora.org (Kumar Gala)
Date: Mon, 12 Aug 2013 12:04:46 -0500
Subject: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
In-Reply-To: <1672769.GMC6E5TsBH@flatron>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
 <1672769.GMC6E5TsBH@flatron>
Message-ID: <5D9E26D4-6273-45CD-B79E-62865F6C5991@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 12, 2013, at 11:59 AM, Tomasz Figa wrote:

> On Monday 12 of August 2013 17:43:54 Mark Rutland wrote:
>> [Adding other devicetree maintainers to Cc]
>> 
>> On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
>>> ________________________________________
>>> 
>>>> ???: Mark Rutland [mark.rutland at arm.com]
>>>> ????: 2013?8?10? 22:08
>>>> ???: Lu Jingchang-B35083
>>>> ??: wsa at the-dreams.de; Estevam Fabio-R49496; Li Xiaochun-B41219;
>>>> s.hauer at pengutronix.de; linux-i2c at vger.kernel.org; Jin
>>>> Zhengxiong-R64188; shawn.guo at linaro.org;
>>>> linux-arm-kernel at lists.infradead.org ??: Re: [PATCH v3 2/2] i2c:
>>>> imx: Add Vybrid VF610 I2C controller support> >
>>>> On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>>>>>  Add Freescale Vybrid VF610 I2C controller support to
>>>>> 
>>>>> imx I2C driver framework.
>>>>> 
>>>>>  Some operation is different from imx I2C controller.
>>>>> 
>>>>> The register offset, the i2c clock divider value table,
>>>>> the module enabling(I2CR_IEN) which is just invert with imx,
>>>>> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
>>>>> but w0c on imx.
>>>>> 
>>>>> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
>>>>> Signed-off-by: Xiaochun Li <b41219@freescale.com>
>>>>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>>>>> ---
>>>>> 
>>>>> changes in v3:
>>>>>  Using struct naming the i2c clock {div, regval} pair.
>>>>> 
>>>>> Using address shift handling registers address difference.
>>>>> 
>>>>> changes in v2:
>>>>>  Fix building section mismatch(es) warning.
>>>>> 
>>>>> drivers/i2c/busses/i2c-imx.c | 146
>>>>> ++++++++++++++++++++++++++++++++++++------- 1 file changed, 122
>>>>> insertions(+), 24 deletions(-)
>>>> 
>>>> [...]
>>>> 
>>>>> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
>>>>> 
>>>>> static const struct of_device_id i2c_imx_dt_ids[] = {
>>>>> 
>>>>>        { .compatible = "fsl,imx1-i2c", .data =
>>>>>        &imx_i2c_devtype[IMX1_I2C], },
>>>>>        { .compatible = "fsl,imx21-i2c", .data =
>>>>>        &imx_i2c_devtype[IMX21_I2C], },> >> 
>>>>> +       { .compatible = "fsl,vf610-i2c", .data =
>>>>> &imx_i2c_devtype[VF610_I2C], },> >> 
>>>>>        { /* sentinel */ }
>>>>> 
>>>>> };
>>>> 
>>>> That string doesn't seem to be documented anywhere (from a quick grep
>>>> of Documentation/devicetree), and there's no binding update included
>>>> here. It would be nice for that to be fixed :)
>>> 
>>> [Lu Jingchang]
>>> The binding string for i2c-imx driver in
>>> Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard
>>> format of "- compatible : Should be "fsl,<chip>-i2c" " for device
>>> using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c is
>>> described in the binding document. So I just leave the vf610 i2c
>>> compatible with this.
>> I'm not a big fan on wildcards in bindings, as it leaves people free to
>> put anything in and claim it's a documented binding, and makes it far
>> harder for an os to actually implement drivers for said binding, as
>> there's no canonical reference for the set of valid variations.
>> 
>> Obviously there is some precedent, but I'm not sure it's something we
>> want to stick with, and we can prevent it my updating the documentation
>> now.
>> 
>> Does anyone else have an opinion?
> 
> In case of Samsung platforms we decided to always use the name of first 
> SoC in which given IP appeared and list all compatible SoCs in binding 
> documentation. This is IMHO the most consistent way, as there is no 
> confusion about IP versions (not always listed in documentation, not even 
> saying about unavailable documentation) or potential problems with new 
> SoCs matching the wildcard, but having different IP.
> 
> In this particular case, the <chip> wildcard can be easily transformed 
> into a non-wildcard binding, by listing all supported <chip> values, i.e. 
> adding following text to binding documentation:
> 
> 8<--
> The <chip> can be one of:
> - imx1 - for i.MX1 and compatible SoCs,
> - imx21 - for i.MX21 and compatible SoCs,
> - vf610 - for Vybrid VF610 and compatible SoCs.
> -->8
> 
> Best regards,
> Tomasz


One way to handle this is to introduce a SoC Family <chip> name doc with the possible list of names and than reference that doc in the binding.  Kinda like how we have vendor-prefixes.txt.

And maybe instead of doing <chip> its <imx-chip> or some reference that isn't too generic such that in the future a .dts could be validated.

- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
