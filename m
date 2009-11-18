From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 18 Nov 2009 01:10:08 +0100
Subject: IXP4xx: unneeded #include platform-specific include files?
In-Reply-To: <op.u3kae7qg2s3iss@richese> (Imre Kaloz's message of "Wed, 18 Nov
	2009 00:05:21 +0100")
References: <m3fx8fso72.fsf@intrepid.localdomain>
	<19200.18453.644399.845601@pilspetsen.it.uu.se>
	<op.u3gddjdi2s3iss@ecaz> <m3y6m7qylr.fsf@intrepid.localdomain>
	<op.u3j6cak02s3iss@richese> <m3ws1o4y3h.fsf@intrepid.localdomain>
	<op.u3j7xuh92s3iss@richese> <m3skcc4wrm.fsf@intrepid.localdomain>
	<op.u3j8zxsd2s3iss@richese> <m3ocn04vma.fsf@intrepid.localdomain>
	<op.u3kae7qg2s3iss@richese>
Message-ID: <m3einw4rrz.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> This is far more tolerable, but SLOT1-3 would be better. Also, the
> _MAX thingie should be dropped, for example the LOFT is nothing more
> then an avila with an USB2 controller on the same IRQ as slot 3, where
> the USB1.1 subdevices will show up as well.

I'd prefer that patches like that, changing the actual behaviour of the
code, are done and especially are tested by people with access to the
actual hardware. I don't know if it's ok to assign an IRQ when there is
nothing to assign. If both have the same PCB, well, perhaps it's the way
to go, but I've never seen those boards.

> Those subdevices won't show
> up on a board without the USB controller, but all this will blow up when
> someone plugs a miniPCI USB controller into one of the slots, not to
> mention if he/she plugs in more ;)

Well... Why would it blow up?
A mini-PCI card should use the same IRQ routing, except that it can't
use more than two INT lines. If the INTA/B/C/D lines are rotated
correctly on board and set up in the PCI config space, it should work
fine.

I'm not sure about a mini-PCI card pretending to use more than two INTx
lines. Probably the "pin <= IRQ_LINES" should be changed to
"pin <= 2" for mini-PCI slots, or maybe % 2 should be used. Can't see
anything about that in the standard and personally I don't have such
card.

I didn't know Avila and Loft are based on mini-PCI, and which devices
exactly are mini-PCI slots.

> Now the best question: do those PCI subdevices need an IRQ?

Most probably.

> If there is only
> one IRQ connected to a PCI slot (probably), does it make sense to assign
> IRQs/GPIOs without any effect?

I don't know how are the lines connected to the slots. The mini-PCI slot
has physically 2 INTx lines. The code suggests that the lines are
rotated, that would mean a slot gets two INTx lines. Yes, that means we
shouldn't assign INTC and INTD (in slot's numbering) to such devices,
but I'm not going to make such changes blindly.

If both lines are connected together, both (or all four) "pins" should
get the same INTx.
-- 
Krzysztof Halasa
