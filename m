From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 27 Dec 2010 10:00:33 +0900
Subject: bug in PL011 console
In-Reply-To: <AANLkTi=4WOv=uHEqw-BUDaoa5LMX_YnbjNMfKLXSoFfm@mail.gmail.com>
References: <20101223150234.GW14221@pengutronix.de>
	<20101223150841.GP3636@n2100.arm.linux.org.uk>
	<20101223154252.GX14221@pengutronix.de>
	<AANLkTimXa_amsei4GQVmG0XceyyMisDZ5fQ4NZPXEquk@mail.gmail.com>
	<AANLkTi=4WOv=uHEqw-BUDaoa5LMX_YnbjNMfKLXSoFfm@mail.gmail.com>
Message-ID: <AANLkTik98tzyX9sRr4TabbL5dfopiUXb6CWUOHQ9CB1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 4:10 PM, Richard Zhao <linuxzsc@gmail.com> wrote:
> 2010/12/24 Jassi Brar <jassisinghbrar@gmail.com>:
>> 2010/12/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>>> On Thu, Dec 23, 2010 at 03:08:41PM +0000, Russell King - ARM Linux wrote:
>>>> On Thu, Dec 23, 2010 at 04:02:34PM +0100, Uwe Kleine-K?nig wrote:
>>>> > Steven told me on irc that sleeping was not allowed in the console write
>>>> > callback. ?Maybe this didn't show up earlier because not all clk
>>>> > implementations sleep as mxs' does.
>>>> >
>>>> > I think the only possible fix is to do the clk_enable in the setup
>>>> > callback instead of per-write.
>>>> >
>>>> > Will send a patch as follow up.
>>>>
>>>> We really need to sort out what's expected from the CLK API. ?The drivers
>>>> I write assume that it's absolutely fine to call clk_enable/clk_disable
>>>> from IRQ context, and for the platforms I implemented the CLK API for,
>>>> that's absolutely true.
>>> The common struct clk patch[1] by Jeremy Kerr sleeps, too. ?And I think
>>> most people who commented to this series thought that this is the right
>>> behaviour.
>>
>> Personally, I am not as against atomic clocks as having two versions
>> of the clock - atomic
>> and sleepable, in the API.
>> I favor sleepable version because with the clock hierarchies becoming so complex
>> in latest SoCs, it would be difficult to write a 'smart' clock
>> management sub-system
> Can you let some intermediate clock on to shorten the time? It might
> be better to use some new global power state management to let clock
> become smart. Clock itself becomes simple.

Isn't a very neat way, imho. Who decides which clocks are enabled by
default - Platform or Machine code? Not to forget, power saving is one
of the intended benefits of
being able to manage clocks atomically and here we would be forced to keep
clocks enabled due to that very 'feature'.

Also, please remember that some intermediate clock sources (eg. scalars)
could provide to more than one peripheral, and it would be nice to have
mechanism to figure out if and when a peripheral can safely modify the clock to
its own need. And for that, AFAICT, we need to poll other users of the clock and
see if they can manage working with different speeds.
