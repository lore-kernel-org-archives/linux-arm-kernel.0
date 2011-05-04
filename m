From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 04 May 2011 11:33:49 -0700
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <20110504064015.GZ14770@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>	<4DBDC3B5.7070808@gmail.com>
	<1304298586.2686.29.camel@pororo>	<4DBE2064.2060303@gmail.com>
	<1304307632.2686.33.camel@pororo>	<4DBEDC12.4090203@gmail.com>	<20110502223636.GB28001@n2100.arm.linux.org.uk>	<4DBF4AA9.7010309@codeaurora.org>
	<20110504064015.GZ14770@pengutronix.de>
Message-ID: <4DC19C0D.7010007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2011 11:40 PM, Sascha Hauer wrote:
> On Mon, May 02, 2011 at 05:22:01PM -0700, Saravana Kannan wrote:
>>> This does bring us to an interesting question though: should clk_set_rate()
>>> succeed or fail with a NULL clk?  There is no clock to control, so my
>>> feeling is that it should fail, just like clk_get_rate() should return
>>> zero because the rate is meaningless.  There is no rate to get and no
>>> rate to set.
>>
>> I think having NULL clocks return success on set_rate() would be
>> more useful. The most common use case for NULL clocks is when a
>> clocks is present in some soc/arch/mach but is not present in
>> another. Instead of having the consumers having an "if" around every
>> clk_* calls on that clk, they would get a NULL clk. If NULL clk
>> starts failing for clk_set_rate(), I think the point of a NULL clk
>> will get defeated.
>
>  From my experience when a clock is present on one SoC but not on another
> the actual rate does not matter, only enabling/disabling the clock for
> register accesses is important. When a driver sets a rate on a clock it
> does it on purpose and if this clock is not even present on other SoCs
> it looks like a bug or at least a very special case for me. So I think
> clk_set_rate for a NULL clock should fail.

Good point.

> Other than that it's not a good behaviour when clk_get_rate() returns
> 0 for clock which rate has been successfully set to another rate using
> clk_set_rate().

It's a NULL clock, so it hopefully shouldn't matter.

I think you have convinced my about set_rate() returning error is not 
catastrophic. But if it doesn't hurt to return success, I think we 
should go ahead and do that in case someone cares about it?

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
