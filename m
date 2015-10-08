From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 08 Oct 2015 08:40:51 +0800
Subject: [PATCH v5 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <56150128.2070309@osg.samsung.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <5614BADD.1070307@rock-chips.com> <5614DBE2.6080102@osg.samsung.com>
 <5614DFBC.8060105@rock-chips.com> <5614E553.6060108@osg.samsung.com>
 <5614FC6B.4080702@rock-chips.com> <56150128.2070309@osg.samsung.com>
Message-ID: <5615BB93.9020008@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 10/07/2015 07:25 PM, Javier Martinez Canillas wrote:
> Hello Yakir,
>
> On 10/07/2015 01:05 PM, Yakir Yang wrote:
>> Hi Javier,
>>
>> On 10/07/2015 05:26 PM, Javier Martinez Canillas wrote:
>>> Hello Yakir,
>>>
>>> On 10/07/2015 11:02 AM, Yakir Yang wrote:
>>>> Hi Javier,
>>>>
>>>> On 10/07/2015 04:46 PM, Javier Martinez Canillas wrote:
>>>>> Hello Yakir,
>>>>>
>>>>> On 10/07/2015 08:25 AM, Yakir Yang wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Friendly ping.....   :)
>>>>>>
>>>>>>
>>>>>> Best regards,
>>>>>> - Yakir
>>>>>>
>>>>>>
>>>>> Do you have a tree that I can use to test these patches?
>>>> Wow, thanks a lot, I do have a tree on github [https://github.com/yakir-Yang/linux/tree/analogix_dp],
>>>> crossing my finger, wish things works......    ;)
>>>>
>>> I tried your analogix_dp branch on an Exynos5800 Peach Pi Chromebook
>>> but the machine didn't boot. Unfortunately I need to do some soldering
>>> to have a serial console on this board so don't have a kernel boot log.
>>>
>>> I'll let you know if I can get more info about this issue.
>> Whoops, sorry for the failed, much appreciated for your works.
>>
>> Besides, I thought maybe I can find a Peach Pit Chromebook in my side,
>> I remember that some of our guys have brought one, but previously I
>> thought that mainline kernel wouldn't run on Peach Pit directly.
>>
> Great, mainline works correctly on all Exynos based Chromebooks.
>
>> Maybe you can email me the method the run mainline kernel on Peach
>> Pit, so I can debug the analogix_dp driver at the same time, that would
>> be great.
> I wrote a little blog post explaining how to run mainline on these boards:
>
> http://blogs.s-osg.org/install-linux-mainline-kernel-distro-exynos-chromebooks/
>
> That explains the simplest setup though so if you need a different one
> (i.e: chain loading a non verified u-boot) or if you have any questions,
> feel free to contact me in private and I can help you with the setup.
>

Ah, thanks, gonna to step-by-step.

- Yakir

>>> Also, there is Kconfig recursive dependency that you may want to fix:
>>>
>>> $ make exynos_defconfig
>>> drivers/video/fbdev/Kconfig:5:error: recursive dependency detected!
>>> drivers/video/fbdev/Kconfig:5: symbol FB is selected by DRM_KMS_FB_HELPER
>>> drivers/gpu/drm/Kconfig:34: symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
>>> drivers/gpu/drm/Kconfig:28: symbol DRM_KMS_HELPER is selected by DRM_ANALOGIX_DP
>>> drivers/gpu/drm/bridge/analogix/Kconfig:1: symbol DRM_ANALOGIX_DP is selected by DRM_EXYNOS_DP
>>> drivers/gpu/drm/exynos/Kconfig:57: symbol DRM_EXYNOS_DP depends on DRM_EXYNOS_FIMD
>>> drivers/gpu/drm/exynos/Kconfig:19: symbol DRM_EXYNOS_FIMD depends on FB_S3C
>>> drivers/video/fbdev/Kconfig:2023: symbol FB_S3C depends on FB
>>>    
>> Yeah, recursive dependency detected, guess I should remove the
>> "DRM_KMS_HELPER" from bridge analogix_dp Kconfig file, thanks
>> for your remind.
>>
>> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
>> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
>> @@ -1,4 +1,3 @@
>>   config DRM_ANALOGIX_DP
>>          tristate
>>          depends on DRM
>> -       select DRM_KMS_HELPER
>>
>>
> That fixes the recursive dependency issue indeed. Thanks.
>
>> Thanks,
>> - Yakir
> Best regards,
