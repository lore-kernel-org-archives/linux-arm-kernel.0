From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 18 Aug 2014 15:11:54 +0200
Subject: [PATCH v2] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <53F1F866.1@samsung.com>
References: <1406269240-24622-1-git-send-email-shawn.guo@freescale.com>
 <53F1AE97.8090807@samsung.com> <20140818123823.GK2114@dragon>
 <53F1F866.1@samsung.com>
Message-ID: <53F1FB9A.4070305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 02:58 PM, Andrzej Hajda wrote:
> On 08/18/2014 02:38 PM, Shawn Guo wrote:
>> Hi Andrzej,
>>
>> On Mon, Aug 18, 2014 at 09:43:19AM +0200, Andrzej Hajda wrote:
>>>> diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
>>>> index def8280d7ee6..ab41152089a3 100644
>>>> --- a/drivers/staging/imx-drm/imx-drm-core.c
>>>> +++ b/drivers/staging/imx-drm/imx-drm-core.c
>>>> @@ -696,6 +696,29 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_PM_SLEEP
>>>> +static int imx_drm_suspend(struct device *dev)
>>>> +{
>>>> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +
>>>> +	drm_kms_helper_poll_disable(drm_dev);
>>> drm_dev can be NULL here. You should add check before.
>> The drvdata is set to drm_dev in drm_driver .load() hook.  So are you
>> saying that .suspend() hook could possibly be called before the .load()
>> hook gets called?
> .load hook is called after all components are attached to the master.
> So if suspend happen after probe of the master and before attaching the last
> component you will have NULL here, I guess.

Probably you can test it by disabling driver for one of drm components
and putting board in sleep mode.

Moreover I guess drvdata should be cleaned in .unload callback,
otherwise if for some reason one of components will be detached and suspend
happens drvdata will contain invalid pointer.

Regards
Andrzej

>
> Regards
> Andrzej
>
>> Shawn
>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int imx_drm_resume(struct device *dev)
>>>> +{
>>>> +	struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> +
>>>> +	drm_helper_resume_force_mode(drm_dev);
>>> ditto
