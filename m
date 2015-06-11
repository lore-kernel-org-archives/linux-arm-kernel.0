From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Jun 2015 11:37:54 +0200
Subject: [PATCH v2 3/4] VFIO: platform: populate the reset function on
 probe
In-Reply-To: <1433949053.4927.167.camel@redhat.com>
References: <1433516792-16397-1-git-send-email-eric.auger@linaro.org>	
 <1433516792-16397-4-git-send-email-eric.auger@linaro.org>	
 <1433874370.4927.113.camel@redhat.com> <5578231E.3030503@linaro.org>
 <1433949053.4927.167.camel@redhat.com>
Message-ID: <557956F2.5060206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,
On 06/10/2015 05:10 PM, Alex Williamson wrote:
> On Wed, 2015-06-10 at 13:44 +0200, Eric Auger wrote:
>> On 06/09/2015 08:26 PM, Alex Williamson wrote:
>>> On Fri, 2015-06-05 at 17:06 +0200, Eric Auger wrote:
>>>> The reset function lookup happens on vfio-platform probe. The reset
>>>> module load is requested  and a reference to the function symbol is
>>>> hold. The reference is released on vfio-platform remove.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>>>
>>>> ---
>>>>
>>>> v1 -> v2:
>>>> - [get,put]_reset now is called once on probe/remove
>>>> - use request_module to automatically load the reset module that
>>>>   matches the compatibility string
>>>> - lookup table is used instead of list
>>>> - remove registration mechanism: reset function name is stored in the
>>>>   lookup table.
>>>> - use device_property_read_string instead of
>>>>   device_property_read_string_array
>>>> ---
>>>>  drivers/vfio/platform/vfio_platform_common.c | 48 +++++++++++++++++++++++++++-
>>>>  1 file changed, 47 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>>>> index 995929b..d474d6a 100644
>>>> --- a/drivers/vfio/platform/vfio_platform_common.c
>>>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>>>> @@ -31,6 +31,47 @@ static const struct vfio_platform_reset_combo reset_lookup_table[] = {
>>>>  	},
>>>>  };
>>>>  
>>>> +static int vfio_platform_get_reset(struct vfio_platform_device *vdev,
>>>> +				   struct device *dev)
>>>> +{
>>>> +	const char *compat;
>>>> +	const struct vfio_platform_reset_combo *iter = reset_lookup_table;
>>>> +	int (*reset)(struct vfio_platform_device *);
>>>> +	int ret;
>>>> +
>>>> +	vdev->type = VFIO_PLATFORM_RESET_TYPE_MAX;
>>>> +	ret = device_property_read_string(dev, "compatible", &compat);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	while (iter->type < VFIO_PLATFORM_RESET_TYPE_MAX) {
>>>> +		if (!strcmp(iter->compat, compat)) {
>>>> +			request_module(iter->module_name);
>>>> +			reset = __symbol_get(iter->reset_function_name);
>>>
>>> symbol_get() appears to be the more robust and dominant interface for
>>> this, why use __symbol_get()? 
>> I used this because it takes a const char * as an argument and this is
>> what I use as a datatype for storing the reset function name. Symbol_get
>> is provided with the symbol directly? It is also used
>> drivers/mtd/chips/gen_probe.c.
> 
> But symbol_get() is just some macro wrappers around __symbol_get() that
> handles tool chains that precede symbols with underscores.  I don't
> really know if that's still a concern, but are you sure it doesn't work?
I confirm it doesn't work due the (typeof(&x)) which in my case matches
a const char *.

drivers/vfio/platform/vfio_platform_common.c:45:10: warning: assignment
from incompatible pointer type [enabled by default]
    reset = symbol_get(

#define symbol_get(x) ((typeof(&x))(__symbol_get(VMLINUX_SYMBOL_STR(x))))

Best Regards

Eric
> 
>>>
>>>> +			if (reset) {
>>>> +				vdev->type = iter->type;
>>>> +				vdev->reset = reset;
>>>> +				return 0;
>>>> +			}
>>>> +		}
>>>> +		iter++;
>>>> +	}
>>>> +	return -1;
>>>
>>> -ENODEV seems preferable to -1, but shouldn't this really be a void
>>> function?
>> yes indeed
>>>
>>>> +}
>>>> +
>>>> +static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>>>> +{
>>>> +	const struct vfio_platform_reset_combo *iter = reset_lookup_table;
>>>> +
>>>> +	while (iter->type < VFIO_PLATFORM_RESET_TYPE_MAX) {
>>>> +		if (iter->type == vdev->type) {
>>>
>>> Again, I don't see the value in storing the enum, since the table is
>>> static, it could just as easily be the array index and avoid this loop,
>>> but we can avoid it anyway with symbol_put_addr().
>> yes you're definitively right!
>>
>> Thanks
>>
>> Eric
>>>
>>>> +			__symbol_put(iter->reset_function_name);
>>>> +			return;
>>>> +		}
>>>> +		iter++;
>>>> +	}
>>>> +}
>>>> +
>>>>  static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
>>>>  {
>>>>  	int cnt = 0, i;
>>>> @@ -519,6 +560,8 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>>>  		return ret;
>>>>  	}
>>>>  
>>>> +	vfio_platform_get_reset(vdev, dev);
>>>> +
>>>>  	mutex_init(&vdev->igate);
>>>>  
>>>>  	return 0;
>>>> @@ -530,8 +573,11 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
>>>>  	struct vfio_platform_device *vdev;
>>>>  
>>>>  	vdev = vfio_del_group_dev(dev);
>>>> -	if (vdev)
>>>> +
>>>> +	if (vdev) {
>>>> +		vfio_platform_put_reset(vdev);
>>>>  		iommu_group_put(dev->iommu_group);
>>>> +	}
>>>>  
>>>>  	return vdev;
>>>>  }
>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
> 
> 
> 
