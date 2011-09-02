From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 02 Sep 2011 10:37:47 +0100
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <20110902092952.GA28500@pulham.picochip.com>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<20110901233403.GA28176@suse.de> <4E609784.3080507@linaro.org>
	<20110902092952.GA28500@pulham.picochip.com>
Message-ID: <4E60A3EB.4090804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/11 10:29, Jamie Iles wrote:
> On Fri, Sep 02, 2011 at 09:44:52AM +0100, Lee Jones wrote:
>> On 02/09/11 00:34, Greg KH wrote:
>>> On Thu, Sep 01, 2011 at 01:27:19PM +0100, Lee Jones wrote:
>>>> +static ssize_t soc_info_get(struct device *dev,
>>>> +			struct device_attribute *attr,
>>>> +			char *buf)
>>>> +{
>>>> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
>>>> +
>>>> +	if (!strcmp(attr->attr.name, "machine"))
>>>> +		return sprintf(buf, "%s\n", soc_dev->machine);
>>>> +	if (!strcmp(attr->attr.name, "family"))
>>>> +		return sprintf(buf, "%s\n", soc_dev->family);
>>>> +	if (!strcmp(attr->attr.name, "revision"))
>>>> +		return sprintf(buf, "%s\n", soc_dev->revision);
>>>> +	if (!strcmp(attr->attr.name, "soc_id")) {
>>>> +		if (soc_dev->pfn_soc_id)
>>>> +			return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
>>>> +		else return sprintf(buf, "N/A \n");
>>>
>>> Move this line
>>>
>>>> +	}
>>>> +
>>>> +	return -EINVAL;
>>>
>>> To here?
>>>
>>
>> I initially had invalid requests return a useful message, but I was told
>> to remove it and return -EINVAL instead:
>>
>> "Just return -EINVAL or similar here to propogate the error to the user."
>>
>> Jamie, what say you?
> 
> Well if there isn't an ID for the SoC, then I think it's better for a 
> read() to return an error rather than have to parse for a special string 
> like "N/A ".  So rather than returning that string, perhaps something 
> like:
> 
> 	if (!strcmp(attr->attr.name, "soc_id")) {
> 		if (!soc_dev->pfn_soc_id)
> 			return -ENOENT;
> 		return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
> 	}
> 
> or if you don't think this is an error, default to an id of "0" so that 
> it can be parsed by tools?

What about at the very end of the function?

What should we return if an inappropriate attr->attr.name is used?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
