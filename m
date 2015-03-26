From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 26 Mar 2015 16:23:36 +0000
Subject: [PATCH v3 3/9] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <20150324225317.GD28997@sirena.org.uk>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236208-18667-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150324225317.GD28997@sirena.org.uk>
Message-ID: <55143288.4040604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/03/15 22:53, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 10:30:08PM +0000, Srinivas Kandagatla wrote:
>
>> +static ssize_t bin_attr_eeprom_write(struct file *filp, struct kobject *kobj,
>> +				     struct bin_attribute *attr,
>> +				     char *buf, loff_t offset, size_t count)
>> +{
>> +	struct device *dev = container_of(kobj, struct device, kobj);
>> +	struct eeprom_device *eeprom = to_eeprom(dev);
>> +	int rc;
>> +
>> +	if (offset > eeprom->size)
>> +		return -EINVAL;
>> +
>> +	if (offset + count > eeprom->size)
>> +		count = eeprom->size - offset;
>> +
>> +	rc = regmap_bulk_write(eeprom->regmap, offset,
>> +			       buf, count/eeprom->stride);
>
> Are you sure that this and the read interface should be using the bulk
> interface and not the raw interface - do we want the byte swapping that
> the bulk interface provides?
>
You are correct, byte swapping is not really needed in this cases.
It should read/write data as it is.

I will fix it in next version.

> I'm also not entirely able to convince myself that the above error
> checks and code line up with what I'd expect the userspace ABI to be, we
> seem to be treating offset as both a byte offset into the data (which is
> what I'd expect the userspace ABI to do) and a word based index into the
> data (which is what the regmap API is doing).  For example with 16 bit
> words offset 2 will start at the 5th byte of data but if userspace seeks
> to offset 5 it will get the 11th byte and onwards.

Thanks for spotting this, Yes, the offset from userspace should be 
treated as byte oriented and the offset to regmap as word based index 
into the data.
Yes, logic here needs a fix to handle data correctly.

>
> The stride and the word size are separate, they will frequently line up
> for memory mapped devices but typically won't for other devices.  I
> think you need more data mangling to handle this robustly.
Yes, I agree I will address this too in next version.

thanks,
srini

>
