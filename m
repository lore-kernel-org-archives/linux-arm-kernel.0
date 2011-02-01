From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Feb 2011 12:21:45 -0800
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201195604.GS31216@n2100.arm.linux.org.uk>
References: <201102011711.31258.jeremy.kerr@canonical.com>	<20110201105449.GY1147@pengutronix.de>	<20110201131512.GH31216@n2100.arm.linux.org.uk>	<20110201141837.GA1147@pengutronix.de>	<20110201143932.GK31216@n2100.arm.linux.org.uk>	<20110201151846.GD1147@pengutronix.de>	<20110201152458.GP31216@n2100.arm.linux.org.uk>	<20110201155344.GF1147@pengutronix.de>	<20110201170637.GR31216@n2100.arm.linux.org.uk>	<20110201193201.GH1147@pengutronix.de>
	<20110201195604.GS31216@n2100.arm.linux.org.uk>
Message-ID: <4D486B59.6010106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2011 11:56 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 08:32:01PM +0100, Uwe Kleine-K?nig wrote:
>> On Tue, Feb 01, 2011 at 05:06:37PM +0000, Russell King - ARM Linux wrote:
>>> So?  You're not _supposed_ to call it from any atomic context ever.
>>
>> My motivation for a more complicated clk_prepare was to make clk_prepare
>> atomic when that's possible (i.e. when the clk is already prepared) and
>> call it before the enable callback in clk_enable.  Then everything
>> behaves nicely even if clk_enable is called from atomic context provided
>> that the clock was prepared before (or doesn't need to).
>
> You really don't get the point of clk_prepare() do you.  I'm not
> going to bother trying to educate you anymore.
>
> Hopefully someone with more patience can give you the necessary
> teaching to make you understand.

Uwe,

If the driver is calling clk_prepare() right next to clk_enable() 
knowing it's been already prepared and will hence be "atomic" (this is 
actually not true), then by your description, it's pointless to call 
clk_prepare().

If you want the driver to call clk_prepare() in atomic context because 
it will be atomic in most cases -- well, that's wrong. It's either 
atomic or is NOT atomic. There is no in between. If a call is NOT 
atomic, it can't be called in atomic context. Long story short, if you 
expect clk_prepare() to be atomic under any circumstance, it beats the 
point of introducing clk_prepare().

Hope I helped.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
