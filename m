From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 2 Aug 2018 08:47:13 +0200
Subject: [PATCH v2] gpu/drm/exynos: Convert
 drm_atomic_helper_suspend/resume()
In-Reply-To: <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
References: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
 <CGME20180802062607epcas1p339ff6aeb0cbdc3b6ece2617be4aadb41@epcas1p3.samsung.com>
 <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com>
Message-ID: <20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec~G-mV4kIr70116001160eucas1p1P@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Souptick,

On 2018-08-02 08:25, Souptick Joarder wrote:
> On Thu, Jul 26, 2018 at 9:24 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> exynos_drm_fbdev_suspend/resume can be removed
>> as drm_mode_config_helper_suspend/resume has
>> implement the same in generic way.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> ---
>> v2: Address Inki Dae's comment. Remove
>>      ret variable from both suspend/resume
>>      function.
>>
> Any further comment on this patch ?

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

However you need to rebase onto current drm-next, because there have
been some changes, which prevent this patch from applying.

pm_runtime_suspended(dev) checks were useless and have been removed,
what simplifies suspend/resume functions even more. Now it is too
late for v4.19 merge window, so this patch will have to wait for
v4.20.

>>   drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>   3 files changed, 4 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> index a81b4a5..46d28cd 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>> @@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>   static int exynos_drm_suspend(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -       struct exynos_drm_private *private;
>>
>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>> +       if (pm_runtime_suspended(dev))
>>                  return 0;
>>
>> -       private = drm_dev->dev_private;
>> -
>> -       drm_kms_helper_poll_disable(drm_dev);
>> -       exynos_drm_fbdev_suspend(drm_dev);
>> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>> -       if (IS_ERR(private->suspend_state)) {
>> -               exynos_drm_fbdev_resume(drm_dev);
>> -               drm_kms_helper_poll_enable(drm_dev);
>> -               return PTR_ERR(private->suspend_state);
>> -       }
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_suspend(drm_dev);
>>   }
>>
>>   static int exynos_drm_resume(struct device *dev)
>>   {
>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>> -       struct exynos_drm_private *private;
>>
>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>> +       if (pm_runtime_suspended(dev))
>>                  return 0;
>>
>> -       private = drm_dev->dev_private;
>> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
>> -       exynos_drm_fbdev_resume(drm_dev);
>> -       drm_kms_helper_poll_enable(drm_dev);
>> -
>> -       return 0;
>> +       return drm_mode_config_helper_resume(drm_dev);
>>   }
>>   #endif
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> index 132dd52..918dd2c 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>          private->fb_helper = NULL;
>>   }
>>
>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>> -{
>> -       struct exynos_drm_private *private = dev->dev_private;
>> -
>> -       console_lock();
>> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
>> -       console_unlock();
>> -}
>> -
>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>> -{
>> -       struct exynos_drm_private *private = dev->dev_private;
>> -
>> -       console_lock();
>> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
>> -       console_unlock();
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
>> --
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
