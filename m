From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 24 Dec 2010 15:10:28 +0800
Subject: bug in PL011 console
In-Reply-To: <AANLkTimXa_amsei4GQVmG0XceyyMisDZ5fQ4NZPXEquk@mail.gmail.com>
References: <20101223150234.GW14221@pengutronix.de>
	<20101223150841.GP3636@n2100.arm.linux.org.uk>
	<20101223154252.GX14221@pengutronix.de>
	<AANLkTimXa_amsei4GQVmG0XceyyMisDZ5fQ4NZPXEquk@mail.gmail.com>
Message-ID: <AANLkTi=4WOv=uHEqw-BUDaoa5LMX_YnbjNMfKLXSoFfm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/24 Jassi Brar <jassisinghbrar@gmail.com>:
> 2010/12/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> On Thu, Dec 23, 2010 at 03:08:41PM +0000, Russell King - ARM Linux wrote:
>>> On Thu, Dec 23, 2010 at 04:02:34PM +0100, Uwe Kleine-K?nig wrote:
>>> > Steven told me on irc that sleeping was not allowed in the console write
>>> > callback. ?Maybe this didn't show up earlier because not all clk
>>> > implementations sleep as mxs' does.
>>> >
>>> > I think the only possible fix is to do the clk_enable in the setup
>>> > callback instead of per-write.
>>> >
>>> > Will send a patch as follow up.
>>>
>>> We really need to sort out what's expected from the CLK API. ?The drivers
>>> I write assume that it's absolutely fine to call clk_enable/clk_disable
>>> from IRQ context, and for the platforms I implemented the CLK API for,
>>> that's absolutely true.
>> The common struct clk patch[1] by Jeremy Kerr sleeps, too. ?And I think
>> most people who commented to this series thought that this is the right
>> behaviour.
>
> Personally, I am not as against atomic clocks as having two versions
> of the clock - atomic
> and sleepable, in the API.
> I favor sleepable version because with the clock hierarchies becoming so complex
> in latest SoCs, it would be difficult to write a 'smart' clock
> management sub-system
Can you let some intermediate clock on to shorten the time? It might
be better to use some new global power state management to let clock
become smart. Clock itself becomes simple.

Thanks
Richard
> that could setup and enable all 'parent' clocks upon enabling a clock.
> Especially, managing mux'es at levels much lower than pll. FWIK,
> drivers have tough
> time managing such parent clocks.
>
