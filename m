From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 18 Apr 2011 19:45:53 -0700
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110418100716.GJ14770@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
Message-ID: <4DACF761.3050503@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2011 03:07 AM, Sascha Hauer wrote:
> On Mon, Apr 18, 2011 at 11:49:09AM +0200, Uwe Kleine-K?nig wrote:
>> On Fri, Apr 15, 2011 at 09:08:10PM +0200, Sascha Hauer wrote:
>>> This patch adds support for the most common type of divider,
>>> which expects a register, width and shift values to desacribe
>>> the location of the divider. The divider can be zero based
>>> or one based (div = reg_val + 1 vs. div = reg_val).
>>>
>>> Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
>>> Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
>>> ---
>>>   drivers/clk/Kconfig       |    3 +
>>>   drivers/clk/Makefile      |    1 +
>>>   drivers/clk/clk-divider.c |  132 +++++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/clk.h       |   31 +++++++++++
>>>   4 files changed, 167 insertions(+), 0 deletions(-)
>>>   create mode 100644 drivers/clk/clk-divider.c
>>>
>>> +static int clk_divider_set_rate(struct clk *clk, unsigned long rate)
>>> +{
>>> +	unsigned long best_parent_rate;
>>> +	struct clk_divider *divider = to_clk_divider(clk);
>>> +	unsigned int div;
>>> +	int ret;
>>> +	unsigned long flags = 0;
>>> +	u32 val;
>>> +
>>> +	div = clk_divider_bestdiv(clk, rate,&best_parent_rate);
>>> +
>>> +	if (rate != best_parent_rate / div)
>>> +		return -EINVAL;
>> This is too harsh, isn't it. Or can you expect to only get values that
>> are returned by round_rate? Again you need DIV_ROUND_UP.
>
> AFAIK there are two different implementation types in the tree. Some
> implementations only allow to set to the exact rate round_rate returns
> while others round down in set_rate.
>
> Has this been specified what behaviour is expected?
>

This is something I have nagged Russell once or twice about and then 
sent out an email to the list for which there was very limited response. 
I think clk_round_rate() is too generic and not very useful.

We should really have something like:
clk_set_rate_range(min, ideal, max)

That way, we don't have to guess what's best for the consumer. The 
consumers knows exactly what range it can work with and what is ideal. 
Also, this simplifies the life of the device driver writer when the 
device is used in many different SoCs with different clock plans and 
different meanings of round rate (up vs. down vs. closest). As of today, 
to deal with the latter case, the device drivers will have to get the 
clock rate passed through platform data.

I'm really hoping there is enough attention to finally get the clock API 
cleaned up for better clarity.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
