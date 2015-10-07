From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 07 Oct 2015 18:01:03 +0100
Subject: [PATCH] nvmem: core: make default user binary file root-access
 only
In-Reply-To: <20151007165046.GC12099@kroah.com>
References: <1444235714-24365-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20151007165046.GC12099@kroah.com>
Message-ID: <56154FCF.6010105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/10/15 17:50, Greg KH wrote:
> On Wed, Oct 07, 2015 at 05:35:14PM +0100, Srinivas Kandagatla wrote:
>> As required by many providers like at24/at25/mxs-ocotp/qfprom, which would
>> want to allow root-only to read/write the nvmem content.
>> So making the defaults to be root-only access which can prevent normal
>> users from reading the nvmem data.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 6fd4e5a..4d2e476 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -112,7 +112,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>>   static struct bin_attribute bin_attr_rw_nvmem = {
>>   	.attr	= {
>>   		.name	= "nvmem",
>> -		.mode	= S_IWUSR | S_IRUGO,
>> +		.mode	= S_IWUSR | S_IRUSR,
>>   	},
>>   	.read	= bin_attr_nvmem_read,
>>   	.write	= bin_attr_nvmem_write,
>> @@ -136,7 +136,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
>>   static struct bin_attribute bin_attr_ro_nvmem = {
>>   	.attr	= {
>>   		.name	= "nvmem",
>> -		.mode	= S_IRUGO,
>> +		.mode	= S_IRUSR,
>>   	},
>>   	.read	= bin_attr_nvmem_read,
>>   };
>
> How about using BIN_ATTR_RO() and friends instead, that way I _know_ you
> got the permissions correct as it's impossible to get them wrong by
> using those macros.
Yes, that sounds good, but there are no macros for just "S_IRUSR" or 
"(S_IWUSR | S_IRUSR)" in ./include/linux/sysfs.h


--srini

>
> thanks,
>
> greg k-h
>
