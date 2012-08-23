From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Aug 2012 11:56:58 -0600
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use imx-syscon
 to access anatop register
In-Reply-To: <20120823061202.GM4011@b20223-02.ap.freescale.net>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-5-git-send-email-b29396@freescale.com>
 <5035BDBF.9020602@wwwdotorg.org>
 <20120823061202.GM4011@b20223-02.ap.freescale.net>
Message-ID: <50366EEA.2070200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 12:12 AM, Richard Zhao wrote:
> On Wed, Aug 22, 2012 at 11:21:03PM -0600, Stephen Warren wrote:
>> On 08/22/2012 01:18 AM, Dong Aisheng wrote:
>>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
>>
>>> diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
>>
>>> @@ -109,7 +110,11 @@ static int __devinit anatop_regulator_probe(struct platform_device *pdev)
>>>  	rdesc->ops = &anatop_rops;
>>>  	rdesc->type = REGULATOR_VOLTAGE;
>>>  	rdesc->owner = THIS_MODULE;
>>> -	sreg->mfd = anatopmfd;
>>> +
>>> +	sreg->anatop = of_parse_phandle(np, "fsl,anatop", 0);
>>> +	if (!sreg->anatop)
>>> +		return -ENODEV;
>>
>> In fact, that imx_syscon_lookup function I proposed could even do the
>> of_parse_phandle() internally, so perhaps:
>>
>> foo->syscon_dev = imx_syscon_lookup(np, "fsl,anatop", 0);
>> if (IS_ERR(foo->syscon_dev))
>>     return PTR_ERR(foo->syscon_dev);
>>
>> with imx_syscon_lookup() internally knowing when to return EPROBE_DEFER
>> rather than any other permanent error code (e.g. for missing property,
>> bad phandle, etc.)
>
> In some case that we access register in machine code, we don't have any
> phandle. The node is got by find compatible or by path.

That sounds a little odd; why not just use a phandle consistently
everywhere?

Either way though, I could imagine still putting all the lookup code
into the syscon driver; just have different functions for the different
lookup methods:

imx_syscon_lookup_by_phandle(np, char *property_name)
imx_syscon_lookup_by_compatible(char *compatible
imx_syscon_lookup_by_path(char *node_path)
