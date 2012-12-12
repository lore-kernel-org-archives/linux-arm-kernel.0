From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Dec 2012 17:59:25 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <1355327745.6771.56.camel@ted>
References: <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
 <20121205235836.GR14363@n2100.arm.linux.org.uk>
 <CAHod+Gf2z-S6B_Z6o_QHbvoLY7L-oYmPVgBzGW3rvKyWAS5apA@mail.gmail.com>
 <20121211002500.GP14363@n2100.arm.linux.org.uk>
 <1355327745.6771.56.camel@ted>
Message-ID: <20121212175925.GA14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 03:55:45PM +0000, Richard Purdie wrote:
> On Tue, 2012-12-11 at 00:25 +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 10, 2012 at 06:21:52PM +0100, Marko Kati? wrote:
> > > > The code which distinguishes between Borzoi and Akita is this:
> > > >
> > > > /* Check for a second SCOOP chip - if found we have Borzoi */
> > > >         ldr     r1, .SCOOP2ADDR
> > > > ==cacheline boundary without patch (0x120)=====
> > > >         ldr     r7, .BORZOIID
> > > >         mov     r6, #0x0140
> > > >         strh    r6, [r1]
> > > > ==cacheline boundary with patch (0x160)======
> > > >         ldrh    r6, [r1]
> > > >         cmp     r6, #0x0140
> > > >         beq     .SHARPEND                       @ We have Borzoi
> > > >
> > > > /* Must be Akita */
> > > >         ldr     r7, .AKITAID
> > > >         b       .SHARPEND                       @ We have Borzoi
> > > >
> > > > and I've marked where the cache line boundary ends up with the patch
> > > > in place... except of course that the caches are off here, so the
> > > > placement of the code should be irrelevant.  It also would have the
> > > > reverse results from those that you're experiencing.
> > > >
> > > > My guess is that because the Scoop2 device is not present, the strh
> > > > access places 0x140 onto the data bus.  By the time the ldrh is
> > > > executed, it reads the data bus, and because nothing drives it, it
> > > > reads back the value last present on the bus, which happens to be
> > > > 0x140 - and this allows us to think we have the Scoop2 device.
> > > >
> > > > In theory, because the caches are off (including the instruction
> > > > cache) the CPU should fetch ldrh between the strh write and the
> > > > ldrh access to the same address.
> > > >
> > > > Having said all that, I'm not impressed by the above code; to write to
> > > > a memory region which may or may not have a device, and immediately
> > > > read it back is a recipe for exactly this kind of stuff happening.  If
> > > > anyone has looked at any real device detection code, they'll know that
> > > > this sequence is typical:
> > > >
> > > >         ldr     r0, =address
> > > >         mov     r1, #probe_data
> > > >         eor     r2, r1, #~0
> > > >         str     r1, [r0, #reg1]
> > > >         str     r2, [r0, #reg2]
> > > >         ldr     r3, [r0, #reg1]
> > > >         ldr     r0, [r0, #reg2]
> > > >         teq     r1, r3
> > > >         teqeq   r2, r0
> > > >         beq     found
> > > >
> > > > This sequence _purposely_ writes the opposite value between the first
> > > > store and the read-back of it to perturb the bus in case it's floating,
> > > > to prevent exactly these kinds of false positives.  The second check is
> > > > additional belt and braces to make the check even more secure.
> > > >
> > > > Can we do that with Scoop2?  I've no idea, I don't know what the weird
> > > > 0x40 offset is that's being probed by this code.  We need whoever wrote
> > > > this code, but I suspect they've long since moved on and aren't
> > > > interested in it.
> 
> I suspect this was me and I was missing some of the subtleties in this
> case. I think the eor to perturb the bus should be fine and fix this
> code.

Except... we're currently hitting the register at 0x08800040 (presumably
a 64-byte offset) which doesn't appear in the scoop header file... so
I'm not sure if this is a special register or not for this.  Also we need
to know another register for the 2nd access which isn't going to cause
problems.  Any suggestions?
