From: jeffy.chen@rock-chips.com (jeffy)
Date: Wed, 05 Apr 2017 18:23:38 +0800
Subject: [PATCH v2 5/9] drm/rockchip: vop: Enable pm domain when resetting
 vop
In-Reply-To: <20170404194234.vhsedpjkf6eqz4oe@art_vandelay>
References: <1491046529-4310-1-git-send-email-jeffy.chen@rock-chips.com>
 <1491046529-4310-6-git-send-email-jeffy.chen@rock-chips.com>
 <20170404194234.vhsedpjkf6eqz4oe@art_vandelay>
Message-ID: <58E4C5AA.3000804@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On 04/05/2017 03:42 AM, Sean Paul wrote:
> On Sat, Apr 01, 2017 at 07:35:25PM +0800, Jeffy Chen wrote:
>
> Hi Jeffy,
> Could you please add commit messages describing *why* you're making the change?
> It might be obvious to you (and maybe me), but others will benefit from better
> descriptions.
ok, will do.
>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 31 +++++++++++++++++++----------
>>   1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index 76c79ac..1d85319 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -1365,6 +1365,12 @@ static int vop_initial(struct vop *vop)
>>   		return ret;
>>   	}
>>
>> +	ret = pm_runtime_get_sync(vop->dev);
>> +	if (ret < 0) {
>> +		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
>> +		goto err_put_pm_runtime;
>
> This should go to err_unprepare_dclk, the next error condition should go to
> err_put_pm_runtime
hmm, that's true, i copied it from vop_enable without a double 
check...will fix that too.
>
>> +	}
>> +
>>   	/* Enable both the hclk and aclk to setup the vop */
>>   	ret = clk_prepare_enable(vop->hclk);
>>   	if (ret < 0) {
>> @@ -1422,6 +1428,8 @@ static int vop_initial(struct vop *vop)
>>
>>   	vop->is_enabled = false;
>>
>> +	pm_runtime_put_sync(vop->dev);
>> +
>>   	return 0;
>>
>>   err_disable_aclk:
>> @@ -1430,6 +1438,8 @@ static int vop_initial(struct vop *vop)
>>   	clk_disable_unprepare(vop->hclk);
>>   err_unprepare_dclk:
>>   	clk_unprepare(vop->dclk);
>> +err_put_pm_runtime:
>> +	pm_runtime_put_sync(vop->dev);
>
> Should be above err_unprepare_dclk
>
oh, too careless, thanx for pointing that out.
>>   	return ret;
>>   }
>>
>> @@ -1530,12 +1540,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>>   	if (!vop->regsbak)
>>   		return -ENOMEM;
>>
>> -	ret = vop_initial(vop);
>> -	if (ret < 0) {
>> -		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
>> -		return ret;
>> -	}
>> -
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0) {
>>   		dev_err(dev, "cannot find irq for vop\n");
>> @@ -1556,15 +1560,22 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>>   	/* IRQ is initially disabled; it gets enabled in power_on */
>>   	disable_irq(vop->irq);
>>
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ret = vop_initial(vop);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
>> +		goto err_disable_pm_runtime;
>> +	}
>
> This function move would be a lot easier to understand with a commit message ;-)
>
ok
>> +
>>   	ret = vop_create_crtc(vop);
>>   	if (ret)
>> -		goto err_enable_irq;
>> -
>> -	pm_runtime_enable(&pdev->dev);
>> +		goto err_disable_pm_runtime;
>
> Do you have anything to clean up from vop_initial()?
>
i'll put it to the end of bind ;)
>>
>>   	return 0;
>>
>> -err_enable_irq:
>> +err_disable_pm_runtime:
>> +	pm_runtime_disable(&pdev->dev);
>>   	enable_irq(vop->irq); /* To balance out the disable_irq above */
>>   	return ret;
>>   }
>> --
>> 2.1.4
>>
>
