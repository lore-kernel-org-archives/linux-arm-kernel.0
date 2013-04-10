From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Apr 2013 22:45:09 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <yw1x1uai84p9.fsf@unicorn.mansr.com>
References: <20130410104002.GF14496@n2100.arm.linux.org.uk>
 <yw1xmwt68whw.fsf@unicorn.mansr.com>
 <20130410114229.GH14496@n2100.arm.linux.org.uk>
 <yw1xip3u8uni.fsf@unicorn.mansr.com>
 <20130410185421.GI14496@n2100.arm.linux.org.uk>
 <yw1xehei8a19.fsf@unicorn.mansr.com>
 <20130410200344.GO14496@n2100.arm.linux.org.uk>
 <yw1x61zu866d.fsf@unicorn.mansr.com>
 <20130410210431.GQ14496@n2100.arm.linux.org.uk>
 <yw1x1uai84p9.fsf@unicorn.mansr.com>
Message-ID: <20130410214509.GT14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 10:18:42PM +0100, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> >> > Subarchitecture, bits [22:16]
> >> > 0b0000011
> >> > VFP architecture v3 or later with Null subarchitecture. The entire floating-point
> >> > implementation is in hardware, and no software support code is required. The
> >> > VFP architecture version is indicated by the MVFR0 and MVFR1 registers.
> >> > This value can be used only by an implementation that does not support the trap
> >> > enable bits in the FPSCR, see Floating-point Status and Control Register
> >> > (FPSCR) on page A2-28.
> >> 
> >> This means merely that the implementation never traps on things like
> >> denormal inputs or over/underflow.  It has nothing to do with vector
> >> support.
> >
> > Wrong.  The VFP subarchitecture defines the interface between *VFP
> > hardware* and the *VFP support code*.  I suggest you read carefully the
> > chapter in the ARM ARM *before* you make any further comment, and make
> > yourself look any more a fool than you already do.
> 
> Yet the A9 clearly does trap, just like the TRM says it should.  So
> which is more likely, that the TRM and silicon are both wrong, or that
> you are wrong?  Perhaps we should put it to a vote.

Look, it's all very simple for those who know how this works, which *you*
plainly don't - but rather than admit that you'll much rather insult
those who do.

- A9 is ARMv7.
- Vector operations are deprecated in ARMv7.
- Whether vector operations are implemented is up to the implementer.
- If they aren't implemented, they will cause an undefined instruction
  exception.
- If the VFP subarchitecture says '3' that means no support code is
  required by the implementation.

All together, that means that on ARMv7, of which Cortex-A9 is one such
implementation, vector operations *are* *deprecated* may or may not be
implement in hardware.  If they are not implemented in hardware *and*
the VFP subarchitecture reports '3', then you _should_ strictly get a
SIGILL for them and not have them executed because they are _deprecated_
*and* _unsupported_ instructions.

The current VFP support code behaviour can *not* be relied upon as being
correct, because it was implemented for VFP9 hardware, and has only been
tweaked so that it apparantly works with later VFP hardware.  There are
a bunch of known errors and problems with it with later VFP hardware,
one of which is providing emulation of all VFP instructions even for
subarch v3.

Subarch v3 _will_ eventually result in no VFP instruction emulation at
all when fixed, and it _will_ provoke a SIGILL instead.

I don't expect you to understand this, and you'll continue whinging.
Feel free, I won't be listening.  I'll be the other side of the country
really not caring in the least what stupid theory you're whining about.
