From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 16 Jan 2011 23:09:44 +0100
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
	<20110105164344.GD8638@n2100.arm.linux.org.uk>
	<AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
Message-ID: <AANLkTim9cX0MTh04YyooEKkXv9E=cn314tcBSi=tiLwZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...and to round off a theory of why the U300 and Ux500 is
missing interrupts:

Maybe the IP-block does not really handle the case of a block
interrupt not being ACK:ed before the next block is ready. So
it will just fire another "1" flag, which gets ACK:ed at the end
of the interrupt handler with the IRQ currently being processed.

So the interrupt handler will unknowingly consume interrupts
for other blocks.

The right way would be to either:

- Queue block ACKs so that they are ACK:ed one at the time
  if the hardware reads ahead. (Which requires a quite deep
  queue on large writes.)

- Hold back further block reading from the card until the IRQ
  has been ACK:ed. (Which is not good for speed.)

So to avoid both it is indeed a logical thing to remove the
block interrupt altogether and just wait for the last one to
avoid trouble, it's just not documented and
HW-implemented as such.

Now I'll send that patch.

Yours,
Linus Walleij
