From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Nov 2009 19:28:44 +0000
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
In-Reply-To: <20091117180200.GL4737@enneenne.com>
References: <20091117114429.GT14091@buzzloop.caiaq.de>
	<20091117120501.GC8008@gundam.enneenne.com>
	<20091117123422.GU14091@buzzloop.caiaq.de>
	<20091117123721.GG8008@gundam.enneenne.com>
	<20091117124334.GW14091@buzzloop.caiaq.de>
	<20091117125953.GI8008@gundam.enneenne.com>
	<20091117130653.GX14091@buzzloop.caiaq.de>
	<20091117143846.GK8008@gundam.enneenne.com>
	<20091117171116.GB14091@buzzloop.caiaq.de>
	<20091117180200.GL4737@enneenne.com>
Message-ID: <20091117192844.GA4033@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 07:02:00PM +0100, Rodolfo Giometti wrote:
> On Tue, Nov 17, 2009 at 06:11:16PM +0100, Daniel Mack wrote:
> > I'm still not convinced that driving the pad as output GPIO and then
> > applying a different level externally to generate an IRQ is intended.
> 
> No external different level applyed! Just a pull-down enabled by a
> machanical switch: if no cards are inserted I read 1 but if I insert a
> card I got 0 due the pull-down enabling.

I'm sorry, but I really can't believe you mean what you just said.  The
two sentences are definitely contradictory.

In the first, you say that you're not applying a different level.

In the second, you say that you're applying zero volts to the output.
That _is_ a different level, no two ways about it.

By doing so, you are brute-force fighting the FET in the SoC which is
trying to pull the output up to logic '1'.  God knows how much current
you're causing the FET to pass - and therefore how much power it is
dissapating - but according to the PXA270 spec, it'll be in excess of
3mA.  (At 3mA, the output voltage on a GPIO pin is guaranteed to be,
for logic 1, at least 0.8 * VCC_IO).

This is in no way good electronic practice.
