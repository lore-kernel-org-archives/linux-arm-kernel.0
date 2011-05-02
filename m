From: robherring2@gmail.com (Rob Herring)
Date: Sun, 01 May 2011 22:09:24 -0500
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <1304298586.2686.29.camel@pororo>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>	
	<4DBDC3B5.7070808@gmail.com> <1304298586.2686.29.camel@pororo>
Message-ID: <4DBE2064.2060303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy,

On 05/01/2011 08:09 PM, Jeremy Kerr wrote:
> Hi Rob,
>
>>> +int clk_prepare(struct clk *clk)
>>> +{
>>> +	int ret = 0;
>>> +
>>
>> Shouldn't all these functions have some clk pointer checks:
>>
>> 	if (IS_ERR_OR_NULL(clk))
>> 		return -EINVAL;
>>
>
> No, I'd prefer not to. The driver code should be responsible for passing
> a valid pointer here, by doing this check once (where the clock is
> initially acquired through clk_get), rather than the core code doing it
> on each function call.

I think you will find many examples in the kernel where that is not done 
by drivers. It is also common that the same driver is used on platforms 
with and without clock support. Adding NULL ptr checks around every clk 
api function makes for ugly and duplicated code.

Every implementation of clk_enable that I looked at does this check in 
their implementation. I looked at omap, imx, spear, and samsung. Seems 
like we should try to minimize breakage from switching to common struct clk.

Rob
