From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 16 Jun 2016 13:08:35 -0400
Subject: [PATCH V7 7/9] vfio, platform: make reset driver a requirement by
 default
In-Reply-To: <8eaecc6e-aece-e859-281a-b02e2b6eced7@redhat.com>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
 <1465792001-27960-8-git-send-email-okaya@codeaurora.org>
 <8eaecc6e-aece-e859-281a-b02e2b6eced7@redhat.com>
Message-ID: <5762DD13.8010501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/16/2016 4:15 AM, Auger Eric wrote:

> Unfortunately this causes a crash when the reset module is not
> available. You should do the vfio_add_group_dev at the end. Something
> like below.
> 

Thanks for testing. I'll post v8 with this change. 


> Best Regards
> 
> Eric
> 
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 26
> ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c
> b/drivers/vfio/platform/vfio_platform_common.c
> index d84c399..0928f7d 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -664,6 +664,14 @@ int vfio_platform_probe_common(struct
> vfio_platform_device *vdev,
>                 return ret;
> 
>         vdev->device = dev;
> +       mutex_init(&vdev->igate);
> +
> +       ret = vfio_platform_get_reset(vdev);
> +       if (ret && vdev->reset_required) {
> +               pr_err("vfio: no reset function found for device %s\n",
> +                      vdev->name);
> +               return ret;
> +       }
> 
>         group = iommu_group_get(dev);
>         if (!group) {
> @@ -672,22 +680,12 @@ int vfio_platform_probe_common(struct
> vfio_platform_device *vdev,
>         }
> 
>         ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
> -       if (ret)
> -               goto out;
> -
> -       ret = vfio_platform_get_reset(vdev);
> -       if (ret && vdev->reset_required) {
> -               pr_err("vfio: no reset function found for device %s\n",
> -                      vdev->name);
> -               goto out;
> -       }
> -
> -       mutex_init(&vdev->igate);
> +       if (ret) {
> +               iommu_group_put(group);
> +               return ret;
> +       }
> 
>         return 0;
> -out:
> -       iommu_group_put(group);
> -       return ret;
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
> 
> 
> 
>>  
>>  	mutex_init(&vdev->igate);
>>  
>>  	return 0;
>> +out:
>> +	iommu_group_put(group);
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
>>  
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index ba9e4f8..68fbc00 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -50,6 +50,7 @@ struct vfio_platform_region {
>>  };
>>  
>>  struct vfio_platform_device {
>> +	bool				reset_required;
>>  	struct vfio_platform_region	*regions;
>>  	u32				num_regions;
>>  	struct vfio_platform_irq	*irqs;
>>


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
