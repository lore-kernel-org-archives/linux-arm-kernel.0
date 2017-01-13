From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Jan 2017 14:39:13 -0800
Subject: [PATCH net-next v2 08/10] net: dsa: Add support for platform data
In-Reply-To: <20170113141110.GI10203@lunn.ch>
References: <20170112034121.27697-1-f.fainelli@gmail.com>
 <20170112034121.27697-9-f.fainelli@gmail.com>
 <20170113141110.GI10203@lunn.ch>
Message-ID: <80ff1fb8-b59e-995c-65c1-cf2460352a70@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 06:11 AM, Andrew Lunn wrote:
>>  static int _dsa_register_switch(struct dsa_switch *ds, struct device *dev)
>>  {
>> +	struct dsa_chip_data *pdata = dev->platform_data;
>>  	struct device_node *np = dev->of_node;
>>  	struct dsa_switch_tree *dst;
>>  	struct device_node *ports;
>>  	u32 tree, index;
>>  	int i, err;
>>  
>> -	err = dsa_parse_member_dn(np, &tree, &index);
>> -	if (err)
>> -		return err;
>> +	if (np) {
>> +		err = dsa_parse_member_dn(np, &tree, &index);
>> +		if (err)
>> +			return err;
>>  
>> -	ports = dsa_get_ports(ds, np);
>> -	if (IS_ERR(ports))
>> -		return PTR_ERR(ports);
>> +		ports = dsa_get_ports(ds, np);
>> +		if (IS_ERR(ports))
>> +			return PTR_ERR(ports);
>>  
>> -	err = dsa_parse_ports_dn(ports, ds);
>> -	if (err)
>> -		return err;
>> +		err = dsa_parse_ports_dn(ports, ds);
>> +		if (err)
>> +			return err;
>> +	} else {
>> +		err = dsa_parse_member(pdata, &tree, &index);
> 

Hello Andrew,

> Hi Florian
> 
> Maybe it is hiding, but i don't see anywhere you check that pdata !=
> NULL.

You are right, there is not such a check, it should probably be added
early on.

> 
> At least for x86 platforms, i don't expect we are booting using
> platform data like ARM systems used to do. I think it is more likely a
> glue module will be loaded. It looks up the MDIO bus and appends a
> platform data to an MDIO device. The switch driver then needs to load
> and use the platform data. But if things happen in a different order,
> it could be the switch driver probes before the glue driver, meaning
> pdata is NULL.

That's very valid, I will fix this, thanks!

> 
> Do we even want to return -EPROBE_DEFERED?

I was trying to exercise that code path a little bit, but could not
quite make sense of what I was seeing, let me try again with more tracing.
-- 
Florian
