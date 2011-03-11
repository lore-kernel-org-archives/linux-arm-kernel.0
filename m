From: maxime.coquelin-nonst@stericsson.com (Maxime Coquelin)
Date: Fri, 11 Mar 2011 16:40:05 +0100
Subject: [RFC PATCHv2 1/2] Export SoC info through sysfs
In-Reply-To: <20110311135043.GA9320@besouro.research.nokia.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110311135043.GA9320@besouro.research.nokia.com>
Message-ID: <4D7A4255.6030603@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




>> +
>> +int __init register_sysfs_soc_info(struct sysfs_soc_info *info, int nb_info)
>> +{
>> +	int i, ret;
>> +
>> +	for (i = 0; i<  nb_info; i++) {
>> +		ret = sysfs_create_file(soc_object,&info[i].attr.attr);
>> +		if (ret) {
>> +			for (i -= 1; i>= 0; i--)
>> +				sysfs_remove_file(soc_object,&info[i].attr.attr);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>  From functional perspective, this looks like a sysfs_create_group.
> Now it makes me wonder if this thing would make sense. Maybe it's
> better to create a node under platform and then add attributes to it, as suggested
> in V1 thread. I don't know, this could still be done by the socinfo code.
> I mean, location is still an issue it seams :-)
>
> Another thing, what could be done is, instead of creating new data structures to hold
> the attributes, a struct  attribute_group could be pass instead during registration time.
> What do you think??

It would be cleaner indeed.

>> +
>> +static struct attribute *soc_attrs[] = {
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group soc_attr_group = {
>> +	.attrs = soc_attrs,
>> +};
>
> What is the point of the above two ?

sysfs_create_group() requires attributes.

>> +
>> +int __init register_sysfs_soc(struct sysfs_soc_info *info, size_t num)
>> +{
>> +	int ret;
>> +
>> +	soc_object = kobject_create_and_add("socinfo", NULL);
>> +	if (!soc_object) {
>> +		ret = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>> +	ret = sysfs_create_group(soc_object,&soc_attr_group);
>> +	if (ret)
>> +		goto kset_exit;
> You add an empty group here.
>
>> +
>> +	ret = register_sysfs_soc_info(info, num);
>> +	if (ret)
>> +		goto group_exit;
> But the real thing happens here.
>
