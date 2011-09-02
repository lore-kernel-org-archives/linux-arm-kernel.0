From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 2 Sep 2011 10:29:52 +0100
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information
	via sysfs
In-Reply-To: <4E609784.3080507@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<20110901233403.GA28176@suse.de> <4E609784.3080507@linaro.org>
Message-ID: <20110902092952.GA28500@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2011 at 09:44:52AM +0100, Lee Jones wrote:
> On 02/09/11 00:34, Greg KH wrote:
> > On Thu, Sep 01, 2011 at 01:27:19PM +0100, Lee Jones wrote:
> >> +static ssize_t soc_info_get(struct device *dev,
> >> +			struct device_attribute *attr,
> >> +			char *buf)
> >> +{
> >> +	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
> >> +
> >> +	if (!strcmp(attr->attr.name, "machine"))
> >> +		return sprintf(buf, "%s\n", soc_dev->machine);
> >> +	if (!strcmp(attr->attr.name, "family"))
> >> +		return sprintf(buf, "%s\n", soc_dev->family);
> >> +	if (!strcmp(attr->attr.name, "revision"))
> >> +		return sprintf(buf, "%s\n", soc_dev->revision);
> >> +	if (!strcmp(attr->attr.name, "soc_id")) {
> >> +		if (soc_dev->pfn_soc_id)
> >> +			return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
> >> +		else return sprintf(buf, "N/A \n");
> > 
> > Move this line
> > 
> >> +	}
> >> +
> >> +	return -EINVAL;
> > 
> > To here?
> > 
> 
> I initially had invalid requests return a useful message, but I was told
> to remove it and return -EINVAL instead:
> 
> "Just return -EINVAL or similar here to propogate the error to the user."
> 
> Jamie, what say you?

Well if there isn't an ID for the SoC, then I think it's better for a 
read() to return an error rather than have to parse for a special string 
like "N/A ".  So rather than returning that string, perhaps something 
like:

	if (!strcmp(attr->attr.name, "soc_id")) {
		if (!soc_dev->pfn_soc_id)
			return -ENOENT;
		return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
	}

or if you don't think this is an error, default to an id of "0" so that 
it can be parsed by tools?

Jamie
