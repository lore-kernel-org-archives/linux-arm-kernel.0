From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Apr 2013 23:21:31 +0100
Subject: Removal of NWFPE in its entirety, and VFP emulation code
In-Reply-To: <20130410214509.GT14496@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 10 Apr 2013 22:45:09 +0100")
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
 <20130410214509.GT14496@n2100.arm.linux.org.uk>
Message-ID: <yw1xsj2y6n84.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Apr 10, 2013 at 10:18:42PM +0100, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> >> > Subarchitecture, bits [22:16]
>> >> > 0b0000011
>> >> > VFP architecture v3 or later with Null subarchitecture. The entire floating-point
>> >> > implementation is in hardware, and no software support code is required. The
>> >> > VFP architecture version is indicated by the MVFR0 and MVFR1 registers.
>> >> > This value can be used only by an implementation that does not support the trap
>> >> > enable bits in the FPSCR, see Floating-point Status and Control Register
>> >> > (FPSCR) on page A2-28.
>> >> 
>> >> This means merely that the implementation never traps on things like
>> >> denormal inputs or over/underflow.  It has nothing to do with vector
>> >> support.
>> >
>> > Wrong.  The VFP subarchitecture defines the interface between *VFP
>> > hardware* and the *VFP support code*.  I suggest you read carefully the
>> > chapter in the ARM ARM *before* you make any further comment, and make
>> > yourself look any more a fool than you already do.
>> 
>> Yet the A9 clearly does trap, just like the TRM says it should.  So
>> which is more likely, that the TRM and silicon are both wrong, or that
>> you are wrong?  Perhaps we should put it to a vote.
>
> Look, it's all very simple for those who know how this works, which *you*
> plainly don't - but rather than admit that you'll much rather insult
> those who do.
>
> - A9 is ARMv7.
> - Vector operations are deprecated in ARMv7.
> - Whether vector operations are implemented is up to the implementer.
> - If they aren't implemented, they will cause an undefined instruction
>   exception.
> - If the VFP subarchitecture says '3' that means no support code is
>   required by the implementation.
>
> All together, that means that on ARMv7, of which Cortex-A9 is one such
> implementation, vector operations *are* *deprecated* may or may not be
> implement in hardware.  If they are not implemented in hardware *and*
> the VFP subarchitecture reports '3', then you _should_ strictly get a
> SIGILL for them and not have them executed because they are _deprecated_
> *and* _unsupported_ instructions.

So you're saying the current kernel behaviour of emulating the vector
operations on A9 is in error.  I suppose I could agree with that
(although the system response to an undefined instruction is not
specified by the architecture), and I'm glad you finally admit that some
VFP instructions can indeed trap on ARMv7.

That said, we should still be prepared to handle reports of previously
(apparently) working software starting to break if the emulation is
dropped.

-- 
M?ns Rullg?rd
mans at mansr.com
