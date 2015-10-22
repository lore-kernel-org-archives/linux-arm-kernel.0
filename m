From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 22 Oct 2015 15:26:55 +0200
Subject: [PATCH v2 6/6] vfio: platform: move get/put reset at open/release
In-Reply-To: <4304536.D7eNHjlsvD@wuerfel>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <1445506922-6005-7-git-send-email-eric.auger@linaro.org>
 <4304536.D7eNHjlsvD@wuerfel>
Message-ID: <5628E41F.5050602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2015 12:29 PM, Arnd Bergmann wrote:
> On Thursday 22 October 2015 11:42:02 Eric Auger wrote:
>> Currently reset lookup is done on probe. This introduces a
>> race with new registration mechanism in the case where the
>> vfio-platform driver is bound to the device before its module
>> is loaded: on the load, the probe happens which triggers the
>> reset module load which itself attempts to get the symbol for
>> the registration function (vfio_platform_register_reset). The
>> symbol is not yet available hence the lookup fails. In case we
>> do the lookup in the first open we are sure the vfio-platform
>> module is loaded and vfio_platform_register_reset is available.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> I don't understand the explanation. I would expect the request_module()
> call to block until the module is actually loaded. Is this not
> what happens?
> 
>>         mutex_unlock(&driver_lock);
>> @@ -181,6 +182,8 @@ static int vfio_platform_open(void *device_data)
>>                 if (ret)
>>                         goto err_irq;
>>  
>> +               vfio_platform_get_reset(vdev);
>> +
>>                 if (vdev->reset)
>>                         vdev->reset(vdev);
>>
> 
> This needs some error handling to ensure that the open() fails
> if there is no reset handler.

Is that really what we want? The code was meant to allow the use case
where the VFIO platform driver would be used without such reset module.

I think the imperious need for a reset module depends on the device and
more importantly depends on the IOMMU mapping. With QEMU VFIO
integration this is needed because the whole VM memory is IOMMU mapped
but in a simpler user-space driver context, we might live without.

Any thought?

Eric
> 
> 	Arnd
> 
