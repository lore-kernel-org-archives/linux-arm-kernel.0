From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 2 Aug 2018 21:21:02 +0530
Subject: [PATCH v3] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
In-Reply-To: <20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c@eucas1p1.samsung.com>
References: <CGME20180802131924epcas4p105dc354b2ee651e70a5e777850222bc5@epcas4p1.samsung.com>
 <20180802132152.GA2833@jordon-HP-15-Notebook-PC>
 <20180802133852eucas1p1de66cfd2db5ed0c87665567455ea4747~HFNvAtE4-1249412494eucas1p1c@eucas1p1.samsung.com>
Message-ID: <CAFqt6zYUT72e7CnUF9a3kg5ZjFcPjZViMNm687-FC_9PF5Oc7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2018 at 7:08 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi,
>
> On 2018-08-02 15:21, Souptick Joarder wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> exynos_drm_fbdev_suspend/resume can be removed
>> as drm_mode_config_helper_suspend/resume has
>> implement the same in generic way.
>>
>> Remove suspend_state from exynos_drm_private
>> struct as it is no more useful.
>>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>> v2: Address Inki Dae's comment. Remove ret variable
>>      from both suspend/resume function.
>>
>> v3: Tested by Marek. Updated the change log.
>>
>>   drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++------------------------
>>   drivers/gpu/drm/exynos/exynos_drm_drv.h   |  1 -
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>   4 files changed, 2 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> index b599f74..d86dd81 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> @@ -149,37 +149,15 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>   static int exynos_drm_suspend(struct device *dev)
>>   {
>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -     struct exynos_drm_private *private;
>> -
>> -     if (!drm_dev)
>> -             return 0;
>> -
>> -     private = drm_dev->dev_private;
>> -
>> -     drm_kms_helper_poll_disable(drm_dev);
>> -     exynos_drm_fbdev_suspend(drm_dev);
>> -     private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>> -     if (IS_ERR(private->suspend_state)) {
>> -             exynos_drm_fbdev_resume(drm_dev);
>> -             drm_kms_helper_poll_enable(drm_dev);
>> -             return PTR_ERR(private->suspend_state);
>> -     }
>>
>> -     return 0;
>> +     return  drm_mode_config_helper_suspend(drm_dev);
>>   }
>>
>>   static void exynos_drm_resume(struct device *dev)
>>   {
>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -     struct exynos_drm_private *private;
>> -
>> -     if (!drm_dev)
>> -             return;
>>
>> -     private = drm_dev->dev_private;
>> -     drm_atomic_helper_resume(drm_dev, private->suspend_state);
>> -     exynos_drm_fbdev_resume(drm_dev);
>> -     drm_kms_helper_poll_enable(drm_dev);
>> +     return drm_mode_config_helper_resume(drm_dev);
>
> exynos_drm_resume() now returns 'void', so to be strict with
> c standard, the return statement should not be used here.

But in struct dev_pm_ops, it is still defined as

                int (*resume)(struct device *dev);

I think, we need to correct the return type of
exynos_drm_resume() to int.

Although I posted v4.



>
>>   }
>>
>>   static const struct dev_pm_ops exynos_drm_pm_ops = {
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>> index c737c4b..7349e7c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
>> @@ -195,7 +195,6 @@ struct drm_exynos_file_private {
>>    */
>>   struct exynos_drm_private {
>>       struct drm_fb_helper *fb_helper;
>> -     struct drm_atomic_state *suspend_state;
>>
>>       struct device *g2d_dev;
>>       struct device *dma_dev;
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> index 132dd52..918dd2c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>       private->fb_helper = NULL;
>>   }
>>
>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>> -{
>> -     struct exynos_drm_private *private = dev->dev_private;
>> -
>> -     console_lock();
>> -     drm_fb_helper_set_suspend(private->fb_helper, 1);
>> -     console_unlock();
>> -}
>> -
>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>> -{
>> -     struct exynos_drm_private *private = dev->dev_private;
>> -
>> -     console_lock();
>> -     drm_fb_helper_set_suspend(private->fb_helper, 0);
>> -     console_unlock();
>> -}
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> index b338472..6840b6a 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>> @@ -19,8 +19,6 @@
>>
>>   int exynos_drm_fbdev_init(struct drm_device *dev);
>>   void exynos_drm_fbdev_fini(struct drm_device *dev);
>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>
>>   #else
>>
>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>
>>   #define exynos_drm_output_poll_changed (NULL)
>>
>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>> -{
>> -}
>> -
>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>> -{
>> -}
>> -
>>   #endif
>>
>>   #endif
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
