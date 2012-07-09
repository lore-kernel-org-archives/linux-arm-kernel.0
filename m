From: hs@denx.de (Heiko Schocher)
Date: Mon, 09 Jul 2012 10:25:28 +0200
Subject: [PATCH v5 4/7] ARM: davinci: net: davinci_emac: add OF support
In-Reply-To: <4FF998A7.50309@ti.com>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-5-git-send-email-hs@denx.de> <4FF998A7.50309@ti.com>
Message-ID: <4FFA9578.1070400@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sekhar,

On 08.07.2012 16:26, Sekhar Nori wrote:
[...]
> On 5/30/2012 3:49 PM, Heiko Schocher wrote:
>> add of support for the davinci_emac driver.
>>
>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: netdev at vger.kernel.org
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
>> Cc: Anatoly Sivov<mm05@mail.ru>
>>
>> ---
>
>> +#ifdef CONFIG_OF
>> +static struct emac_platform_data
>> +	*davinci_emac_of_get_pdata(struct platform_device *pdev,
>> +	struct emac_priv *priv)
>> +{
>> +	struct device_node *np;
>> +	struct emac_platform_data *pdata = NULL;
>> +	const u8 *mac_addr;
>> +	u32 data;
>> +	int ret;
>> +
>> +	pdata = pdev->dev.platform_data;
>> +	if (!pdata) {
>> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata)
>> +			goto nodata;
>> +	}
>> +
>> +	np = pdev->dev.of_node;
>> +	if (!np)
>> +		goto nodata;
>> +	else
>> +		pdata->version = EMAC_VERSION_2;
>> +
>> +	mac_addr = of_get_mac_address(np);
>> +	if (mac_addr)
>> +		memcpy(pdata->mac_addr, mac_addr, ETH_ALEN);
>
> I suspect that even in the DT case, many boards will continue to
> read mac address from on-board EEPROMs or from an on-chip eFUSE.
> To take care of such cases, I propose use mac address in DT data
> only if no valid address is passed through platform data. The
> attached patch does this change.

Ok, understand. I am fine with this.

> If you are OK with this modification, can you please merge it and
> repost just this patch for review? Please CC David Miller
> (davem at davemloft.net) on your next post as he is the netdev maintainer
> and this patch needs to be merged through him or at least needs his ack.

Merged, done.

> With this modification, you can add my:
>
> Acked-by: Sekhar Nori<nsekhar@ti.com>

Ok, thanks. Post this patch soon, if I am finished with testing this
change.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
