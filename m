From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 16:14:48 +0100
Subject: [PATCH 05/10] clk: Add support for simple dividers
In-Reply-To: <4DACF761.3050503@codeaurora.org>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-6-git-send-email-s.hauer@pengutronix.de>
	<20110418094909.GE31131@pengutronix.de>
	<20110418100716.GJ14770@pengutronix.de>
	<4DACF761.3050503@codeaurora.org>
Message-ID: <20110428151447.GS17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 07:45:53PM -0700, Saravana Kannan wrote:
> On 04/18/2011 03:07 AM, Sascha Hauer wrote:
>> AFAIK there are two different implementation types in the tree. Some
>> implementations only allow to set to the exact rate round_rate returns
>> while others round down in set_rate.
>>
>> Has this been specified what behaviour is expected?
>>
>
> This is something I have nagged Russell once or twice about and then  
> sent out an email to the list for which there was very limited response.  
> I think clk_round_rate() is too generic and not very useful.

As I've always said, clk_round_rate() returns the rate which you will
get if you ask clk_set_rate() to set the same rate.  It's not ment to
be "tell me the clock rate which I'd like to then pass to clk_set_rate(),
oh that's not good enough, so lets tweak it a bit and try again".

For example, take a video driver.  The user passes in the pixel clock as
a picosecond argument.  This gets converted to Hz.  We can then use
clk_round_rate() to find out what clock rate we _actually_ end up with
when we set that rate using clk_set_rate(), and return that rate (again
as ps) back to the user before we alter anything.  The user can then
make a decision whether they want to actually set it.

Having some sort of range stuff doesn't help you there because you're
not supplied a range from userspace.  You're just asked to set a 39752ps
clock rate.
