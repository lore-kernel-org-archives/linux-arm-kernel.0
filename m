From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 25 May 2010 00:17:02 +0200
Subject: Should we pass amba device peripheral id with device structure or
	not?
In-Reply-To: <20100524213237.GH21117@n2100.arm.linux.org.uk>
References: <4BECF57A.4050802@st.com>
	<20100521193802.GG11042@n2100.arm.linux.org.uk>
	<4BFA02DC.6090906@st.com>
	<20100524213237.GH21117@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinQqEIs3PDWJGFwYqsBZxANmrbH_xOtOchK5Nlh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]

> So... that must mean your hardware gates both the peripheral clock and
> the per-primecell bus clock together. ?Let's hope that the bus clock
> control takes notice of any in-progress bus transaction...
>
> However, I'm still concerned - the driver's use of clk_enable/clk_disable
> is based on the assumption that these calls do not affect the bus clock -
> we expect to be able to write to registers before the first clk_enable()
> call.
>
> And as I've said (and you cut off of the quote) if we have SoCs where the
> bus clock is controllable, we need amba/bus.c to deal with that situation.

This is an interesting thing.

In the U300 the bus clock is gated by one control bit per block.

However we cannot gate the peripheral clock. (Or it's just wired
up to be gated by the same control bit, I'd have to check.)

So through the clock framework we enable/disable the bus
clock, and if we issue get_rate() we return the rate of the peripheral
clock.

Thus clk enable/disable and get_rate are actually orthogonal in
our implementation which is not so nice.

We'd have to add a proper bus clock to all PrimeCells to have this in
some sane state I believe.

Yours,
Linus Walleij
