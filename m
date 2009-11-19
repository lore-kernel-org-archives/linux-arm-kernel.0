From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 19 Nov 2009 21:07:33 +0900
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <20091119114833.GH9763@rakim.wolfsonmicro.main>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
	<20091118221345.GB4808@trinity.fluff.org>
	<1b68c6790911181844p3fb32525h11f79f942afb2d64@mail.gmail.com>
	<20091119103336.GB15460@sirena.org.uk>
	<1b68c6790911190305w33e777e3n1ed6b172d67f1639@mail.gmail.com>
	<20091119110827.GE9763@rakim.wolfsonmicro.main>
	<20091119113841.GJ13376@n2100.arm.linux.org.uk>
	<20091119114833.GH9763@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790911190407x5c717df0q3f259c1f739b20a7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 8:48 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 19, 2009 at 11:38:41AM +0000, Russell King - ARM Linux wrote:
>
>> I'm not sure what you're commenting on precisely, but the Samsung code as
>> a whole doesn't use the clk API very well, and I suspect that is starting
>> to cause people to have to pass clock names around.
>
> That's what I'd thought originally but it's not quite the problem here.
> The issue is that Samsung serial port clock is chosen from a mux and the
> logic to select which of the inputs to that mux should be used is in the
> serial driver. ?This means that if the set of parent clocks changes then
> the serial driver needs to be told what they are.
just to add to the info: unlike system clocks and mux'es which are controlled
by registers of a dedicated clock/system controller, this uart mux is
managed by bits of some register of the UART controller.

> My suggestion was to push this logic down into the clock API so the
> serial driver just requests a rate and then clock API picks the best
> option from the mux. ?As well as being nicer from the clock API point of
> view this would also allow other drivers to use the same logic since
> these muxes are a standard idiom for Samsung SoCs.
how transparently could we add this 'uart-mux' into the clock API, provided
that the register space ioremap'ing is done in the uart driver, is to be seen.
