From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 5 Jan 2012 11:21:21 +0100
Subject: [PATCH v2 03/10] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
In-Reply-To: <20120104181224.GJ15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-4-git-send-email-b-cousson@ti.com>
 <20120104181224.GJ15503@ponder.secretlab.ca>
Message-ID: <4F0579A1.2080102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 1/4/2012 7:12 PM, Grant Likely wrote:
> On Fri, Dec 09, 2011 at 03:02:34PM +0100, Benoit Cousson wrote:

[...]

>> @@ -1183,22 +1187,53 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>   	int				status;
>>   	unsigned			i;
>>   	struct twl4030_platform_data	*pdata = client->dev.platform_data;
>> +	struct device_node		*node = client->dev.of_node;
>>   	u8 temp;
>>   	int ret = 0;
>>
>> +	if (node&&  !pdata) {
>> +		/*
>> +		 * XXX: Temporary fake pdata until the information
>> +		 * is correctly retrieved by every TWL modules from DT.
>> +		 */
>> +		pdata = kzalloc(sizeof(struct twl4030_platform_data),
>> +				GFP_KERNEL);
>
> devm_kzalloc() so that it gets cleaned up on remove.

Yep, it was already updated like that in the v4.

>> +		if (!pdata) {
>> +			status = -ENOMEM;
>> +			goto exit;
>> +		}
>> +
>> +		/*
>> +		 * XXX: For the moment the IRQs for TWL seems to be encoded in
>> +		 * the global OMAP space. That should be cleaned to allow
>> +		 * dynamically adding a new IRQ controller.
>> +		 */
>> +		if ((id->driver_data)&  TWL6030_CLASS) {
>> +			pdata->irq_base = TWL6030_IRQ_BASE;
>> +			pdata->irq_end = pdata->irq_base + TWL6030_BASE_NR_IRQS;
>> +		} else {
>> +			pdata->irq_base = TWL4030_IRQ_BASE;
>> +			pdata->irq_end = pdata->irq_base + TWL4030_BASE_NR_IRQS;
>> +		}
>> +		irq_domain_add_simple(node, pdata->irq_base);
>
> Yes, you'll want a follow-up patch to convert to dynamically allocated
> irqs... but I've got to merge the final irq_domain work first.  :-)

Yes. I already have a version based on Rob's series, but did not push it 
since Rob was not confident with the merge of that feature for 3.3.

> Acked-by: Grant Likely<grant.likely@secretlab.ca>

Thanks,
Benoit
