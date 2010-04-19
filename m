From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 19 Apr 2010 20:26:30 +0100
Subject: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <j2hfa686aa41004191205jf61e53ectc994ab0e5a2c4c53@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
	<o2g56d259a01004191152w9c2245fdgaa2d4ac1b9e95ed7@mail.gmail.com>
	<j2hfa686aa41004191205jf61e53ectc994ab0e5a2c4c53@mail.gmail.com>
Message-ID: <k2z56d259a01004191226u40c3af14g87604b996716dbb4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>  >>  >> > +       for (cpsr = 2; cpsr <= 254; cpsr += 2) {
>  >>  >> > +               for (scr = 0; scr <= 255; scr++) {
>  >>  >>
>  >>  >> Non-deterministic.
>  > Eh? Some new meaning of "non-deterministic" that I wasn'f familiar with? :)
>  >
>  > Yes, it does look gross, but max clock rate is 3.7Mhz (7.4 in rev E2
>  > silicon), so if your slowest device is 400kHz, in practice it only
>  > runs the inner loop from 0 to less than 10.
>  > How slow do SPI devices go in reality? The 254*256 divisor gives 100Hz.
>
> Fair enough.  s/non-deterministic/gross/  :-p  I just prefer to see
>  analytic solutions over numerical ones.  :-)  As I said, I won't
>  object to the driver because of these lines.

Absolutely :D
Hey, that's not my code, that comes from Cirrus' code..

Analytical solutions are nicer, yes.
Especially when they get the answer right.
I can see that that loop gets the answer right, whereas once we go
into integer division it is very easy to write code that looks right
but which gets the answer out by one

More to the point, they're probably faster if the calculation happns
once per transfer.
Only "probably" - this chip doesn't have a divide instruction, so
integer division causes a function call to a soft math routine. Would
you like to suggest a code fragment that achieves the desired effect
using only + - * and logical operators and that you have tested in a
loop from 1 to N against the "stupid" version?

So my question stands "what is the slowest SPI device", to know
whether it is worth worrying about, and whether I want to spend a
morning writing an analytical method that is both actually faster and
is sure get the answer right. Otherwise we end up driving devices at
the wrong clock rate.

    M
