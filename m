From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 13:30:42 +0200
Subject: next-20160914 build: 2 failures 3 warnings (next-20160914)
In-Reply-To: <20160919105429.GK10189@sirena.org.uk>
References: <E1bk5OS-0000Vu-1C@optimist> <2300987.vYzazfRX5F@wuerfel>
 <20160919105429.GK10189@sirena.org.uk>
Message-ID: <1474883226.Je8NqnULCh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 19, 2016 11:54:29 AM CEST Mark Brown wrote:
> On Mon, Sep 19, 2016 at 12:31:04PM +0200, Arnd Bergmann wrote:
> 
> > My guess is that this is indeed the correct fix, but I don't understand
> > at all what the function does, and Marcin Niestroj said the same thing,
> > he just copied the code from a driver that is always built-in.
> 
> Yes, most of the code is copied from regmap-irq.  Setting the parent is
> needed for edge triggered interrupts that don't latch state when
> disabled but isn't needed in the general case.

I found this in the tps65217 data sheet:

 9.3.7 Interrupt Pin (nINT)
 The interrupt pin is used to signal any event or fault
 condition to the host processor. Whenever a fault or event
 occurs in the IC the corresponding interrupt bit is set in
 the INT register, and the open-drain output is pulled low.
 The nINT pin is released (returns to Hi-Z state) and fault
 bits are cleared when the INT register is read by the
 host. However, if a failure persists, the corresponding
 INT bit remains set and the nINT pin is pulled low again
 after a maximum of 32 ?s.

 Interrupt events include pushbutton pressed/released, USB
 and AC voltage status change.
 The MASK bits in the INT register are used to mask events
 from generating interrupts. The MASK settings affect the
 nINT pin only and have no impact on protection and
 monitor circuits themselves. Note that persisting event
 conditions such as ISINK enabled shutdown can cause the
 nINT pin to be pulled low for an extended period of
 time which can keep the host in a loop trying to resolve
 the interrupt. If this behavior is not desired, set the
 corresponding mask bit after receiving the interrupt and
 keep polling the INT register to see when the event
 condition has disappeared. Then unmask the interrupt bit
 again.

Does this tell us if it's needed or not?

	Arnd
