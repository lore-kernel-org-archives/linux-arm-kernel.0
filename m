From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 17 May 2012 12:51:00 +0530
Subject: [PATCH v3 4/7] ARM: davinci: net: davinci_emac: add OF support
In-Reply-To: <4FB49B7B.60506@denx.de>
References: <1330945804-3379-1-git-send-email-hs@denx.de>
 <1330945804-3379-5-git-send-email-hs@denx.de>
 <DF0F476B391FA8409C78302C7BA518B63EA14401@DBDE01.ent.ti.com>
 <4FB49B7B.60506@denx.de>
Message-ID: <4FB4A6DC.20208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/17/2012 12:02 PM, Heiko Schocher wrote:
> Nori, Sekhar wrote:
>> On Mon, Mar 05, 2012 at 16:40:01, Heiko Schocher wrote:

>>> +#ifdef CONFIG_OF
>>> +static struct emac_platform_data
>>> +	*davinci_emac_of_get_pdata(struct platform_device *pdev,
>>> +	struct emac_priv *priv)
>>> +{
>>> +	struct device_node *np;
>>> +	struct device_node *pinmux_np;
>>> +	struct emac_platform_data *pdata = NULL;
>>> +	const u8 *mac_addr;
>>> +	u32 data;
>>> +	int ret;
>>> +	int version;
>>> +
>>> +	np = pdev->dev.of_node;
>>> +	if (!np)
>>> +		goto nodata;
>>> +	else
>>> +		version = EMAC_VERSION_2;
>>
>> You could set pdata->version directly here. 
> 
> done.

Just noticed that pdata is not setup at this time. I guess you will be
moving around some code to do this.

>>> +
>>> +	pinmux_np = of_parse_phandle(np, "pinmux-handle", 0);
>>> +	if (pinmux_np)
>>> +		davinci_cfg_reg_of(pinmux_np);
>>
>> This is a DaVinci specific pinmux function and this
>> driver can be used in non-DaVinci platforms like C6x
>> and OMAP. So, it will not be correct to call a DaVinci
>> specific function here.
> 
> Ah, right!
> 
>> Can you drop the pinmux from this patch for now? On DaVinci,
> 
> Done ... Hmm.. so I think, I should drop this for all patches
> from my patchset, right?

Yes.

> 
>> for pinmux, we need to migrate to drivers/pinctrl/ as well.
> 
> Ah, I see ... take a look at it, maybe I find time to do here
> something ... or do you know about work in progress here?

There is no work in progress within TI. So, if you are interested in
taking a stab it it, it will be great.

> 
>> Doing this will also make this patch independent of the rest
>> of this series can even be merged separately. Can you please
>> make these changes and resend just this patch?
> 
> Yep, I do some test with the changes you requested and resend
> this patch ... do you prefer some tree, which I should use as
> base?

This one should ideally merge through the network subsystem so may be
base it on the net-next tree?

http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;a=summary

Thanks,
Sekhar
