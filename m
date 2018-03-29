From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Mar 2018 10:59:41 -0400
Subject: [net-next, v2, 01/10] soc: ti: K2G: enhancement to support QMSS in
 NSS
In-Reply-To: <1ccf03e7-17b4-cf00-176d-0e41038c88f8@ti.com>
References: <1522168309-12338-2-git-send-email-m-karicheri2@ti.com>
 <1ccf03e7-17b4-cf00-176d-0e41038c88f8@ti.com>
Message-ID: <feb354cc-2556-c82c-6061-bea6ee819ed5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2018 03:01 PM, Grygorii Strashko wrote:
> Hi Murali,
> 

>>   
>> +enum qmss_version {
>> +	QMSS,
>> +	QMSS_LITE,
> 
> QMSS_66AK2G
> 

OK.

>> +};
>> +
>>   struct knav_device {
>>   	struct device				*dev;
>>   	unsigned				base_id;
>> @@ -305,6 +310,7 @@ struct knav_device {
>>   	struct list_head			pools;
>>   	struct list_head			pdsps;
>>   	struct list_head			qmgrs;
>> +	enum qmss_version			version;
>>   };
>>   
> 
> [...]
> 
>>   }
>>   
>> +/* Match table for of_platform binding */
>> +static const struct of_device_id keystone_qmss_of_match[] = {
>> +	{
>> +		.compatible = "ti,keystone-navigator-qmss",
> 
> 		.data	= (void *)QMSS,

This seems to be unnecessary as QMSS is actually defined as zero. Also 
this static. So that value is zero already in memory.
> 
>> +	},
>> +	{
>> +		.compatible = "ti,keystone-navigator-qmss-l",
>> +		.data	= (void *)QMSS_LITE,
>> +	},
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, keystone_qmss_of_match);
>> +
>>   static int knav_queue_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *node = pdev->dev.of_node;
>>   	struct device_node *qmgrs, *queue_pools, *regions, *pdsps;
>> +	const struct of_device_id *match;
>>   	struct device *dev = &pdev->dev;
>>   	u32 temp[2];
>>   	int ret;
>> @@ -1700,6 +1749,10 @@ static int knav_queue_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   	}
>>   
>> +	match = of_match_device(of_match_ptr(keystone_qmss_of_match), dev);
>> +	if (match && match->data)
>> +		kdev->version = QMSS_LITE;
> 
> 	if (match)
> 		kdev->version = match->data;
> 	else
> 		error?

Similar to above. This private memory is allocated using kzalloc which initializes
everything to zero. So the else part is unnecessary.

Murali

> [...]
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
