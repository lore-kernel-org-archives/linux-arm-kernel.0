From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 31 Jul 2012 15:30:00 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <87obmw5rm9.fsf@lebrac.rtp-net.org>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <87obmw5rm9.fsf@lebrac.rtp-net.org>
Message-ID: <5017EBE8.10208@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 08:14, Arnaud Patard (Rtp) wrote:
> Ian Molton<ian.molton@codethink.co.uk>  writes:
> Hi,
>
> [...]
>
>> @@ -2873,7 +2913,31 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>>   	struct resource *res;
>>   	int err;
>>
>> -	pd = pdev->dev.platform_data;
>> +	if (pdev->dev.of_node) {
>> +		struct device_node *np = NULL;
>> +
>> +		/* when all users of this driver use FDT, we can remove this */
>> +		pd = kzalloc(sizeof(*pd), GFP_ATOMIC);
>> +		if (!pd) {
>> +			dev_dbg(&pdev->dev, "Could not allocate platform data\n");
>> +			return -ENOMEM;
>> +		}
>> +
>> +		of_property_read_u32(pdev->dev.of_node,
>> +			"port_number",&pd->port_number);
>> +		of_property_read_u32(pdev->dev.of_node,
>> +			"phy_addr",&pd->phy_addr);
>
> I guess we need something for tx_csum_limit in the device tree too. It's
> important for kirkwood and dove.

Is this something for all kirkwood devices? I think the best way of
doing this is to give the driver a new device-tree name and having
it set this field in the init sequence.

However we could also do with some of these as dt parameters just in
case people want to try and alter them for their own systems.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
