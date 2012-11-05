From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Mon, 05 Nov 2012 16:49:09 -0600
Subject: [PATCH 1/6 v2] arm: use devicetree to get smp_twd clock
In-Reply-To: <20121105223155.GJ28327@n2100.arm.linux.org.uk>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1351882309-733-1-git-send-email-mark.langsdorf@calxeda.com>
 <1351882309-733-2-git-send-email-mark.langsdorf@calxeda.com>
 <20121104100822.GY21164@n2100.arm.linux.org.uk> <50983D75.50009@calxeda.com>
 <20121105223155.GJ28327@n2100.arm.linux.org.uk>
Message-ID: <50984265.9010804@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 04:31 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 04:28:05PM -0600, Mark Langsdorf wrote:
>> On 11/04/2012 04:08 AM, Russell King - ARM Linux wrote:
>>> On Fri, Nov 02, 2012 at 01:51:44PM -0500, Mark Langsdorf wrote:
>>>> -static struct clk *twd_get_clock(void)
>>>> +static struct clk *twd_get_clock(struct device_node *np)
>>>>  {
>>>> -	struct clk *clk;
>>>> +	struct clk *clk = NULL;
>>>>  	int err;
>>>>  
>>>> -	clk = clk_get_sys("smp_twd", NULL);
>>>> +	if (np)
>>>> +		clk = of_clk_get(np, 0);
>>>> +	if (!clk)
>>>
>>> What does a NULL return from of_clk_get() mean?  Where is this defined?
>>
>> Well, it's a valid path if (np) is NULL. I'll add an IS_ERR(clk) and
>> resubmit.
> 
> Hang on - what logic are you trying to achieve here?  Wouldn't:
> 
> 	if (np)
> 		clk = of_clk_get(np, 0);
> 	else
> 		clk = clk_get_sys("smp_twd", NULL);
> 
> be sufficient?  If we have DT, why would we ever want to fall back to
> "smp_twd" ?

I'm just trying to make sure I have a clock so I can do cpufreq operations.

Your solution works and is sufficient. Thanks.

--Mark Langsdorf
Calxeda, Inc.
