From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 18 Jun 2015 13:57:57 +0100
Subject: [PATCH v5 05/11] nvmem: Add nvmem_device based consumer apis.
In-Reply-To: <5580A7EA.2090909@codeaurora.org>
References: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226603-8863-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5580A7EA.2090909@codeaurora.org>
Message-ID: <5582C055.6040908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/06/15 23:49, Stephen Boyd wrote:
> On 05/21/2015 09:43 AM, Srinivas Kandagatla wrote:
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 8a4b358..68ee8d1 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -436,6 +436,51 @@ static int __nvmem_device_put(struct nvmem_device *nvmem)
>>   	return 0;
>>   }
>>
>> +static int nvmem_match(struct device *dev, const void *data)
>> +{
>> +	return !strcmp(dev_name(dev), (const char *)data);
>
> Unnecessary cast.
Sure, will fix it.
>
>> +}
>> +
>> +static struct nvmem_device *nvmem_find(const char *name)
>> +{
>> +	struct device *d;
>> +
>> +	d = class_find_device(&nvmem_class, NULL, (void *)name, nvmem_match);
>
> Unnecessary cast
Will fix it.
>
>> +
>> +	return d ? to_nvmem_device(d) : NULL;
>> +}
>
> [...]
>> +
>> +void nvmem_device_put(struct nvmem_device *nvmem)
>> +{
>> +	__nvmem_device_put(nvmem);
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_device_put);
>>
>> +int nvmem_device_cell_read(struct nvmem_device *nvmem,
>> +			   struct nvmem_cell_info *info, void *buf)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_device_cell_read);
>> +
>> +int nvmem_device_cell_write(struct nvmem_device *nvmem,
>> +			    struct nvmem_cell_info *info, void *buf)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_device_cell_write);
>> +
>> +int nvmem_device_read(struct nvmem_device *nvmem,
>> +		      unsigned int offset,
>> +		      size_t bytes, void *buf)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_device_read);
>> +
>> +int nvmem_device_write(struct nvmem_device *nvmem,
>> +		       unsigned int offset,
>> +		       size_t bytes, void *buf)
>> +{
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_device_write);
>
> Can you please add kernel-doc on these exported APIs?
>
Thanks for spotting, I will add them.

>> +
>>   static int nvmem_init(void)
>>   {
>>   	return class_register(&nvmem_class);
>> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
>> index c3fa8c7..66c67ba 100644
>> --- a/include/linux/nvmem-consumer.h
>> +++ b/include/linux/nvmem-consumer.h
>> @@ -23,6 +32,18 @@ void nvmem_cell_put(struct nvmem_cell *cell);
>>   void *nvmem_cell_read(struct nvmem_cell *cell, ssize_t *len);
>>   int nvmem_cell_write(struct nvmem_cell *cell, void *buf, ssize_t len);
>>
>> +/* direct nvmem device read/write interface */
>> +struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
>> +void nvmem_device_put(struct nvmem_device *nvmem);
>> +int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
>> +		      size_t bytes, void *buf);
>> +int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
>> +		       size_t bytes, void *buf);
>> +int nvmem_device_cell_read(struct nvmem_device *nvmem,
>> +			   struct nvmem_cell_info *info, void *buf);
>> +int nvmem_device_cell_write(struct nvmem_device *nvmem,
>> +			    struct nvmem_cell_info *info, void *buf);
>> +
>
> Can we also have devm_nvmem_*_get() APIs please?
Sure, I will spin it in next version.
>
>> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
>> index 4908b37..7a982cd 100644
>> --- a/include/linux/nvmem-provider.h
>> +++ b/include/linux/nvmem-provider.h
>> @@ -12,15 +12,9 @@
>>   #ifndef _LINUX_NVMEM_PROVIDER_H
>>   #define _LINUX_NVMEM_PROVIDER_H
>>
>> -struct nvmem_device;
>> +#include <linux/nvmem-consumer.h>
>>
>> -struct nvmem_cell_info {
>> -	const char		*name;
>> -	int			offset;
>> -	int			bytes;
>> -	int			bit_offset;
>> -	int			nbits;
>> -};
>> +struct nvmem_device;
>
> Should this diff be part of an earlier patch?
Possibly, something wrong with this diff, I will fix it.
>
