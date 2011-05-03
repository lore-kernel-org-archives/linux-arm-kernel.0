From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 02 May 2011 20:37:06 -0700
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <20110428151447.GS17290@n2100.arm.linux.org.uk>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
	<20110428151447.GS17290@n2100.arm.linux.org.uk>
Message-ID: <4DBF7862.3050103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2011 08:14 AM, Russell King - ARM Linux wrote:
> On Mon, Apr 18, 2011 at 07:45:53PM -0700, Saravana Kannan wrote:
>> On 04/18/2011 03:07 AM, Sascha Hauer wrote:
>>> AFAIK there are two different implementation types in the tree. Some
>>> implementations only allow to set to the exact rate round_rate returns
>>> while others round down in set_rate.
>>>
>>> Has this been specified what behaviour is expected?
>>>
>>
>> This is something I have nagged Russell once or twice about and then
>> sent out an email to the list for which there was very limited response.
>> I think clk_round_rate() is too generic and not very useful.
>
> As I've always said, clk_round_rate() returns the rate which you will
> get if you ask clk_set_rate() to set the same rate.  It's not ment to
> be "tell me the clock rate which I'd like to then pass to clk_set_rate(),
> oh that's not good enough, so lets tweak it a bit and try again".

Yes, I understood the purpose of clk_round_rate() from the previous 
discussion we had.

> For example, take a video driver.  The user passes in the pixel clock as
> a picosecond argument.  This gets converted to Hz.  We can then use
> clk_round_rate() to find out what clock rate we _actually_ end up with
> when we set that rate using clk_set_rate(), and return that rate (again
> as ps) back to the user before we alter anything.  The user can then
> make a decision whether they want to actually set it.

Sure clk_round_rate() might be sufficient for this case.

> Having some sort of range stuff doesn't help you there because you're
> not supplied a range from userspace.  You're just asked to set a 39752ps
> clock rate.

But this not the problem I'm trying to solve though. There are several 
devices that have a freq operating range in their spec sheet and they 
can't operate outside of that range. As of today, when the 
device/drivers are used in multiple soc/arch, they are solving that 
issue either by using clk_round_rate() in a way that you didn't intend 
(to search for a freq that will work for them) or by passing in the 
clock freq through platform data.

I think a better way to solve this problem is to have a 
clk_set_rate_range() and hence suggesting it. This would also help 
reduce the no. of lines/data passed in board files which I think helps 
clean up ARM code.

Btw, one of the use cases this would help is actually related to display 
too. It's some clock that's fed to the display panel (I don't think it's 
the pixel clock) which has a 96 MHz - 103 MHz operating range.

-Saravana
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
