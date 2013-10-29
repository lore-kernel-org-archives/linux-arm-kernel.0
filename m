From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Wed, 30 Oct 2013 00:38:06 +0100
Subject: [PATCH v6 0/5] clk: clock deregistration support
In-Reply-To: <13429728.zDYQ5qS5ur@avalon>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <52420664.2040604@gmail.com> <13429728.zDYQ5qS5ur@avalon>
Message-ID: <527046DE.6050009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On 10/28/2013 10:05 PM, Laurent Pinchart wrote:
> On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
>> On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
>>> This patch series implements clock deregistration in the common clock
>>> framework. Comparing to v5 it only includes further corrections of NULL
>>> clock handling.
[...]
>> ---------8<------------------
>>   From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
>> From: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Date: Thu, 19 Sep 2013 23:52:04 +0200
>> Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()
>>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> ---
>>    drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
>>    drivers/media/platform/omap3isp/isp.h |    1 +
>>    2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/omap3isp/isp.c
>> b/drivers/media/platform/omap3isp/isp.c
>> index df3a0ec..d7f3c98 100644
>> --- a/drivers/media/platform/omap3isp/isp.c
>> +++ b/drivers/media/platform/omap3isp/isp.c
>> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
>>    	struct clk_init_data init;
>>    	unsigned int i;
>>
>> +	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i)
>> +		isp->xclks[i] = ERR_PTR(-EINVAL);
>
> I don't think you've compile-tested this :-)

Thank you for the comments. Yeah, I messed up this, I thought this part
got recompiled but it didn't. I've fixed this in the recently posted
patch.

>> +
>>    	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
>>    		struct isp_xclk *xclk =&isp->xclks[i];
>> -		struct clk *clk;
>>
>>    		xclk->isp = isp;
>>    		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
>> @@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)
>>
>>    		xclk->hw.init =&init;
>>
>> -		clk = devm_clk_register(isp->dev,&xclk->hw);
>> -		if (IS_ERR(clk))
>> -			return PTR_ERR(clk);
>> +		xclk->clk = clk_register(NULL,&xclk->hw);
>> +		if (IS_ERR(xclk->clk))
>> +			return PTR_ERR(xclk->clk);
>
> This doesn't introduce any regression in the sense that it will trade a
> problem for another one, so I'm fine with it in the short. Could you add a
> small comment above the clk_register() call to explain why the first argument
> is NULL ?

I'm not entirely happy about doing something like that. Nevertheless I 
didn't
hear so far any better proposals and I guess it could be treated as a short
term modification while we're working on proper handling of those circular
references.

--
Thanks,
Sylwester
