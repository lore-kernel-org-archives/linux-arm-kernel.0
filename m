From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 4 May 2018 10:39:28 +0200
Subject: [PATCH V4 5/8] soc: mediatek: pwrap: add pwrap for mt6797 SoCs
In-Reply-To: <1525403052.14792.131.camel@mtkswgap22>
References: <20180502092112.3991-1-argus.lin@mediatek.com>
 <20180502092112.3991-6-argus.lin@mediatek.com>
 <1525320067.14792.95.camel@mtkswgap22> <1525328436.6214.10.camel@mtkswgap22>
 <1525403052.14792.131.camel@mtkswgap22>
Message-ID: <69e4766f-8c7a-7729-93f8-4f87d2ceff8b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/04/2018 05:04 AM, Sean Wang wrote:
> On Thu, 2018-05-03 at 14:20 +0800, Argus Lin wrote:
>> On Thu, 2018-05-03 at 12:01 +0800, Sean Wang wrote:
>>>  };
> 
> [...]
> 
>>>> @@ -1503,11 +1581,13 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	if (IS_ERR(wrp->base))
>>>>  		return PTR_ERR(wrp->base);
>>>>  
>>>> -	wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
>>>> -	if (IS_ERR(wrp->rstc)) {
>>>> -		ret = PTR_ERR(wrp->rstc);
>>>> -		dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
>>>> -		return ret;
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_RESET)) {
>>>> +		wrp->rstc = devm_reset_control_get(wrp->dev, "pwrap");
>>>
>>> there should be a reset bit present for pwrap on infrasys.
>>>
>>> the specific condition can be dropped when the reset cell is exported from infrasys and then the device has a reference to it.
>> hmm, I think it need to keep here.
>> because after pwrap initialized, it can't be reset alone.
>> It needs to reset PMIC simultaneously, too.
> 
> Reset a pair, either a master or its slave, all had been a part of
> pwrap_init.
> 
> The reset controller provided here is just to reset pwrap device.
> And for its slave reset, it should be done by pwrap_reset_spislave. 
> 
> So for MT6397, it should be able to fall into the same procedure.
> 
>>>
>>>> +		if (IS_ERR(wrp->rstc)) {
>>>> +			ret = PTR_ERR(wrp->rstc);
>>>> +			dev_dbg(wrp->dev, "cannot get pwrap reset: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>>  	}
>>>>  
>>>>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
>>>> @@ -1549,9 +1629,17 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	if (ret)
>>>>  		goto err_out1;
>>>>  
>>>> -	/* Enable internal dynamic clock */
>>>> -	pwrap_writel(wrp, 1, PWRAP_DCM_EN);
>>>> -	pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
>>>> +	/*
>>>> +	 * add dcm capability check
>>>> +	 */
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
>>>
>>> the specific condition can be dropped since so far all devices the driver can support are owning PWRAP_CAP_DCM
>> We did not support DCM for future chips.
>> MT6797 is the last one.
>> This why I want to add judgement here.
> 
> The series is only for MT6797 pwrap, so it's fine with only adding these
> things the SoC actually relies on. 
> 
> PWRAP_CAP_DCM should not be added until a new SoC without dcm is really
> introduced.
> 

I agree (and I think I said this already in a previous review).

Regards,
Matthias

>>>
>>>> +		if (wrp->master->type == PWRAP_MT6797)
>>>> +			pwrap_writel(wrp, 3, PWRAP_DCM_EN);
>>>
>>> the setup for MT6797 can be moved into .init_soc_specific callback ?
>>
>> I think put it here is more generally.
>>>
>>>> +		else
>>>> +			pwrap_writel(wrp, 1, PWRAP_DCM_EN);
>>>> +
>>>> +		pwrap_writel(wrp, 0, PWRAP_DCM_DBC_PRD);
>>>> +	}
>>>>  
>>>>  	/*
>>>>  	 * The PMIC could already be initialized by the bootloader.
>>>> @@ -1580,6 +1668,12 @@ static int pwrap_probe(struct platform_device *pdev)
>>>>  	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
>>>>  	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
>>>>  	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
>>>> +	/*
>>>> +	 * We add INT1 interrupt to handle starvation and request exception
>>>> +	 * If we support it, we should enable them here.
>>>> +	 */
>>>> +	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>>>> +		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>>>>  
>>>
>>> if there is no explicitly enabling on INT1, then ISR handling for INT1 is also unnecessary
>>
>> It's ok for me.
>>>
>>>>  	irq = platform_get_irq(pdev, 0);
>>>>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
>>>
>>>
>>>
>>
>>
> 
> 
