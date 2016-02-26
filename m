From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 26 Feb 2016 14:21:06 -0500
Subject: [PATCH V14 8/9] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <56D08843.5020306@linaro.org>
References: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
 <1454646882-24369-9-git-send-email-okaya@codeaurora.org>
 <56D08843.5020306@linaro.org>
Message-ID: <56D0A5A2.6020907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> +#ifdef CONFIG_ACPI
>> +int vfio_platform_probe_acpi(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(dev);
>> +
>> +	if (!adev)
>> +		return -EINVAL;
> -ENODEV seems to be commonly used in that case

ok

>> +
>> +	vdev->acpihid = acpi_device_hid(adev);
>> +	if (!vdev->acpihid) {
> can it return NULL? Seems to return dummy "device" or actual hid
>> +		pr_err("VFIO: cannot find ACPI HID for %s\n",
>> +		       vdev->name);
>> +		return -EINVAL;
> -ENODEV too?

sure

>> +	}
>> +	return 0;
>> +}
>> +#else
>> +int vfio_platform_probe_acpi(struct vfio_platform_device *vdev,
>> +			     struct device *dev)
>> +{
>> +	return -EINVAL;
>> +}
>> +#endif
>> +
>> +int vfio_platform_probe_of(struct vfio_platform_device *vdev,
>> +			   struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	ret = device_property_read_string(dev, "compatible",
>> +					  &vdev->compat);
>> +	if (ret) {
>> +		pr_err("VFIO: cannot retrieve compat for %s\n",
>> +			vdev->name);
>> +		return -EINVAL;
> return ret instead.

ok

>> +	}
>> +	return 0;
>> +}
>> +
>>  int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  			       struct device *dev)
>>  {
>> @@ -550,14 +600,14 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
>>  	if (!vdev)
>>  		return -EINVAL;
>>  
>> -	ret = device_property_read_string(dev, "compatible", &vdev->compat);
>> -	if (ret) {
>> -		pr_err("VFIO: cannot retrieve compat for %s\n", vdev->name);
>> -		return -EINVAL;
>> -	}
>> +	ret = vfio_platform_probe_acpi(vdev, dev);
>> +	if (ret)
>> +		ret = vfio_platform_probe_of(vdev, dev);
>>  
>> -	vdev->device = dev;
>> +	if (ret)
>> +		return ret;
>>  
>> +	vdev->device = dev;
>>  	group = iommu_group_get(dev);
>>  	if (!group) {
>>  		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
>> @@ -602,13 +652,21 @@ void __vfio_platform_register_reset(struct vfio_platform_reset_node *node)
>>  EXPORT_SYMBOL_GPL(__vfio_platform_register_reset);
>>  
>>  void vfio_platform_unregister_reset(const char *compat,
>> +				    const char *acpihid,
>>  				    vfio_platform_reset_fn_t fn)
>>  {
>>  	struct vfio_platform_reset_node *iter, *temp;
>>  
>>  	mutex_lock(&driver_lock);
>>  	list_for_each_entry_safe(iter, temp, &reset_list, link) {
>> -		if (!strcmp(iter->compat, compat) && (iter->reset == fn)) {
>> +		if (acpihid && iter->acpihid &&
>> +		    !strcmp(iter->acpihid, acpihid) && (iter->reset == fn)) {
>> +			list_del(&iter->link);
>> +			break;
>> +		}
>> +
>> +		if (compat && iter->compat &&
>> +		    !strcmp(iter->compat, compat) && (iter->reset == fn)) {
>>  			list_del(&iter->link);
>>  			break;
>>  		}
> 
> in vfio_platform_get_reset, if the 1st vfio_platform_lookup_reset call
> does not return anything then we currently call
> request_module("vfio-reset:%s", vdev->compat);
> 
> you need to handle the case where compat is not set but vdev->acpihid
> is, instead.
> 
> currently the module alias is constructed with the compat only
> MODULE_ALIAS("vfio-reset:" compat);
> 
> Looks you can define several ones ( for instance in
> drivers/block/xen-blkfront.c).
> 
> If I am not wrong this currently would not work with
> vfio-platform-qcomhidma compiled as a module.
> 

Good point. I happen to have both defined as the driver support both ACPI
and device-tree. That's why, I have never seen the problem during testing.


>>  
>> -#define module_vfio_reset_handler(compat, reset)		\
>> -MODULE_ALIAS("vfio-reset:" compat);				\
>> -static int __init reset ## _module_init(void)			\
>> -{								\
>> -	vfio_platform_register_reset(compat, reset);		\
>> -	return 0;						\
>> -};								\
>> -static void __exit reset ## _module_exit(void)			\
>> -{								\
>> -	vfio_platform_unregister_reset(compat, reset);		\
>> -};								\
>> -module_init(reset ## _module_init);				\
>> +#define module_vfio_reset_handler(compat, acpihid, reset)		\
>> +MODULE_ALIAS("vfio-reset:" compat);					\
> Here you need to handle alias for hid case I think
> 
I'll add this and test different combinations where compat and acpihid are null.

#define module_vfio_reset_handler(compat, acpihid, reset) \
MODULE_ALIAS("vfio-reset:" compat); \
MODULE_ALIAS("vfio-reset:" acpihid); \


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
