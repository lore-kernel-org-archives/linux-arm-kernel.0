From: zourongrong@huawei.com (Rongrong Zou)
Date: Mon, 14 Nov 2016 22:10:38 +0800
Subject: [PATCH v6 8/9] drm/hisilicon/hibmc: Add vblank interruput
In-Reply-To: <CAOw6vbKx88Bz4RcD3a0K7m-uomHx9wOGN6y7eOuq+yeUdRjZ5Q@mail.gmail.com>
References: <1477639682-22520-1-git-send-email-zourongrong@gmail.com>
 <1477639682-22520-9-git-send-email-zourongrong@gmail.com>
 <CAOw6vbKx88Bz4RcD3a0K7m-uomHx9wOGN6y7eOuq+yeUdRjZ5Q@mail.gmail.com>
Message-ID: <5829C5DE.4040100@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/11/11 9:49, Sean Paul ??:
> On Fri, Oct 28, 2016 at 3:28 AM, Rongrong Zou <zourongrong@gmail.com> wrote:
>> Add vblank interrupt.
>>
>> Signed-off-by: Rongrong Zou <zourongrong@gmail.com>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 56 ++++++++++++++++++++++++-
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 +
>>   2 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 4253603..b668e3e 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -40,16 +40,46 @@
>>
>>   static int hibmc_enable_vblank(struct drm_device *dev, unsigned int pipe)
>>   {
>> +       struct hibmc_drm_device *hidev =
>> +               (struct hibmc_drm_device *)dev->dev_private;
>> +
>> +       writel(HIBMC_RAW_INTERRUPT_EN_VBLANK(1),
>> +              hidev->mmio + HIBMC_RAW_INTERRUPT_EN);
>> +
>>          return 0;
>>   }
>>
>>   static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
>>   {
>> +       struct hibmc_drm_device *hidev =
>> +               (struct hibmc_drm_device *)dev->dev_private;
>> +
>> +       writel(HIBMC_RAW_INTERRUPT_EN_VBLANK(0),
>> +              hidev->mmio + HIBMC_RAW_INTERRUPT_EN);
>> +}
>> +
>> +irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
>> +{
>> +       struct drm_device *dev = (struct drm_device *)arg;
>> +       struct hibmc_drm_device *hidev =
>> +               (struct hibmc_drm_device *)dev->dev_private;
>> +       struct drm_crtc *crtc = &hidev->crtc;
>> +       u32 status;
>> +
>> +       status = readl(hidev->mmio + HIBMC_RAW_INTERRUPT);
>> +
>> +       if (status & HIBMC_RAW_INTERRUPT_VBLANK(1)) {
>> +               writel(HIBMC_RAW_INTERRUPT_VBLANK(1),
>> +                      hidev->mmio + HIBMC_RAW_INTERRUPT);
>> +               drm_crtc_handle_vblank(crtc);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>>   }
>>
>>   static struct drm_driver hibmc_driver = {
>>          .driver_features        = DRIVER_GEM | DRIVER_MODESET |
>> -                                 DRIVER_ATOMIC,
>> +                                 DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
>>          .fops                   = &hibmc_fops,
>>          .name                   = "hibmc",
>>          .date                   = "20160828",
>> @@ -63,6 +93,7 @@ static void hibmc_disable_vblank(struct drm_device *dev, unsigned int pipe)
>>          .dumb_create            = hibmc_dumb_create,
>>          .dumb_map_offset        = hibmc_dumb_mmap_offset,
>>          .dumb_destroy           = drm_gem_dumb_destroy,
>> +       .irq_handler            = hibmc_drm_interrupt,
>>   };
>>
>>   static int hibmc_pm_suspend(struct device *dev)
>> @@ -242,6 +273,13 @@ static int hibmc_unload(struct drm_device *dev)
>>          struct hibmc_drm_device *hidev = dev->dev_private;
>>
>>          hibmc_fbdev_fini(hidev);
>> +
>> +       if (dev->irq_enabled)
>> +               drm_irq_uninstall(dev);
>> +       if (hidev->msi_enabled)
>> +               pci_disable_msi(dev->pdev);
>> +       drm_vblank_cleanup(dev);
>> +
>>          hibmc_kms_fini(hidev);
>>          hibmc_mm_fini(hidev);
>>          hibmc_hw_fini(hidev);
>> @@ -272,6 +310,22 @@ static int hibmc_load(struct drm_device *dev, unsigned long flags)
>>          if (ret)
>>                  goto err;
>>
>> +       ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
>> +       if (ret) {
>> +               DRM_ERROR("failed to initialize vblank.\n");
>> +               goto err;
>> +       }
>> +
>> +       hidev->msi_enabled = 0;
>> +       if (pci_enable_msi(dev->pdev)) {
>
> It would be useful to check and print the return value of this.

agreed, thanks.

>
>> +               DRM_ERROR("Enabling MSI failed!\n");
>> +       } else {
>> +               hidev->msi_enabled = 1;
>> +               ret = drm_irq_install(dev, dev->pdev->irq);
>> +               if (ret)
>> +                       DRM_ERROR("install irq failed , ret = %d\n", ret);
>
> DRM_WARN might be more appropriate, given that this isn't considered fatal.

agreed, thanks.

>
>> +       }
>> +
>>          /* reset all the states of crtc/plane/encoder/connector */
>>          drm_mode_config_reset(dev);
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index 450247d..f1706fb 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -42,6 +42,7 @@ struct hibmc_drm_device {
>>          void __iomem   *fb_map;
>>          unsigned long  fb_base;
>>          unsigned long  fb_size;
>> +       int msi_enabled;
>
> Why not bool?

agreed, thanks.

Regards,
Rongrong.

>
>>
>>          /* drm */
>>          struct drm_device  *dev;
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
>
> .
>
