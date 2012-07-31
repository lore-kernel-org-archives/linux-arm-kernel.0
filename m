From: ian.molton@codethink.co.uk (Ian Molton)
Date: Tue, 31 Jul 2012 09:19:52 +0100
Subject: [PATCH 3/6] mv643xx.c: Add basic device tree support.
In-Reply-To: <87obmw5rm9.fsf@lebrac.rtp-net.org>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-4-git-send-email-ian.molton@codethink.co.uk>
 <87obmw5rm9.fsf@lebrac.rtp-net.org>
Message-ID: <50179528.2020801@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 08:14, Arnaud Patard (Rtp) wrote:
> Ian Molton <ian.molton@codethink.co.uk> writes:
> Hi,
>
> [...]
>
>> @@ -2873,7 +2913,31 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>>  	struct resource *res;
>>  	int err;
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
>> +			"port_number", &pd->port_number);
>> +		of_property_read_u32(pdev->dev.of_node,
>> +			"phy_addr", &pd->phy_addr);
> I guess we need something for tx_csum_limit in the device tree too. It's
> important for kirkwood and dove.

It was my intention to keep the patch as non-invasive as possible - none
of the platforms using D-T at present require this.

Furthermore, git grep shows nothing in mach-kirkwood or mach-dove using
at all...

Are you sure this is required? It can always be added if anything
actually uses it :)

-Ian
